# How to work with translatable items
Translatable items offer the possibility to maintain translatable information in a standardized way. In many data models data must be translated into different languages based on user settings. This is especially true for data that is used for select lists, labels and the like. PIT offers a possibility to translate messages into many languages, but maintaining this kind of information with messages is not a valid approach, as it overloads the msg package with useless messages.

To overcome this, PIT now offers PIT Translatable Items, or PTI for short. A PTI is a lightweigt alternative to messages. It lacks some of the functionality of messages but offers other benefits. First, a PTI is not attached to a severity, it does not come as an object and it is not secured by a constant at package MSG. It does allow for the integration of message parameters and exceeds messages in its possibility to store three message chunks under one name:

- A PTI_NAME property with up to 200 characters in length and MSG_ARGS support,
- A PTI_DISPLAY_NAME property with up to 200 characters in length and MSG_ARGS support and
- A PTI_DESCRIPTION property of type CLOB wirthout MSG_ARGS support.

The PTI_DESCRIPTION property was planned to be used for help texts and the like, therefore no support for MSG_ARGS was felt to be necessary.

Messages had the possibility to group them into message groups already, but translatable items require you to assign them to a message group. The message group is part of the primary key, allowing for an easier naming system as a name has to be unique for a message group only.


## Technical Background
Technically, translatable items are stored in table PIT_TRANSLATABLE_ITEM and consist of a PTI_ID (it's unique name for the message group),  a reference to table PIT_MESSAGE_GROUP and PIT_MESSAGE_LANGUAGE. Plus, it offers the beforementioned columns for storing the PTI_NAME, PTI_DISPLAY_NAME and PTI_DESCRIPTION. To allow for other tables to reference entries in this table, PIT_TRANSLATABE_ITEM grants a REFERENCES right to any PIT client. Plus, it offers a virtual column named PIT_UID which, in combination with column PTI_PMG_NAME, forms a unique constraint other tables can reference. In conjunction with the REFERENCES grant on this table, other data models are allowed to include this table in a foreign key relationship into their local data models. They are not allowed to write to this table directly, but this can be achieved by using the respective API from PIT.

Above this table, there is a view called PIT_TRANSLATABLE_ITEM_V which selects the best fitting translation for the session language and for the given translatable item. If, fi, the session is set to GERMAN and the default language of PIT is ENGLISH, the view will try to find a GERMAN translated version of a translatable item and will fall back to the default ENGLISH translation should it not be successful.

As an example, here is a table definition that makes use of this and delegates the storage of translatable items to PIT:

```
create table sct_action_item_focus(
  sif_id varchar2(50 char),
  sif_pti_id varchar2(50 char),
  sif_pmg_name varchar2(5 char) default 'SCT',
  constraint pk_sct_action_item_focus primary key(sif_id),
  constraint fk_pti_id foreign key(sif_pti_id, sif_pmg_name)
    references &PIT_OWNER..pit_translatabe_item(pti_id, pti_pmg_name),
  constraint chk_sif_pmg_name check(sif_pmg_name = 'SCT')
);
```

Please note the use of `&PIT_OWNER.` to see how a reference to a foreign schema can be made (of course you can provide a local synonym for that table as well). Also note that it is a good practice to define a static property for SIF_PMG_NAME (which references the message group in PIT) to make it easy to collect all translatable items for a certain area of the data model. This way, you can create an export of all translatable items very easily.

It may be a good idea to create a view above your own table to wrap the storage of translatable items. The next code gives an idea on how to do this:

```
create or replace view sct_action_item_focus_v as
select sif_id, pti_name sif_name, pti_description sif_description
  from sct_action_item_focus
  join &PIT_OWNER..pit_translatable_item_v
    on sif_pti_id = pti_id
   and sif_pmg_name = pti_pmg_name;
```

For the calling code, this view behaves exactly like a local table with the exception that it "automagically" shows the value in the correct language, if available. Keep in mind though that based on the fact that this view is a complex view, you can't write through this view but must either offer the table for writing purposes or provide a table API which in my opinion is always a good thing to do.

As usual, there is the possibility to maintain PTI's using an API that also allows for semi automatic exporting of translatable items. Plus, PIT has been extended with four version to access a translatable item from PL/SQL. There are three methods to directly access one of the three translated text chunks plus a forth version that returns a record with all three translated text chunks. When working in SQL, it is better to directly join the PIT_TRANSLATABLE_ITEM_V, as this view contains all translated items and does a proper translation based on the language settings of the actual session.

## Performance Considerations

Is it a good idea to store all translatable items in one central table? This may or may not be a good idea, but most of the times this is not a problem. Reason is that this table is not written to very often (if at all), as the data is captured during the development cycle and not in a production environment. Reading information in parallel is basically what a stabase data cache was made for. Therefore chances are, that this table will be held in memory anyway as it is used quite frequently, granting access to this data as quickly as possible.

Plus, access to this table is done using a primary key access anytime. It would be even better to store the table as organization index, but unfortunately this is  not supported when using virtual columns. The virtual column on the other hand is necessary to be able to provide a unique constraint to a translatable item without the language property (which is part of the primary key). This way, other tables can reference the PTI without the need to store the language at those tables.

What you should not do though is accessing data from SQL using the PL/SQL-API. This will cause a roundtrip between the PL/SQL and SQL side of the database which is one main reason for bad SQL performance, especially when used in the `where` clause of a statement. It is better to join the view to your table for this purpose.

Within the view, there is an analytic function that does a Top-1 search against the data. This may sound like a bad idea, but it is not, because a typical accees to a set of rows of that table will result in as many rows as you have languages for that PTI. Over this amount of data the analytic function will perform a quick window sort and give you the best possible match. It would be faster to not do it, but I couldn't think of a faster way of doing it if you have to do it anyway. So if you need to do it, here's your way to do it, if you don't need to do it, you probably don't need translatable items at all.

