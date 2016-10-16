create or replace trigger pit_message_trg_briu 
  before insert or update on pit_message
  for each row
begin
  /* Asserts that
   * <ul><li>any message with severity <= is provided with an error number, either passed in or -20000.</li>
   * <li>any custom error number is unique and not a predefined Oracle error</li>
   * <li>MESSAGE_NAME and MESSAGE_LANGUAGE are uppercase.</li></ul>
   */
  if :new.pms_pse_id <= 30 then
    :new.pms_custom_error := coalesce(:new.pms_custom_error, -20000);
    -- Exclude Oracle predefined errors from package STANDARD
    if :new.pms_custom_error != -20000 then
      $IF $$PIT_INSTALLED $THEN
      pit_util.check_error(:new.pms_name, :new.pms_custom_error);
      $ELSE
      null;
      $END
    end if;
  else
    :new.pms_custom_error := null;
  end if;
  :new.pms_name := upper(:new.pms_name);
  :new.pms_pml_name := upper(:new.pms_pml_name);
end;
/