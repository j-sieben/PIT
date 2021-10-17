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

 constructor function msg_param(
   self in out nocopy msg_param,
   p_param in varchar2,
   p_value in date)
   return self as result
 as
 begin
   self.p_param := substrb(p_param, 1, 128);
   if p_value > trunc(p_value) then
     self.p_value := to_char(p_value, 'YYYY-MM-DD HH24:MI:SS');
   else
     self.p_value := to_char(p_value, 'YYYY-MM-DD');
   end if;
   return;
 end;

 constructor function msg_param(
   self in out nocopy msg_param,
   p_param in varchar2,
   p_value in number)
   return self as result
 as
   C_EXTENSION constant varchar2(10 byte) := '...';
 begin
   self.p_param := substrb(p_param, 1, 128);
   if p_value > trunc(p_value) then
     self.p_value := to_char(p_value, 'fm999999999999999999990D9999999999999999');
   else
     self.p_value := to_char(p_value, 'fm999999999999999999999');
   end if;
   return;
 end;

 constructor function msg_param(
   self in out nocopy msg_param,
   p_param in varchar2,
   p_value in timestamp)
   return self as result
 as
 begin
   self.p_param := substrb(p_param, 1, 128);
   if p_value > trunc(p_value) then
     self.p_value := to_char(p_value, 'YYYY-MM-DD HH24:MI:SSXFF');
   else
     self.p_value := to_char(p_value, 'YYYY-MM-DD');
   end if;
   return;
 end;

 constructor function msg_param(
   self in out nocopy msg_param,
   p_param in varchar2,
   p_value in timestamp with time zone)
   return self as result
 as
 begin
   self.p_param := substrb(p_param, 1, 128);
   if p_value > trunc(p_value) then
     self.p_value := to_char(p_value, 'YYYY-MM-DD HH24:MI:SSXFF TZR');
   else
     self.p_value := to_char(p_value, 'YYYY-MM-DD');
   end if;
   return;
 end;

 constructor function msg_param(
   self in out nocopy msg_param,
   p_param in varchar2,
   p_value in timestamp with local time zone)
   return self as result
 as
 begin
   self.p_param := substrb(p_param, 1, 128);
   if p_value > trunc(p_value) then
     self.p_value := to_char(p_value, 'YYYY-MM-DD HH24:MI:SSXFF TZR');
   else
     self.p_value := to_char(p_value, 'YYYY-MM-DD');
   end if;
   return;
 end;

 constructor function msg_param(
   self in out nocopy msg_param,
   p_param in varchar2,
   p_value in interval year to month)
   return self as result
 as
 begin
   self.p_param := substrb(p_param, 1, 128);
   self.p_value := to_char(p_value);
   return;
 end;

 constructor function msg_param(
   self in out nocopy msg_param,
   p_param in varchar2,
   p_value in interval day_to_second)
   return self as result
 as
 begin
   self.p_param := substrb(p_param, 1, 128);
   self.p_value := to_char(p_value);
   return;
 end;

 constructor function msg_param(
   self in out nocopy msg_param,
   p_param in varchar2,
   p_value in xmltype)
   return self as result
 as
   C_EXTENSION constant varchar2(10 byte) := '...';
 begin
   self.p_param := substrb(p_param, 1, 128);
   self.p_value := case when p_value is not null then substr(p_value.getclobval(), 1, 4000 - length(C_EXTENSION)) else null end;
   return;
 end;

end;
/
