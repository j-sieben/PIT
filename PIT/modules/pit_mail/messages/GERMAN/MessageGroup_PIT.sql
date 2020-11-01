begin

  pit_admin.merge_message(
    p_pms_name => 'PIT_MAIL_SALUTATION',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Sehr geehrte Damen und Herren^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_MAIL_SALUTATION_FEMALE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Sehr geehte Frau #1##2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_MAIL_SALUTATION_MALE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Sehr geehrter Herr #1##2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 60,
    p_pms_pml_name => 'GERMAN',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_MAIL_MESSAGE_TEMPLATE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^<tr><td>#SEVERITY#</td><td>#AMOUNT#</td><td>#FIRST_DATE#</td><td>#LAST_DATE#</td><td>#MESSAGE#</td><td>#STACK#</td><td>#BACKTRACE#</td></tr>^',
    p_pms_description => q'^Vorlage, die festlegt, wie eine Nachricht zum Senden vorbereitet werden soll. Sollte die Ersatzanker SEVERITY, AMOUNT, FIRST_DATE, LAST_DATE, MESSAGE, STACK und BACKTRACE enthalten^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'PIT_MAIL_MAIL_TEMPLATE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^<p>Die folgenden Fehler wurden gemeldet: <p>
   <table><thead><tr><td>Schweregrad</td><td>Menge</td><td>Erstes Vorkommen</td><td>Letztes Vorkommen</td><td>Text</td><td>Fehlernummer</td><td>Aufrufstapel</td></tr></thead><tbody>#MELDUNGEN#</body></table>^',
    p_pms_description => q'^Email-Vorlage des Moduls PIT_MAIL. Muss mindestens einen MESSAGES-Anker enthalten, in den die Nachrichten eingefügt werden.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN');

  pit_admin.merge_message(
    p_pms_name => 'PIT_MAIL_ATTACHMENT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Der Fehlerbericht ist als Anhang beigefügt.^',
    p_pms_description => q'^Message wird verwendet, wenn die Fehlermeldung zu lang ist, um in eine normale Mail eingebaut zu werden.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'GERMAN');


  commit;
  pit_admin.create_message_package;
  
end;
/