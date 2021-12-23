create or replace package pit_file_pkg
  authid definer
as

  /**
    Package: Output Modules.PIT_FILE.PIT_FILE_PKG
      Implementation package for type <PIT_AFILE>
   
    Author::
      Juergen Sieben, ConDeS GmbH
   */
    
  /**
    Procedure: log
      Method to write log information to a trace file.
      
      Method implements the LOG member procedure and writes the message attributes to the trace file.
      
    Parameter:
      p_message - Instance of <MESSAGE_TYPE>
   */
  procedure log (
    p_message in message_type);
    
    
  /**
    Procedure: log
      Method to write state information to a trace file.
      
      Method implements the <pit_file.log> member procedure and writes the key value pairs of MSG_PARAM to a trace file.
      
    Parameter:
      p_params - Instance of <MSG_PARAMS>
   */
  procedure log (
    p_params in msg_params);
    
    
  /**
    Procedure: purge
      Method to purge log information from tables <PIT_TABLE_LOG>, <PIT_TABLE_CALL_STACK> and <PIT_TABLE_PARAMS>.
      
      Method implements the <pit_file.purge> member procedure and erases the log file. 
      It will not filter as by <P_DATE_UNTIL> and <P_SEVERITY_GREATER_EQUAL> defined in the type.
   */
  procedure purge;
    
    
  /**
    Procedure: enter
      Method to write call stack information on enter to a trace file
      
      Method implements the <pit_file.enter> member procedure and writes the call stack type attributes to a trace file.
      
    Parameter:
      p_call_stack - Instance of <CALL_STACK_TYPE>
   */
  procedure enter(
    p_call_stack in pit_call_stack_type);
    
    
  /**
    Procedure: leave
      Method to write call stack information on leave to a trace file
      
      Method implements the <pit_file.leave> member procedure and writes the call stack type attributes to a trace file.
      
    Parameter:
      p_call_stack - Instance of <CALL_STACK_TYPE>
   */
  procedure leave(
    p_call_stack in pit_call_stack_type);
    
    
  /**
    Procedure: initialize_module
      Method implements the parameterless <pit_file> constructor of type PIT_FILE. The output module is available if it is possible to open the trace file.
      
    Parameter:
      p_call_stack - Instance of <CALL_STACK_TYPE>
   */
  procedure initialize_module(self in out pit_file);
  
end pit_file_pkg;
/

show errors
