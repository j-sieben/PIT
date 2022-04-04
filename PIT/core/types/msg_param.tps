/**
  Type: msg_param
    Holds a key-value-pair to pass parameters and their values.
    Overloaded constructor for several parameter value types.
  
  Properties:
    p_param - Name of the parameter
    p_value - Value of the parameter
 */
create or replace type msg_param force as object(
  /** Type to be used as a key value pair to pass parameter or variable values along with their value */
  p_param &ORA_NAME_TYPE.,
  p_value varchar2(4000 byte),
  /**
    Function: msg_param
      Constructor function for values of type VARCHAR2
   */
  constructor function msg_param(
    self in out nocopy msg_param,
    p_param in varchar2,
    p_value in varchar2)
    return self as result,
  /**
    Function: msg_param
      Constructor function for values of type CLOB
   */
  constructor function msg_param(
    self in out nocopy msg_param,
    p_param in varchar2,
    p_value in clob)
    return self as result,
  /**
    Function: msg_param
      Constructor function for values of type DATE
   */
  constructor function msg_param(
    self in out nocopy msg_param,
    p_param in varchar2,
    p_value in date)
    return self as result,
  /**
    Function: msg_param
      Constructor function for values of type NUMBER
   */
  constructor function msg_param(
    self in out nocopy msg_param,
    p_param in varchar2,
    p_value in number)
    return self as result,
  /**
    Function: msg_param
      Constructor function for values of type TIMESTAMP
   */
  constructor function msg_param(
    self in out nocopy msg_param,
    p_param in varchar2,
    p_value in timestamp)
    return self as result,
  /**
    Function: msg_param
      Constructor function for values of type TIMESTAMP_WITH_TIME_ZONEW
   */
  constructor function msg_param(
    self in out nocopy msg_param,
    p_param in varchar2,
    p_value in timestamp with time zone)
    return self as result,
  /**
    Function: msg_param
      Constructor function for values of type XMLTYPE
   */
  constructor function msg_param(
    self in out nocopy msg_param,
    p_param in varchar2,
    p_value in xmltype)
    return self as result
);
/
