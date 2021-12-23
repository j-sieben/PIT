create or replace type pit_file under pit_module(
  
  /** 
    Package: Output Modules.PIT_FILE.PIT_FILE
      Output module to write information to a trace file. Extends <PIT_MODULE>.
   */
  /** 
    Procedure: log
      See <PIT_MODULE.log>
   */
  overriding member procedure log(
    self in out nocopy pit_file,
    p_message in message_type),    
    
  /** 
    Procedure: purge
      See <PIT_MODULE.purge>
   */
  overriding member procedure purge(
    self in out nocopy pit_file,
    p_purge_date in date,
    p_severity_greater_equal in integer default null),   
    
  /** 
    Procedure: enter
      See <PIT_MODULE.enter>
   */
  overriding member procedure enter(
    self in out nocopy pit_file,
    p_call_stack in pit_call_stack_type),   
    
  /** 
    Procedure: leave
      See <PIT_MODULE.leave>
   */
  overriding member procedure leave(
    self in out nocopy pit_file,
    p_call_stack in pit_call_stack_type),   
    
  /** 
    Procedure: pit_file
      Contructor function to instantiate the output module. Marks the module available only if the parameterized directory exists.
   */
  constructor function pit_file(
    self in out nocopy pit_file)
    return self as result)
  final instantiable;
/
