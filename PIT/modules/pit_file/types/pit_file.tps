create or replace type pit_file under pit_module(
  /** Output module to write information to a trace file */
  
  /** Method writes logging or debugging information to the file */
  overriding member procedure log(
    self in out nocopy pit_file,
    p_message in message_type),
    
  /** Method purges a trace file. It will purge the file completely, no filters are applied */
  overriding member procedure purge(
    self in out nocopy pit_file,
    p_purge_date in date,
    p_severity_greater_equal in integer default null),
    
  /** Method writes entering a method to the file, including input parameters */
  overriding member procedure enter(
    self in out nocopy pit_file,
    p_call_stack in call_stack_type),
    
  /** Method writes leaving a method to the file, including output parameters */
  overriding member procedure leave(
    self in out nocopy pit_file,
    p_call_stack in call_stack_type),
    
  /** Constructor method. If the directory is not accessible, it will render the module unusable */
  constructor function pit_file(
    self in out nocopy pit_file)
    return self as result)
  final instantiable;
/
