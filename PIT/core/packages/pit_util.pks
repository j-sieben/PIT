create or replace package pit_util
  authid definer
as
  /** 
    Package: PIT_UTIL
      Generic utitilies for PIT.
   
    Author:: 
      Juergen Sieben, ConDeS GmbH
      
      Published under MIT licence
   */
   
  /**
    Group: Type declarations
   */
  /**
    Types: PL/SQL subtypes
      c_max_length - Maximum length of strings
      ora_name_type - Name of an Oracle object. 30 byte up to version 11, 128 byte afterwards
      flag_type - Boolean flag. Type is defined upon installation of PIT. Must be "SQL savvy"
      max_char - 32 KByte Varchar2
      max_sql_char - Maximium SQL VARCHAR2 legnth. As extended char length is stored as a length delimited CLOB,
                     MAX_SQL_CHAR is still set to 4000 byte. Use CLOB otherwise
      small_char - VARCHAR2 with 255 byte length
      sign_type - One character, used for signs apart from boolean flags
   */
  c_max_length constant binary_integer := &ORA_MAX_LENGTH.;
  subtype ora_name_type is &ORA_NAME_TYPE.;
  subtype flag_type is &FLAG_TYPE.;
  subtype max_char is varchar2(32767 byte);
  subtype max_sql_char is varchar2(4000 byte);
  subtype small_char is varchar2(255 byte);
  subtype sign_type is char(1 byte);
  
  /**
    Group: Data types
   */
  /**
    Type: context_type
      Record to store log and trace settings
    
    Properties:
      context_name - Name of the context, is used to identify a stored context
      settings - Condensed string with settings for log/trace level, flag_timing and module list
      log_level - On of the C_LEVEL constants, controls logging
      trace_level - On of the C_TRACE constants, controls tracing
      trace_timing - Flag to control whether timing information for methods are calculated
      module_list - Colon separated list of output modules
      allow_toggle - Flag to indicate whether logging can be switched on and off based on package names (toggles)
      broadcast_context_switch - Flag to indicate whether a context switch should be broadcasted to all instantiated output modules
      ctx_changed - Flag to indicate whether context has changed in comparison to actual context
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
    
  /**
    Type: named_ctx_list_tab
      List of <CONTEXT_TYPE> indexed by <ORA_NAME_TYPE>
   */
  type named_ctx_list_tab is table of context_type index by ora_name_type;
    

  /** 
    Type: translatable_item_rec
      Record to grant access to a translatable item
      
    Properties:
      pti_name - Technical or internal name
      pti_display_name - more descriptive name, used for UI purposes
      pti_description - Additional description or help text
   */
  type translatable_item_rec is record(
    pti_name pit_translatable_item.pti_name%type,
    pti_display_name pit_translatable_item.pti_display_name%type,
    pti_description pit_translatable_item.pti_description%type);

  
  /** 
    Group: Exceptions
      Don't use PIT messages here as PIT may not be initialized yet.
   */
  /**
    Exceptions: Public exceptions
      invalid_sql_name - Is thrown if a name does not adhere to the Oracle naming conventions
      context_missing - Is thrown if a context is missing
      name_too_long - Is thrown if a name exceeds the maximum length limitation
   */
  invalid_sql_name exception;
  context_missing exception;
  name_too_long exception;
  
  /** 
    roup: Public constants
   */
  /**
    Constants: Common constants
      Some constants are implemented as functions to allow access from SQL
      
      C_TRUE - Boolean flag TRUE, <flag_type>
      C_FALSE - Boolean flag FALSE, <flag_type>
      C_DEFAULT_LANGUAGE - Oracle name of the default language. Is defined during installation of PIT
      C_DEFAULT_CONTEXT - Name of the default context
      C_ACTIVE_CONTEXT - Name of the active context
      C_PARAMETER_GROUP - Name of the PIT parameter group
   */
  function c_true
    return flag_type;
    
  function c_false
    return flag_type;
    
  C_DEFAULT_LANGUAGE constant ora_name_type := '&DEFAULT_LANGUAGE.';
  C_DEFAULT_CONTEXT constant ora_name_type := 'CONTEXT_DEFAULT';
  C_ACTIVE_CONTEXT constant ora_name_type := 'CONTEXT_ACTIVE';
  
  C_PARAMETER_GROUP constant varchar2(5) := 'PIT';
  /**
    Group: Public getter methods
   */

  /** 
    Function: get_call_stack
      Wrapper around UTL_CALL_STACK to get the call stack
      
    Returns:
      formatted call stack.
   */
  function get_call_stack
    return varchar2;
    
    
  /**
    Function: get_error_name
      Helper to create the name for an exception constant in package <MSG>. 
      Name is formed on the basis of params ERROR_PREFIX and ERROR_POSTFIX
      
    Parameter:
      p_pms_name - Name of the message to create the exception name for
      
    Returns:
      Exception name.
   */
  function get_error_name(
    p_pms_name in pit_message.pms_name%type)
    return varchar2;


  /** 
    Function: get_error_stack
      Wrapper around UTL_CALL_STACK to get the call stack
      
    Returns:
      formatted error stack.
   */
  function get_error_stack
    return varchar2;
  
  
  /* 
    Procedure: get_module_and_action
      Reads module and action from UTL_CALL_STACK
      
      Should p_module and/or p_action be null, 
      <UTL_CALL_STACK> is called to get the respective information.
      
    Parameters:
      p_module - Module that was called
      p_action - Method with module that was called
   */
  procedure get_module_and_action(
    p_module in out nocopy varchar2,
    p_action in out nocopy varchar2);
    
   
  /**
    Function: get_user
      Getter for SYS.STANDARD-USER to avoid SQL environment changes
   */
  function get_user
    return ora_name_type;


  /**
    Group: Text helper methods
   */


  /** 
    Function: bulk_replace
      Helper to bulk-replace chunks in a text. Is called to replace more replacement anchors at once
      
    Parameters:
      p_string - Text with replacement anchors
      p_chunks - List of chars for replacement
      
    Returns:
      <p_string> with replacements
   */
  function bulk_replace(
    p_string in varchar2,
    p_chunks in char_table)
    return varchar2;


  /** 
    Procedure: clob_append
      Helper to append CLOB. Wrapper for DBMS_LOB.APPEND that takes care to instantiate P_CLOB if
      it's not yet there and append only if P_CHUNK is not null
      
    Parameters:
      p_clob - CLOB instance to append P_CHUNK to
      p_chunk - CLOB instance to append to P_CLOB
   */
  procedure clob_append(
    p_clob in out nocopy clob,
    p_chunk in clob);


  /** 
    Function: concatenate
      Helper to concatenate text. 
      
    Parameters:
      p_text_list - <CHAR_TABLE> instance with the text chunks to concatenate
      p_delimiter - Delimiter to separate the chunks
      p_keep_null - Flag to indicate whether NULL values are kept (ie as delimiter is inserted (default) or not
   */
  function concatenate(
    p_chunk_list char_table,
    p_delimiter varchar2,
    p_keep_null boolean default true)
    return varchar2;
    
    
  /** 
    Function: harmonize_sql_name
      Helper function to convert a SQL primary key name according to the naming convention.
             Is called to harmonize the naming of alphanumeric primary key items.
             
    Parameters:
      p_name - Name to harmonize
      p_prefix - Optional prefix for the resulting name
      p_max_length - Optional length limitation. If ommitted, the name will be cropped to fit into C_MAX_LENGTH limit
      
    Returns:
      Converted name. The following rules apply:
      
      - length limit <C_MAX_LENGTH> byte
      - upper case
      - no whitespace, only underscores
      - must be a DBMS_ASSERT.ASSERT_SIMPLE_SQL_NAME
   */
  function harmonize_sql_name(
    p_name in varchar2,
    p_prefix in varchar2 default null,
    p_max_length number default null)
    return varchar2;


  /** 
    Function: harmonize_name
      Helper function to harmonize a given name.  <P_NAME> will be uppercased and <P_PREFIX> prefixes <P_NAME>
    
    Parameters:
      p_name - Name to harmonize
      p_prefix - Prefix that should exist once before the name
      
    Returns:
      Harmonized name
   */
  function harmonize_name(
    p_prefix in varchar2,
    p_name in varchar2)
    return varchar2;


  /**
    Group: Validation helper methods
   */
  /** 
    Procedure: check_context_settings
      Helper to validate named context settings. Is called to verify that entered settings are correct.
      
    Parameters:
      p_context_name - Name of the context to check
      p_settings - Settings for the named context
   */
  procedure check_context_settings(
    p_context_name in ora_name_type,
    p_settings in varchar2);


  /** 
    Procedure: check_toggle_settings
      Helper to validate toggle settings.  Is called from PIT_ADMIN.CREATE_CONTEXT_TOGGLE to validate settings
      
    Parameters:
      p_toggle_name - Name of the toggle to check
      p_module_list - List of code blocks which toggle context settings
      p_context_name - Name of the named context to toggle to
      
    Errors:
      pit_util.invalid_sql_name -Toggle name must adhere to the SQL naming conventions
      pit_util.context_missing - Referenced context does not exist
      pit_util.name_too_long - The maximum length of a toggle name was exceeded
   */
  procedure check_toggle_settings(
    p_toggle_name in ora_name_type,
    p_module_list in varchar2,
    p_context_name in ora_name_type);
    
  
  /**
    Group: Conversion methods
   */
  /** 
    Function: cast_to_msg_args_char
      Methods to cast an instance of type <MSG_ARGS> to <MSG_ARGS_CHAR>.
      
      Is called to allow to store <MSG_ARGS>-instances in tables (which is not supported for VARRAY(CLOB)).
      
    Parameter:
      p_msg_args - Instance of type <MSG_ARGS>
      
    Returns: 
      Instance of <MSG_ARGS_CHAR> with the content of <>MSG_ARGS> (abbreviated to max 4000 byte per entry)
   */
  function cast_to_msg_args_char(
    p_msg_args msg_args)
    return msg_args_char;
    
  /** 
    Function: cast_to_msg_args
      Methods to cast an instance of type <MSG_ARGS_CHAR> to <MSG_ARGS>.
      
      Is called to instantiate messages which require the message arguments to be of type <MSG_ARGS>.
      
    Parameter:
      p_msg_args - Instance of type <MSG_ARGS_CHAR>
      
    Returns: 
      Instance of <MSG_ARGS> with the content of <>MSG_ARGS_CHAR>
   */
  function cast_to_msg_args(
    p_msg_args msg_args_char)
    return msg_args;
    
    
  /** 
    Function: context_type_to_string
      Method to cast an instance of <CONTEXT_TYPE> to VARCHAR2
      
    Parameter:
      p_settings - Only enough attributes to allow for storage within the context are put together.
      
    Returns:
      String with a pipe separated list of DEBUG_LEVEL|TRACE_LEVEL|TIMING_FLAG|MODULE_LIST
   */
  function context_type_to_string(
    p_settings in context_type)
    return varchar2;
    
    
  /** 
    Procedure: string_to_context_type
      Method to cast a context value read from the globally accessed context to a context type record.
      
    Parameters:
      p_context_values - String as read from <UTL_CONTEXT.get_first_match> or from call stack
      p_context - Instance of <CONTEXT_TYPE>
   */
  procedure string_to_context_type(
    p_context_values in varchar2,
    p_context in out nocopy context_type);
    
    
  /**
    Function: string_to_table
      Helper to convert a string with a given separator into an instance of type ARGS.
      Internal helper to split a string into an array of chars.
      
    Parameters:
      p_string_value - List of items to be split
      p_delimiter - Optional character that separates the items in <p_string_value>. Defaults to colon (:)
      
    Returns:
      Array of items (up to 50) of VARCHAR2
   */
  function string_to_table(
    p_string_value in varchar2,
    p_delimiter in varchar2 := ':')
    return args;
    
    
  /** 
    Function: to_bool
      Method to convert a boolean to a bool flag of type FLAG_TYPE.
      
    Parameter:
      p_boolean - Boolean type value
      
    Returns: Boolean value as <flag_type>
   */
  function to_bool(
    p_boolean in boolean)
    return flag_type;
    
    
  /** 
    Function: to_bool
      Method to convert a boolean to a bool flag of type FLAG_TYPE.
      
    Parameter:
      p_boolean - <-flag_type> boolean value
      
    Returns: Value as boolean
   */
  function to_bool(
    p_boolean in flag_type)
    return boolean;


  /**
    Group: Other helper methods
   */
  /** 
    Procedure: recompile_invalid_objects
      Procedure to recompile invalid objects.
      
      Called internally when recreating <MSG> package to recompile packages with dependencies on <MSG>
   */
  procedure recompile_invalid_objects;
  
end pit_util;
/