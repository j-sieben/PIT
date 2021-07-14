# Throwing and catching exceptions with `PIT`

After having defined a message of severity `ERROR` or `FATAL`, package `MSG` has defined a respective message, an exception and an exception init for the given Oracle error number. If no Oracle error number has been provided, `PIT` automatically assigns a custom error number within the range `-20,999 .. -20,000`. Exception follow a naming convention that is parameterizable. As per default, any exception is derived from `<MESSAGE_NAME>_ERR`, but you're free to set your own pre- and postfix parameters (`PIT.ERROR_PREFIX`and `PIT.ERROR_POSTFIX`) to achieve something as `X_<MESSAGE_NAME>`. The overall length of the name extension (including underscores) is limited to 4 byte, though.

In regard to parameterization, also note that there is a parameter called `OMIT_PIT_IN_STACK` to control whether internal `PIT` method calls are included in the call and error stack (if set to FALSE) or not (which is the default).

Be aware that messages of severity `LEVEL_FATAL` and `LEVEL_ERROR` always get logged, regardless of any settings in the context. The only possibility to surpress the output of these messages is to reduce the log threshold of an output module. After all, this is not a recommended practice, as you require to be informed about errors in your code anyway.

Let's have a look at how we can work with these errors in `PIT`.

## Throwing errors

To throw an error, there are two options with specific advantages.

### Throwing errors using `raise`

With the `raise` command, it's very easy to throw an error: 

```
begin
  ... some work
  raise msg.MY_MESSAGE_ERR;
exception
 when msg.MY_MESSAGE_ERR then
   ... do something
end;
```

The advantage of this way of throwing errors is that it's very common for many programmers. After catching the error, you reference a message and pass any optional parameters in as you see fit. We'll look at catching and processing error later.

The disadvantage is that you don't have control over the message that will be logged. Imagine a situation where the same error may occur at several positions within your code. Based on where it is thrown, the parameteres to add to the message may vary. In these situations it may be helpful to be able to create the message right where the error occurs, including the parameters you have right then. This is why a second way to throw errors exists.

### Throwing errors using `pit.error` or `pit.fatal`

The idea is to create a message of severity error and have it throw the exception for you. Because we create a message rather than throwing an exception we now have the option to pass in any arguments we need. To achieve this, we pass in the message name and parameters as with any other message logging. As you recall, every message has got a matching exception, should it's severity demand for it. This is now used to throw the error based on the message you just created. Review the following code snippet:

```
begin
  ... some work
  pit.error(msg.MY_MESSAGE, mgs_args('row', to_char(id)));
exception
 when msg.MY_MESSAGE_ERR then
   ... do something
end;
```

The code to catch the exception is the same, although the way to process the error with `PIT` is different. Before we come to that, I'd like to stress that after throwing an exception with `pit.error` or `pit.fatal`, `SQLCODE` and `SQLERRM` are populated with the message you created when throwing the error. `SQLCODE` contains the Oracle error number or the custom error number assigned to the message. Therefore, to use this feature, make sure that the message has a severity of `level_error` or `level_fatal` to have `PIT` assign a custom error number to it. In general, `pit.error` and `pit.fatal` overwrite the message's severity with the respective method level to assure that a message of severity `level_error` will stop further execution of the code if it has been thrown by `pit.fatal`.

Note: If you use `pit.error`or `pit.fatal` and a message with a severity milder than `pit.LEVEL_ERROR`, it will be still thrown as an exception with the error code `-20.000`. It is not possible though to catch this error, as no exception was defined for it in package `MSG`.

## Catching exceptions with `PIT`

Let's see how to catch exceptions with `PIT` and the options we have here.

There are two specialized methods to handle exceptions within `PIT`: `pit.handle_exception` and `pit.stop` respectively `pit.reraise_exception`. `pit.reraise_exception` is a synonym for `pit.stop` and can be used interchangeably.

Note: In earlier releases there was a function called `pit.handle_exception`. This is now deprecated, but still available. Use `pit.handle_exception` instead. It was felt that this name is more consise and explains better what it does.

Method `pit.handle_exception` is intended to be used as the default exception handler. By catching the exception with this method, it gets passed to all output modules and after that the code will continue. If you want to stop the code you may add the command `raise` after catching the exception.

The parameters for this method are all optional. If used in conjunction with `raise`, passing a matching message for the exception caught may make most sense, as in the following example:

```
begin
  ... some work
  raise msg.MY_MESSAGE_ERR;
exception
 when msg.MY_MESSAGE_ERR then
   pit.handle_exception(msg.MY_MESSAGE, msg_args('row', to_char(id)));
end;
```

Method `pit.stop`, on the other hand, stops the execution of the code. The difference to `pit.handle_exception` with a following `raise;` is that `pit.stop` will throw a new exception after it has logged the original exception, overwriting the old call stack. This may come in handy if you don't want to expose all the internals to the log but rather wrap all exceptions in a newly created error.

### Passing predefined messages to `PIT`

If you threw the exception with `pit.error` or `pit.fatal`, the messages have been created already. Therefore you don't want the message to be overwritten by a new message in `pit.handle_exception` or `pit.stop` respectively. To achieve this, simply call the exception handlers without parameters.

If you review the next code sample, you will get the idea of how this works immediately:

```
begin
  ... some work
  pit.error(msg.MY_MESSAGE, mgs_args('row', to_char(id)));
exception
 when msg.MY_MESSAGE_ERR then
   pit.handle_exception;
   -- raise;
end;
```

The same works with `pit.stop`:

```
begin
  ... some work
  pit.error(msg.MY_MESSAGE, mgs_args('row', to_char(id)));
exception
 when msg.MY_MESSAGE_ERR then
   pit.stop;
end;
```

Recall that using `pit.stop` will create a new exception and throws this, hiding the original call stack.

Use this approach if you need to differ between many places the same error may occur, if the respecitive parameters have lost focus in the excpetion block or simply if you feel more comfortable with directly creating the error message where it occurs.

## Catching named Oracle errors

If you want to catch named Oracle errors such as `NO_DATA_FOUND` or `TOO_MANY_ROWS`, the way to catch them stays the same as without `PIT`. The only additional possibility you have is to process the exception with any custom defined message. Here's a code snippet that shows this usage:

```
begin
  ... some work
exception
 when NO_DATA_FOUND then
   pit.handle_exception(msg.MY_MESSAGE, mgs_args('row', to_char(id)));
end;
```

If a server error is catched with `pit.stop` without parameters, the original exception and message will be included into a newly created exception named `SQL_ERROR`. Please note that the error message will not contain the original error code, only the text. This is in line with the focus of the method to hide the internals. The next code snippet shows this in action:

```
declare
  l_result number;
begin
  pit.enter;
  l_result := 1/0;
  pit.leave;
exception
  when others then
    pit.stop;
end;

Error report -
ORA-20967: A SQL error occurred: divisor is equal to zero
ORA-06512: at line 9
``` 

## Passing parameters to exception handlers

It's also possible to pass output parameter values even in the case of exceptions. To achieve that, `pit.HANDLE_EXCEPTION` and `pit.STOP` provide an optional parameter called `P_PARAMS` that accepts an instance of `MSG_PARAMS` holding the name and value of any number of parameters. Those parameters are passed as attributes of the call stack methods (These methods include a call to `pit.leave`). This way, it's easy to get access to out parameters even in the case of an error.

## Passing Error Codes

Sometimes, it's useful to have the ability to maintain custom error codes with error messages. This functionality comes in handy if you need to maintain return codes that other application parts expose, such as a return code for a Web Service. You can achieve this by simply passing in another parameter called `P_ERROR_CODE`. This can be any information you like up to 30 char in width. Another use of this functionality is when running `PIT` in collection mode, as described [here](https://github.com/j-sieben/PIT/blob/master/Doc/collect_messages.md).

If you use this feature, this error code is passed as part of the message instance, so that any output module can access  this information and do  with it whatever it has to.

## Throwing errors with `pit.log` (formerly called `log_specific`)

Throwing errors with this method is possible, but not it's intended use. This method is used to overwrite log settings for a specific message. It's useful to make sure that certain messages always get logged. Do not use it for normal logging. 

## Overview of possibilities to throw and catch exceptions in `PIT`

Here is a brief overview of the different possibilities of throwing and catching exceptions with `PIT`. It is assumed that the respective messages were created upfront with a severity of 20 or 30 and a matching Oracle error number, if applicable. Catching exceptions with `pit.handle_exception` or `pit.stop` is identical syntaxwise. The only difference is that `pit.stop` will throw the error after logging it, whereas `pit.handle_exception` will not.

### Catching Oracle named exceptions

```
begin
  <do something that causes Oracle to throw a named exception>
exception
  when NO_DATA_FOUND then
    pit.handle_exception(msg.NO_ITEMS_IN_STOCK, msg_args(...));
end;
```

### Catching Oracle non-named exceptions

```
begin
  <do something that causes Oracle to throw an exception `PIT` has a message for>
exception
  when msg.CHILD_RECORD_FOUND_ERR then
    pit.handle_exception(msg.CHILD_RECORD_FOUND, msg_args(...));
end;
```

### Catching user defined exceptions, option 1

```
begin
  <do something>
  raise msg.PARAM_OUT_OF_RANGE_ERR
exception
  when msg.PARAM_OUT_OF_RANGE_ERR then
    pit.handle_exception(msg.PARAM_OUT_OF_RANGE, msg_args(...));
end;
```

### Catching user defined exceptions, option 2

```
begin
  <do something>
  pit.error(msg.PARAM_OUT_OF_RANGE, msg_args(...));
exception
  when msg.PARAM_OUT_OF_RANGE_ERR then
    pit.handle_exception;
end;
```

### Throwing exceptions with `pit.assert` and predefined messages

```
begin
  pit.assert(p_param_1 in (10, 20, 30));
  pit.assert_not_null(p_param_2);
  <do something>
exception
  when msg.ASSERT_TRUE_ERR then
    pit.stop(msg.PARAM_OUT_OF_RANGE, msg_args('P_PARAM1', to_char(p_param_1)));
  when msg.ASSERT_IS_NOT_NULL_ERR then
    pit.handle_exception(msg.PARAM_MUST_EXIST, msg_args('P_PARAM_2'));
end;
```

### Throwing exceptions with `pit.assert` and custom messages, option 1

```
begin
  pit.assert(
    p_condition => p_param_1 in (10, 20, 30), 
    p_message_name => msg.PARAM_OUT_OF_RANGE, 
    p_msg_args => msg_args('P_PARAM_1', to_char(p_param_1)));
  pit.assert_not_null(
    p_condition => p_param_2, 
    p_message_name => msg.PARAM_MUST_EXIST, 
    p_msg_args => msg_args('P_PARAM_2'));
  <do something>
exception
  when msg.PARAM_OUT_OF_RANGE_ERR then
    pit.stop; -- or: pit.handle_exception; raise;
  when msg.PARAM_MUST_EXIST_ERR then
    pit.handle_exception;
end;
```

### Throwing exceptions with `pit.assert` and custom messages, option 2

```
begin
  pit.assert(p_param_1 in (10, 20, 30), msg.PARAM_OUT_OF_RANGE);
  pit.assert_not_null(p_param_2, msg.PARAM_MUST_EXIST);
  <do something>
exception
  when msg.PARAM_OUT_OF_RANGE_ERR then
    pit.stop(msg.PARAM_OUT_OF_RANGE, msg_args('P_PARAM1', to_char(p_param_1)));
  when msg.PARAM_MUST_EXIST_ERR then
    pit.handle_exception(msg.PARAM_MUST_EXIST, msg_args('P_PARAM_2'));
end;
```

Difference in the second option is that upon asserting you simply refer to a given message of severity `pit.level_error` or stronger. This is to be able to catch it's exception in the exception handler to divide between two `assert` methods. In the exception block, the message is enriched with parameters, something that has been done in option 1 already. Option 1 therefore is slightly more elegant in the exception block but more clumsy in the assertion block.

### Throwing exceptions with `pit.assert`, custom messages and error codes

```
declare
  l_message message_type;
begin
  pit.assert_not_null(p_param_1, msg.PARAM_MISSING);
  pit.assert_not_null(p_param_2, msg.PARAM_MISSING, p_error_code => 'PARAM_2_MISSING');
  pit.assert_not_null(p_param_3, msg.PARAM_MISSING, p_error_code => 'PARAM_3_MISSING');
  <do something>
exception
  when msg.PARAM_MISSING_ERR then
    l_message := pit.get_active_message;
    case l_message.error_code
      when msg.PARAM_MISSING then
        do_something;
      when 'PARAM_2_MISSING' then
        do_something;
      when 'PARAM_3_MISSING' then
        do_something;
end;
```

This example shows the use of error codes. Obviously, it's impossible to provide a constant for error codes passed into a message dynamically. But if you omit it, the error code will default to the message name so that it's possible to use the exceptions in a mixed mode, with or witout error codes. The exception thrown is the same but the error codes allow for a finer distinction between error scenarios. If not used, you would have to create different messages for the same kind of exception in order to distinguish between them.

If you use error codes, make sure to comment them in the package specification, as you should do with the list of exceptions a method may potentially throw.
If you run `PIT` in collect mode, error codes are always populated. If you provide an explicit error code, it will be used, if not, the message name is used.

