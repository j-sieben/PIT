begin

  pit_admin.merge_message_group(
    p_pmg_name => 'PIT',
    p_pmg_description => q'^Core PIT messages and translatable items^',
    p_pmg_error_prefix => '',
    p_pmg_error_postfix => 'ERR');

  pit_admin.merge_message(
    p_pms_name => 'PIT_ASSERT_DATATYPE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^#1# is not of data type #2#.^',
    p_pms_description => q'^An unsuccessful attempt was made to convert a value to the specified data type. Check the value.^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_ASSERTION_FAILED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Assertion failed.^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_ASSERT_EXISTS',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^A statement was expected to return rows, but did not.^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_ASSERT_IS_NOT_NULL',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^#1# was expected, but was null.^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_ASSERT_IS_NULL',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^A value was expected to be null, but was [#1#].^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_ASSERT_NOT_EXISTS',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^A statement was expected to return no rows, but did.^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_ASSERT_TRUE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^A value was expected to be equal, but was not.^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CASE_NOT_FOUND',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^#1# not found when executing CASE statement^',
    p_pms_description => q'^An option was passed for which no handler was present in a CASE statement and which does not contain an ELSE branch.^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CTX_CHANGED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Context set to ##1#.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.LEVEL_ALL,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CTX_CREATED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Context ##1# created and added to the available contexts list.^',
    p_pms_description => q'^A context collects log settings under one name.^',
    p_pms_pse_id => pit.LEVEL_ALL,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CTX_CREATION_ERROR',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Error initializing a new context.^',
    p_pms_description => q'^As a rule, a context cannot be initialized if invalid settings were passed for the individual parameters.^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CTX_DEFAULT_CREATION_ERROR',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Default Context could not be created.^',
    p_pms_description => q'^The default context is created by initialization parameters. Make sure that no invalid entries are contained there.^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CTX_INVALID_CONTEXT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Context #1# does not exist. Please provide a valid context name that is controlled by #2#.^',
    p_pms_description => q'^Create a context using UTL_CONTEXT.CREATE_CONTEXT before you use it^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CTX_MISSING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Tried to call context ##1# but it is not existing.^',
    p_pms_description => q'^Create a context using PIT_ADMIN.CREATE_NAMED_CONTEXT before you use it^',
    p_pms_pse_id => pit.LEVEL_WARN,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CTX_NO_CONTEXT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Context cannot be null. Please provide a valid context name.^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_IMPOSSIBLE_CONVERSION',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Invalid conversion of element value "#1#" and format mask "#2#" to type #3#.^',
    p_pms_description => q'^The element value could not be converted correctly when automatically determining a date or numeric value.^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_LONG_OP_WO_TRACE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Use of PIT.LONG_OP requires PIT.ENTER/LEAVE usage.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_BULK_ERROR',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^An error occurred during execution of a bulk processing.^',
    p_pms_description => q'^If PIT is in collect mode and at least one error of level C_LEVEL_ERROR is raised, this error is thrown.^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_BULK_SEVERE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^A severe error occurred during execution of a bulk processing.^',
    p_pms_description => q'^If PIT is in collect mode and at least one error of level C_LEVEL_SEVERE is raised, this error is thrown.^',
    p_pms_pse_id => pit.LEVEL_SEVERE,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_BULK_FATAL',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^A fatal error occurred during execution of a bulk processing.^',
    p_pms_description => q'^If PIT is in collect mode and at least one error of level C_LEVEL_FATAL is raised, this error is thrown.^',
    p_pms_pse_id => pit.LEVEL_FATAL,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CODE_ENTER',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Entering: #1#^',
    p_pms_description => q'^This message is output when a procedure or function is called.^',
    p_pms_pse_id => pit.LEVEL_ALL,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CODE_ENTER_W_PARAM',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Entering: #1#, Params: #2#^',
    p_pms_description => q'^Diese Meldung wird ausgegeben, wenn eine Prozedur oder Funktion aufgerufen wird.^',
    p_pms_pse_id => pit.LEVEL_ALL,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CODE_LEAVE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Leaving: #1#^',
    p_pms_description => q'^This message is issued when a procedure or function is left.^',
    p_pms_pse_id => pit.LEVEL_ALL,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_CONTEXT_MISSING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^The context #1# does not exist. Please create it in advance.^',
    p_pms_description => q'^A toggle must reference an existing context, otherwise the output will not work.^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_DUPLICATE_MESSAGE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^he message #1# you entered already exists.^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_FAIL_MESSAGE_CREATION',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Log message "#1#" could not be created.^',
    p_pms_description => q'^No further details^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_FAIL_MESSAGE_PURGE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Error purging the message stack.^',
    p_pms_description => q'^No further details^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_FAIL_MODULE_INIT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Module #1# received an error during installation: #2#^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.LEVEL_WARN,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_FAIL_READ_MODULE_LIST',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Error reading the list of modules.^',
    p_pms_description => q'^The list of modules includes all installed, initialized or active output modules. This list was empty here.^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_INITIALIZED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Finished initialization at #1#. Loaded modules: [#2#]^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.LEVEL_ALL,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_INSTANTIATED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Module #1# has been succesfully instantiated.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.LEVEL_INFO,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_LIST_LOADED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Module list has been successfully loaded.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.LEVEL_ALL,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_PARAM_MISSING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^At least one output module must be specified.^',
    p_pms_description => q'^If no output module has been defined in the current context that can be initialized, PIT cannot output any messages. Make sure that at least one module can be reached.^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_TERMINATED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Module #1# was terminated due to an error.^',
    p_pms_description => q'^If an error occurs during the initialization of a module, the module is deactivated. Other modules continue to operate normally.^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_UNAVAILABLE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Module #1# has been requested, but is not available.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.LEVEL_WARN,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_MSG_NOT_EXISTING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Message #1# does not exist. Call PIT using Package MSG to avoid this error.^',
    p_pms_description => q'^A message must be created by procedure PIT_ADMIN.MERGE_MESSAGE. Then method PIT_ADMIN.CREATE_MESSAGE_PACKAGE must be called to update package MSG.^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_NAME_TOO_LONG',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^The identifier exceeds the maximum length of #1# characters.^',
    p_pms_description => q'^A maximum length is specified for an identifier. This length is currently exceeded.^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_PARAM_OUT_OF_RANGE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Parameter #1# was expected to be in (#2#) but was #3#.^',
    p_pms_description => q'^Obviously^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_PASS_MESSAGE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^#1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.LEVEL_ALL,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_READ_MODULE_LIST',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Module list read succesfully.^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.LEVEL_ALL,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_UNKNOWN_NAMED_CONTEXT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Named context #1# does not exist.^',
    p_pms_description => q'^A context should be used that does not exist. Use PIT_ADMIN.CREATE_NAMED_CONTEXT to create a context^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_NO_CONTEXT_SETTINGS',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^No settings for logging could be found.^',
    p_pms_description => q'^An attempt was made to read values for logging from the gloable context. But this failed. Check whether PIT is correctly initialized.^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_SQL_ERROR',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^SQL Error occurred: #SQLERRM#^',
    p_pms_description => q'^General error message. For more information, see the message parameter.^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_PMG_ERROR_MARKER_MISSING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Neither prefix nor postfix for error messages were specified.^',
    p_pms_description => q'^A message group needs a flag for errors. These are taken from the default, but must not be NULL. At least one value must be assigned.^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_PMG_ERROR_MARKER_INVALID',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^The length of prefix and postfix together must not exceed 12 characters and at least prefix or postfix must be defined.^',
    p_pms_description => q'^The prefix and/or postfix for error names must remain below a maximum length to avoid problems with the naming convention.^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_PMS_TOO_LONG',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^The message "#1#" must not be longer than #2# characters, but has the length #3#.^',
    p_pms_description => q'^The length restriction applies because of the length of exception prefixes and postfixes to be added.^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_PMS_PREDEFINED_ERROR',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^The error number #1# is a predefined Oracle error named #2# in #3#.#4#. Please do not overwrite Oracle predefined errors.^',
    p_pms_description => q'^By overwriting a predefined error, it will no longer be trapped under its name.^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_PARAM_MISSING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^The #LABEL# element is a mandatory element.^',
    p_pms_description => q'^Obviously.^',
    p_pms_pse_id => pit.LEVEL_ERROR,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'PIT_INVALID_SQL_NAME',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Invalid SQL name. #1#. Please specify a name that conforms to Oracle naming conventions.^',
    p_pms_description => q'^Since some identifiers are also used as Oracle names (for example, as constants), they must conform to Oracle naming conventions.^',
    p_pms_pse_id => pit.LEVEL_WARN,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  pit_admin.merge_message(
    p_pms_name => 'PIT_TWEET',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Tweet: #1#^',
    p_pms_description => q'^^',
    p_pms_pse_id => pit.LEVEL_WARN,
    p_pms_pml_name => 'AMERICAN',
    p_error_number => null);

  commit;
  pit_admin.create_message_package;
end;
/