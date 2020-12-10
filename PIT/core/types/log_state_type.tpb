create or replace type body log_state_type
as
  /** Implementation of constructor method */
  
  /** constructor function */
  constructor function log_state_type(
    self in out nocopy log_state_type,
    p_severity in integer,
    p_params in msg_params)
    return self as result
  as
  begin
    self.id := pit_log_seq.nextval;
    self.severity := p_severity;
    self.params := p_params;
    return;
  end log_state_type;
  
end;
/