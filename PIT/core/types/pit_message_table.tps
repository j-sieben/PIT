create or replace type pit_message_table as 
  /** 
    Type: pit_message_table
      List type of <MESSAGE_TYPE>, used to collect messages on a stack 
   */
  table of message_type;
/