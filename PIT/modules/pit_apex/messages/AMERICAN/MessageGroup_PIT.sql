begin
    

  pit_admin.merge_message(
    p_pms_name => 'WEBSOCKET_MESSAGE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^#1#: #2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  commit;
  pit_admin.create_message_package;
end;
/