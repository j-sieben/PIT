create or replace type pit_log_state_type
  authid definer
is object (
  /**
    Type: log_state_type
      Used to log a state along with an ID and a severity 
      
    Properties:
      id - Technical key,
      severity - Level of the entry
      params - Method parameters passed in
   */
  id integer,
  severity integer,
  params msg_params,
  /** 
    Function: log_state_type
      Constructor function
      
    Parameters:
      p_severity - Level of the entry
      p_params - Method parameters passed in
   */
  constructor function pit_log_state_type(
    self in out nocopy pit_log_state_type,
    p_severity in integer,
    p_params in msg_params)
    return self as result
)
final instantiable;
/