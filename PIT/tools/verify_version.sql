set define &
prompt Verifying PIT version &PIT_VERSION. Git commit &PIT_GIT_COMMIT.
declare
  l_valid pls_integer;
  l_version varchar2(128);
  l_commit varchar2(128);
begin
  select count(*) into l_valid
    from user_objects
   where object_name = 'PIT'
     and object_type in ('PACKAGE', 'PACKAGE BODY')
     and status = 'VALID';
  if l_valid != 2 then
    raise_application_error(-20000, 'PIT package specification or body is invalid.');
  end if;
  -- Dynamic SQL verifies SQL callability and still reports invalid objects above.
  execute immediate 'select pit.get_version(), pit.get_git_commit() from dual'
    into l_version, l_commit;
  if l_version is null or l_commit is null
     or l_version != '&PIT_VERSION.' or l_commit != '&PIT_GIT_COMMIT.' then
    raise_application_error(-20000, 'Installed PIT version does not match installation metadata.');
  end if;
  dbms_output.put_line('Installed PIT ' || l_version || ' Git commit ' || l_commit);
end;
/
