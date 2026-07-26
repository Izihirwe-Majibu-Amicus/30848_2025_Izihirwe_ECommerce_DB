/*==============================================================
  PHASE VI -- PL/SQL DEVELOPMENT
  Script 06: Verification Bundle (READ-ONLY)
  Run as  : ECOMM_ADMIN
==============================================================*/

-- 1) Check object status (all should show VALID)
select object_name,
       object_type,
       status
  from user_objects
 where object_type in ( 'FUNCTION',
                        'PROCEDURE',
                        'PACKAGE',
                        'PACKAGE BODY' )
 order by object_type,
          object_name;

-- 2) Check for any lingering compilation errors
select name,
       type,
       line,
       position,
       text
  from user_errors
 order by name,
          type,
          sequence;

-- 3) State of the order table after test suite execution
select order_id,
       customer_id,
       order_status,
       order_date
  from orders
 order by order_id;