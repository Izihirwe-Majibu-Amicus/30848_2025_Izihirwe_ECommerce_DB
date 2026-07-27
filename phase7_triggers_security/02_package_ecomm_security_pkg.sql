/*==============================================================
  PHASE VII -- TRIGGERS, SECURITY & AUDITING
  Script 02: ECOMM_SECURITY_PKG -- Security Policy & Autonomous Audit
  Run as  : ECOMM_ADMIN
==============================================================*/

------------------------------------------------------------------
-- PACKAGE SPECIFICATION
------------------------------------------------------------------
create or replace package ecomm_security_pkg is

  -- Autonomous logging procedure -- commits independently so DENIED/AUDIT
  -- rows persist even when the caller transaction rolls back.
   procedure log_audit_event (
      p_table_name     in varchar2,
      p_operation_type in varchar2,
      p_record_pk      in varchar2 default null,
      p_old_value      in clob default null,
      p_new_value      in clob default null,
      p_action_status  in varchar2 default 'ALLOWED'
   );

  -- Checks system_config for DML window / maintenance rules.
  -- Raises exception if access is denied.
   procedure check_dml_window (
      p_table_name     in varchar2,
      p_operation_type in varchar2
   );

end ecomm_security_pkg;
/

SHOW ERRORS PACKAGE ecomm_security_pkg;

------------------------------------------------------------------
-- PACKAGE BODY
------------------------------------------------------------------
create or replace package body ecomm_security_pkg is

   procedure log_audit_event (
      p_table_name     in varchar2,
      p_operation_type in varchar2,
      p_record_pk      in varchar2 default null,
      p_old_value      in clob default null,
      p_new_value      in clob default null,
      p_action_status  in varchar2 default 'ALLOWED'
   ) is
      pragma autonomous_transaction;
   begin
      insert into audit_log (
         table_name,
         operation_type,
         record_pk,
         db_username,
         os_username,
         host_machine,
         ip_address,
         module_name,
         action_timestamp,
         old_value,
         new_value,
         action_status
      ) values
         ( upper(p_table_name),
           upper(p_operation_type),
           p_record_pk,
           user,
           sys_context(
              'USERENV',
              'OS_USER'
           ),
           sys_context(
              'USERENV',
              'HOST'
           ),
           sys_context(
              'USERENV',
              'IP_ADDRESS'
           ),
           sys_context(
              'USERENV',
              'MODULE'
           ),
           systimestamp,
           p_old_value,
           p_new_value,
           upper(p_action_status) );

      commit; -- Commits autonomously without affecting calling transaction
   exception
      when others then
         rollback; -- Protects primary transaction if logging fails
   end log_audit_event;


   procedure check_dml_window (
      p_table_name     in varchar2,
      p_operation_type in varchar2
   ) is
      v_mode         varchar2(50) := 'LITERAL';
      v_maint_mode   varchar2(50) := 'OFF';
      v_current_hour number := to_number ( to_char(
         sysdate,
         'HH24'
      ) );
      v_day_of_week  varchar2(10) := upper(to_char(
         sysdate,
         'DY',
         'NLS_DATE_LANGUAGE=ENGLISH'
      ));
   begin
    -- 1. Schema Owner / Admin Exemption Check
    -- Exempts ECOMM_ADMIN from lockouts during maintenance and testing
      if user = 'ECOMM_ADMIN' then
         return;
      end if;

    -- 2. Fetch Configuration Flags
      begin
         select config_value
           into v_mode
           from system_config
          where config_key = 'DML_RULE_MODE';
      exception
         when no_data_found then
            v_mode := 'LITERAL';
      end;

      begin
         select config_value
           into v_maint_mode
           from system_config
          where config_key = 'MAINTENANCE_MODE';
      exception
         when no_data_found then
            v_maint_mode := 'OFF';
      end;

    -- 3. Maintenance Mode Restriction
      if v_maint_mode = 'ON' then
         log_audit_event(
            p_table_name     => p_table_name,
            p_operation_type => p_operation_type,
            p_action_status  => 'DENIED'
         );
         raise_application_error(
            -20050,
            'DML DENIED: System is currently in MAINTENANCE_MODE.'
         );
      end if;

    -- 4. Check Mode Rule Processing
      if v_mode = 'DISABLED' then
      -- Rule checks explicitly bypassed
         return;
      elsif v_mode = 'FORCE_DENY_TEST' then
      -- Force deny mode used strictly for live demonstration / testing
         log_audit_event(
            p_table_name     => p_table_name,
            p_operation_type => p_operation_type,
            p_action_status  => 'DENIED'
         );
         raise_application_error(
            -20051,
            'DML DENIED: Simulated security policy rejection (FORCE_DENY_TEST mode).'
         );
      elsif v_mode = 'LITERAL' then
      -- Standard Business Operating Hours Rule: Block DML after 20:00 or before 08:00, or on weekends
         if v_day_of_week in ( 'SAT',
                               'SUN' )
         or v_current_hour < 8
         or v_current_hour >= 20 then
            log_audit_event(
               p_table_name     => p_table_name,
               p_operation_type => p_operation_type,
               p_action_status  => 'DENIED'
            );
            raise_application_error(
               -20052,
               'DML DENIED: Operations on '
               || p_table_name
               || ' are restricted outside standard business hours (Mon-Fri 08:00-20:00).'
            );
         end if;
      end if;

   end check_dml_window;

end ecomm_security_pkg;
/

SHOW ERRORS PACKAGE BODY ecomm_security_pkg;