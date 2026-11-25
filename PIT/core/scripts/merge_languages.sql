prompt &s1.Merge message languages
-- Seed the parent row before DEFAULT ON NULL is used by the bulk import.
-- Older installations receive PML_EFFECTIVE_NAME after this script runs.
declare
  l_has_default number;
  l_has_effective_name number;
  l_language pit_message_language.pml_name%type := '&DEFAULT_LANGUAGE.';
  l_display_name pit_message_language.pml_display_name%type;
begin
  select count(*) into l_has_default
    from pit_message_language
   where pml_name = l_language;

  if l_has_default = 0 then
    l_display_name := case l_language when 'GERMAN' then 'Deutsch'
                     else initcap(l_language) end;
    select count(*) into l_has_effective_name
      from user_tab_columns
     where table_name = 'PIT_MESSAGE_LANGUAGE'
       and column_name = 'PML_EFFECTIVE_NAME';

    if l_has_effective_name > 0 then
      execute immediate q'[
        insert into pit_message_language (
          pml_name, pml_display_name, pml_default_order, pml_effective_name)
        values (:language, :display_name, 10, :effective_name)]'
        using l_language, l_display_name, l_language;
    else
      insert into pit_message_language (
        pml_name, pml_display_name, pml_default_order)
      values (l_language, l_display_name, 10);
    end if;
  end if;
end;
/

merge into pit_message_language t
using (select value pml_name, 
              case value 
              when '&DEFAULT_LANGUAGE.' then 10
              else 0 end pml_default_order,
              case value when 'GERMAN' then 'Deutsch'
              else initcap(value) end pml_display_name
         from v$nls_valid_values
        where parameter = 'LANGUAGE') s
   on (t.pml_name = s.pml_name)
 when matched then update set
      t.pml_default_order = s.pml_default_order,
      t.pml_display_name = s.pml_display_name
 when not matched then insert (pml_name, pml_display_name, pml_default_order)
      values (s.pml_name, s.pml_display_name, s.pml_default_order);

commit;