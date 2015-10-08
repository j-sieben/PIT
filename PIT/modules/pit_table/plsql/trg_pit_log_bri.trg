
create or replace trigger trg_pit_log_bri 
before insert on pit_log 
for each row 
begin
  /* Asserts that 
   * <ul><li>LOG_DATE is set to localtimestamp</li>
   * <li>SESSION_ID is limited to 64 char</li>
   * <li>USER_NAME is limited ot 30 char</li></ul>
   */
  :new.log_date := localtimestamp;
  :new.session_id := substr(:new.session_id, 1, 64);
  :new.user_name := substr(:new.user_name, 1, 30);
end;
/
