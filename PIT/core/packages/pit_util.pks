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
  c_max_length constant binary_integer := 128;
  subtype ora_name_type is varchar2(128 byte);
  subtype flag_type is number(1, 0);
  subtype max_char is varchar2(32767 byte);
  subtype max_sql_char is varchar2(4000 byte);
  subtype small_char is varchar2(255 byte);
  subtype sign_type is char(1 byte);
  
  /**
    Group: Data types
   */
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
    Type: predefined_error_rec
      Record to store details for a named Oracle error
      
    Properties:
      source_type - Type of data object in which the error is defined
      owner - Owner of the data object that defines the error
      package_name - Name of the data object that defines the error
      error_name - Name of the error
   */
  type predefined_error_rec is record(
    source_type pit_util.ora_name_type,
    owner pit_util.ora_name_type,
    package_name pit_util.ora_name_type,
    error_name pit_util.ora_name_type);

  
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
    
  C_DEFAULT_LANGUAGE constant ora_name_type := 'GERMAN';
  C_CONTEXT_PREFIX constant ora_name_type := 'CONTEXT_';
  C_TOGGLE_PREFIX constant ora_name_type := 'TOGGLE_';
  C_DEFAULT_CONTEXT constant ora_name_type := C_CONTEXT_PREFIX || 'DEFAULT';
  C_ACTIVE_CONTEXT constant ora_name_type := C_CONTEXT_PREFIX || 'ACTIVE';
  
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
    Function: check_error_number_exists
      Method to check whether an Oracle error number is already a named error
      
    Parameter: 
      p_error_number - Oracle error number to check

    Returns:
      Record with information to the predefined error, if it exists, NULL otherwise
   */
  function check_error_number_exists(
    p_pms_name in pit_message.pms_name%type,
    p_pms_custom_error in pit_message.pms_custom_error%type)
    return predefined_error_rec;
    
  /**
    Function: get_max_message_length
      Method retrieves the maximum length of a message for a given message group.
      
      The length is calculated by the maximum length of an Oracle name minus the
      length of the actual error prefix of that message group.
      
    Parameter: 
      p_pmg_name - Name of the message group to get the maximum length for.

    Returns:
      Record with information to the predefined error, if it exists, NULL otherwise
   */
  function get_max_message_length(
    p_pmg_name in pit_message_group.pmg_name%type)
    return binary_integer;
    
    
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
    Function: string_to_table
      Helper to convert a string with a given separator into an instance of type PIT_ARGS.
      Internal helper to split a string into an array of chars.
      
    Parameters:
      p_string_value - List of items to be split
      p_delimiter - Optional character that separates the items in <p_string_value>. Defaults to colon (:)
      
    Returns:
      Instance of <PIT_ARGS>
   */
  function string_to_table(
    p_string_value in varchar2,
    p_delimiter in varchar2 := ':')
    return pit_args;
    
    
  /**
    Function: table_to_string
      Helper to convert a <PIT_ARGS> instance to a string with a given separator.
      
    Parameters:
      p_table - Instance of <PIT_ARGS>
      p_delimiter - Optional character that combines the items in <p_table>. Defaults to colon (:)
      
    Returns:
      String containig all non null entries from <p_table>
   */
  function table_to_string(
    p_table in pit_args,
    p_delimiter in varchar2 := ':')
  return varchar2;
    
    
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