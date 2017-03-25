begin
  pit_admin.merge_message(
    p_pms_name => 'PIT_INVALID_INTEGER',
    p_pms_text => 'Eine Ganzzahl wurde erwartet, eingegeben wurde jedoch #1#.',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN');
    
    
  pit_admin.merge_message(
    p_pms_name => 'PAR_PGR_EXPORTED',
    p_pms_text => 'Parametergruppe #1# wurde exportiert.',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN');
    
  commit;
  
  pit_admin.create_message_package;
end;
/