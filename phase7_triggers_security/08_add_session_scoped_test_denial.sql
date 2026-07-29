/*==============================================================
  PHASE VII -- ADVANCED (TRIGGERS, SECURITY, AUDIT)
  Script 08: ECOMM_SECURITY_PKG patch -- session-scoped test denial
  Run as  : ECOMM_ADMIN
==============================================================*/

create or replace package ecomm_security_pkg is
   function is_dml_allowed return boolean;

   procedure enforce_dml_window (
      p_table_name in varchar2,
      p_operation  in varchar2,
      p_record_pk  in varchar2 default 'N/A'
   );

   procedure log_audit_event (
      p_table_name in varchar2,
      p_operation  in varchar2,
      p_record_pk  in varchar2,
      p_status     in varchar2 default 'SUCCESS',
      p_old_value  in clob default null,
      p_new_value  in clob default null
   );

end ecomm_security_pkg;
/

SHOW ERRORS PACKAGE ecomm_security_pkg;

create or replace package body ecomm_security_pkg is

   function is_dml_allowed return boolean is
      v_mode          system_config.config_value%type;
      v_start         system_config.config_value%type;
      v_end           system_config.config_value%type;
      v_dow           varchar2(3);
      v_holiday_count number;
   begin
    -- SESSION-SCOPED TEST DENIAL SWITCH (Checked first)
      if sys_context(
         'USERENV',
         'CLIENT_INFO'
      ) = 'FORCE_DENY_TEST' then
         return false;
      end if;

    -- Schema-owner exemption
      if sys_context(
         'USERENV',
         'SESSION_USER'
      ) = 'ECOMM_ADMIN' then
         return true;
      end if;
      select config_value
        into v_mode
        from system_config
       where config_key = 'DML_RULE_MODE';

      if v_mode = 'DISABLED' then
         return true;
      end if;
      select count(*)
        into v_holiday_count
        from public_holidays
       where holiday_date = trunc(sysdate);
      if v_holiday_count > 0 then
         return false;
      end if;
      v_dow := to_char(
         sysdate,
         'DY',
         'NLS_DATE_LANGUAGE=ENGLISH'
      );
      if v_mode = 'LITERAL' then
         return v_dow not in ( 'MON',
                               'TUE',
                               'WED',
                               'THU',
                               'FRI' );
      elsif v_mode = 'BUSINESS_HOURS' then
         if v_dow in ( 'SAT',
                       'SUN' ) then
            return false;
         end if;
         select config_value
           into v_start
           from system_config
          where config_key = 'BUSINESS_HOURS_START';
         select config_value
           into v_end
           from system_config
          where config_key = 'BUSINESS_HOURS_END';

         return to_char(
            sysdate,
            'HH24:MI'
         ) between v_start and v_end;
      else
         return false;
      end if;
   end is_dml_allowed;


   procedure enforce_dml_window (
      p_table_name in varchar2,
      p_operation  in varchar2,
      p_record_pk  in varchar2 default 'N/A'
   ) is
   begin
      if not is_dml_allowed then
         log_audit_event(
            p_table_name => p_table_name,
            p_operation  => p_operation,
            p_record_pk  => p_record_pk,
            p_status     => 'DENIED'
         );
         raise_application_error(
            -20100,
            'DML denied: writes are not permitted at this time ('
            || to_char(
               sysdate,
               'DY HH24:MI'
            )
            || '). Contact an administrator if you believe this is in error.'
         );
      end if;
   end enforce_dml_window;


   procedure log_audit_event (
      p_table_name in varchar2,
      p_operation  in varchar2,
      p_record_pk  in varchar2,
      p_status     in varchar2 default 'SUCCESS',
      p_old_value  in clob default null,
      p_new_value  in clob default null
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
         action_status,
         old_value,
         new_value
      ) values
         ( p_table_name,
           p_operation,
           p_record_pk,
           sys_context(
              'USERENV',
              'SESSION_USER'
           ),
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
           p_status,
           p_old_value,
           p_new_value );
      commit;
   end log_audit_event;

end ecomm_security_pkg;
/

SHOW ERRORS PACKAGE BODY ecomm_security_pkg;

-- Corrected Self-Test Block using PL/SQL
EXEC DBMS_APPLICATION_INFO.SET_CLIENT_INFO('FORCE_DENY_TEST');
begin
   if ecomm_security_pkg.is_dml_allowed then
      dbms_output.put_line('RESULT: ALLOWED (unexpected!)');
   else
      dbms_output.put_line('RESULT: DENIED (correct)');
   end if;
end;
/

EXEC DBMS_APPLICATION_INFO.SET_CLIENT_INFO(NULL);
begin
   if ecomm_security_pkg.is_dml_allowed then
      dbms_output.put_line('RESULT: ALLOWED (correct, exempt as schema owner)');
   else
      dbms_output.put_line('RESULT: DENIED (unexpected!)');
   end if;
end;
/