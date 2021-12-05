create or replace package utl_context
  authid definer
as
  /** 
    Package: pit_context
      Generic maintenance of globally accessed contexts.
      
      If a globally accessed context is created in such a way that this package
      has write privileges on it, access to the context is achieved by calling
      the methods within this helper package.
   
    Author:: 
      Juergen Sieben, ConDeS GmbH
      
      Published under MIT licence
   */
   
  /**
    Group: Context Type Constants
   */
  subtype ora_name_type is &ORA_NAME_TYPE.;
  subtype flag_type is &FLAG_TYPE.;
  subtype sql_char is varchar2(4000 byte);
  subtype small_char is varchar2(255 byte);
  

  /**
    Constants: Context types
      C_GLOBAL - Visible for any user and any session
      C_FORCE_USER - Visible only if user matches
      C_FORCE_CLIENT_ID - Visible only if client_identifier matches
      C_FORCE_USER_CLIENT_ID - Visible only if user AND client_identifier matches
      C_PREFER_CLIENT_ID - Visible if a matching value for that client_identifier exists, it is visible, otherwise a default value is provided
      C_PREFER_USER_CLIENT_ID - Visible if a matching value for that user AND client_identifier exists, it is visible, otherwise a default value is provided
      C_SESSION - Visible only within the session that set the value (pseduo local context)
   */
  C_GLOBAL constant ora_name_type := 'GLOBAL';
  C_FORCE_USER constant ora_name_type := 'FORCE_USER';
  C_FORCE_CLIENT_ID constant ora_name_type := 'FORCE_CLIENT_ID';
  C_FORCE_USER_CLIENT_ID constant ora_name_type := 'FORCE_USER_CLIENT_ID';
  C_PREFER_CLIENT_ID constant ora_name_type := 'PREFER_CLIENT_ID';
  C_PREFER_USER_CLIENT_ID constant ora_name_type := 'PREFER_USER_CLIENT_ID';
  C_SESSION constant ora_name_type := 'SESSION';
  
  C_NO_VALUE constant varchar2(10) := 'NOVALUE';
  C_NAME_DELIMITER constant char(1 byte) := '@';
  
  /**
    Procedure: set_value
      Sets a parameter value for a given parameter in the context requested. When using the 
      <p_client_id> attribute, a parameter may be set for a given session only and be invisible to other sessions.
      
    Parameters:
      p_context -  Name of the context to write a value to
      p_attribute - Name of the parameter for which a value shall be stored
      p_value - Varchar-value of the parameter
      p_client_id - Optional client id as set at sys_context('USERENV', 'CLIENT_IDENTIFIER')
   */
  procedure set_value(
    p_context in varchar2,
    p_attribute in varchar2,
    p_value in varchar2,
    p_client_id varchar2 default null);


  /**
    Function: get_calue
      Reads a parameter value for a given parameter from the context requested. When using the 
      <p_client_id> attribute, a parameter may be read that is private for a given session.
      
    Parameters:
      p_context - Name of the context to write a value to
      p_attribute - Name of the parameter for which a value shall be stored
      p_client_id  Optional client id as set at sys_context('USERENV', 'CLIENT_IDENTIFIER')
      
    Returns:
      Varchar-value of the parameter
   */
  function get_value(
    p_context in varchar2,
    p_attribute in varchar2,
    p_client_id varchar2 default null)
    return varchar2;


  /**
    Proceudre: clear_value
      Clears a value in one of the available contexts in the context requested. When using the 
      <p_client_id> attribute, a parameter may be cleared that is private for a given session.
      
    Parameters:
      p_context - Name of the context to write a value to
      p_attribute - Name of the parameter for which a value shall be stored
      p_client_id - Optional client id as set at sys_context('USERENV', 'CLIENT_IDENTIFIER')
   */
  procedure clear_value(
    p_context in varchar2,
    p_attribute in varchar2,
    p_client_id varchar2 default null);
    
  
  /**
    Function: get_first_match
      Get the best matching parameter value based on a collection of context attributes. 
      Tries to find a value for each entered attribute name and returns the first NOT-NULL-value.
      
    Parameters:
      p_context - Name of the context to write a value to
      p_attribute_list - List of attributes for which a value shall be retrieved
      p_with_name - Optional flag that indicates whether the name of the context attribute should be appended (TRUE)
                    or not (FALSE, default). If TRUE, the attribute name is separated by <C_NAME_DELIMITER>
      p_client_id - Optional client id as set at sys_context('USERENV', 'CLIENT_IDENTIFIER')
      
    Returns:
      Varchar-value of the parameter
   */
  function get_first_match(
    p_context in varchar2,
    p_attribute_list in pit_args,
    p_with_name in boolean default false,
    p_client_id varchar2 default null)
    return varchar2;


  /**
    Procedure: reset_context
      Procedure to reset one of the available contexts.
      
      This procedure resets a context completely, removing any value in it. 
      If private parameters for sessions exists, they will be cleared as well.
      
    Parameter:
      p_context - Name of the context to reset
   */
  procedure reset_context(
    p_context in varchar2);
    
end utl_context;
/