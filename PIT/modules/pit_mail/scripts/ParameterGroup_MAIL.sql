begin

  param_admin.edit_parameter_group(
    p_pgr_id => 'MAIL',
    p_pgr_description => 'Parameters for MAIL helper package',
    p_pgr_is_modifiable => true
  );
  
  param_admin.edit_parameter(
    p_par_id => 'SEND'
   ,p_par_pgr_id => 'MAIL'
   ,p_par_description => 'Errorhandling'
   ,p_par_string_value => q'^^'
   ,p_par_pat_id => 'STRING'
  );

  commit;
end;
/