-- 1) PDB status
select name,
       open_mode,
       restricted
  from v$pdbs
 where name = 'PDB_30848_ECOMMERCE';

alter session set container = pdb_30848_ecommerce;

-- 2) Tablespaces
select tablespace_name,
       status,
       contents
  from dba_tablespaces
 where tablespace_name in ( 'ECOMM_DATA',
                            'ECOMM_TEMP' );

-- 3) Users
select username,
       account_status,
       default_tablespace,
       temporary_tablespace,
       created
  from dba_users
 where username in ( 'ECOMM_ADMIN',
                     'MUGISHA',
                     'AKARENZI' )
 order by created;

-- 4) Roles
select role
  from dba_roles
 where role like 'ECOMM_%';

select grantee,
       granted_role
  from dba_role_privs
 where grantee in ( 'ECOMM_ADMIN',
                    'MUGISHA',
                    'AKARENZI' )
 order by granted_role,
          grantee;

-- 5) System privileges
select grantee,
       privilege
  from dba_sys_privs
 where grantee = 'ECOMM_ADMIN'
 order by privilege;

-- 6) Quotas
select username,
       tablespace_name,
       max_bytes
  from dba_ts_quotas
 where username in ( 'ECOMM_ADMIN',
                     'MUGISHA',
                     'AKARENZI' );