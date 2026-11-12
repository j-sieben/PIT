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

  procedure check_raw(p_value in raw, p_expected in varchar2) is
  begin
    l_param := msg_param('binary', p_value);
    expect(l_param.p_param = 'binary', 'RAW parameter name changed');
    expect(l_param.p_value = p_expected, 'Incorrect RAW preview or length');
  end;
begin
  -- A UUID retains all bytes, including leading zeroes, in uppercase hex.
  check_raw(hextoraw('00112233445566778899AABBCCDDEEFF'),
    '00112233445566778899AABBCCDDEEFF (16 byte)');
  check_raw(hextoraw('00FF'), '00FF (2 byte)');

  -- Exercise the boundary and prove that the suffix reports the original length.
  for n in 199 .. 201 loop
    l_raw := hextoraw(rpad('AB', 2 * n, 'AB'));
    check_raw(l_raw, rpad('AB', 2 * least(n, 200), 'AB') ||
      ' (' || n || ' byte)');
  end loop;
  l_raw := utl_raw.copies(hextoraw('AB'), 32767);
  check_raw(l_raw, rpad('AB', 400, 'AB') || ' (32767 byte)');

  l_raw := null;
  l_param := msg_param('null raw', l_raw);
  expect(l_param.p_param = 'null raw' and l_param.p_value is null,
    'Null RAW must remain null');

  -- BLOB values retain length-only output, even beyond the RAW preview limit.
  dbms_lob.createtemporary(l_blob, true);
  l_param := msg_param('empty blob', l_blob);
  expect(l_param.p_value = '[BLOB], 0 byte', 'Incorrect empty BLOB length');
  l_raw := hextoraw(rpad('AB', 402, 'AB'));
  dbms_lob.writeappend(l_blob, 201, l_raw);
  l_param := msg_param('blob', l_blob);
  expect(l_param.p_param = 'blob' and l_param.p_value = '[BLOB], 201 byte',
    'BLOB must report only its length');
  dbms_lob.freetemporary(l_blob);
  dbms_output.put_line('PASS: RAW hex preview and full length; BLOB length only');
exception
  when others then
    if dbms_lob.istemporary(l_blob) = 1 then
      dbms_lob.freetemporary(l_blob);
    end if;
    raise;
end;
/
