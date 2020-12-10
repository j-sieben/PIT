create or replace type pit_message_table as 
  /** List type of MESSAGE_TYPE, used to collect messages on a stack */
  table of message_type;
/