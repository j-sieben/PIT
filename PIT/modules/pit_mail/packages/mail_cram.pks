create or replace package mail_cram
  authid definer
as
  /** Package to allow to authenticate to a CRAM SMTP server
      Disclaimer
        Based on a blog by Sean Stuber:
        http://www.experts-exchange.com/Database/Oracle/A_5915-Extending-Oracle%27s-Email-functionality-with-PL-SQL-Authentication.html
  */

  /* Public constant declarations */
  c_hash_md5 constant varchar2(20) := 'CRAM-MD5';
  c_hash_sha1 constant varchar2(20) := 'CRAM-SHA1';


  /** Method to authenticate with a CRAM SMTP server like Exchange
   * %param  p_conn         Parameter for the actual SMTP-connection
   * %param  p_hash_method  One of the package constants to identify the authentication method
   * %param  p_user_name    Name of the user to authenticate
   * %param  p_password     Authentication users password
   * %usage  Procedure will authenticate p_conn with the credentials provided and return the connection
   */
  procedure authenticate(
    p_conn in out nocopy utl_SMTP.connection,
    p_hash_method in varchar2,
    p_user_name in varchar2,
    p_password in varchar2);

end mail_cram;
/

