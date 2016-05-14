# Throwing and catching exceptions with PIT

After having defined a message of severity `ERROR` or `FATAL`, package `MSG` has defined a respective message, an exception and an exception init for the given Oracle error number. If no Oracle error number has been provided, PIT automatically assigns a custom error number within the range `-20,999 .. -20,000`. Let's have a look at how we can work with these errors in PIT.

## Throwing errors

To throw an error, there are two different ways with specific advantages.

### Throw and error using `raise`

When using the `raise` command, it's very easy to throw an error: 

```
begin
  ... some work
  raise msg.CHILD_RECORD_FOUND_ERR;
exception
 when msg.SQL_ERROR_ERR then
   ... do something
end;
```

The advantage of this way to throw errors is that it's very common for many programmers to throw errors like this. The disadvantage is that you don't have control over the message that will come out lateron. Of course, it's possible to catch the exception and pass the matching message to PIT. While doing so, you can pass in any parameters that you like.

But imagine a situation where the same error may occur at several positions within your code. Based on where it is thrown, the parameteres to add to the message vary. In these situations it may be helpful to be able and create the message right where the error occurs, passing in all parameters you have at the moment you throw the error. This is, why a second possibility to throw errors exists.

### Throwing errors with `pit.error` or `pit.fatal`

If you throw an error using these two functions, the basic mimic stays the same. But now you have the option to pass in any arguments to the error you like. This is achieved by passing in the message name and parameters instead of throwing an error. As you recall, every message has got a matching exception, if severity demands for it. This is now used to throw the error with the message you just created. Review the following code snippet:

```
begin
  ... some work
  pit.error(msg.CHILD_RECORD_FOUND, mgs_args('row', to_char(id)));
exception
 when msg.SQL_ERROR_ERR then
   ... do something
end;
```

The code to catch the exception is the same, although the way to process the error with PIT is different. Before we come to that, I'd like to stress that after throwing an exception with `pit.error` or `pit.fatal`, `SQLCODE` and `SQLERRM` are populated with the message you created when throwing the error. `SQLCODE` contains the Oracle error number or the custom error number assigned to the message.

## Catching exceptions with PIT

Let's see how to catch exceptions with PIT and the options we have here.

There are two specialized methods to handle exceptions within PIT: `pit.sql_exception` and `pit.stop`. I have to admit that the latter was the reason to call the whole package PIT ...

### `pit.sql_exception` 
This is the ideal partner for `pit.error`, because by catching the exception with this method, it gets passed to all output modules and after that the exception is handled and the code is allowed to continue. You may define any message you like to be passed with this method, but normally the matching message may make most sense when used with `raise`. Things are slightly different when using `pit.error` but we'll come to that in a moment.

So let's extend our code snippet and process the catched exception:
```
begin
  ... some work
  raise msg.CHILD_RECORD_FOUND_ERR;
exception
 when msg.SQL_ERROR_ERR then
   pit.sql_exception(msg.CHILD_RECORD_FOUND, msg_args('row', to_char(id)));
end;
```

### `pit.stop`
This method, on the other hand, is ideal for working in conjunction with `pit.fatal` or `raise`. The difference between these two methods is the same as with `pit.sql_exception`, so I won't get into detail here again. The difference with `pit.stop` is that it will throw an exception after it has logged the original excpetion. The thrown exception may be kust the same exception that was passed in or a default exception called `msg.FATAL_ERROR_OCCURRED` that accepts a parameter to explain what exactly went wrong. I will show you both usages in a second.

### Passing predefined messages to PIT
If you threw the excpetion with `pit.error` or `pit.fatal`, the message has been created already. Therefore you don't want this message to be overwritten by a new message in `pit.sql_exception´ or `pit.stop` respecitvely. To achieve this, you may use a specific message called `pit.PASS_MESSAGE´. If you do so, the already existing message (which is stored in `SQLERRM`) will be used for logging, allowing for individual parameters throughout the code.

If you review the next code sample, you will get the idea of how it works immediately:

```
begin
  ... some work
  pit.error(msg.CHILD_RECORD_FOUND, mgs_args('row', to_char(id)));
exception
 when msg.SQL_ERROR_ERR then
   pit.sql_exception(msg.PASS_MESSAGE);
   -- or: pit.stop(msg.PASS_MESSAGE);
end;
```

There is one special thing with the `pit.stop` method. As I already stated, there is a predefined message for convenience. You might use this method if an unexpected exception has been thrown in a deeper procedure level. If this exception pops up, you have already logged the exception to the stack. Now you want to pass a more generic message to the »outer world«. If you want to do so, just call `pit.stop´ without a parameters:

```
begin
  ... some work
  pit.error(msg.CHILD_RECORD_FOUND, mgs_args('row', to_char(id)));
exception
 when msg.SQL_ERROR_ERR then
   pit.stop();
end;
```
If `pit.stop` is called without parameters, it will logg `msg.FATAL_ERROR_OCCURRED` instead.
