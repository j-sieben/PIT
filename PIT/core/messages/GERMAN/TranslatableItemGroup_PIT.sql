begin

  pit_admin.merge_message_group(
    p_pmg_name => 'PIT',
    p_pmg_description => q'^Core PIT messages and translatable items^',
    p_pmg_error_prefix => '',
    p_pmg_error_postfix => 'ERR');

  pit_admin.merge_translatable_item(
    p_pti_id => 'BOOLEAN_' || replace(to_char(&C_FALSE.), ''''),
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^PIT^',
    p_pti_name => q'^&C_FALSE.^',
    p_pti_display_name => q'^Nein^',
    p_pti_description => q'^Boolescher Wert für FALSCH^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'BOOLEAN_' || replace(to_char(&C_FALSE.), ''''),
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^PIT^',
    p_pti_name => q'^&C_TRUE.^',
    p_pti_display_name => q'^Ja^',
    p_pti_description => q'^Boolescher Wert für WAHR^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LEVEL_ALL',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^PIT^',
    p_pti_name => q'^Alle^',
    p_pti_display_name => q'^Alle^',
    p_pti_description => q'^Weitergehende Loginformationen, detaillierte Codemeldungen^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LEVEL_DEBUG',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^PIT^',
    p_pti_name => q'^Debug-Meldung^',
    p_pti_display_name => q'^Debug-Meldung^',
    p_pti_description => q'^Debug-Meldung mit eher technischem Hintergrund zur Verfolgung der Ausführung des Codes^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LEVEL_ERROR',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^PIT^',
    p_pti_name => q'^Fehler^',
    p_pti_display_name => q'^Fehler^',
    p_pti_description => q'^Fehler, wird durch PIT abschließend behandelt^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LEVEL_FATAL',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^PIT^',
    p_pti_name => q'^Fataler Fehler^',
    p_pti_display_name => q'^Fataler Fehler^',
    p_pti_description => q'^Unbehandelter Fehler, wird an die aufrufende Umgebung propagiert^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LEVEL_INFO',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^PIT^',
    p_pti_name => q'^Information^',
    p_pti_display_name => q'^Information^',
    p_pti_description => q'^Information, z.B. über erflogreiche Anmeldungen etc.^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LEVEL_OFF',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^PIT^',
    p_pti_name => q'^Logging aus^',
    p_pti_display_name => q'^Logging aus^',
    p_pti_description => q'^Schaltet das Logging aus, Fehler und fatale Fehler werden dennoch geloggt^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'LEVEL_WARN',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^PIT^',
    p_pti_name => q'^Warnung^',
    p_pti_display_name => q'^Warnung^',
    p_pti_description => q'^Warnung, kann unterdrückt werden, dient der Information über ungewöhnliche Vorkommnisse^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'TRACE_ALL',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^PIT^',
    p_pti_name => q'^Alle^',
    p_pti_display_name => q'^Alle^',
    p_pti_description => q'^Übermittelt alle Methodenaufrufe^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'TRACE_DETAILED',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^PIT^',
    p_pti_name => q'^Detailliert^',
    p_pti_display_name => q'^Detailliert^',
    p_pti_description => q'^Übermittelt Methodenaufrufe über ENTER_DETAILED^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'TRACE_MANDATORY',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^PIT^',
    p_pti_name => q'^Verpflichtend^',
    p_pti_display_name => q'^Verpflichtend^',
    p_pti_description => q'^Übermittelt Methodenaufrufe über ENTER_MANDATORY^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'TRACE_OFF',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^PIT^',
    p_pti_name => q'^Tracing aus^',
    p_pti_display_name => q'^Tracing aus^',
    p_pti_description => q'^Unterdrückt die Ausgabe von Tracing-Informationen^'
  );

  pit_admin.merge_translatable_item(
    p_pti_id => 'TRACE_OPTIONAL',
    p_pti_pml_name => q'^GERMAN^',
    p_pti_pmg_name => q'^PIT^',
    p_pti_name => q'^Optional^',
    p_pti_display_name => q'^Optional^',
    p_pti_description => q'^Übermittelt Methodenaufrufe über ENTER_OPTIONAL^'
  );

  commit;
end;
/