begin

  pit_admin.merge_message_group(
    p_pmg_name => 'PIT',
    p_pmg_description => 'Core PIT messages'
  );

  pit_admin.merge_message(
    p_pms_name => 'ASSERT_EXISTS',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^A statement was expected to return rows, but did not.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'ASSERTION_FAILED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Assertion failed.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'ASSERT_IS_NULL',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^A value was expected to be null, but was [#1#].^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'ASSERT_IS_NOT_NULL',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^#1# was expected, but was null.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'ASSERT_NOT_EXISTS',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^A statement was expected to return no rows, but did.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'ASSERT_TRUE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^A value was expected to be equal, but was not.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_CODE_ENTER',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Entering: #1#^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 70,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_CODE_ENTER_W_PARAM',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Entering: #1#, Params: #2#^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 70,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_CODE_LEAVE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Leaving: #1#^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 70,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'CTX_CHANGED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Context set to ##1#.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 70,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'CTX_CREATED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Context ##1# created and added to the available contexts list.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 70,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'CTX_CREATION_ERROR',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Error initializing a new context.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 70,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'CTX_MISSING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Tried to call context ##1# but it is not existing.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 40,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'CTX_INVALID_CONTEXT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Context #1# does not exist. Please provide a valid context name that is controlled by #2#.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );
  
  pit_admin.merge_message(
    p_pms_name => 'CTX_NO_CONTEXT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Context cannot be null. Please provide a valid context name.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'CTX_DEFAULT_CREATION_ERROR',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Default Context could not be created.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_DUPLICATE_MESSAGE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^he message #1# you entered already exists.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_INITIALIZED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Finished initialization at #1#. Loaded modules: [#2#]^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 70,
    p_error_number => null
  );
  
  pit_admin.merge_message(
    p_pms_name => 'PIT_FAIL_MESSAGE_CREATION',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Log message "#1#" could not be created.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_FAIL_MESSAGE_PURGE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Error purging the message stack.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_FAIL_MODULE_INIT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Module #1# received an error during installation: #2#^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 40,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_INSTANTIATED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Module #1# has been succesfully instantiated.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 50,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_LIST_LOADED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Module list has been successfully loaded.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 70,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_UNAVAILABLE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Module #1# has been requested, but is not available.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 40,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_TERMINATED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Module #1# was terminated due to an error.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PARAM_ADMIN_MODE_REQUIRED',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Requested change requires admin mode.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PARAM_IS_NULL',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^The requested parameter #1# doesn't exist.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 40,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PARAM_NOT_EXTENDABLE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Parameter-Group does not allow for new parameters.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PARAM_NOT_FOUND',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Parameter #1# does not exist.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PARAM_NOT_MODIFIABLE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Parameter #1# is not allowed to be changed.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_PASS_MESSAGE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^#1#^',
    p_pms_pse_id => 70,
    p_pms_pml_name => '&DEFAULT_LANGUAGE.',
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_READ_MODULE_LIST',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Module list read succesfully.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 70,
    p_error_number => null
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_FAIL_READ_MODULE_LIST',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Error reading the list of modules.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'SQL_ERROR',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^SQL Error occurred: #SQLERRM#^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_UNKNOWN_NAMED_CONTEXT',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Named context #1# does not exist.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_PARAM_OUT_OF_RANGE',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Parameter #1# was expected to be in (#2#) but was #3#.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_MODULE_PARAM_MISSING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^At least one output module must be specified.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  pit_admin.merge_message(
    p_pms_name => 'PIT_MSG_NOT_EXISTING',
    p_pms_pmg_name => 'PIT',
    p_pms_text => q'^Message #1# does not exist. Call PIT using Package MSG to avoid this error.^',
    p_pms_pml_name => 'AMERICAN',
    p_pms_pse_id => 30,
    p_error_number => -20000
  );

  commit;
end;
/