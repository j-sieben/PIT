create or replace trigger trg_message_briu 
  before insert or update on message
  for each row
begin
  /* Asserts that
   * <ul><li>any message with severity <= is provided with an error number, either passed in or -20000.</li>
   * <li>any custom error number is unique and not a predefined Oracle error</li>
   * <li>MESSAGE_NAME and MESSAGE_LANGUAGE are uppercase.</li></ul>
   */
  if :new.severity <= 30 then
    :new.custom_error_number := coalesce(:new.custom_error_number, -20000);
    -- Exclude Oracle predefined errors from package STANDARD
    if :new.custom_error_number != -20000 then
      $IF $$PIT_INSTALLED $THEN
      pit_util.check_error(:new.message_name, :new.custom_error_number);
      $ELSE
      null;
      $END
    end if;
  else
    :new.custom_error_number := null;
  end if;
  :new.message_name := upper(:new.message_name);
  :new.message_language := upper(:new.message_language);
end;
/