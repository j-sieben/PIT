prompt &s1.Create synonym &1.
begin
  if '&PIT_USER.' != user then
    execute immediate 'create or replace synonym &1. for &PIT_USER..&1.';
  end if;
end;
/
