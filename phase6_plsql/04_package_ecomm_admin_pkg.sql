/*==============================================================
  PHASE VI -- PL/SQL DEVELOPMENT
  Script 04: ECOMM_ADMIN_PKG -- Reporting & Maintenance Package
  Run as  : ECOMM_ADMIN

  Demonstrates: Parameterized explicit cursors and Dynamic DDL
  executed via EXECUTE IMMEDIATE.
==============================================================*/

------------------------------------------------------------------
-- PACKAGE SPECIFICATION
------------------------------------------------------------------
create or replace package ecomm_admin_pkg is
   procedure low_stock_report (
      p_threshold_override in number default null
   );

   procedure archive_audit_log (
      p_before_date in date
   );

end ecomm_admin_pkg;
/

SHOW ERRORS PACKAGE ecomm_admin_pkg;

------------------------------------------------------------------
-- PACKAGE BODY
------------------------------------------------------------------
create or replace package body ecomm_admin_pkg is

   procedure low_stock_report (
      p_threshold_override in number default null
   ) is
    -- Parameterized cursor using NVL override logic
      cursor c_low_stock (
         p_override in number
      ) is
      select p.product_name,
             i.quantity_on_hand,
             i.reorder_level
        from inventory i
        join products p
      on p.product_id = i.product_id
       where i.quantity_on_hand < nvl(
         p_override,
         i.reorder_level
      )
       order by i.quantity_on_hand;
      v_found boolean := false;
   begin
      dbms_output.put_line('=== Low Stock Report ===');
      for rec in c_low_stock(p_threshold_override) loop
         v_found := true;
         dbms_output.put_line(rpad(
            rec.product_name,
            25
         )
                              || ' | On hand: '
                              || lpad(
            rec.quantity_on_hand,
            4
         )
                              || ' | Reorder at: ' || rec.reorder_level);
      end loop;
      if not v_found then
         dbms_output.put_line('Nothing below threshold.');
      end if;
   end low_stock_report;


   procedure archive_audit_log (
      p_before_date in date
   ) is
      v_archive_table varchar2(60);
      v_count         number;
   begin
      select count(*)
        into v_count
        from audit_log
       where action_timestamp < p_before_date;

      if v_count = 0 then
         dbms_output.put_line('No audit rows older than '
                              || to_char(
            p_before_date,
            'YYYY-MM-DD'
         ) || '. Nothing to archive.');
         return;
      end if;

      v_archive_table := 'AUDIT_LOG_ARCHIVE_' || to_char(
         sysdate,
         'YYYYMMDD'
      );

    -- Dynamic DDL via EXECUTE IMMEDIATE with bind variable
      execute immediate 'CREATE TABLE '
                        || v_archive_table
                        || ' AS SELECT * FROM audit_log WHERE action_timestamp < :cutoff'
         using p_before_date;
      delete from audit_log
       where action_timestamp < p_before_date;
      commit;
      dbms_output.put_line(v_count
                           || ' audit row(s) archived into ' || v_archive_table);
   exception
      when others then
         rollback;
         raise_application_error(
            -20020,
            'ARCHIVE_AUDIT_LOG failed: ' || sqlerrm
         );
   end archive_audit_log;

end ecomm_admin_pkg;
/

SHOW ERRORS PACKAGE BODY ecomm_admin_pkg;