create or replace package pit_notification_util
  authid current_user
as
  /**
    Package: PIT_NOTIFICATION_UTIL
      Implements functionality to pass a message to a websocket server.

    Author::
      Juergen Sieben, ConDeS GmbH

      Published under MIT licence
   */
  

  /**
    Group: Public Methods
   */
  /**
    Procedure: notify
      Method creates a message to be passed to the websocket server.
      
    Parameters:
      p_message - Message to send
   */
  procedure notify(
    p_message in message_type);

end pit_notification_util;
/