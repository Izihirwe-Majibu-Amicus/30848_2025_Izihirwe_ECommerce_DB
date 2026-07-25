alter session set container = pdb_30848_ecommerce;

-- Staff account (Mugisha)
create user mugisha identified by "StaffUser#2026Pass"
   default tablespace ecomm_data
   temporary tablespace ecomm_temp
   quota 0 on ecomm_data;

grant connect,ecomm_clerk to mugisha;

-- Admin account (Akarenzi)
create user akarenzi identified by "AdminUser#2026Pass"
   default tablespace ecomm_data
   temporary tablespace ecomm_temp
   quota 0 on ecomm_data;

grant connect,ecomm_manager to akarenzi;

-- Verify user account statuses
select username,
       account_status
  from dba_users
 where username in ( 'MUGISHA',
                     'AKARENZI' );

-- Verify granted roles
select grantee,
       granted_role
  from dba_role_privs
 where grantee in ( 'MUGISHA',
                    'AKARENZI' );