create or replace type log_state_type
  authid definer
is object (
  /** Type to log a state along with an ID and a severity */
  
  -- Attributes
  id integer,
  severity integer,
  params msg_params,
  /** constructor function */
  constructor function log_state_type(
    self in out nocopy log_state_type,
    p_severity in integer,
    p_params in msg_params)
    return self as result
)
final instantiable;
/