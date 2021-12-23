create or replace package mail_cram
  authid definer
as
  /** 
    Package: Output Modules.PIT_MAIL.MAIL_CRAM
      Package to allow to authenticate to a CRAM SMTP server
      
    Disclaimer::
      Based on a <blog: http://www.experts-exchange.com/Database/Oracle/A_5915-Extending-Oracle%27s-Email-functionality-with-PL-SQL-Authentication.html> by Sean Stuber.        
   
    Author::
      Juergen Sieben, ConDeS GmbH
  */

  /**
    Group: Public Constants
   */
  /**
    Constants: Crypto-related constants
      C_HASH_MD5 - MD5 has algorythm
      C_HASH_SHA1 - SHA1 has algorythm
   */
  C_HASH_MD5 constant varchar2(20) := 'CRAM-MD5';
  C_HASH_SHA1 constant varchar2(20) := 'CRAM-SHA1';


  /**
    Group: Public Methods
   */
  /** 
    Procedure: authenticate
      Method to authenticate with a CRAM SMTP server like Exchange with the credentials provided and return the connection.
      
      Connection is passed back via <P_CONN> parameter.
      
    Parameters:
      p_conn - Parameter for the actual SMTP-connection
      p_hash_method - One of the <C_HASH_MD5>|<C_HASH_SHA1> to identify the authentication method
      p_user_name - Name of the user to authenticate
      p_password - Authentication users password
   */
  procedure authenticate(
    p_conn in out nocopy utl_SMTP.connection,
    p_hash_method in varchar2,
    p_user_name in varchar2,
    p_password in varchar2);

end mail_cram;
/

