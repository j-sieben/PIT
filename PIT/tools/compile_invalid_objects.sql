prompt &h2.Recompile invalid schema objects

begin
  dbms_utility.compile_schema(
    schema => user,
    compile_all => false,
    reuse_settings => true);

  for obj in (
    select object_name, object_type
      from user_objects
     where status != 'VALID'
     order by object_type, object_name)
  loop
    dbms_output.put_line(
      '&s1.Remains invalid: ' || obj.object_type || ' ' || obj.object_name);
  end loop;
end;
/
