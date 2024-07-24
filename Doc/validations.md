# Validate User Input

One of the most important parts of `PIT` is its support for user input validation. Main challenge in many software architectures is that the business logic is separated from the UI logic. The question then is, where to put the validation logic. `PIT` allows to keep the validation logic separated from the UI logic, allowing to reuse validation logic across client applications such as a web frontend or a batch run. Reason for this is the concept of output modules which separates the delivery of an exception message from the point where it is raised. Therefore, the business logic does not need to know wheter Oracle APEX, a Java application or SQL*Plus is connected to it. It simply validates the data and asks `PIT` to communicate any findings to whom it may concern.

There are many possibilities for implementing validation logic. In recent years, the introduction of numeric return codes were quite common. `PIT` on the other hand relies on named exceptions and the exception raising mechanism in PÜL/SQL to communicate any validation errors. There are good reasons to separate validation findings from »real« exceptions and errors because validation findings normally are just shown to the user but not persisted in error logging tables. To cater for this, `PIT` not only offers a rich set of assertion methods to make validating data easy but also a separate communication channel to each output module names especially for validation findings.

Plus, `PIT` gives youu the chance to run validations in a »collect mode« which, when entered, collects all messages on an internal stack and examines it if the collection mode is left. If an exception is found, it raises an error, allowing you to deal with the list of messages collected. Read more about the collection mode [here]().

## Assertions

An assertion is a very simple pattern that takes a test and throws an exception if the test fails. The beauty of this approach is that it allows you to »think positive«, meaning that you test what you expect the data to look like. Normal validation code forces you to turn the test to its logical opposite, making things more complex. `PIT` supports a wide variation of built in assertion methods, partly overloaded for different datatypes. These are:

-  `pit.assert`: The most basic assertion method that checks whether the boolean expression passed in evaluates to `TRUE`. If `FALSE` or `NULL`, the tast fails.
-  `pit.assert_is_null`: Simple check whether the parameter passed in is `NULL`. Fails, if it is not `NULL`
-  `pit.assert_not_null`: The logical oppsite. This test is often used for mandatory parameters.
-  `pit.assert_exists`: Takes an opened cursor and assures that at least one row is returned.
-  `pit.assert_not_exists`: Takes an opened cursor and assures that no row is returned.
-  `pit.assert_dataype`: Asserts that the parameter passed can be converted to the desired datatype.

There are also two functions, named `pit.assert_is_ok` and `pit.assert_is_not_ok` but those serve a different purpose in the vicinity of the collect mode.

## Example

The following example shows a typical validation method

```
  procedure validate_rule_group(
    p_row in adc_rule_groups%rowtype)
  as
    l_cur sys_refcursor;
  begin
    pit.enter_mandatory('validate_rule_group');
      
    pit.assert_not_null(p_row.crg_app_id, msg.ADC_PARAM_MISSING, p_error_code => 'CRG_APP_ID_MISSING');
    pit.assert_not_null(p_row.crg_page_id, msg.ADC_PARAM_MISSING, p_error_code => 'CRG_PAGE_ID_MISSING');

    if p_row.crg_id is null then
      -- only if inserting we need to check whether the name is unique
      open l_cur for 
        select null
          from adc_rule_groups
         where crg_app_id = p_row.crg_app_id
           and crg_page_id = p_row.crg_page_id;
      pit.assert_not_exists(
        p_cursor => l_cur,
        p_message_name => msg.ADC_CRG_MUST_BE_UNIQUE,
        p_msg_args => null,
        p_affected_id => 'CRG_PAGE_ID');
    end if;
    
    pit.leave_mandatory;
  end validate_rule_group;
``` 

Many validations are single liners. The validation of the mandatory items share a common message, separating them by using a different error code. The third validation uses a cursor, but the rest of the call is the same than the simpler variants before. This is an example of a full validation method. When run normally, it will raise exception `msg.ADC_PARAM_MISSING_ERR` if one of the mandatory parameters is `NULL` or `msg.ADC_CRG_MUST_BE_UNIQUE_ERR` if a new row is to be inserted and the alphanumerical ID is in use already.

## Handling Validation Findings

To prevent confusion, it may be a good idea to separate validation findings from exceptions. You may use the assertion methods to throw errors if this does make sense to you. You may also decide to throw validation findings only, fi in a UI package who's only purpose is to show those findings to the user. The beauty of this approach is: It doesn't change anything within the validation method. If you call this method from within a UI-related package, you may treat the exceptions as findings whereas in a business logic package you may treat them as errors. It's up to you.

Here is a code snippet that treats any exception as a validation finding:

```
begin
  some_pck.validate_rule_group(l_row);
exception
  when others then
    pit.handle_validation;
end;
```

Depending on the possibilities of your UI frontend, you may show the message differently based on the severity of the message: A message of level `ERROR` may be displayed as an error, whereas a message of level `WARN` may be shown as a warning hint. Bacause you passed the messages to a different communication channel, those will not, depending on the implementation of your output modules, be persisted at all but simply forwared to the GUI. Examine the possibilities of the collect mode as well to learn about even mor powerful methods of dealing with user input.
