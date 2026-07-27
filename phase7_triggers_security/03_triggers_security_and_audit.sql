/*==============================================================
  PHASE VII -- TRIGGERS, SECURITY & AUDITING
  Script 03: Security Policy & Table Audit Triggers
  Run as  : ECOMM_ADMIN

  Applies time/maintenance window restrictions and automated
  change logging across critical ecommerce tables.
==============================================================*/

------------------------------------------------------------------
-- 1. ORDERS Security & Audit Triggers
------------------------------------------------------------------
create or replace trigger trg_orders_sec_chk before
   insert or update or delete on orders
   for each row
declare
   v_op varchar2(10);
begin
   if inserting then
      v_op := 'INSERT';
   elsif updating then
      v_op := 'UPDATE';
   elsif deleting then
      v_op := 'DELETE';
   end if;

   ecomm_security_pkg.check_dml_window(
      'ORDERS',
      v_op
   );
end;
/
SHOW ERRORS TRIGGER trg_orders_sec_chk;

create or replace trigger trg_orders_audit after
   insert or update or delete on orders
   for each row
declare
   v_op  varchar2(10);
   v_pk  varchar2(50);
   v_old clob;
   v_new clob;
begin
   if inserting then
      v_op := 'INSERT';
      v_pk := to_char(:new.order_id);
      v_new := 'status='
               || :new.order_status
               || ', cust='
               || :new.customer_id;
   elsif updating then
      v_op := 'UPDATE';
      v_pk := to_char(:new.order_id);
      v_old := 'status=' || :old.order_status;
      v_new := 'status=' || :new.order_status;
   elsif deleting then
      v_op := 'DELETE';
      v_pk := to_char(:old.order_id);
      v_old := 'status='
               || :old.order_status
               || ', cust='
               || :old.customer_id;
   end if;

   ecomm_security_pkg.log_audit_event(
      p_table_name     => 'ORDERS',
      p_operation_type => v_op,
      p_record_pk      => v_pk,
      p_old_value      => v_old,
      p_new_value      => v_new,
      p_action_status  => 'ALLOWED'
   );
end;
/
SHOW ERRORS TRIGGER trg_orders_audit;

------------------------------------------------------------------
-- 2. PAYMENTS Security & Audit Triggers
------------------------------------------------------------------
create or replace trigger trg_payments_sec_chk before
   insert or update or delete on payments
   for each row
declare
   v_op varchar2(10);
begin
   if inserting then
      v_op := 'INSERT';
   elsif updating then
      v_op := 'UPDATE';
   elsif deleting then
      v_op := 'DELETE';
   end if;

   ecomm_security_pkg.check_dml_window(
      'PAYMENTS',
      v_op
   );
end;
/
SHOW ERRORS TRIGGER trg_payments_sec_chk;

create or replace trigger trg_payments_audit after
   insert or update or delete on payments
   for each row
declare
   v_op  varchar2(10);
   v_pk  varchar2(50);
   v_old clob;
   v_new clob;
begin
   if inserting then
      v_op := 'INSERT';
      v_pk := to_char(:new.payment_id);
      v_new := 'amount='
               || :new.amount
               || ', method='
               || :new.payment_method
               || ', status='
               || :new.payment_status;
   elsif updating then
      v_op := 'UPDATE';
      v_pk := to_char(:new.payment_id);
      v_old := 'status=' || :old.payment_status;
      v_new := 'status=' || :new.payment_status;
   elsif deleting then
      v_op := 'DELETE';
      v_pk := to_char(:old.payment_id);
      v_old := 'amount='
               || :old.amount
               || ', status='
               || :old.payment_status;
   end if;

   ecomm_security_pkg.log_audit_event(
      p_table_name     => 'PAYMENTS',
      p_operation_type => v_op,
      p_record_pk      => v_pk,
      p_old_value      => v_old,
      p_new_value      => v_new,
      p_action_status  => 'ALLOWED'
   );
end;
/
SHOW ERRORS TRIGGER trg_payments_audit;

------------------------------------------------------------------
-- 3. INVENTORY Security & Audit Triggers
------------------------------------------------------------------
create or replace trigger trg_inventory_sec_chk before
   insert or update or delete on inventory
   for each row
declare
   v_op varchar2(10);
begin
   if inserting then
      v_op := 'INSERT';
   elsif updating then
      v_op := 'UPDATE';
   elsif deleting then
      v_op := 'DELETE';
   end if;

   ecomm_security_pkg.check_dml_window(
      'INVENTORY',
      v_op
   );
end;
/
SHOW ERRORS TRIGGER trg_inventory_sec_chk;

create or replace trigger trg_inventory_audit after
   insert or update or delete on inventory
   for each row
declare
   v_op  varchar2(10);
   v_pk  varchar2(50);
   v_old clob;
   v_new clob;
begin
   if inserting then
      v_op := 'INSERT';
      v_pk := to_char(:new.product_id);
      v_new := 'qty='
               || :new.quantity_on_hand
               || ', reorder='
               || :new.reorder_level;
   elsif updating then
      v_op := 'UPDATE';
      v_pk := to_char(:new.product_id);
      v_old := 'qty=' || :old.quantity_on_hand;
      v_new := 'qty=' || :new.quantity_on_hand;
   elsif deleting then
      v_op := 'DELETE';
      v_pk := to_char(:old.product_id);
      v_old := 'qty=' || :old.quantity_on_hand;
   end if;

   ecomm_security_pkg.log_audit_event(
      p_table_name     => 'INVENTORY',
      p_operation_type => v_op,
      p_record_pk      => v_pk,
      p_old_value      => v_old,
      p_new_value      => v_new,
      p_action_status  => 'ALLOWED'
   );
end;
/
SHOW ERRORS TRIGGER trg_inventory_audit;