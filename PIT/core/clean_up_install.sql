declare
  object_does_not_exist exception;
  pragma exception_init(object_does_not_exist, -4043);
  table_does_not_exist exception;
  pragma exception_init(table_does_not_exist, -942);
  sequence_does_not_exist exception;
  pragma exception_init(sequence_does_not_exist, -2282);
  synonym_does_not_exist exception;
  pragma exception_init(synonym_does_not_exist, -1434);
  cursor delete_object_cur is
          select object_name name, object_type type
            from all_objects
           where object_name in (
                 'MESSAGE_TYPE', 'MSG_PARAM', 'MSG_PARAMS', 'MSG_ARGS', 'MSG_ARGS_CHAR', 'PIT_MODULE', 
                 'DEFAULT_ADAPTER', 'CALL_STACK_TYPE', 'PIT_MODULE_LIST', 'PIT_CONTEXT', '', 
                 'PIT_MODULE_META', 'PIT_MODULE_LIST', 'CHAR_TABLE', -- Typen
                 'MSG', 'PIT', 'PIT_PKG', 'PIT_ADMIN', 'PIT_UTIL', -- Packages
                 'PIT_MESSAGE_LANGUAGE_V', 'PIT_MESSAGE_V', 'PIT_TRANSLATABLE_ITEM_V', -- Views
                 'PIT_MESSAGE', 'PIT_MESSAGE_LANGUAGE', 'PIT_MESSAGE_SEVERITY', 'PIT_TRACE_LEVEL', 'PIT_MESSAGE_GROUP', 'PIT_TRANSLATABLE_ITEM',  -- Tabellen
                 'MSG',  -- Synonyme
                 'PIT_LOG_SEQ', 'PIT_TRANSLATABLE_ITEM_SEQ' -- Sequenzen
                 )
             and object_type not like '%BODY'
             and owner = upper('&INSTALL_USER.')
           order by object_type, object_name;
           
  cursor context_cur is
    select namespace
      from dba_context
     where schema = upper('&INSTALL_USER.')
       and namespace in ('PIT_CTX', 'PIT_CTX_&INSTALL_USER.');
       
begin
  for obj in delete_object_cur loop
    begin
      execute immediate 'drop ' || obj.type || ' ' || obj.name ||
                        case obj.type 
                        when 'TYPE' then ' force' 
                        when 'TABLE' then ' cascade constraints' 
                        end;
     dbms_output.put_line('&s1.' || initcap(obj.type) || ' ' || obj.name || ' deleted.');
    
    exception
      when object_does_not_exist or table_does_not_exist or sequence_does_not_exist or synonym_does_not_exist then
        dbms_output.put_line('&s1.' || obj.type || ' ' || obj.name || ' does not exist.');
      when others then
        raise;
    end;
  end loop;
  for ctx in context_cur loop
    execute immediate 'drop context ' || ctx.namespace;
    dbms_output.put_line('&s1.Context ' || ctx.namespace || ' deleted.');
  end loop;
end;
/