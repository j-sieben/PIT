create or replace package utl_text
  authid definer
as
  function not_empty(
    p_text in varchar2)
    return boolean;

  function append(
    p_text in varchar2,
    p_chunk in varchar2,
    p_delimiter in varchar2 default null,
    p_before in varchar2 default 'N')
    return varchar2;

  procedure append(
    p_text in out nocopy varchar2,
    p_chunk in varchar2,
    p_delimiter in varchar2 default null,
    p_before in varchar2 default 'N');

  function concatenate(
    p_chunks in char_table,
    p_delimiter in varchar2 default ':',
    p_ignore_nulls in boolean default true)
    return varchar2;

  procedure concatenate(
    p_text in out nocopy varchar2,
    p_chunks in char_table,
    p_delimiter in varchar2 default ':',
    p_ignore_nulls in boolean default true);


  procedure bulk_replace(
    p_text in out nocopy varchar2,
    p_chunks in char_table);

  function bulk_replace(
    p_text in varchar2,
    p_chunks in char_table)
    return varchar2;

  function string_to_table(
    p_string in varchar2,
    p_delimiter in varchar2 default ':')
    return char_table
    pipelined;

  function contains(
    p_string in varchar2,
    p_pattern in varchar2,
    p_delimiter in varchar2 default ',')
    return number;

  procedure merge(
    p_string in out nocopy varchar2,
    p_pattern in varchar2,
    p_delimiter in varchar2 default ',');

  function merge(
    p_string in varchar2,
    p_pattern in varchar2,
    p_delimiter in varchar2 default ',')
    return varchar2;

  ---------------------------------------------------------------------------------------------------------------
  --  Function:    clobAppend
  --
  --  Zweck:       Dient dem Zusammenstellen von CLOB-Texten aus einzelnen Textfragmenten
  --
  --  Parameter:   ip_op_text IN OUT - CLOB, an den die Ergaenzungen angefuegt werden sollen
  --               ip_chunk   IN - Anfuegung, CLOB
  ---------------------------------------------------------------------------------------------------------------
  PROCEDURE clob_append(ip_op_text IN OUT NOCOPY CLOB,
                        ip_chunk   IN     CLOB);
  ---------------------------------------------------------------------------------------------------------------
  

  ---------------------------------------------------------------------------------------------------------------
  --  Function:    clobReplace
  --
  --  Zweck:       Dient dem Zusammenstellen von CLOB-Texten aus einzelnen Textfragmenten
  --
  --  Parameter:   ip_op_text IN OUT - CLOB, in den die Ersetzung eingefuegt werden soll
  --               ip_what    IN - Ersetzung, VARCHAR2
  --               ip_with    IN - Anfuegung, CLOB
  ---------------------------------------------------------------------------------------------------------------
  FUNCTION clob_replace(ip_text    IN VARCHAR2, 
                        ip_what    IN VARCHAR2, 
                        ip_with    IN CLOB := null)
                        RETURN CLOB;
  ---------------------------------------------------------------------------------------------------------------
end utl_text;
/

