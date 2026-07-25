alter session set container = cdb$root;

-- 1. Drop default XEPDB1 to free up the 1-PDB slot in Oracle 21c XE
alter pluggable database xepdb1 close immediate;
drop pluggable database xepdb1 including datafiles;

-- 2. Create PDB using standard seed template
create pluggable database pdb_30848_ecommerce
   admin user pdbadmin identified by "PdbAdmin#2026Pass" roles = ( dba )
      file_name_convert = ( 'pdbseed','PDB_30848_ECOMMERCE' );

-- 3. Open and save state so it stays open on restarts
alter pluggable database pdb_30848_ecommerce open;
alter pluggable database pdb_30848_ecommerce save state;

-- 4. Verify PDB status
select name,
       open_mode
  from v$pdbs
 where name = 'PDB_30848_ECOMMERCE';