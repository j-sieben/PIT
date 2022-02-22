begin
  pit_admin.delete_message_group(
    p_pmg_name => 'PIT_UI',
    p_force => true);
    
  pit_admin.merge_message_group(
    p_pmg_name => 'PIT_UI',
    p_pmg_description => 'Messages for the PIT_UI'
  );
  
  pit_admin.merge_message(
    p_pms_name => 'PIT_INVALID_INTEGER',
    p_pms_pmg_name => 'PIT_UI',
    p_pms_text => 'Eine Ganzzahl wurde erwartet, eingegeben wurde jedoch #1#.',
    p_pms_description => q'^Offensichtlich.^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'GERMAN');
    
    
  pit_admin.merge_message(
    p_pms_name => 'PAR_PGR_EXPORTED',
    p_pms_pmg_name => 'PIT_UI',
    p_pms_text => 'Parametergruppe #1# wurde exportiert.',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN');
    
    
  pit_admin.merge_message(
    p_pms_name => 'PIT_XLIFF_IMPORTED',
    p_pms_pmg_name => 'PIT_UI',
    p_pms_text => 'Übersetzung erfolgreich importiert.',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'PIT_UI_INVALID_REQUEST',
    p_pms_pmg_name => 'PIT_UI',
    p_pms_text => q'^Für den Request »#1#« ist kein Handler hinterlegt.^',
    p_pms_description => q'^In einer Auswahlliste ist für den aktuellen Requestwert kein Entschiedungsbaum hinterlegt. Daher wird dieser Request nicht behandelt.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_UI_PARAMETER_REQUIRED',
    p_pms_pmg_name => 'PIT_UI',
    p_pms_text => q'^Parameter »#1#« darf nicht NULL sein.^',
    p_pms_description => q'^Offensichtlich.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);
    
  commit;
  
  pit_admin.create_message_package;
end;
/
