begin

  pit_admin.merge_message_group(
    p_pmg_name => 'PIT',
    p_pmg_description => q'^Core PIT messages and translatable items^');

  pit_admin.merge_translatable_item(
    p_pti_id => 'LEVEL_OFF',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => 'PIT',
    p_pti_name => 'Logging aus',
    p_pti_display_name => 'Logging aus',
    p_pti_description => 'Schaltet das Logging aus, Fehler und fatale Fehler werden dennoch geloggt');

  pit_admin.merge_translatable_item(
    p_pti_id => 'LEVEL_FATAL',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => 'PIT',
    p_pti_name => 'Fataler Fehler',
    p_pti_display_name => 'Fataler Fehler',
    p_pti_description => 'Unbehandelter Fehler, wird an die aufrufende Umgebung propagiert');

  pit_admin.merge_translatable_item(
    p_pti_id => 'LEVEL_ERROR',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => 'PIT',
    p_pti_name => 'Fehler',
    p_pti_display_name => 'Fehler',
    p_pti_description => 'Fehler, wird durch PIT abschließend behandelt');

  pit_admin.merge_translatable_item(
    p_pti_id => 'LEVEL_WARN',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => 'PIT',
    p_pti_name => 'Warnung',
    p_pti_display_name => 'Warnung',
    p_pti_description => 'Warnung, kann unterdrückt werden, dient der Information über ungewöhnliche Vorkommnisse');

  pit_admin.merge_translatable_item(
    p_pti_id => 'LEVEL_INFO',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => 'PIT',
    p_pti_name => 'Information',
    p_pti_display_name => 'Information',
    p_pti_description => 'Information, z.B. über erflogreiche Anmeldungen etc.');

  pit_admin.merge_translatable_item(
    p_pti_id => 'LEVEL_DEBUG',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => 'PIT',
    p_pti_name => 'Debug-Meldung',
    p_pti_display_name => 'Debug-Meldung',
    p_pti_description => 'Debug-Meldung mit eher technischem Hintergrund zur Verfolgung der Ausführung des Codes');

  pit_admin.merge_translatable_item(
    p_pti_id => 'LEVEL_ALL',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => 'PIT',
    p_pti_name => 'Alle',
    p_pti_display_name => 'Alle',
    p_pti_description => 'Weitergehende Loginformationen, detaillierte Codemeldungen');

  pit_admin.merge_translatable_item(
    p_pti_id => 'TRACE_ALL',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => 'PIT',
    p_pti_name => 'Alle',
    p_pti_display_name => 'Alle',
    p_pti_description => 'Übermittelt alle Methodenaufrufe');

  pit_admin.merge_translatable_item(
    p_pti_id => 'TRACE_DETAILED',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => 'PIT',
    p_pti_name => 'Detailliert',
    p_pti_display_name => 'Detailliert',
    p_pti_description => 'Übermittelt Methodenaufrufe über ENTER_DETAILED');

  pit_admin.merge_translatable_item(
    p_pti_id => 'TRACE_OPTIONAL',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => 'PIT',
    p_pti_name => 'Optional',
    p_pti_display_name => 'Optional',
    p_pti_description => 'Übermittelt Methodenaufrufe über ENTER_OPTIONAL');

  pit_admin.merge_translatable_item(
    p_pti_id => 'TRACE_MANDATORY',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => 'PIT',
    p_pti_name => 'Verpflichtend',
    p_pti_display_name => 'Verpflichtend',
    p_pti_description => 'Übermittelt Methodenaufrufe über ENTER_MANDATORY');

  pit_admin.merge_translatable_item(
    p_pti_id => 'TRACE_OFF',
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => 'PIT',
    p_pti_name => 'Tracing aus',
    p_pti_display_name => 'Tracing aus',
    p_pti_description => 'Unterdrückt die Ausgabe von Tracing-Informationen');    

  pit_admin.merge_translatable_item(
    p_pti_id => 'BOOLEAN_' || replace(&C_TRUE., ''''),
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => 'PIT',
    p_pti_name => &C_TRUE.,
    p_pti_display_name => 'Ja',
    p_pti_description => 'Boolescher Wert für WAHR');

  pit_admin.merge_translatable_item(
    p_pti_id => 'BOOLEAN_' || replace(&C_FALSE., ''''),
    p_pti_pml_name => 'GERMAN',
    p_pti_pmg_name => 'PIT',
    p_pti_name => &C_FALSE.,
    p_pti_display_name => 'Nein',
    p_pti_description => 'Boolescher Wert für FALSCH');
    
    
  commit;
end;
/
