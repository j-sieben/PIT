# Working with PIT in collection mode

The driving factor for developing this extension to `PIT`came up when we wanted to reuse validation logic in the database layer for an APEX application. Even with APEX where all code resides within the database, it's a wise decision to carefully think about where to implement which part of the code. As a bare minimum, the APEX workspace schema should be separated from the schema containing the data and its attached validation and processing logic. This is to support future development, where you proably want to replace APEX with the new kid on the block. Wrapping all your validation and data processing logic in the vicinity of APEX will then turn out to be a desastrous idea.

But if we split the logic between a schema that contains the data and an APEX schema that only holds part of the logic that deals with user input and display issues, you may wonder where to put your validation logic. The end user's data input has to be validated within the application and this should be done in accordance to the APEX lifecycle. In APEX, a validation of a page is called either upon submit of the page or during lifetime of a page using an AJAX call to the database.

Unfortunately, validation of data within the database has a differnt aim than validation on the APEX UI side. Whereas the focus of validating data within a transaction API within the database is used to assert that no invalid data may be stored in the database, the UI is interested in getting all validation issues of all form fields at once. This is to avoid that the end user has to submit the page mutliple times to sort out all errors.

The existing validation logic on the other hand immediately stops if the first issue is detected, as this is sufficient to reject writing data to the database. So how do we overcome this different goals? It should be possible to switch the desired strategy between »find first issue« versus »find all issues«. If you set up your validation logic using `PIT` (chances are you did, as you read this manual) then there is a simple solution available for you.

## Collect Mode

The solution is to switch `PIT` to collect mode. This hinders it to immediately throw an exception once an assertion has gone wild or an exception has been thrown using `PIT.error` or `PIT.fatal`. Instead, `PIT` will silently push all messages on a stack until you tell it to stop collecting messages.

Switching collect mode on is done by calling `PIT.start_message_collection`. This call should be used just before you call the validation code if you require the »find all issues« strategy. If you omit this call, `PIT` will work in its default »find first issue« strategy just as PL/SQL does.

After you have called all validation logic of interest, you stop the collect mode by calling `PIT.stop_message_collection`.

Now, `PIT` will examine the collected messages and detect the most severe message during that period. Should at least one message of severity `ERROR` or `FATAL` be found, `PIT` will now throw exception `PIT_BULK_ERROR` or `PIT_BULK_FATAL` respecitvely. You can catch those jnust like any other `PIT` exception and get access to all collected messages by using `PIT.get_message_collection`. This method returns an instance of type `PIT_MESSAGE_TABLE` which is simpyl a table of `MESSAGE_TYPE` instances, so you will have all attributes of a normal message, such as message text, message attributes, severity, call stack etc. But there's even more.

## Special usage of attribute `ERROR_CODE`

`MESSAGE_TYPE`contains an attribute called `ERROR_CODE`. This attribute is used to transport error codes from legacy systems. In collection mode, `PIT` uses this attribute in a specific manner. The reason is that I had to find a solution for a repeated use of the same message. Say that a validation logic checks some input parameters for `NOT NULL` checks. If will most likely use the same `PIT` message for those tests. But how can you now tell, which parameter value caused this exception to be raised?

If you utilize a `PIT` message more than once in a validation method, you may differ those by giving them a different error code. You can simply pass this code as a parameter to the `PIT.assert...` methods. If you now examine your message collection, you can distinguish those messages easily.

As a consequence of this, the possible error codes the validation may throw should be documented, fi by using a method comment. To the calling environment there is hardly any differnce between an error code and a message name. Rather, `PIT` will populate the error code attribute with the message name if it is in collect mode and no explicit error code was provided. Therefore, it is save to base your logic on the existence of this error code attribute.

## Mapping of UI elements to messages

But there is also another problem we need to solve. As the validation logic is part of the data schema, it should not have any knowledge about the details of the UI which is on a higher level. This means that the validation logic does not know any name or id of an input field where the information it validated came from. Just opposite, the UI logic should not have any knowledge about the implementation of the validation logic. So this boils down to a problem of how to match the input fields to the messages which come back as a result of the validation.

The easiest way that came to my mind is to provide a mapping table between the error codes returned from the validation logic and the UI field names on the UI level. On the UI side, this should be encapsulated into a helper method. This method expects an instance of type `PIT_MESSAGE_TABLE` (the return type of `PIT.get_message_collection` as you may remember) and an instance of type `CHAR_TABLE` containt a pair-wise mapping of the error code and the name of the input field the error code belongs to. The helper method can then match the error codes from the validation logic with the UI field names and show the validation errors next to those fields. 

Neither the validation logic nor the UI logic cross any permitted boundaries the knowledge stays where it belongs. The possible error codes are part of the validation method interface and it is therefore acceptable to expect that the calling logic knows about this list of possible exceptions.

## Wrap up: How do you work with collect mode?

To wrap things up, I'd like to describe how the proper use of the collect mode is done:

1.  Implement your validation logic in a separate method within the transaction API (A transaction API is not a Table API, as a transaction API deals with use cases instead of table rows). Implement you validation logic using `PIT.assert...` methods or by raising exception using the `PIT.error/fatal` methods.
2.  In your transaction API, prior to saving the data to database tables, call you validation logic in normal mode
3.  In your UI package dealing with the user data entries, enrich missing data, harmonize spelling issues, provide missing default values and the like and then call the validation logic in collect mode by wrapping the call of the validation logic with calls to `PIT.start_message_collection` and `PIT.stop_message_collection`. If validation errors occur, this will throw an exception you can catch.
4.  Handle exception `msg.PIT_BULK_FATAL_ERR` and `msg.PIT_BULK_ERROR_ERR` (exception prefix is dependent on your parameterization) and call you internal helper method to pass the result of `PIT.get_message_collection` along with a list of matching error code to UI field mappings.

This way you don't need to duplicate you validation logic but make it reusable in a user friendly manner.
