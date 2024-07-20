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
    self.p_value := substrb(p_value, 1, 2000);
    if self.p_value != p_value then
      self.p_value := self.p_value || C_EXTENSION;
    end if;
    return;
  end;
  
  constructor function msg_param(
    self in out nocopy msg_param,
    p_param in varchar2,
    p_value in clob)
    return self as result
  as
    C_EXTENSION constant varchar2(10 byte) := '...';
  begin
    self.p_param := substrb(p_param, 1, 128);
    self.p_value := dbms_lob.substr(p_value, 2000, 1);
    if dbms_lob.getlength(p_value) > 2000 then
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
    p_value in xmltype)
    return self as result
  as
    C_EXTENSION constant varchar2(10 byte) := '...';
  begin
    self.p_param := substrb(p_param, 1, 128);
    if p_value is not null then
      self.p_value := substr(p_value.getClobVal(), 1, 2000);
      if self.p_value != p_value.getClobVal() then
        self.p_value := self.p_value || C_EXTENSION;
      end if;
    end if;
    return;
  end;
  
  constructor function msg_param(
    self in out nocopy msg_param,
    p_param in varchar2,
    p_value in msg_args)
    return self as result
  as
    C_EXTENSION constant varchar2(10 byte) := '...';
    l_value varchar2(4000 byte);
  begin
    self.p_param := substrb(p_param, 1, 128);
    if p_value is not null then
      for i in 1 .. p_value.count loop
        if i > 1 then
          l_value := l_value || ', ';
        end if;
        l_value := l_value || substr(p_value(i), 1, 200);
        if length(p_value(i)) > 200 then 
          l_value := l_value || C_EXTENSION;
        end if;
        if length(l_value) > 3800 then
          l_value := l_value || ' [...]';
          exit;
        end if;
      end loop;
    end if;
    return;
   end;

  constructor function msg_param(
    self in out nocopy msg_param,
    p_param in varchar2,
    p_value in boolean)
    return self as result
  as
  begin
    self.p_param := substrb(p_param, 1, 128);
    if p_value then
      self.p_value := 'true';
    else
      self.p_value := 'false';
    end if;
    return;
  end;  

end;
/