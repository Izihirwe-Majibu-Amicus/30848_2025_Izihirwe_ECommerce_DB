-- Switch session context to our project PDB
alter session set container = pdb_30848_ecommerce;

-- Create primary data tablespace
create tablespace ecomm_data
   datafile 'ecomm_data01.dbf' size 100M
   autoextend on next 50M maxsize 500M
   extent management local
segment space management auto;

-- Create dedicated temporary tablespace
create temporary tablespace ecomm_temp
   tempfile 'ecomm_temp01.dbf' size 50M
   autoextend on next 25M maxsize 200M;

-- Verify created tablespaces
select tablespace_name,
       status,
       contents
  from dba_tablespaces
 where tablespace_name in ( 'ECOMM_DATA',
                            'ECOMM_TEMP' );