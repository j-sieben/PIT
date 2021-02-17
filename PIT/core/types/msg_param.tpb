create or replace type body msg_param
as
 constructor function msg_param(
   self in out nocopy msg_param,
   p_param in varchar2,
   p_value in varchar2)
   return self as result
 as
   C_EXTENSION constant varchar2(10 byte) := '...';
 begin
   self.p_param := substrb(p_param, 1, 128);
   self.p_value := substrb(p_value, 1, 4000 - length(C_EXTENSION));
   if self.p_value != p_value then
     self.p_value := self.p_value || C_EXTENSION;
   end if;
   return;
 end;

end;
/