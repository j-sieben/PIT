create or replace type body pit_context_type
as

  constructor function pit_context_type(
    self in out nocopy pit_context_type)
  return self as result
  as
  begin
    return;
  end pit_context_type;

  constructor function pit_context_type(
    self in out nocopy pit_context_type,
    p_context_name in varchar2,
    p_settings varchar2)
  return self as result
  as
  begin
    pit_context.instantiate_pit_context_type(
      p_self =>self, 
      p_settings => p_settings, 
      p_context_name => p_context_name);
    return;
  end pit_context_type;

  constructor function pit_context_type(
    self in out nocopy pit_context_type,
    p_settings varchar2)
  return self as result
  as
  begin
    pit_context.instantiate_pit_context_type(
      p_self => self,
      p_settings => p_settings);
    return;
  end pit_context_type;
end;
/
    