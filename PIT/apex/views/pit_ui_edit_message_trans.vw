create or replace force view pit_ui_edit_message_trans as
select pms_name, pms_pml_name, pms_text
  from pit_message
 where pms_id is null;
    

create or replace trigger pit_ui_edit_msg_trans_iot
instead of insert or update or delete on pit_ui_edit_message_trans
for each row
begin
  if inserting or updating then
    pit_admin.translate_message(
      p_pms_name => :new.pms_name,
      p_pms_text => :new.pms_text,
      p_pms_pml_name => :new.pms_pml_name);
  else
    pit_admin.remove_message(
      p_pms_name => :old.pms_name,
      p_pms_pml_name => :old.pms_pml_name);
  end if;
end;
/