create or replace package body mail_ntlm
as
  /** 
    Package: Output Modules.PIT_MAIL.MAIL_NTLM Body
      Package to allow to authenticate to a NTLM SMTP server
      
    Disclaimer::
      This package is a PL/SQL port from the Ntml.java, distributed under
      <GNU General Public License Version 2 only ("GPL") or the Common Development
      and Distribution License("CDDL") 1.0: https://glassfish.dev.java.net/public/CDDL+GPL_1_1.html>.
      Ntlm.java is part of javamail, available at http://kenai.com/projects/javamail
      Authors: Michael McMahon and Bill Shannon
      Port made by Javier Martin-Ortega, under GPL v2
   
    Author::
      Juergen Sieben, ConDeS GmbH
  */

  /** 
    Group: Private Constants
  */

  /**
    Constants: Crypt-related constants
      C_CRYPT_TYPE - Encryption method required for NTLM
      C_MAGIC - Salt information
      C_NTLM - Name of the authentication method NTLM
  */
  c_crypt_type constant pls_integer :=
    dbms_crypto.chain_ecb + dbms_crypto.encrypt_des + dbms_crypto.pad_none;
  c_magic constant varchar2(16):='4b47532140232425';
  c_ntlm constant varchar2(10) := 'NTLM';


  function bitor(
    p_x in number,
    p_y in number)
    return number
  as
  begin
    return p_x + p_y - bitand(p_x, p_y);
  end bitor;


  function bit_shift_left(
    p_x in number,
    p_n in number)
    return number
  as
  begin
    return p_x * power(2, p_n);
  end bit_shift_left;


  function bit_shift_right(
    p_x in number,
    p_n in number)
    return number
  as
  begin
      return trunc(p_x / power(2, p_n));
  end bit_shift_right;


  function binary_ops(
    p_first_byte char,
    p_second_byte char,
    p_first_offset number,
    p_second_offset number)
    return char
  as
    v_return char;
  begin
    return ltrim(to_char(bitor(bitand(
             bit_shift_left(to_number(p_first_byte, '0x'), p_first_offset), 255),
             bit_shift_right(to_number(p_second_byte, '0x'), p_second_offset)), '0x'));
  end binary_ops;


  /**
    Group: Helper Methods
   */
  /** 
    Function: create_des_key
      Method to create a DES key based on the input parameters
      
    Parameters:
      p_key - Key
      p_offset - Offset value for the key
      
    Returns:
      DES key
   */
  function create_des_key(
    p_key varchar,
    p_offset number)
    return varchar2
  as
  begin
    return substr(p_key, 1 + p_offset * 2, 2) ||
      binary_ops(substr(p_key, 1 + p_offset * 2, 2),substr(p_key, 3 + p_offset * 2, 2),7, 1) ||
      binary_ops(substr(p_key, 3 + p_offset * 2, 2),substr(p_key, 5 + p_offset * 2, 2),6, 2) ||
      binary_ops(substr(p_key, 5 + p_offset * 2, 2),substr(p_key, 7 + p_offset * 2, 2),5, 3) ||
      binary_ops(substr(p_key, 7 + p_offset * 2, 2),substr(p_key, 9 + p_offset * 2, 2),4, 4) ||
      binary_ops(substr(p_key, 9 + p_offset * 2, 2),substr(p_key, 11 + p_offset * 2, 2),3, 5) ||
      binary_ops(substr(p_key, 11 + p_offset * 2, 2),substr(p_key, 13 + p_offset * 2, 2),2, 6) ||
      ltrim(to_char(bitand(bit_shift_left(to_number(substr(p_key, 13 + p_offset * 2, 2), '0x'), 1), 255), '0x'));
  end create_des_key;


  /**
    Function: add_parity_bit
      Adds a parity bit at the end of every byte
      
    Parameter:
      p_des_key - DES key
    
    Returns: 
      DES key with the parity bits added
   */
  function add_parity_bit(
    p_des_key in varchar2)
    return varchar2
  as
    l_num_des_key number;
    l_aux_des_key number;
    l_high_bit_count number;
  begin
    -- We count the number of high bits by dividing the original number by two until it reaches 0.
    l_num_des_key := to_number(p_des_key, '0x');
    l_aux_des_key := l_num_des_key;
    l_high_bit_count := 0;
    while (l_aux_des_key > 0) loop
      l_high_bit_count := l_high_bit_count + mod(l_aux_des_key, 2);
      l_aux_des_key := trunc(l_aux_des_key/2, 0);
    end loop;
    -- If l_high_bit_count is even, add a final bit
    if (mod(l_high_bit_count, 2)=0) then
      -- If original number is odd, there is already a final bit, do not add it.
      if (mod(l_num_des_key, 2)=0) then
        return ltrim(to_char(l_num_des_key + 1, '0x'));
      end if;
    end if;
    -- If not, return the same number
    return ltrim(to_char(l_num_des_key, '0x'));
  end add_parity_bit;


  /**
    Function: generate_secret
      Generates a secret from the DES key
      
    Parameter:
      p_des_key - DES key
    
    Returns: 
      Secret
   */
  function generate_secret(
    p_des_key varchar2)
    return varchar2
  as
  begin
    return add_parity_bit(substr(p_des_key, 1, 2)) ||
      add_parity_bit(substr(p_des_key, 3, 2)) ||
      add_parity_bit(substr(p_des_key, 5, 2)) ||
      add_parity_bit(substr(p_des_key, 7, 2)) ||
      add_parity_bit(substr(p_des_key, 9, 2)) ||
      add_parity_bit(substr(p_des_key, 11, 2)) ||
      add_parity_bit(substr(p_des_key, 13, 2)) ||
      add_parity_bit(substr(p_des_key, 15, 2));
  end;


  /**
    Function: get_utf_little_unmarked
      Converts <P_TEXT> to Unicode by simply adding a 00 byte after every original text's byte
      
    Parameter:
      p_text - Text to convert
      
    Returns:
      Unicode encoded string
   */
  function get_utf_little_unmarked(
    p_text varchar2)
    return varchar2
  as
    l_unicode_text varchar2(2000);
  begin
    -- We simply add a 00 byte after every original text's byte
    for i in 1..length(p_text) loop
      l_unicode_text := l_unicode_text||
        rawtohex(utl_raw.cast_to_raw(substr(p_text, i, 1))) ||
        '00';
    end loop;
    return l_unicode_text;
  end get_utf_little_unmarked;


  /**
    Function: length_in_two_bytes
      Returns the length passed in as <P_DATA> in a two byte representation
      
    Parameter:
      p_data - Length to convert
      
    Returns:
      Length as a two byte string
   */
  function length_in_two_bytes(
    p_data number)
    return varchar2
  as
  begin
    return ltrim(to_char(mod(p_data, 256), '0x')) ||
           ltrim(to_char(trunc(p_data / 256, 0), '0x'));
  end length_in_two_bytes;


  /**
    Function: calc_response
    
    Parameters:
      p_key - Key
      p_test - Textto encrypt
    
    Returns:
      Encrypted version of <P_TEXT> 
   */
  function calc_response(
    p_key in varchar2,
    p_text in varchar2)
    return varchar2
  as
    l_result varchar2(200);
  begin
      l_result :=
        dbms_crypto.encrypt(
          key => hextoraw(generate_secret(create_des_key(p_key, 0))),
          src => hextoraw(p_text),
          typ => c_crypt_type
        ) ||
        dbms_crypto.encrypt(
          key => hextoraw(generate_secret(create_des_key(p_key, 7))),
          src => hextoraw(p_text),
          typ => c_crypt_type
        ) ||
        dbms_crypto.encrypt(
            key => hextoraw(generate_secret(create_des_key(p_key, 14))),
            src => hextoraw(p_text),
            typ => c_crypt_type
        );
      return l_result;
  end calc_response;


  /**
    Function: calc_lm_hash
      
    Parameter:
      p_password - Password to hash
      
    Returns: 
      Encrypted password for LM
   */
  function calc_lm_hash (
    p_password in varchar2)
    return varchar2
  as
    l_password varchar2(64);
    l_hash varchar2(200);
  begin
    l_password := rpad(substr(rawtohex(utl_raw.cast_to_raw(upper(p_password))), 1, 28), 28, '0');
    l_hash :=
      dbms_crypto.encrypt (
        key => hextoraw(generate_secret(create_des_key(l_password, 0))),
        src => hextoraw(c_magic),
        typ => c_crypt_type
      )||
      dbms_crypto.encrypt (
        key => hextoraw(generate_secret(create_des_key(l_password, 7))),
        src => hextoraw(c_magic),
        typ => c_crypt_type
    );
    return rpad(l_hash, 21 * 2, '0');
  end calc_lm_hash;


  /**
    Function: calc_nt_hash
      
    Parameter:
      p_password - Password to hash
      
    Returns: 
      Encrypted password for NT
   */
  function calc_nt_hash(
    p_password varchar2)
    return varchar2
  as
  begin
    -- get the MD4 digest message, filled with 0s 'til 21 bytes
    return rpad(substr(
      dbms_crypto.hash (
          src => hextoraw(get_utf_little_unmarked(p_password)),
          typ => dbms_crypto.hash_md4
      ),
      1, 16 * 2), 21 * 2, '0');
  end calc_nt_hash;

  
  /**
    Function: generate_first_msg
      Generates the initial message to authenticate
      
    Parameters:
      p_domain - Domain of the mail server
      p_host - Name of the mail server
      
    Returns:
      Initial message
   */
  function generate_first_msg(
    p_domain in varchar2,
    p_host in varchar2)
    return varchar2
  as
    c_bytes_0_15 constant varchar2(60) := '4E544C4D535350000100000003B20000';
    c_bytes_22_23 constant varchar2(4) := '0000';
    c_bytes_28_31 constant varchar2(8) := '20000000';
    c_crlf constant varchar2(2) := chr(13) || chr(10);
    l_host varchar2(128);
    l_domain_byte_count varchar2(4);
    l_host_byte_count varchar2(4);
    l_domain_offset_bytes varchar2(4);
  begin
    -- hostname is only until the first dot
    l_host := p_host;
    if (instr(p_host, '.') > 0) then
      l_host := substr(p_host, 1, instr(p_host, '.') - 1);
    end if;
    l_domain_byte_count := length_in_two_bytes(length(p_domain));
    l_host_byte_count := length_in_two_bytes(length(l_host));
    l_domain_offset_bytes := length_in_two_bytes(32 + length(l_host));
    -- BASE64_ENCODE includes a CR/LF every 64 characters that must be removed
    return
      replace(
        utl_raw.cast_to_varchar2(
          utl_encode.base64_encode(
            hextoraw(
              c_bytes_0_15 ||
              l_domain_byte_count ||
              l_domain_byte_count ||
              l_domain_offset_bytes ||
              c_bytes_22_23 ||
              l_host_byte_count ||
              l_host_byte_count ||
              c_bytes_28_31 ||
              rawtohex(utl_raw.cast_to_raw(l_host)) ||
              rawtohex(utl_raw.cast_to_raw(p_domain))
            )
          )
        ),
        c_crlf, ''
      );
  end generate_first_msg;


  /**
    Function: generate_second_msg
      Generates the initial message to authenticate
      
    Parameters:
      p_first_reply - First reply of the server
      p_user - User name to authenticate
      p_password - Password of the user
      p_domain - Domain of the mail server
      p_host - Name of the mail server
      
    Returns:
      Second message
   */
  function generate_second_msg(
    p_first_reply in varchar2,
    p_user in varchar2,
    p_password in varchar2,
    p_domain in varchar2,
    p_host in varchar2)
    return varchar2
  as
    l_host varchar2(128);
    l_nonce varchar2(16);
    l_lm_response varchar2(64);
    l_nt_response varchar2(64);
    l_user_byte_count varchar2(4);
    l_domain_byte_count varchar2(4);
    l_host_byte_count varchar2(4);
    l_total_byte_count varchar2(4);
    l_utf_user varchar2(128);
    l_utf_domain varchar2(128);
    l_utf_host varchar2(128);
    l_user_offset_bytes varchar2(4);
    l_host_offset_bytes varchar2(4);
    l_lm_response_offset_bytes varchar2(4);
    l_nt_response_offset_bytes varchar2(4);
    l_temp_offset number := 64;
  begin
    -- hostname is only until the first dot
    l_host := p_host;
    if (instr(p_host, '.')>0) then
      l_host := substr(p_host, 1, instr(p_host, '.')-1);
    end if;
    -- l_nonce is located at challenge message, byte 24 for 8 bytes.
    -- type2 challenge message comes in BASE64
    l_nonce := substr(rawtohex(utl_encode.base64_decode(utl_raw.cast_to_raw(p_first_reply))), 24 * 2 + 1, 8 * 2);

    l_nonce := substr(RAWTOHEX(UTL_ENCODE.BASE64_DECODE(UTL_RAW.CAST_TO_RAW(p_first_reply))),24 * 2 + 1,8 * 2);
    l_user_byte_count := length_in_two_bytes(length(p_user) * 2);
    l_domain_byte_count := length_in_two_bytes(length(p_domain) * 2);
    l_host_byte_count := length_in_two_bytes(length(l_host) * 2);
    l_lm_response := calc_response(calc_lm_hash(p_password), l_nonce);
    l_nt_response := calc_response(calc_nt_hash(p_password), l_nonce);
    l_utf_user := get_utf_little_unmarked(p_user);
    l_utf_domain := get_utf_little_unmarked(p_domain);
    l_utf_host := get_utf_little_unmarked(l_host);
    l_temp_offset := l_temp_offset + length(l_utf_domain)/2;
    l_user_offset_bytes := length_in_two_bytes(l_temp_offset);
    l_temp_offset := l_temp_offset + length(l_utf_user)/2;
    l_host_offset_bytes := length_in_two_bytes(l_temp_offset);
    l_temp_offset := l_temp_offset + length(l_utf_host)/2;
    l_lm_response_offset_bytes := length_in_two_bytes(l_temp_offset);
    l_temp_offset := l_temp_offset + length(l_lm_response)/2;
    l_nt_response_offset_bytes := length_in_two_bytes(l_temp_offset);
    l_temp_offset := l_temp_offset + length(l_nt_response)/2;
    l_total_byte_count := length_in_two_bytes(l_temp_offset);

    -- BASE64_ENCODE includes a CR/LF every 64 characters that must be removed
    return replace(utl_raw.cast_to_varchar2(utl_encode.base64_encode(hextoraw(
      '4E544C4D535350000300000018001800'|| -- bytes 00-15
      l_lm_response_offset_bytes ||
      '000018001800' ||-- bytes 18-23
      l_nt_response_offset_bytes ||
      '0000'|| --bytes 16-27
      l_domain_byte_count||
      l_domain_byte_count||
      '4000' || --domain offset is always 64
      '0000'|| --bytes 34-35
      l_user_byte_count||
      l_user_byte_count||
      l_user_offset_bytes ||
      '0000' || -- bytes 42-43
      l_host_byte_count ||
      l_host_byte_count ||
      l_host_offset_bytes||
      '000000000000'|| -- bytes 50-56
      l_total_byte_count ||
      '000001820000'|| -- bytes 58-63
      l_utf_domain||
      l_utf_user||
      l_utf_host||
      l_lm_response||
      l_nt_response))), chr(13) || chr(10), '');
  end generate_second_msg;


  /**
    Group: Interface
   */
  /**
    Procedure: authenticate
      see: <MAIL_NTLM.authenticate>
   */
  procedure authenticate(
    p_conn in out nocopy utl_smtp.connection,
    p_host in varchar2,
    p_user_name in varchar2,
    p_password in varchar2)
  as
    l_message varchar2(32767);
    l_reply utl_smtp.reply;
    l_host varchar2(64);
    l_domain varchar2(64);
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_host', p_host),
                    msg_param('p_user_name', p_user_name),
                    msg_param('p_password', lpad('*', length(p_password), '*'))));
                    
    l_host := substr(p_host, 1, instr(p_host, '.') - 1);
    l_domain := substr(p_host, instr(p_host, '.') + 1);
    utl_smtp.command(p_conn, 'AUTH NTLM');
    l_message := generate_first_msg(l_domain, l_host);
    l_reply := utl_smtp.command(p_conn, l_message);
    l_message :=
      generate_second_msg(
        p_first_reply => l_reply.text,
        p_user => p_user_name,
        p_password => p_password,
        p_domain => l_domain,
        p_host => l_host);
    l_reply := utl_smtp.command(p_conn, l_message);
    
    pit.leave_optional;
  end authenticate;
  
end mail_ntlm;
/

