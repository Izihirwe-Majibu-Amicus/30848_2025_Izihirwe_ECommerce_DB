-- Switch session context to our project PDB
alter session set container = pdb_30848_ecommerce;

-- Create application schema user
create user ecomm_admin identified by "EcommAdmin#2026Pass"
   default tablespace ecomm_data
   temporary tablespace ecomm_temp
   quota unlimited on ecomm_data;

-- Grant required system privileges
grant connect,resource,
   create view,
   create sequence,
   create procedure
to ecomm_admin;

-- Verify user creation and default tablespaces
select username,
       default_tablespace,
       temporary_tablespace,
       account_status
  from dba_users
 where username = 'ECOMM_ADMIN';