# How to use PIT
After having installed PIT, it's ready to be used within your code. 

## Trace method calls
To start with, you may want to add a call to `pit.enter(p_action, p_module)` at the beginning and to `pit.leave` at the end of a method you want to trace. Doing so enables PIT to collect data about your call hierarchy, the time spent and optionally the parameters passed into the method. If you want to completely instrument your code, you may want to add the respective calls to a method template of your favourite IDE.

As a best practice, provide `pit.enter` with the name of your method and your package. This way, PIT is able to achieve the highest performance because if you don't pass this information in, PIT will try to gather this information from environment or call stack information, based on the database version you're using. This in any case is slower than providing the information yourself. One recommendation to pass the package name in is to create a global package constant `C_PKG constant varchar2(30 byte) := $$PLSQLUNIT;`. After having defined this constant once, you can easily pass it in without having to rewrite the package name over and over again.

Please make sure, that before leaving a method a call to `pit.leave` is included. This is especially important for exception handlers (if you don't use `pit.sql_exception`, as described later), before `exit` and `return` clauses and after `case`- or `if` switches.

### Passing parameters to trace-methods

If you want to include parameters passed to a method in your tracing, this can be achieved by passing them in as an instance of `MSG_PARAMS`. This type is a nested table of `MSG_PARAM` objects, which in turn are simple key value objects. A key name may be as long as 30 byte and the param value up to 4000 byte of varchar2. You create an instance of `MSG_PARAM`by calling its constructor function:

```
msg_param('key', 'value');
```

Instances of `MSG_PARAM` are passed to the constructor function for `MSG_PARAMS` to create a collection of `MSG_PARAM`-objects. This way, you can pass in any number of parameters which then can be stored for further reference by your output modules. Be sure to convert any parameter name and -value to `varchar2` before passing them to the constructor method. Here's an example of a call to `pit.enter` with parmeters:

```
function my_func(
  p_id in number,
  p_date in date,
  p_string in varchar2)
  return varchar2
as
begin
  pit.enter('my_func', c_pkg, msg_params(
    msg_param('p_id', to_char(p_id)),
    msg_param('p_date', to_char(p_date, 'yyyy-mm-dd')),
    msg_param('p_string', p_string)));
    ...
  pit.leave;
end my_func;
```

### Adjusting trace level
Method `pit.enter` provides different levels of tracing. These levels are:
- `pit.trace_off` (10),
- `pit.trace_mandatory` (20),
- `pit.trace_optional` (30),
- `pit.trace_detailed` (40)
- `pit.trace_all` (50)

To make their use convenient, PIT offers dedicated `enter`- and `leave` methods for the respective trace levels, such as `pit.enter_optional` and `pit.leave_optional`. Please make sure that you select a matching `leave` method for the `enter` method you chose. This makes sure that the call stack does not get out of sync, which may happen if a method is pushed on the call stack but never popped.

If you choose `pit.enter_mandatory`, parameters `p_action` and `p_module` are mandatory as well. Reason is that this method also sets `dbms_application_info` which in turn shows in some performance views. Therefore, `pit.enter_mandatory` also offers an optional parameter called `p_client_info` to pass in additional information that also shows up in performance views. Settings for `dbms_application_info` will be set in any case, no matter whether you actually trace your code or not.

Choosing an appropriate enter method is a good practice to allow you to set your trace level easily with a context. As a best practice, you may mark your public methods `pit.enter_mandatory` (with the exception of helper packages probably) and the more important private methods within a package `pit.enter_optional`. You then have another two levels at hand to adjust when a method gets traced.

## Handling exceptions with PIT

To use PIT to handle your errors, you start by creating a new error message. The easiest way to achieve this is to call `pit_admin.merge_message` and `pit_admin.translate_message` for any message and translation you require. As a first example, let's create a message to handle Oracle error `-2292, Child record found`. This error has no predefined exception, so we will create this along with the message creation. After having created your messages, you call procedure `pit_admin.create_message_package` to (re-)create the central message package `MSG`. Here's the code to create this message:

```
begin
  pit_admin.merge_message(
    p_message_name => 'CHILD_RECORD_FOUND',
    p_message_text => 'A child record is existing.',
    p_severity => pit.level_error, -- or 30
    p_message_language => 'AMERICAN',
    p_error_number => -2292);
  
  pit.translate_message(
    p_message_name => 'CHILD_RECORD_FOUND',
    p_message_text => 'Ein abhängiger Datensatz wurde gefunden.',
    p_message_language => 'GERMAN');
  
  pit_admin.create_message_package;
end;
```

If you review package `MSG` you will immediately see the created message in that package as a constant with the same name as the message:

``` 
create or replace package MSG
as
  CHILD_RECORD_FOUND constant varchar2(30) := 'CHILD_RECORD_FOUND';
  child_record_found_err exception;
  pragma exception_init(child_record_found_err, -2292);
  ...
end MSG;
```

This is to assure that you can't loose any error because you mistyped the message name. Additionally, the `MSG`package contains an exception called `CHILD_RECOR_FOUND_ERR`and a pragma to connect the exception to Oracle error -2292. If you want to create messages for your own errors, you do exactly the same what we did in the example above but simply pass in -20000 or null for parameter `p_error_number`. You may as well simply leave it away completely, as it is an optional parameter. If `pit_admin` creates a new message of severity 20 or 30 (`PIT.level_fatal|PIT.level_error`) and no error number is passed in, it assumes a user specific error.

After you created the message you're ready to use it in your code. As error -2292 is thrown automatically by the Oracle database, you will need to catch it in the exception block. To achieve this, simply write code like this:

```
begin
  pit.enter('my_proc', c_pkg);
    delete from dept
     where deptno = 30;
  pit.leave;
exception
  when msg.CHILD_RECORD_FOUND_ERR then
    pit.sql_exception(msg.CHILD_RECORD_FOUND);
end;
```

Method `pit.sql_exception` is used to achieve two goals:
1.  It will log the error to all output modules actually parameterized
2.  It will cleanly close the call stack, as it includes a call to leave.

If you defined a message for your own exception, simply raise the error by calling `pit.error(msg.CHILD_RECORD_FOUND_ERR);`. In your exception handler, you catch this exception as you would do with any other exception in PIT.

## Handling message parameters

Messages require parameters. To pass parameters to a message, an object of type `MSG_ARGS` is provided. This is a `varray(20) of clob`. I chose a clob varray because the parameters have to keep their defined order to make sure that the right parameter is replaced at the right position within the message. To prepare a message for replacements of parameters, you add anchors of the form `#n#` to the message, with `n` being an integer between 1 and 20. Here's an example of a message with replacement anchors and the code to call it:

```
-- Message: "Couldn't delete #1# with id #2#.", name: msg.DELETE_ITEM, severity: pit.error

pit.sql_exception(msg.DELETE_ITEM, msg_args('row', to_char(id)));

-- Resulting Message: "Couldn't delete row with id 12345."
```

As `MSG_ARGS` is a varray of clob, it is possible to pass in parameters of any size. Your output modules should decide how to handle large messages. The next paragraph will show you what these large message may be used for.

## Printing messages to the view layer
If your output module implements a `print`-method, you can use this method to pass a message with parameters to the view layer. Here it turns out to be a wise decision that all messages are CLOB based. This allows for messages of arbitrary size. In some projects, I even use messages to pass JSON strings of any size to APEX-applications. This fits in nicely because the print method is capable of handling clob messages and the print method implementation in the APEX output module therefore already caters for splitting this messages into appropriate chunks.

Main use obviously is to pass validation messages, status messages and the like to the view layer. To achieve this, you normally create a message of severity `pit.level_verbose`. This way, only a constant for the message is created in the MSG package. To use it, you simply call `pit.print(msg.MY_MESSAGE)` and you're done.

## Using PIT to assert conditions

If you code using the "contractor pattern", you want to assert that incoming parameters meet certain conditions. Should an assertion fail, an exception is thrown and an error message needs to be generated. To help you on this, PIT provides a basic set of assertion methods. Here are the methods PIT provides so far:

- `pit.assert_is_null`
- `pit.assert_not_null`
- `pit.assert`
- `pit.assert_exists`
- `pit.assert_not_exists`

Most methods are provided with overloads for varchar2, number and date, the exists methods take a sql statement as parameter and check whether that statement returns at least one or no row. Only select statements are allowed of course ... The most generic function is `pit.assert` which expects a boolean expression of any kind and returns without result if the condition evaluates to true and throws an exception otherwise.

What makes all assertion methods convenient is that they come with a default message (which of course can be translated as any other message PIT uses). Should you require to do so, you may pass in your own message that gets thrown if the assertion fails. Simply pass in the message name and the message parameters optionally.

