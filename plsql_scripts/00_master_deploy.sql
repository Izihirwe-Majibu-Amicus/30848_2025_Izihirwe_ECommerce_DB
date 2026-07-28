/*==============================================================
  MASTER DEPLOYMENT RUNNER
  Project: Enterprise E-Commerce Database Architecture
  Author: Izihirwe-Majibu-Amicus
  Run as: ECOMM_ADMIN
==============================================================*/

   SET ECHO ON;
SET DEFINE OFF;
SET SERVEROUTPUT ON SIZE UNLIMITED;
SPOOL master_deployment_log.txt;

pro    =========================================================
pro     STARTING FULL DATABASE ARCHITECTURE DEPLOYMENT
pro    =========================================================

pro    [1/5] Executing Database Creation & Schema Setup...
@@../phase4_database_creation/01_create_tablespaces_user.sql;
@@../phase5_table_implementation/01_create_tables_constraints.sql;

pro    [2/5] Compiling Security Packages & Helper Modules...
@@../phase6_plsql/01_ecomm_security_pkg.sql;
@@../phase6_plsql/02_ecomm_order_pkg.sql;

pro    [3/5] Compiling Database Triggers & Business Rules...
@@../phase7_triggers_security/01_audit_triggers.sql;
@@../phase7_triggers_security/02_compound_triggers.sql;

pro    [4/5] Creating Power BI & Executive Analytics Views...
@@../phase8_documentation/01_bi_reporting_views.sql;

pro    [5/5] Recompiling Schema Objects & Verifying Status...
EXEC DBMS_UTILITY.compile_schema(schema => USER, compile_all => FALSE);

select object_type,
       object_name,
       status
  from user_objects
 where status != 'VALID';

pro    =========================================================
pro     DEPLOYMENT COMPLETE! Check master_deployment_log.txt
pro    =========================================================

SPOOL OFF;