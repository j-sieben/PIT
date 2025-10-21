# Translate messages and translatable items
`PIT` messages and translatable items are translatable into any Oracle supported language. This can be done using different methods. The probably easiest way is to use the [APEX UI](https://github.com/j-sieben/PIT/blob/master/Doc/administration_app.md) for `PIT`.


## Using the APEX UI
To translate messages or translatable items using the APEX UI, go to the master data section (called »Stammdaten«) and select the message group or groups you want to translate (the same applies to translatable items, I don't mention this from now on). Then select the target language. Button »Meldungen übersetzen« (translate messages) becomes active. If you click on it, a zip file containing XLIFF files for each message group is downloaded. You may open any of these XLIFF files using an editor such as [POEdit](https://poeditor.com) or any other translation application that can deal with XLIFF files in format 2.0.

Translate all entries to the target language and save the XLIFF file.

You can then upload the translation using the file browse in the APEX UI where you just exported the translation files. Uploading the files and clicking on »Übersetzung laden« (load translation) will import the messages in the target language.

If you now export the message group, you will see that each method is exported in the default language you defined when installing `PIT` and for any translation you created the message will have a call to `pit_admin.translate_message` with your translations. That's all there is to it!

## Using PL/SQL

Of course you can translate your message without the APEX UI as well. Under the covers, the APEX UI simply calls `pit_admin.create_translation_xml` to generate the XLIFF instance. This method expects the message group to translate and the target language. As this method can be used to translate translatable items as well, it requires you to define whether you want to translate message (`pit_admin.C_TARGET_PMS`) or translatable items (`pit_admin.C_TARGET_PTI`). 

Two out parameters for the file name and the file instance as `XMLType` are provided.

Proceed with your translations, either by using an editor or by directly adding content to the XLIFF instance. If you're ready, you can apply the translation by passing it into `pit_admin.apply_translation`. Once again, you need to tell the method whether you're translating messages or translatable items.

## Translating one message or translatable item at a time

A third option is to call `pit_admin.translate_message` directly, using the same approach as the export routine with translated messages does. You may want to add calls to this method directly into the export script and translate the messages there. If you now run the export script a second time, all messages are translated as well.

To translate messages, `pit_admin` offers a specialized method. This is because it is cumbersome and error prone to repeat the other attributes such as severity, custom error number and so forth. When translating translatable items, no such method exists. Therefore you simply copy the call to `pit_admin.merge_translatable_item` and change the parameters accordingly. The only parameter with the same value now is the group parameter which is part of the primary key anyway. Therefore a dedicated translation method is not useful.

## Loading a translated `PIT` version

If you install `PIT`, you need to define a default language. Later, you can easily add a translation by calling `pit_load_trans.sql`. You need to pass in the install user and the target language (Oracle language name). At the moment, only `GERMAN` and `AMERICAN` are provided. If you want to translate into other messages, look out for folder `messages` in the `PIT` installation folder. There are several folders of that kind but the organization of these is the same: They contain a folder named after the Oracle language and script files with the respective messages.

If you want to add your own, simply duplicate a language folder, rename it to the desired target language, open the files and translate them. It would be nice if you provide me with your translations, I will gladly incorporate them into this project for others to use it.
