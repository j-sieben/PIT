create or replace trigger trg_pit_call_stack_bri 
before insert on pit_call_stack
for each row
begin
  /* Asserts that 
   * <ul><li>SESSION_ID is limited to 64 char</li>
   * <li>USER_NAME is limited ot 30 char</li></ul>
   */
  :new.session_id := substr(:new.session_id, 1, 64);
  :new.user_name := substr(:new.user_name, 1, 30);
end;
/
