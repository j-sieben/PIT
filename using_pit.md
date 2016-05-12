# How to use PIT
After having installed PIT, it's ready to be used within your code. To start with, you may want to add a call to `pit.enter(p_action, p_module)` at the beginning and to `pit.leave` at the end of a method you want to trace. Doing so enables PIT to collect data about your call hierarchy, the time spent and optionally the parameters passed into the method. If you want to complete instrument your code, you may want to add the respective calls to a method template of your favourite IDE.

To use PIT for handling your errors, you start with creating a new error message. The easiest way to achieve this is to call `pit_admin.merge_message` and `pit_admin.translate_message` for any translation of the message you require. As a first example, let's create a message to handle Oracle error `-2292, Child record found`. This error has no predefined exception, so we will create this along with the message creation. After having created your messages, you call procedure `pit_admin.create_message_package` to (re-)create the central message package `MSG`. Here's the code to create this message:

```begin
  pit_admin.merge_message(
    p_message_name => 'CHILD_RECORD_FOUND',
    p_message_text => 'A child record is existing.',
    p_severity => pit.level_error, -- or 30
    p_message_language => 'AMERICAN',
    p_error_number => -2292);
  
  pit.translate_message(
    p_message_name => 'CHILD_RECORD_FOUND',
    p_message_text => 'Ein Kinddatensatz wurde gefunden.',
    p_message_language => 'GERMAN');
  
  pit_admin.create_message_package;
end;```

If you review package `MSG` you will immediately see the created message as a constant with the same name as the message. This is to assure that you can't mistype the message name and loose any error because of that. Additionally, the `MSG`package contains an exception called `CHILD_RECOR_FOUND_ERR`and a pragma to connect the exception to Oracle error -2292. If you want to create messages for your own errors, your do exactly the same what we did in the example above but simply pass in -20000 or null for parameter `p_error_number`. You may as well simply leave it away completly, as it is an optional parameter. If `pit_admin` creates a new message of severity 20 or 30 (`PIT.level_fatal|PIT.level_error`) and no error number is passed in, it assumes a user specific error.

No, as you created this message, you'r ready to use it in your code. As error -2292 is thrown automatically 
