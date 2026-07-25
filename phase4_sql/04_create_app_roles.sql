-- Ensure we are in our project PDB
alter session set container = pdb_30848_ecommerce;

-- Create application roles
create role ecomm_manager;
create role ecomm_clerk;
create role ecomm_customer;

-- Verify roles created in PDB
select role
  from dba_roles
 where role like 'ECOMM_%';