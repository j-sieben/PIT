begin

  pit_admin.merge_message_group(
    p_pmg_name => 'PIT_APEX',
    p_pmg_description => q'^Meldung für Ausgabemodul PIT_MAIL^'
  );


  pit_admin.merge_message(
    p_pms_name => 'WEBSOCKET_MESSAGE',
    p_pms_pmg_name => 'PIT_APEX',
    p_pms_text => q'^#1#: #2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );
  
  commit;
  pit_admin.create_message_package;
end;
/