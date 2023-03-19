begin

  pit_admin.merge_message(
    p_pms_name => 'PIT_WEBSOCKET_MESSAGE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^#1#: #2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null);

  commit;
  pit_admin.create_message_package;
end;
/