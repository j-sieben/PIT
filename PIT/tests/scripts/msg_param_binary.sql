-- Run as the PIT owner after installing the matching MSG_PARAM specification/body.
set serveroutput on
whenever sqlerror exit failure rollback

declare
  l_param msg_param;
  l_raw raw(32767);
  l_blob blob;

  procedure expect(p_condition in boolean, p_description in varchar2) is
  begin
    if p_condition is null or not p_condition then
      raise_application_error(-20000, p_description);
    end if;
  end;

begin
  -- BLOB values retain length-only output.
  dbms_lob.createtemporary(l_blob, true);
  l_param := msg_param('empty blob', l_blob);
  expect(l_param.p_value = '[BLOB], 0 byte', 'Incorrect empty BLOB length');
  l_raw := hextoraw(rpad('AB', 402, 'AB'));
  dbms_lob.writeappend(l_blob, 201, l_raw);
  l_param := msg_param('blob', l_blob);
  expect(l_param.p_param = 'blob' and l_param.p_value = '[BLOB], 201 byte',
    'BLOB must report only its length');
  dbms_lob.freetemporary(l_blob);
  dbms_output.put_line('PASS: BLOB length only');
exception
  when others then
    if dbms_lob.istemporary(l_blob) = 1 then
      dbms_lob.freetemporary(l_blob);
    end if;
    raise;
end;
/
