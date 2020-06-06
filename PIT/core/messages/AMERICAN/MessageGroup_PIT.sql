begin

  pit_admin.merge_message_group(
    p_pmg_name => 'PIT',
    p_pmg_description => q'^Core PIT messages^');

  pit_admin.merge_message(
    p_pms_name => 'ASSERTION_FAILED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Assertion failed.^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ASSERT_EXISTS',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^A statement was expected to return rows, but did not.^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ASSERT_IS_NOT_NULL',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^#1# was expected, but was null.^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ASSERT_IS_NULL',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^A value was expected to be null, but was [#1#].^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ASSERT_NOT_EXISTS',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^A statement was expected to return no rows, but did.^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'ASSERT_TRUE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^A value was expected to be equal, but was not.^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'CASE_NOT_FOUND',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^#1# not found when executing CASE statement^',
    p_pms_description => q'^An option was passed for which no handler was present in a CASE statement and which does not contain an ELSE branch.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'CTX_CHANGED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Context set to ##1#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'CTX_CREATED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Context ##1# created and added to the available contexts list.^',
    p_pms_description => q'^A context collects log settings under one name.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'CTX_CREATION_ERROR',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Error initializing a new context.^',
    p_pms_description => q'^As a rule, a context cannot be initialized if invalid settings were passed for the individual parameters.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'CTX_DEFAULT_CREATION_ERROR',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Default Context could not be created.^',
    p_pms_description => q'^The default context is created by initialization parameters. Make sure that no invalid entries are contained there.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'CTX_INVALID_CONTEXT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Context #1# does not exist. Please provide a valid context name that is controlled by #2#.^',
    p_pms_description => q'^Create a context using UTL_CONTEXT.CREATE_CONTEXT before you use it^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'CTX_MISSING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Tried to call context ##1# but it is not existing.^',
    p_pms_description => q'^Create a context using PIT_ADMIN.CREATE_NAMED_CONTEXT before you use it^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'CTX_NO_CONTEXT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Context cannot be null. Please provide a valid context name.^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'IMPOSSIBLE_CONVERSION',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Invalid conversion of element value "#1#" and format mask "#2#" to type #3#.^',
    p_pms_description => q'^The element value could not be converted correctly when automatically determining a date or numeric value.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'INVALID_SQL_NAME',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^The identifier does not correspond to the specifications for an SQL identifier. ""-encoded names are not allowed.^',
    p_pms_description => q'^The identifier must comply with the naming rules of SQL. In addition, names masked by "-characters are not allowed.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -44003);

  pit_admin.merge_message(
    p_pms_name => 'LONG_OP_WO_TRACE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Use of PIT.LONG_OP requires PIT.ENTER/LEAVE usage.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PARAM_ADMIN_MODE_REQUIRED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Requested change requires admin mode.^',
    p_pms_description => q'^To make changes, you must be logged in as administrator.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PARAM_IS_NULL',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^The requested parameter #1# doesn't exist.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PARAM_NOT_EXTENDABLE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Parameter-Group does not allow for new parameters.^',
    p_pms_description => q'^Parameter groups can prohibit changes by the end user. This is the case here, the parameters cannot be changed.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PARAM_NOT_FOUND',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Parameter #1# does not exist.^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PARAM_NOT_MODIFIABLE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Parameter #1# is not allowed to be changed.^',
    p_pms_description => q'^A parameter can be defined as not changeable, in contrast to the settings of the parameter group. This is the case here.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_BULK_ERROR',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^An error occurred during execution of a bulk processing.^',
    p_pms_description => q'^If PIT is in collect mode and at least one error of level C_LEVEL_ERROR is raised, this error is thrown.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_BULK_FATAL',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^A fatal error occurred during execution of a bulk processing.^',
    p_pms_description => q'^If PIT is in collect mode and at least one error of level C_LEVEL_FATAL is raised, this error is thrown.^',
    p_pms_pse_id => 20,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CODE_ENTER',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Entering: #1#^',
    p_pms_description => q'^This message is output when a procedure or function is called.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CODE_ENTER_W_PARAM',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Entering: #1#, Params: #2#^',
    p_pms_description => q'^Diese Meldung wird ausgegeben, wenn eine Prozedur oder Funktion aufgerufen wird.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CODE_LEAVE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Leaving: #1#^',
    p_pms_description => q'^This message is issued when a procedure or function is left.^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CONTEXT_MISSING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^The context #1# does not exist. Please create it in advance.^',
    p_pms_description => q'^A toggle must reference an existing context, otherwise the output will not work.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_DUPLICATE_MESSAGE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^he message #1# you entered already exists.^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_FAIL_MESSAGE_CREATION',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Log message "#1#" could not be created.^',
    p_pms_description => q'^No further details^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_FAIL_MESSAGE_PURGE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Error purging the message stack.^',
    p_pms_description => q'^No further details^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_FAIL_MODULE_INIT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Module #1# received an error during installation: #2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_FAIL_READ_MODULE_LIST',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Error reading the list of modules.^',
    p_pms_description => q'^The list of modules includes all installed, initialized or active output modules. This list was empty here.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_INITIALIZED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Finished initialization at #1#. Loaded modules: [#2#]^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_INSTANTIATED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Module #1# has been succesfully instantiated.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 50,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_LIST_LOADED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Module list has been successfully loaded.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_PARAM_MISSING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^At least one output module must be specified.^',
    p_pms_description => q'^If no output module has been defined in the current context that can be initialized, PIT cannot output any messages. Make sure that at least one module can be reached.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_TERMINATED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Module #1# was terminated due to an error.^',
    p_pms_description => q'^If an error occurs during the initialization of a module, the module is deactivated. Other modules continue to operate normally.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_UNAVAILABLE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Module #1# has been requested, but is not available.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 40,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_MSG_NOT_EXISTING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Message #1# does not exist. Call PIT using Package MSG to avoid this error.^',
    p_pms_description => q'^A message must be created by procedure PIT_ADMIN.MERGE_MESSAGE. Then method PIT_ADMIN.CREATE_MESSAGE_PACKAGE must be called to update package MSG.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_NAME_TOO_LONG',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^The identifier exceeds the maximum length of #1# characters.^',
    p_pms_description => q'^A maximum length is specified for an identifier. This length is currently exceeded.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_PARAM_OUT_OF_RANGE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Parameter #1# was expected to be in (#2#) but was #3#.^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_PASS_MESSAGE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_READ_MODULE_LIST',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Module list read succesfully.^',
    p_pms_description => q'^^',
    p_pms_pse_id => 70,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_UNKNOWN_NAMED_CONTEXT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Named context #1# does not exist.^',
    p_pms_description => q'^A context should be used that does not exist. Use PIT_ADMIN.CREATE_NAMED_CONTEXT to create a context^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'SQL_ERROR',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^SQL Error occurred: #SQLERRM#^',
    p_pms_description => q'^General error message. For more information, see the message parameter.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  commit;
  pit_admin.create_message_package;
end;
/