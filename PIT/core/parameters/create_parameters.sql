begin
  param_admin.edit_parameter_type('STRING', 'Einfache Texte');
  param_admin.edit_parameter_type('HTML', 'HTML-Instanzen');
  param_admin.edit_parameter_type('SQL', 'SQL-Anweisungen');
  
  param_admin.edit_parameter_realm(
    p_pre_id => 'ENTWICKLUNG', 
    p_pre_description => 'Entwicklungsumgebung');
  
  param_admin.edit_parameter_realm(
    p_pre_id => 'FREIGABE', 
    p_pre_description => 'Freigabe-Umgebung');
  
  param_admin.edit_parameter_realm(
    p_pre_id => 'PNT', 
    p_pre_description => 'Produktionsnahe Testumgebung');
  
  param_admin.edit_parameter_realm(
    p_pre_id => 'PRODUKTION', 
    p_pre_description => 'Produktionsumgebung');
  
  param_admin.edit_parameter_realm(
    p_pre_id => 'TEST', 
    p_pre_description => 'Testumgebung');
    
  commit;
end;
/
