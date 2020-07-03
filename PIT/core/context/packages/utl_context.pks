create or replace package utl_context
  authid definer
as
  /** Generic maintenance of globally accessed contexts<br>
   *  If a globally accessed context is created in such a way that this package
   *  has write privileges on it, access to the context is achieved by calling
   *  the methods within this helper package.
   */
   
  subtype ora_name_type is &ORA_NAME_TYPE.;
  subtype sql_char is varchar2(4000 byte);
  subtype small_char is varchar2(255 byte);
  subtype flag_type is &FLAG_TYPE.;
  
  C_NO_VALUE varchar2(10) := 'NOVALUE';
  C_NAME_DELIMITER char(1 byte) := '@';

  /* Context Type Constants: Context values are visible ...
   * global: ... for any user and any session
   * force_user: ... only if user matches
   * force_client_id: ... only if client_identifier matches
   * force_user_client_id: ... only if user AND client_identifier matches
   * prefer_client_id: ... if a matching value for that client_identifier exists,
   *                       it is visible, otherwise a default value is provided
   * prefer_user_client_id: ... if a matching value for that user AND client_identifier exists,
   *                            it is visible, otherwise a default value is provided
   * session: ... only within the session that set the value (pseduo local context)
   */
  C_GLOBAL constant ora_name_type := 'GLOBAL';
  C_FORCE_USER constant ora_name_type := 'FORCE_USER';
  C_FORCE_CLIENT_ID constant ora_name_type := 'FORCE_CLIENT_ID';
  C_FORCE_USER_CLIENT_ID constant ora_name_type := 'FORCE_USER_CLIENT_ID';
  C_PREFER_CLIENT_ID constant ora_name_type := 'PREFER_CLIENT_ID';
  C_PREFER_USER_CLIENT_ID constant ora_name_type := 'PREFER_USER_CLIENT_ID';
  C_SESSION constant ora_name_type := 'SESSION';
  
  
  /* Procedure to set a value in one of the available contexts
   * @param  p_context    Name of the context to write a value to
   * @param  p_attribute  Name of the parameter for which a value shall be stored
   * @param  p_value      varchar-value of the parameter
   * @param [p_client_id] client id as set at sys_context('USERENV', 'CLIENT_IDENTIFIER')
   * @usage  This procedure set a parameter value for a given parameter in the 
   *         context requested. When using the p_client_id attribute, a parameter
   *         may be set for a given session only and be invisible to other sessions
   */
  procedure set_value(
    p_context in varchar2,
    p_attribute in varchar2,
    p_value in varchar2,
    p_client_id varchar2 default null);


  /* Procedure to read a value from one of the available contexts
   * @param  p_context    Name of the context to write a value to
   * @param  p_attribute  Name of the parameter for which a value shall be stored
   * @param [p_client_id] optional client id as set at sys_context('USERENV', 'CLIENT_IDENTIFIER')
   * @return Varchar-value of the parameter
   * @usage  This procedure gets a parameter value for a given parameter from the 
   *         context requested. When using the p_client_id attribute, a parameter
   *         may be read that is private for a given session
   */
  function get_value(
    p_context in varchar2,
    p_attribute in varchar2,
    p_client_id varchar2 default null)
    return varchar2;


  /* Procedure to clear a value in one of the available contexts
   * @param  p_context    Name of the context to write a value to
   * @param  p_attribute  Name of the parameter for which a value shall be stored
   * @param [p_client_id] optional client id as set at sys_context('USERENV', 'CLIENT_IDENTIFIER')
   * @usage  This procedure clears a parameter value for a given parameter in the 
   *         context requested. When using the p_client_id attribute, a parameter
   *         may be cleared that is private for a given session
   */
  procedure clear_value(
    p_context in varchar2,
    p_attribute in varchar2,
    p_client_id varchar2 default null);
    
  
  /* Function to get a value based on a collection of context attributes
   * %param  p_context         Name of the context to write a value to
   * @param  p_attribute_list  List of attributes for which a value shall be retrieved
   * @param [p_with_name]      Optional flag that indicates whether the name of the context attribute should be appended (TRUE)
   *                           or not (FALSE, default). If TRUE, the attribute name is separated by C_NAME_DELIMITER
   * @param [p_client_id]      Optional client id as set at sys_context('USERENV', 'CLIENT_IDENTIFIER')
   * @return Varchar-value of the parameter
   * @usage  Tries to find a value for each entered attribute name and returns the first NOT-NULL-value
   */
  function get_first_match(
    p_context in varchar2,
    p_attribute_list in args,
    p_with_name in boolean default false,
    p_client_id varchar2 default null)
    return varchar2;


  /* Procedure to reset one of the available contexts
   * @param  p_context  Name of the context to write a value to
   * @usage  This procedure resets a context completely, removing any value in it.
   *         If private parameters for sessions exists, they will be cleared as well.
   */
  procedure reset_context(
    p_context in varchar2);
    
end utl_context;
/