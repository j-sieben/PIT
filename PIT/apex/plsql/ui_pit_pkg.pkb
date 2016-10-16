create or replace
package body ui_pit_pkg as

  procedure merge_message(
    p_messagen_name in pit_message.pms_name%type,
    p_pms_pml_name in pit_message.pms_pml_name%type,
    p_pms_text in pit_message.pms_text%type,
    p_pms_pse_id in pit_message.pms_pse_id%type,
    p_pms_custom_error pit_message.pms_custom_error%type) as
  begin
    -- TODO: Implementierung für procedure UI_PIT_PKG.merge_message erforderlich
    null;
  end merge_message;

  procedure delete_message(
    p_pms_name in pit_message.pms_name%type) as
  begin
    -- TODO: Implementierung für procedure UI_PIT_PKG.delete_message erforderlich
    null;
  end delete_message;

end ui_pit_pkg;