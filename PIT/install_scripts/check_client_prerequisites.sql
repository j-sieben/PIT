
declare
  l_count binary_integer;
begin
  select count(*)
    into l_count
    from all_users
   where username = upper('&1.');
   
  if l_count = 0 then
    raise_application_error(-20000, 'User &1. does not exist, please check your parameters');
  end if;
  
  select count(*)
    into l_count
    from user_objects
   where object_type = 'PACKAGE'
     and object_name = 'PIT';
   
  if l_count = 0 then
    raise_application_error(-20000, 'User ' || user || ' has no PIT installed. Please install it first');
  end if;
end;
/
