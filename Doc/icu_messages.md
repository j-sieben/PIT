# Working with ICU messages

ICU (International Components for Unicode) is an open-source project of mature C/C++ and Java libraries for Unicode support, software internationalization, and software globalization. ICU is widely portable to many operating systems and environments. It gives applications the same results on all platforms and between C, C++, and Java software. The ICU project is a technical committee of the Unicode Consortium and sponsored, supported, and used by IBM and many other companies.

--- [International Components for Unicode. In Wikipedia, The Free Encyclopedia. Retrieved 11:39, January 07, 2021](https://en.wikipedia.org/wiki/International_Components_for_Unicode)

In regard to messages, ICU puts normal `PIT` messages on steroids. It solves problems you can't address using simple `PIT` messages, such as plural, gender, selective messages based upon quantity and others. Let's look at an example.

## Example of an ICU message

An ICU message takes more information into account than a normal message. As an example, I've copied a message from the [ICU Documentation](http://userguide.icu-project.org/formatparse/messages). The aim of this message is to provide different messages based on the gender of the host and the amount of guests:

```
{
  gender_of_host, 
  select,
  female {{num_guests, plural, offset:1 
      =0 {{host} does not give a party.}
      =1 {{host} invites {guest} to her party.}
      =2 {{host} invites {guest} and one other person to her party.}
      other {{host} invites {guest} and # other people to her party.}}}
  male {{num_guests, plural, offset:1 
      =0 {{host} does not give a party.}
      =1 {{host} invites {guest} to his party.}
      =2 {{host} invites {guest} and one other person to his party.}
      other {{host} invites {guest} and # other people to his party.}}}
  other {{num_guests, plural, offset:1 
      =0 {{host} does not give a party.}
      =1 {{host} invites {guest} to their party.}
      =2 {{host} invites {guest} and one other person to their party.}
      other {{host} invites {guest} and # other people to their party.}}}}
```

The message provides an anchor named `gender_of_host`. Based on the value of that anchor, one of the three select options are taken: `female`, `male` or `other`.
Within the respective tree, anchor `num_guests` is evaluated, looking for a plural selection. Values are `0`, `1`, `2` or higher. Based on these values, different messages are returned. Anchors `host` and `guest` are taken as simple string and included in the resulting message.

The special sign `#` refers to the anchor that is actually being examined, `num_guests` in our case.

If you pass in 
```
{
  "gender_of_host":"female",
  "num_guests":2,
  "host":"Maria",
  "guest:"Tamer"
}
```
ICU will calculate `Maria invites Tamer and one other person to her party.` as the resulting message.

For a more in depth introduction to this message format, you may want to check out [this tutorial](https://phrase.com/blog/posts/guide-to-the-icu-message-format/).

## Working with ICU messages in `PIT`

To distinguish a »normal« `PIT` message from an ICU message, I've decided to base it on a convention rather than extending the API. The convention says that the first message argument you pass in must be the constant `PIT.FORMAT_ICU` (or the string `FORMAT_ICU`). 

To use ICU messages, you must provide values for the named anchors. As `PIT` uses unnamed anchors internally, this is not an option anymore, as things would get too complicated for anybody who wishes to translate these messages. Additionally, we have to distinguish number and string types, so providing the values as a JSON instance felt to be a natural choice.

To use the example message in PIT, you must first create a message with the example message as the message text:

```
begin
  pit_admin.merge_message ( 
    p_pms_name => 'ICU_TEST',
    p_pms_text => '{gender_of_host, select,
        female {{num_guests, plural, offset:1 
              =0 {{host} does not give a party.}
              =1 {{host} invites {guest} to her party.}
              =2 {{host} invites {guest} and one other person to her party.}
              other {{host} invites {guest} and # other people to her party.}}}
          male {{num_guests, plural, offset:1 
              =0 {{host} does not give a party.}
              =1 {{host} invites {guest} to his party.}
              =2 {{host} invites {guest} and one other person to his party.}
              other {{host} invites {guest} and # other people to his party.}}}
          other {{num_guests, plural, offset:1 
              =0 {{host} does not give a party.}
              =1 {{host} invites {guest} to their party.}
              =2 {{host} invites {guest} and one other person to their party.}
              other {{host} invites {guest} and # other people to his party.}}}}',
    p_pms_pse_id => 70,
    p_pms_description => 'Test of ICU messages',
    p_pms_pmg_name => 'PIT'); 

  pit_admin.create_message_package;
end;
/
```

You call the message this way:
```
declare
  l_gender varchar2(10 byte);
  l_num_guests pls_integer;
  l_host varchar2(128 byte);
  l_guest varchar2(128 byte);
  l_param_template constant varchar2(200) := q'^{'gender_of_host':'#GENDER#','num_guests':#NUM_GUESTS#,'host':'#HOST#','guest':'#GUEST#'}^';
  l_json_params varchar2(2000);
begin
  l_gender := 'female';
  l_num_guests := 5;
  l_host := 'Maria';
  l_guest :='Tamer';
  l_json_params := utl_text.bulk_replace(l_param_template, char_table(
                     'GENDER', l_gender,
                     'NUM_GUESTS', l_num_guests,
                     'HOST', l_host,
                     'GUEST', l_guest));
  pit.print(msg.ICU_TEST, msg_args(pit.FORMAT_ICU, l_json_params));
end;
/

SQL> Maria invites Tamer and 4 other people to her party.
```

This is obviously more complicated than a »normal« `PIT` message but offers much more power. Plus, keep in mind that all the internals of the translation issues to other languages are taken away from the code and put into the hands of the translator of the message.

Using this convention, you can mix »normal« and ICU messages without any setup. This way, you can benefit from the powerful ICU messages if you need this functionality and stick to the easier to use messages in all other cases.

## Installing the ICU extension

`PIT` supports ICU messages after some preparational work. You have to load three java libraries into the database at the `PIT` owner schema. These libraries are:

- ICU4j, I've tested with [Release 68.2](https://github.com/unicode-org/icu/releases/tag/release-68-2)
- orgJson, [Version 20201115](https://jar-download.com/artifacts/org.json)
- A small ICU.jar, provided at folder `PIT/core/java/ICU.jar`

`PIT` already supports the ICU extension, even if the jar files are not loaded into the database. As the code is missing, calling messages with the `FORMAT_ICU` switch will lead to an exception unless the jar files are loaded into the database.

