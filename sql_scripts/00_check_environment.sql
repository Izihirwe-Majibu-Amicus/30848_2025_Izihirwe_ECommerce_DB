select banner
  from v$version;
select name,
       cdb,
       open_mode
  from v$database;
select name,
       open_mode,
       restricted
  from v$pdbs;
select sys_context(
   'USERENV',
   'CON_NAME'
) as current_container
  from dual;