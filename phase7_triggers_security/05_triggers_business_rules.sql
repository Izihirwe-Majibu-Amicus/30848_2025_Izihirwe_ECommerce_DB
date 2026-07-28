/*==============================================================
  PHASE VII -- TRIGGERS, SECURITY & AUDITING
  Script 05: Business Rule Enforcement Triggers
  Run as  : ECOMM_ADMIN

  Guards data integrity for products, payments, and inventory.
==============================================================*/

------------------------------------------------------------------
-- 1. PRODUCTS Price Integrity Trigger
------------------------------------------------------------------
create or replace trigger trg_products_price_check before
   insert or update of unit_price on products
   for each row
begin
   if :new.unit_price <= 0 then
      raise_application_error(
         -20060,
         'Product unit_price must be greater than zero.'
      );
   end if;

  -- Prevent accidental price reductions exceeding 80% in a single update
   if
      updating
      and :new.unit_price < ( :old.unit_price * 0.20 )
   then
      raise_application_error(
         -20061,
         'Price reduction exceeds maximum allowed threshold (80%).'
      );
   end if;
end;
/
SHOW ERRORS TRIGGER trg_products_price_check;

------------------------------------------------------------------
-- 2. PAYMENTS Amount Validation Trigger
------------------------------------------------------------------
create or replace trigger trg_payments_amount_check before
   insert or update of amount on payments
   for each row
begin
   if :new.amount <= 0 then
      raise_application_error(
         -20062,
         'Payment amount must be greater than zero.'
      );
   end if;
end;
/
SHOW ERRORS TRIGGER trg_payments_amount_check;

------------------------------------------------------------------
-- 3. INVENTORY Non-Negative Stock Check Trigger
------------------------------------------------------------------
create or replace trigger trg_inventory_negative_check before
   insert or update of quantity_on_hand on inventory
   for each row
begin
   if :new.quantity_on_hand < 0 then
      raise_application_error(
         -20063,
         'Inventory quantity_on_hand cannot be negative.'
      );
   end if;
end;
/
SHOW ERRORS TRIGGER trg_inventory_negative_check;
------------------------------------------------------------------
-- 4. AUDIT LOG SEQUENCE
------------------------------------------------------------------
begin
   execute immediate 'CREATE SEQUENCE SEQ_AUDIT_LOG START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE';
exception
   when others then
      if sqlcode != -955 then -- ORA-00955: name is already used by an existing object
         raise;
      end if;
end;
/

------------------------------------------------------------------
------------------------------------------------------------------
-- 5. ECOMM_SECURITY_PKG SPECIFICATION
------------------------------------------------------------------
create or replace package ecomm_security_pkg as
   procedure log_audit_event (
      p_user      in varchar2,
      p_table     in varchar2,
      p_action    in varchar2,
      p_status    in varchar2,
      p_action_by in varchar2,
      p_timestamp in timestamp default systimestamp
   );

   procedure check_dml_window (
      p_table  in varchar2,
      p_action in varchar2
   );
end ecomm_security_pkg;
/
SHOW ERRORS PACKAGE ECOMM_SECURITY_PKG;

------------------------------------------------------------------
-- 6. ECOMM_SECURITY_PKG BODY (Exact Schema Alignment)
------------------------------------------------------------------
create or replace package body ecomm_security_pkg as

   procedure log_audit_event (
      p_user      in varchar2,
      p_table     in varchar2,
      p_action    in varchar2,
      p_status    in varchar2,
      p_action_by in varchar2,
      p_timestamp in timestamp default systimestamp
   ) is
      pragma autonomous_transaction;
   begin
      insert into audit_log (
         audit_id,
         table_name,
         operation_type,
         db_username,
         action_timestamp,
         action_status
      ) values
         ( seq_audit_log.nextval,
           upper(trim(p_table)),
           upper(trim(p_action)),
           nvl(
              p_action_by,
              nvl(
                 p_user,
                 user
              )
           ),
           nvl(
              p_timestamp,
              systimestamp
           ),
           upper(trim(p_status)) );
      commit;
   exception
      when others then
         rollback;
         raise;
   end log_audit_event;

   procedure check_dml_window (
      p_table  in varchar2,
      p_action in varchar2
   ) is
      v_current_hour number;
      v_current_day  varchar2(10);
   begin
      v_current_hour := to_number ( to_char(
         sysdate,
         'HH24'
      ) );
      v_current_day := upper(trim(to_char(
         sysdate,
         'DAY',
         'NLS_DATE_LANGUAGE=ENGLISH'
      )));
      if
         ( v_current_hour < 8
         or v_current_hour >= 18
         or v_current_day in ( 'SATURDAY',
                               'SUNDAY' ) )
         and user != 'ECOMM_ADMIN'
      then
         log_audit_event(
            p_user      => user,
            p_table     => p_table,
            p_action    => p_action,
            p_status    => 'DENIED',
            p_action_by => user
         );

         raise_application_error(
            -20001,
            'DML operations are currently restricted by system policy.'
         );
      else
         log_audit_event(
            p_user      => user,
            p_table     => p_table,
            p_action    => p_action,
            p_status    => 'ALLOWED',
            p_action_by => user
         );
      end if;
   end check_dml_window;

end ecomm_security_pkg;
/
SHOW ERRORS PACKAGE BODY ECOMM_SECURITY_PKG;