# How to use PIT
After having installed PIT, it's ready to be used within your code. 

## Trace method calls
To start with, you may want to add a call to `pit.enter(p_action, p_module)` at the beginning and to `pit.leave` at the end of a method you want to trace. Doing so enables PIT to collect data about your call hierarchy, the time spent and optionally the parameters passed into the method. If you want to completely instrument your code, you may want to add the respective calls to a method template of your favourite IDE.

As a best practice, provide `pit.enter` with the name of your method and your package. This way, PIT is able to achieve the highest performance because if you don't pass this information in, PIT will try to gather this information from environment or call stack information, based on the database version you're using. This in any case is slower than providing the information yourself. One recommendation to pass the package name in is to create a global package constant `C_PKG constant varchar2(30/128 byte) := $$PLSQL_UNIT;`. After having defined this constant once, you can easily pass it in without having to rewrite the package name over and over again.

Please make sure, that before leaving a method a call to `pit.leave` is included. This is especially important for exception handlers (if you don't use `pit.sql_exception`, as described later), before `exit` and `return` clauses and after `case`- or `if` switches. As there is no easy and secure way to maintain the call stack of methods in PL/SQL (other than frequently calling `UTL_CALL_STACK` starting with Oracle 12c, that is), PIT maintains the call hierarchy manually by storing `enter` and `leave` calls on an internal stack. If you don't provide a proper call to `leave`, the hierarchy of the calls gets out of sync. Calling `pit.initialize` or `pit.stop` will empty the call stack to adjust those snychronitaion issues.

Starting with version 12c, PIT has extended its possibility of handling the call stack by utilizing `UTL_CALL_STACK`under the covers. This makes call stack maintenance more stable and reliable and allows for even less code in the application. Imagine a method `A` that calls method `B` which in turn calls method `C`. In `C`, an error is raised, but it is catched at method `A`. Normally, there would be no way to clear the call stack if not any of the methods `A`, `B` and `C` would offer an exception handler. Methods `C` and `B` would then implement a dummy handler such as 

```
...
exception
  when others then
    pit.leave;
    raise;
end;
```

which is rather ugly. Starting with 12c, this is not necessary anymore. Simply throw the error and catch it where you require it and PIT will clean the call stack up to the actual method that caught the exception.

### Passing parameters to trace-methods

If you want to include parameters passed to a method in your tracing, this can be achieved by providing the methods with an instance of `MSG_PARAMS`. This type is a nested table of `MSG_PARAM` objects, which in turn is a simple key value object. A key name may be as long as `30 byte` (`128 byte` starting with Oracle 12c) and the param value up to `4000 byte` of `varchar2`. You create an instance of `MSG_PARAM`by calling its constructor function:

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

Instances of `MSG_PARAMS` may be passed ot `pit.leave` as well. This comes in handy if a method calculates values and you want to log the results. As it is also important to log the outcome of parameters in case of an exception, you may pass instances of `MSG_PARAMS` to the error handlers `pit.sql_exception` and `pit.stop` as well.

### Adjusting trace level
Method `pit.enter` provides different levels of tracing. These levels are:
- `pit.trace_off` (10),
- `pit.trace_mandatory` (20),
- `pit.trace_optional` (30),
- `pit.trace_detailed` (40)
- `pit.trace_all` (50)

To make their use convenient, PIT offers dedicated `enter`- and `leave` methods for the respective trace levels, such as `pit.enter_optional` and `pit.leave_optional`. Please make sure that you select a matching `leave` method for the `enter` method you chose. This makes sure that the call stack does not get out of sync, which may happen if a method is pushed on the call stack but never popped because of the actual trace settings.

If you choose `pit.enter_mandatory`, this method also sets `dbms_application_info` which in turn is shown in some performance views. Therefore, `pit.enter_mandatory` also offers an optional parameter called `p_client_info` to pass in additional information that also shows up in performance views. Settings for `dbms_application_info` will be set in any case, no matter whether you actually trace your code or not.

Choosing an appropriate enter method is a good practice to allow you to set your trace level easily with a context. As a best practice, you may mark your public methods `pit.enter_mandatory` (with the exception of helper packages probably) and the more important private methods within a package `pit.enter_optional`. You then have another two levels at hand to adjust when a method gets traced.

## Handling log messages and debugging with PIT

PIT provides several methods to log messages. These methods are there to support the differnt log levels as you saw at the trace sections earlier already. The log levels PIT supports are:

- `pit.level_off` (10)
- `pit.level_fatal` (20)
- `pit.level_error` (30)
- `pit.level_warn` (40)
- `pit.level_info` (50)
- `pit.level_debug` (60)
- `pit.level_all` (70)

According to the trace methods, PIT provides respective log methods, fi `pit.error`. Keep in mind that, despite the trace methods which need to distinguish between entering and leaving methods, this is not required when logging. Therefore, the log level is sufficient as the method name.

As with the trace methods, log methods accept parameters. Here's a list of parameters available for logging:
- `p_message_name`: Name of the message that should be logged
- `p_arg_list`: Optional list of arguments that is passed into the message to replace anchors within the message text
- `p_affected_id`: Optional ID that is used in specific environments to indicate to which instance a message belongs. You normally don't need this parameter.

To be able to use the log functionality, you must create a message first. This can be done easily with the `pit_admin` package that offers a suite of administrative methods to maintain PIT. Here you see how a simple informal message is being created:

```
begin
  pit_admin.merge_message(
    p_message_name => 'MY_FIRST_MESSAGE',
    p_message_text => 'This is my first PIT message. Hello World!',
    p_severity => pit.level_info, -- or 50
    p_message_language => 'AMERICAN');
  
  pit.translate_message(
    p_message_name => 'MY_FIRST_MESSAGE',
    p_message_text => 'Das ist meine erste PIT-Nachricht. Hallo Welt!',
    p_message_language => 'GERMAN');
  
  pit_admin.create_message_package;
end;
```

At the end of the script, method `pit_admin.create_message_package` is called to have `pit_admin` (re)-create package `MSG`. It rebuilds the package based on the messages found in table `MESSAGE` where the `pit_admin` writes its messages to. It therefore can be called as often as you like and will always resemble the latest status of your messages. Keep in mind that it doesn't contain the messages itself. So if you just correct a typo there's no need to recreate the message package. This package contains a constant of type `varchar2(30)` with the same name as the message and the value of the message name:

``` 
create or replace package MSG
as
  MY_FIRST_MESSAGE constant varchar2(30) := 'MY_FIRST_MESSAGE';
  ...
end msg;
```

So, immediately after creating package `MSG`, you're ready to use it in your code. Here's a code snippet that makes use of this newly created message:

```
begin
  pit.info(msg.MY_FIRST_MESSAGE);
end;
```

Depending on the settings of the context actually in use and the language settings that applies for your session, you may see the following output on the console:

```
alter session set nls_language=AMERICAN;
session altered

<code snippet>
This is my first PIT message. Hello World!

alter session set nls_language=GERMAN;
session altered

<code_snippet>
Das ist meine erste PIT-Nachricht. Hallo Welt!
```

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

This is to assure that you can't loose any error because you mistyped the message name. Additionally, the `MSG`package contains an exception called `CHILD_RECOR_FOUND_ERR`and a pragma to connect the exception to Oracle error -2292. If you want to create messages for your own errors, you do exactly the same what we did in the example above but simply pass in -20000 or null for parameter `p_error_number`. You may as well simply omit it completely, as it is an optional parameter. If `pit_admin` creates a new message of severity 20 or 30 (`PIT.level_fatal|PIT.level_error`) and no error number is passed in, it assumes a user specific error.

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

- It will log the error to all output modules actually parameterized
- It will cleanly close the call stack, as it includes a call to leave.

If you defined a message for your own exception, simply raise the error by calling `pit.error(msg.CHILD_RECORD_FOUND_ERR);`. In your exception handler, you catch this exception as you would do with any other exception in PIT. Further details on throwing and catching exceptions can be found [here](https://github.com/j-sieben/PIT/blob/master/Doc/exceptions.md).

## Logging independently of log settings

If you require PIT to log any information regardless of any log settings, this is possible by calling method `pit.log`. To enhance its usability, this method accepts some additional parameters.

First, the message severity is taken from the message you pass in. So if you want to log a message with severity `pit.LEVEL_ERROR`, this then defines the severity of the logging. You can limit this by using a parameter call `P_LOG_THRESHOLD`. If set, only messages are logged with a severity lower or equal this value.

You then can decide upon the output modules to use for this log process. Without changing any log settings, you may want to log a specific message to one output module only. This is possible by passing in the list of requested output modules as a colon-separated list into parameter `P_MODULE_LIST`. As said, this does not effect any log settings but will be set for this single log process.

Imagine an application like a flow control system that needs to log changed status messages to a dedicated output module called PIT_FLOW_CONTROL. By calling `pit.log` with parameter `p_module_list => 'PIT_FLOW_CONTROL` only this output module will receive the status change message. 

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

If you code using the *Contractor Pattern*, you want to assert that incoming parameters meet certain conditions. Should an assertion fail, an exception is thrown and an error message needs to be generated. To help you on this, PIT provides a basic set of assertion methods. Here are the methods PIT provides so far:

- `pit.assert_is_null`
- `pit.assert_not_null`
- `pit.assert`
- `pit.assert_exists`
- `pit.assert_not_exists`

Most methods are provided with overloads for `varchar2`, `number` and `date`, the exists methods take a sql statement as parameter and check whether that statement returns at least one or no row. Only `select` statements are allowed here of course ... The most generic function is `pit.assert` which expects a boolean expression of any kind and returns without result if the condition evaluates to true and throws an exception otherwise.

I added the paramter `p_affected_id` to the assertion methods as I did before in the log methods. Reason is that many validations require a reference to an input field or similar. E.g. in APEX you have the possibility to attach an error message to a specific input field. I found it cumbersome to validate input, create a message for it and then have to deal with proper placement of that message on the screen. By adding `p_affected_id` it's now possible to simply pass in the id of the element you're working at and you're done, the rest is done within output module `pit_apex`.

Plus, you have the ability to pass in any custom error codes you like. If the assertion fails, those custom error codes are integrated into the message instance for later reference.

What makes all assertion methods convenient is that they come with a default message (which of course can be translated as any other message PIT uses). Should you require to do so, you may pass in your own message that gets thrown if the assertion fails. Simply pass in the message name and the message parameters optionally. Here's an example on how to check an assertion with a user defined message:

```
begin
  pit.assert(
    p_condition => p_param in (10,20,30),
    p_message_name => msg.PARAM_OUT_OF_RANGE, 
    p_arg_list => msg_args('P_PARAM', '10,20,30', to_char(p_param))
  );
  ...
end;
```

If the assertion throws an error, this may lead to a message like »Parameter 'P_PARAM' is supposed to be in the range of [10,20,30] but was 45.«

Be creative when thinking about these methods. In a project it turned out to be very convenient to wrap these assertion methods into a method that didn't throw an exception but rather catched any upcoming error and integrated into an APEX error stack. This way, it is very convenient to test a set of conditions and all conditions that fail add to the error stack.
