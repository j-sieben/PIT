begin

  pit_admin.merge_message_group(
    p_pmg_name => 'PITA',
    p_pmg_description => 'Messages for the PITA application',
    p_pmg_error_prefix => '',
    p_pmg_error_postfix => 'ERR');

  pit_admin.merge_translatable_item(
    p_pti_id => 'PMET_NONE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^PITA^',
    p_pti_name => q'^kein Fehlerobjekt^',
    p_pti_display_name => q'^kein Fehlerobjekt^',
    p_pti_description => q'^Meldung soll keine Fehlerkonstante in PL/SQL erhalten^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'PMET_CUSTOM',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^PITA^',
    p_pti_name => q'^Anwendungsfehler^',
    p_pti_display_name => q'^Anwendungsfehler^',
    p_pti_description => q'^Fehlercode aus dem Zahlenraum -21000 - -20000^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'PMET_ORACLE',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^PITA^',
    p_pti_name => q'^Oracle-Fehler^',
    p_pti_display_name => q'^Oracle-Fehler^',
    p_pti_description => q'^Von Oracle definierter, nich benannter Fehlercode^'
  );

  commit;
end;
/