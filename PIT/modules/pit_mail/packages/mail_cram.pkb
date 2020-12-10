create or replace package body mail_cram
as

  /** Package implements CRAM-Authentication */

  /** Method to create an authorization string
   * %param  p_user         User name
   * %param  p_password     Password of the user
   * %param  p_challenge    Password of the user
   * %param  p_hash_method  Password of the user
   * %return Authorization string
   * %usage  Is used to form an authorization string based on the hash method chosen
   */
  function get_auth_string(
    p_user in varchar2,
    p_password in varchar2,
    p_challenge in varchar2,
    p_hash_method in varchar2)
    return varchar2
  as
    c_blocksize constant integer := 64;
    c_zeroblock constant raw(64) := utl_raw.copies(hextoraw('00'), c_blocksize);
    c_outerpad constant raw(64) := utl_raw.copies(hextoraw('5C'), c_blocksize);
    c_innerpad constant raw(64) := utl_raw.copies(hextoraw('36'), c_blocksize);

    l_outer raw(64);
    l_inner raw(64);
    l_challenge varchar2(32767);
    l_key raw(32767) := utl_raw.cast_to_raw(p_password);
    l_hash varchar2(64);
    l_hash_method pls_integer;
  begin
    pit.enter_optional('get_auth_string',
      p_params => msg_params(
                    msg_param('p_user', p_user),
                    msg_param('p_password', lpad('*', length(p_password), '*')),
                    msg_param('p_challenge', p_challenge),
                    msg_param('p_hash_method', p_hash_method)));
                    
    case p_hash_method
    when c_hash_md5 then
      l_hash_method := dbms_crypto.hash_md5;
    when c_hash_sha1 then
      l_hash_method := dbms_crypto.hash_sh1;
    else
      l_hash_method := null;
    end case;

    -- If the key is bigger than the block size (64) then hash it
    -- which will reduce it to a shorter byte stream
    if utl_raw.length(l_key) > c_blocksize then
      l_key := dbms_crypto.hash(l_key, l_hash_method);
    end if;

    -- 0-pad the key to fill a block
    if utl_raw.length(l_key) < c_blocksize then
      l_key := utl_raw.overlay(l_key, c_zeroblock);
    end if;

    -- The challenge will be a base64 encoded string
    l_challenge := utl_encode.base64_decode(utl_raw.cast_to_raw(p_challenge));

    l_outer := utl_raw.bit_xor(l_key, c_outerpad);
    l_inner := utl_raw.bit_xor(l_key, c_innerpad);

    -- append the challenge to the key and hash it
    l_inner := dbms_crypto.hash(utl_raw.concat(l_inner, l_challenge), l_hash_method);

    -- append the new inner hash to the outer and hash again
    -- return results as a string for use in next step
    l_hash := lower(rawtohex(dbms_crypto.hash(utl_raw.concat(l_outer, l_inner), l_hash_method)));

    -- base64 encode the username with the hash, separated by a space
    l_hash := utl_raw.cast_to_varchar2(
             utl_encode.base64_encode(utl_raw.cast_to_raw(p_user || ' ' || l_hash)));
             
    pit.leave_optional(
      p_params => msg_params(
                    msg_param('Authorization String', l_hash)));
    return l_hash;
  end get_auth_string;


  procedure authenticate(
    p_conn in out nocopy utl_smtp.connection,
    p_hash_method in varchar2,
    p_user_name in varchar2,
    p_password in varchar2)
  as
    l_reply utl_smtp.reply;
    l_auth_string varchar2(32767);
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_user_name', p_user_name),
                    msg_param('p_password', lpad('*', length(p_password), '*')),
                    msg_param('p_hash_method', p_hash_method)));
                    
    l_reply := utl_smtp.command(p_conn, 'AUTH', p_hash_method);
    if l_reply.code = 334 then
      l_auth_string := get_auth_string(
                         p_user => p_user_name,
                         p_password => p_password,
                         p_challenge => l_reply.text, -- challenge from server
                         p_hash_method => p_hash_method);
      utl_smtp.command(p_conn, l_auth_string);
    end if;
    
    pit.leave_optional;
  end authenticate;

end mail_cram;
/

