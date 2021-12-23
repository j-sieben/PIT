create or replace package mail_ntlm
  authid definer
as
  /** 
    Package: Output Modules.PIT_MAIL.MAIL_NTLM
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
    Procedure: authenticate
      Method to authenticate with a NTLM smtp server like Exchange  with the credentials provided
      and return the connection via <P_CONN>.
      
    Parameters:
      p_conn - Parameter for the actual smtp-connection
      p_host - Name of the ntlm-server, including domain
      p_user_name - Name of the user to authenticate
      p_password - Authentication users password
   */
  procedure authenticate(
    p_conn in out nocopy utl_smtp.connection,
    p_host in varchar2,
    p_user_name in varchar2,
    p_password in varchar2);

end mail_ntlm;
/

