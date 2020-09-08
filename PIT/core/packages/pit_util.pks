create or replace package pit_util
  authid definer
as

  /** TYPE DECLARATIONS */
  c_max_length constant binary_integer := &ORA_MAX_LENGTH.;
  subtype ora_name_type is &ORA_NAME_TYPE.;
  subtype flag_type is &FLAG_TYPE.;
  subtype max_char is varchar2(32767 byte);
  -- As extended char length is stored as a length delimited CLOB,
  -- MAX_SQL_CHAR is still set to 4000 byte. Use CLOB otherwise
  subtype max_sql_char is varchar2(4000 byte);
  subtype small_char is varchar2(255 byte);
  subtype sign_type is char(1 byte);
  
  /** EXCEPTIONS **/
  -- Don't use PIT messages here as PIT may not be initialized yet.
  invalid_sql_name exception;
  context_missing exception;
  name_too_long exception;
  
  /** GLOBAL CONSTANTS */
  C_TRUE constant flag_type := &C_TRUE.;
  C_FALSE constant flag_type := &C_FALSE.;
  C_DEFAULT_LANGUAGE constant ora_name_type := '&DEFAULT_LANGUAGE.';
  C_DEFAULT_CONTEXT constant ora_name_type := 'CONTEXT_DEFAULT';
  
 /** Record to store log and trace settings
   * @param  context_name              Name of the context, is used to identify a stored context
   * @param  settings                  Condensed string with settings for log/trace level, flag_timing and module list
   * @param  log_level                 On of the C_LEVEL constants, controls logging
   * @param  trace_level               On of the C_TRACE constants, controls tracing
   * @param  trace_timing              Flag to control whether timing information for methods are calculated
   * @param  module_list               Colon separated list of output modules
   * @param  allow_toggle              Flag to indicate whether logging can be switched on and off based on package names (toggles)
   * @param  broadcast_context_switch  Flag to indicate whether a context switch should be broadcasted to all instantiated output modules
   * @param  ctx_changed               Flag to indicate whether context has changed in comparison to actual context
   */
  type context_type is record (
    context_name pit_util.ora_name_type,
    settings pit_util.max_sql_char,
    log_level binary_integer,
    trace_level binary_integer,
    trace_timing boolean,
    module_list pit_util.max_sql_char,
    allow_toggle boolean,
    broadcast_context_switch boolean,
    ctx_changed boolean := true);
    
  /** List of CONTEXT_TYPE indexed by ORA_NAME_TYPE
   */
  type named_ctx_list_tab is table of context_type index by ora_name_type;
    

  /** Record to grant access to a translatable item
   * @param  pti_name           Technical or internal name
   * @param  pti_display_name   more descriptive name, used for UI purposes
   * @param  pti_description    Additional description or help text
   */
  type translatable_item_rec is record(
    pti_name pit_translatable_item.pti_name%type,
    pti_display_name pit_translatable_item.pti_display_name%type,
    pti_description pit_translatable_item.pti_description%type);

  /* Getter for SYS.STANDARD.USER to avoid environment changes to SQL
   */
  function get_true
    return flag_type;
    
  function get_false
    return flag_type;
   
  function get_user
    return ora_name_type;


  /**** TEXT HELPER ****/
  /*+ Helper to convert a string with a given separator into an instance of type ARGS
   * @param  p_string_value  List of items to be split
   * @param [p_delimiter]    character that separates the items in <code>p_string_value</code>
   *                         Default: colon (:)
   * @return Array of items (up to 50) of <code>varchar2(50)</code>
   * @usage  internal helper to split a string into an array of chars.
   */
  function string_to_table(
    p_string_value in varchar2,
    p_delimiter in varchar2 := ':')
    return args;


  /** Helper to bulk-replace chunks in a text
   * @param  p_string  Text with replacement anchors
   * @param  p_chunks  List of chars for replacement
   * @return p_string with replacements
   * @usage  Is called to replace more replacement anchors at once
   */
  function bulk_replace(
    p_string in varchar2,
    p_chunks in char_table)
    return varchar2;


  /** Helper to append CLOB.
   * @param  p_clob   CLOB instance to append P_CHUNK to
   * @param  p_chunk  CLOB instance to append to P_CLOB
   * @usage  Wrapper for DBMS_LOB.APPEND that takes care to instantiate P_CLOB if
   *         it's not yet there and append only if P_CHUNK is not null
   */
  procedure clob_append(
    p_clob in out nocopy clob,
    p_chunk in clob);


  /** Helper to concatenate text
   * @param  p_text_list CHAR_TABLE instance with the text chunks to concatenate
   * @param  p_delimiter Delimiter to separate the chunks
   * @param  p_keep_null Flag to indicate whether NULL values are kept (ie as delimiter
   *                     is inserted (default) or not
   */
  function concatenate(
    p_chunk_list char_table,
    p_delimiter varchar2,
    p_keep_null boolean default true)
    return varchar2;
    
    
  /** Helper function to convert a SQL primary key name according to the naming convention
   * @param  p_name        Name to harmonize
   * @param [p_prefix]     Optional prefix for the resulting name
   * @param [p_max_length] Optional length limitation. If ommitted, the name will be cropped to fit into C_MAX_LENGTH limit
   * @return Converted name. The following rules apply:
   *         - length limit C_MAX_LEGNTH byte
   *         - upper case
   *         - no whitespace, only underscores
   *         - must be a DBMS_ASSERT.ASSERT_SIMPLE_SQL_NAME
   * @usage  Is called to harmonize the naming of alphanumeric primary key items
   */
  function harmonize_sql_name(
    p_name in varchar2,
    p_prefix in varchar2 default null,
    p_max_length number default null)
    return varchar2;


  /** Helper function to harmonize a given name
   * @param  p_name    Name to harmonize
   * @param  p_prefix  Prefix that should exist once before the name
   * @return harmonized name
   * @usage  P_NAME will be uppercased and P_PREFIX prefixes P_NAME
   */
  function harmonize_name(
    p_prefix in varchar2,
    p_name in varchar2)
    return varchar2;
    
    
  /** Method to convert a boolean to a bool flag of type FLAG_TYPE and vice versa
   */
  function to_bool(
    p_boolean in boolean)
    return flag_type;
    
  function to_bool(
    p_boolean in flag_type)
    return boolean;


  /** Methods to cast an instance of type MSG_ARGS to MSG_ARGS_CHAR and vice versa
   * @param  p_msg_args  Instance of type MSG_ARGS
   * @return Instance of MSG_ARGS_CHAR with the content of MSG_ARGS (abbreviated
   *         to max 4000 byte per entry)
   * @usage  is called to allow to store MSG_ARGS-instances in tables (which is
   *         not supported for VARRAY(CLOB)).
   */
  function cast_to_msg_args_char(
    p_msg_args msg_args)
    return msg_args_char;
    
  function cast_to_msg_args(
    p_msg_args msg_args_char)
    return msg_args;


  /**** VALIDATION HELPER ****/
  /** Helper to create the name for an exception constant in package MSG.
   *  Name is formed on the basis of params ERROR_PREFIX and ERROR_POSTFIX
   * @param  p_pms_name  Name of the message to create the exception name for
   * @return Exception name
   */
  function get_error_name(
    p_pms_name in pit_message.pms_name%type)
    return varchar2;


  /** Helper to validate named context settings
   * @param  p_context_name  Name of the context to check
   * @param  p_settings      Settings for the named context
   * @usage  Is called to verify that entered settings are correct.
   */
  procedure check_context_settings(
    p_context_name in ora_name_type,
    p_settings in varchar2);


  /** Helper to validate toggle settings
   * @param  p_toggle_name Name of the toggle to check
   * @param  p_module_list List of code blocks which toggle context settings
   * @param  p_context_name Name of the named context to toggle to
   * @usage  Is called from PIT_ADMIN.CREATE_CONTEXT_TOGGLE to validate settings
   * @throws pit_util.invalid_sql_name  Toggle name must adhere to the SQL naming conventions
   *         pit_util.context_missing   Referenced context does not exist
   *         pit_util.name_too_long     The maximum length of a toggle name was exceeded
   */
  procedure check_toggle_settings(
    p_toggle_name in ora_name_type,
    p_module_list in varchar2,
    p_context_name in ora_name_type);
    
  
  /** Method to cast a context value read from the globally accessed context to a context type record
   * @param  p_context_values  String as read from UTL_CONTEXT.get_first_match or from call stack
   * @param  p_context         Instance of CONTEXT_TYPE
   */
  procedure string_to_context_type(
    p_context_values in varchar2,
    p_context in out nocopy context_type);
    
    
  /** Method to cast an instance of CONTEXT_TYPE to string
   * @param  p_settings  Only enough attributes to allow for storage within the context are put together
   * @return String with a pipe separated list of DEBUG_LEVEL|TRACE_LEVEL|TIMING_FLAG|MODULE_LIST
   */
  function context_type_to_string(
    p_settings in context_type)
    return varchar2;


  /** Procedure to recompile invalid objects
   * @usage  Called internally when recreating MSG package to recompile packages with dependencies on MSG
   */
  procedure recompile_invalid_objects;
  
  
  /* Reads module and action from UTL_CALL_STACK
   * @usage  Is used only from Oracle 12c onwards. Should p_module and/or p_action
   *         be null, UTL_CALL_STACK is called to get the respective information
   * @param  p_trace_level  Controls the recursive level needed by UTL_CALL_STACK
   * @param  p_module       Module that was called
   * @param  p_action       Method with module that was called
   */
  procedure get_module_and_action(
    p_module in out nocopy varchar2,
    p_action in out nocopy varchar2);

  /** Helper to get the call/error stack 
   * @return formatted call/error stack. Starting with version 12, utl_call_stack is used.
   */
  function get_call_stack
    return varchar2;

  function get_error_stack
    return varchar2;

end pit_util;
/