# How to use `PIT`
After having installed `PIT`, it's ready to be used within your code. 

## Trace method calls
To start with, you may want to add a call to `pit.enter` at the beginning and to `pit.leave` at the end of a method you want to trace. Doing so enables `PIT` to collect data about your call hierarchy, the time spent and optionally the parameters passed into the method. If you want to completely instrument your code, you may want to add the respective calls to a method template of your favourite IDE.

When entering a method, you may optionally set the method name as parameter `p_action` and, seldomly necessary, the package name via parameter `p_module`. This is  unnessessary in most of the cases because `PIT` makes use of the `UTL_CALL_STACK` possibilities starting with Oracle version 12. There are two exceptions of this rule:

- You are still using version 11 of the database
- You set your plsql optimization level to 2 or higher and code inlining took place.

The second point requires some explanation. When inlining code, the compiler effectively removes a helper method and puts its code at the point where the helper method was called. For `UTL_CALL_STACK`, the helper method does not exist anymore. Therefore it is impossible to get the original name of the helper method for logging anymore. In this case, it is advisable to pass the helper method name with the `ENTER` method to inform the call stack about that original name.

Please make sure that before leaving a method a call to `pit.leave` is included. This is especially important for exception handlers (if you don't use `pit.handle_exception`, as described later), before `exit` and `return` clauses and after `case`- or `if` switches.

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
  pit.enter('my_func', 
    p_params => msg_params(
                  msg_param('p_id', to_char(p_id)),
                  msg_param('p_date', to_char(p_date, 'yyyy-mm-dd')),
                  msg_param('p_string', p_string)));
    ...
  pit.leave;
end my_func;
```

Instances of `MSG_PARAMS` may be passed ot `pit.leave` as well. This comes in handy if a method calculates values and you want to log the results. As it is also important to log the outcome of parameters in case of an exception, you may pass instances of `MSG_PARAMS` to the error handlers `pit.handle_exception` and `pit.stop` as well.

### Extended use of parameters

You may also work with parameters independently from the `pit.enter` and `pit.leave` methods. You may pass parameter values at any time during method execution using the `pit.log_state` method. This method expects only one parameter of type `MSG_PARAMS` and allows to debug the state of any variable during processing of code without the requirement to create a message for it. This is more flexible than the normal message approach in that it allows to extend the list of parameters easily. Thanks Sebastian Köll for pointing me to this functionality. A sample code using this functionality may look like this:

```
begin
  pit.set_context('DEBUG');
  pit.enter;
  pit.log_state(
    msg_params(
      msg_param('Param 1', 'Hello world'),
      msg_param('Param 2', 'How are you?')));
  pit.leave;
  pit.reset_context;
end;
/

Context set to 70|50|Y|PIT_CONSOLE.
> .__ANONYMOUS_BLOCK
-> State
...Param 1: Hello world
...Param 2: How are you?
<- State
< .__ANONYMOUS_BLOCK [wc=02.11.20 12:50:01,090000; e=0; e_cpu=0; t=+00 00:00:00.000000; t_cpu=0]

```

To allow for this functionality, the output modules must support this by implementing an overloaded `LOG` method with the `MSG_PARAMS` parameter.

### Adjusting trace level
Method `pit.enter` provides different levels of tracing. These levels are:
- `pit.trace_off` (10),
- `pit.trace_mandatory` (20),
- `pit.trace_optional` (30),
- `pit.trace_detailed` (40)
- `pit.trace_all` (50)

To make their use convenient, `PIT` offers dedicated `enter`- and `leave` methods for the respective trace levels, such as `pit.enter_optional` and `pit.leave_optional`. Please make sure that you select a matching `leave` method for the `enter` method you chose. This makes sure that the call stack does not get out of sync, which may happen if a method is pushed on the call stack but never popped because of the actual trace settings.

If you choose `pit.enter_mandatory`, this method also sets `dbms_application_info` which in turn is shown in some performance views. Therefore, `pit.enter_mandatory` also offers an optional parameter called `p_client_info` to pass in additional information that also shows up in performance views. Settings for `dbms_application_info` will be set in any case, no matter whether you actually trace your code or not.

Choosing an appropriate enter method is a good practice to allow you to set your trace level easily with a context. As a best practice, you may mark your public methods `pit.enter_mandatory` (with the exception of helper packages probably) and the more important private methods within a package `pit.enter_optional`. You then have another two levels at hand to adjust when a method gets traced.

## Handling log messages and debugging with `PIT`

PIT provides several methods to log messages. These methods are there to support the differnt log levels as you saw at the trace sections earlier already. The log levels `PIT` supports are:

- `pit.level_off` (10)
- `pit.level_fatal` (20)
- `pit.level_error` (30)
- `pit.level_warn` (40)
- `pit.level_info` (50)
- `pit.level_debug` (60)
- `pit.level_all` (70)

According to the trace methods, `PIT` provides respective log methods, fi `pit.error`. Keep in mind that, despite the trace methods which need to distinguish between entering and leaving methods, this is not required when logging. Therefore, the log level is sufficient as the method name.

As with the trace methods, log methods accept parameters. Here's a list of parameters available for logging:
- `p_message_name`: Name of the message that should be logged
- `p_msg_args`: Optional list of arguments that is passed into the message to replace anchors within the message text
- `p_affected_id`: Optional ID that is used in specific environments to indicate to which instance a message belongs. You normally don't need this parameter.
- `p_error_code`: Optional error code in case you're instrumenting legacy code that works with error codes. This parameter allows you to pass those codes with the exception.

To be able to use the log functionality, you must create a message first. This can be done easily with the `pit_admin` package that offers a suite of administrative methods to maintain `PIT`. Here you see how a simple informal message is being created:

```
begin
  pit_admin.merge_message_group(
    p_pmg_name => 'MY_GROUP',
    p_pmg_description => 'Message of my project');
    
  pit_admin.merge_message(
    p_pms_name => 'MY_FIRST_MESSAGE',
    p_pms_pmg_name => 'MY_GROUP',
    p_pms_text => 'This is my first PIT message. Hello World!',
    p_pms_description => 'Example message, here you can also find explanations for errors, etc.',
    p_pms_pse_id => pit.level_info, -- or 50
    p_pms_pml_name => 'AMERICAN');
  
  pit_admin.translate_message(
    p_pms_name => 'MY_FIRST_MESSAGE',
    p_pms_text => 'Das ist meine erste PIT-Nachricht. Hallo Welt!',
    p_pms_pml_name => 'GERMAN',
    p_pms_description => 'Beispielnachricht, hier können auch Erläuterungen für Fehler stehen etc.');
  
  pit_admin.create_message_package;
end;
```

It begins by creating (or reusing) a message group. Message groups make it easy to collect and export messages as a script file, but they are purely declarative and don't allow you to use the same message name in another group. Would I have done this, the group name would have to become part of the message name (or provided as a second parameter, blowing up the API.

You then create one or many messages within that group by calling `pit_admin.merge_message`. Make sure to provide this message in the default language you chose when installing `PIT`. A translation can be provided in any Oracle target language by calling `pit_admin.translate_message`, as shown above.

At the end of the script, method `pit_admin.create_message_package` is called to have `pit_admin` (re)-create package `MSG`. It rebuilds the package based on the messages found in table `PIT_MESSAGE` where the `pit_admin` writes its messages to. It therefore can be called as often as you like and will always resemble the latest status of your messages. Keep in mind that it doesn't contain the messages itself. So if you just correct a typo there's no need to recreate the message package. This package contains a constant of type `varchar2(30)` (`varchar2(128)` starting with 12c) with the same name as the message and the value of the message name:

``` 
create or replace package MSG
as
  MY_FIRST_MESSAGE constant varchar2(128) := 'MY_FIRST_MESSAGE';
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

Message can contain up to 20 replacement anchors using the syntax `#n#`. These anchors will be replace by the values you pass in via the `p_msg_args` parameter. The order of the parameters decides on the anchor that gets replace, so the third parameter will replace anchor `#3#`. As with other code in SQL, lists are 1-based. See section »Handling message parameters« further down the line.

If you prefer to use a GUI to create messages, you can install the administration application and create the message and the message group there. When exporting from this application, a script file similar to the one shown above will be created automatically.

## Handling exceptions with `PIT`

To use `PIT` to handle your errors, you start by creating a new error message. The easiest way to achieve this is to call `pit_admin.merge_message` and `pit_admin.translate_message` for any message and translation you require. As a first example, let's create a message to handle Oracle error `-2292, Child record found`. This error has no predefined exception, so we will create this along with the message creation. After having created your messages, you call procedure `pit_admin.create_message_package` to (re-)create the central message package `MSG`. Here's the code to create this message:

```
begin
  pit_admin.merge_message(
    p_pms_name => 'CHILD_RECORD_FOUND',
    p_pms_pmg_name => 'MY_GROUP',
    p_pms_text => 'A child record is existing.',
    p_pms_description => 'The data cannot be deleted as long as dependent data still exists. First delete the dependent data.',
    p_pms_pse_id => pit.level_error, -- or 30
    p_pms_pml_name => 'AMERICAN',
    p_error_number => -2292);
  
  pit.translate_message(
    p_pms_name => 'CHILD_RECORD_FOUND',
    p_pms_text => 'Ein abhängiger Datensatz wurde gefunden.',
    p_pms_description => 'Die Daten können nicht gelöscht werden, solange noch abhängige Daten existieren. Löschen Sie zunächst die abhängigen Daten.',
    p_pms_pml_name => 'GERMAN');
  
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

This is to assure that you can't loose any error because you mistyped the message name. Additionally, the `MSG` package contains an exception called `CHILD_RECOR_FOUND_ERR`and a pragma to connect the exception to Oracle error -2292. If you want to create messages for your own errors, you do exactly the same what we did in the example above but simply pass in -20000 or null for parameter `p_error_number`. You may as well simply omit it completely, as it is an optional parameter. If `pit_admin` creates a new message of severity 20 or 30 (`PIT.level_fatal|PIT.level_error`) and no error number is passed in, it assumes a user specific error.

In case you dislike the postfix `_ERR` to name an exception, you may choose a different setting by selecting a respective parameter value for it. This way, you could decide to use `X` as a prefix for example, resulting in `X_CHILD_RECORD_FOUND` as the name of the exception.

After you created the message you're ready to use it in your code. As error -2292 is thrown automatically by the Oracle database, you will need to catch it in the exception block. To achieve this, simply write code like this:

```
begin
  pit.enter('my_proc', c_pkg);
    delete from dept
     where deptno = 30;
  pit.leave;
exception
  when msg.CHILD_RECORD_FOUND_ERR then
    pit.handle_exception(msg.CHILD_RECORD_FOUND);
end;
```

Method `pit.handle_exception` is used to achieve two goals:

- It will log the error to all output modules actually parameterized
- It will cleanly close the call stack, as it includes a call to `pit.leave`.

If you defined a message for your own exception, simply raise the error by calling `pit.error(msg.CHILD_RECORD_FOUND_ERR);`. In your exception handler, you catch this exception as you would do with any other exception in `PIT`. Further details on throwing and catching exceptions can be found [here](https://github.com/j-sieben/PIT/blob/master/Doc/exceptions.md).

## Logging independently of log settings

If you require `PIT` to log any information regardless of any log settings, this is possible by calling method `pit.log`. To enhance its usability, this method accepts some additional parameters.

First, the message severity is taken from the message you pass in. So if you want to log a message with severity `pit.LEVEL_ERROR`, this then defines the severity of the logging. You can limit this by using a parameter call `P_LOG_THRESHOLD`. If set, only messages are logged with a severity lower or equal this value.

You then can decide upon the output modules to be used for this log process. Without changing any log settings, you may want to log a specific message to one output module only. This is possible by passing in the list of requested output modules as a colon-separated list into parameter `P_MODULE_LIST`. As said, this does not effect any log settings but will be set for this single log process.

Imagine an application like a flow control system that needs to log status messages to a dedicated output module called `PIT_FLOW_CONTROL`. By calling `pit.log` with parameter `p_module_list => 'PIT_FLOW_CONTROL` only this output module will receive the status change message, regardless of whether logging is switch on or off. 

## Handling message parameters

Messages require parameters. To pass parameters to a message, an object of type `MSG_ARGS` is provided. This is a `varray(20) of clob`. I chose a `varray of clob` because the parameters have to keep their defined order to make sure that the right parameter is put at the right position within the message. CLOB on the other hand makes it possible to create message of any size. To prepare a message for replacements of parameters, you add anchors of the form `#n#` to the message, with `n` being an integer between 1 and 20. Here's an example of a message with replacement anchors and the code to call it:

```
-- Message: "Couldn't delete #1# with id #2#.", name: msg.DELETE_ITEM, severity: pit.error

pit.handle_exception(msg.DELETE_ITEM, msg_args('row', to_char(id)));

-- Resulting Message: "Couldn't delete row with id 12345."
```

As `MSG_ARGS` is a `varray of clob`, it is possible to pass in parameters of any size. Your output modules should decide how to handle large messages. The next paragraph will show you what these large message may be used for.

## Power messages with ICU

As an extension, you can even use ICU messages to power up your possibilities. What ICU is and what it offers as a benefit is explained [here](Doc/icu_messages.md).

## Printing messages to the view layer

If your output module implements a `print`-method, you can use this method to pass a message with parameters to the view layer. Here it turns out to be a wise decision that all messages are `clob` based. This allows for messages of arbitrary size. In some projects, I even use messages to pass JSON strings of any size to APEX-applications. This fits in nicely because the print method implementation in the APEX output module caters for splitting this messages into appropriate chunks.

Main use obviously is to pass validation messages, status messages and the like to the view layer. To achieve this, you normally create a message of severity `pit.level_verbose`. This way, only a constant for the message is created in the MSG package and no error numbers are occupied. To use it, you simply call `pit.print(msg.MY_MESSAGE)` and you're done. Of course you can also add parameters to this message call.

## Using `PIT` to assert conditions

If you code using the *Contractor Pattern*, you want to assert that incoming parameters meet certain conditions. Should an assertion fail, an exception is thrown and an error message needs to be generated. To help you on this, `PIT` provides a basic set of assertion methods. Here are the methods `PIT` provides so far:

- `pit.assert_is_null`
- `pit.assert_not_null`
- `pit.assert`
- `pit.assert_exists`
- `pit.assert_not_exists`
- `pit.assert_datatype`

Most methods are provided with overloads for `varchar2`, `number` and `date`, the exists methods take a sql statement as parameter and check whether that statement returns at least one or no row. Only `select` statements are allowed here of course ... `PIT` offers an overloaded method for the `pi.assert_(not_)exists` method that either accept a sql statement as `varchar2`or an openend cursor. The most generic function is `pit.assert` which expects a boolean expression of any kind and returns without result if the condition evaluates to true and throws an exception otherwise.

I added paramter `p_affected_id` to the assertion methods as I did before in the log methods. Reason is that many validations require a reference to an input field or similar. E.g. in APEX you have the possibility to attach an error message to a specific input field. I found it cumbersome to validate input, create a message for it and then have to deal with proper placement of that message on the screen. By adding `p_affected_id` it's now possible to simply pass in the id of the element you're working at and you're done, the rest is done within output module `pit_apex`.

Plus, you have the ability to pass in any custom error codes you like. If the assertion fails, those custom error codes are integrated into the message instance for later reference. Error codes can refine a constant error. Imagine a set of validations that validates whether a required input exists. Normally, all these validations will throw the same error if the validation fails. With error codes, you can refine which parameter value failed without having to create new messages for each validation.

What makes all assertion methods convenient is that they come with a default message so you can call the assertion methods with no parameter except for the test. If you need to, you may pass in your own message that gets thrown if the assertion fails. Simply pass in the message name and the message parameters optionally. Here's an example on how to check an assertion with a user defined message:

```
begin
  pit.assert(
    p_condition => p_param in (10,20,30),
    p_message_name => msg.PARAM_OUT_OF_RANGE, 
    p_msg_args => msg_args('P_PARAM', '10,20,30', to_char(p_param))
  );
  ...
end;
```

If the assertion throws an error, this may lead to a message like »Parameter 'P_PARAM' is supposed to be in the range of [10,20,30] but was 45.«
