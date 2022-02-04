﻿NDSummary.OnToolTipsLoaded("File:core/packages/pit_admin.pks",{384:"<div class=\"NDToolTip TClass LSQL\"><div class=\"TTSummary\">Package to administer PIT. Provides methods to create or maintain messages.</div></div>",386:"<div class=\"NDToolTip TConstant LSQL\"><div class=\"TTSummary\">Flags indicate whether the respective functionality should be compiled or not.</div></div>",396:"<div class=\"NDToolTip TConstant LSQL\"><div class=\"TTSummary\">Target distinguish between areas of similar items to streamline the API</div></div>",401:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype401\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> create_message_package(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_directory&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to (re-) create package MSG.</div></div>",402:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype402\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_message_text(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pms_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message.pms_name<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pms_pml_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_language.pml_name<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return varchar2</span></div></div><div class=\"TTSummary\">Function to retrieve the text for a given language without replacements.&nbsp; Is used to review the text of a given message in a desired language</div></div>",403:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype403\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> set_language_settings(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pml_list&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.max_sql_char</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to set default language settings.</div></div>",405:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype405\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> merge_message_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pmg_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pmg_description&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_description<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_pmg_error_prefix&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_error_prefix<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHString\">\'&amp;ERROR_PRE.\'</span>,</td></tr><tr><td class=\"PName first\">p_pmg_error_postfix&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_error_postfix<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHString\">\'&amp;ERROR_POST.\'</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to maintain message groups. Is used to create or change a message group.&nbsp; Message groups do not have any special meaning other than sorting messages for easier maintenance and export separation.</div></div>",406:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype406\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> merge_message_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> pit_message_group<span class=\"SHKeyword\">%rowtype</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to matain a message group. Overload with a row record.</div></div>",407:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype407\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_message_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pmg_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_force&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\">false</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to delete a message group. Does not delete a message group if messages exists within that group, unless specified by setting the &lt;P_FORCE&gt; parameter to true. Will not commit nor re-create the MSG package.</div></div>",408:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype408\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> merge_message(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pms_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message.pms_name<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pms_text&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message.pms_text<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pms_pse_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message.pms_pse_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pms_description&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message.pms_description<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_pms_pmg_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_pms_pml_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_language.pml_name<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_error_number&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message.pms_custom_error<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to maintain messages. Is used to create or change a PIT message. Will not commit nor re-create the MSG package.</div></div>",409:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype409\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> merge_message(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> pit_message<span class=\"SHKeyword\">%rowtype</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to merge a message. Overload with a row record.</div></div>",410:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype410\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_message(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pms_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message.pms_name<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pms_pml_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_language.pml_name<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to delete a single pit_message. Will delete all translations as well. Is called to remove mistyped or unnecessary messages in all languages. Will not commit nor re-create the MSG package.</div></div>",411:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype411\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_all_messages(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pmg_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to delete all messages. Is called if a new set of messages shall be installed and all old and unneeded messages must be thrown away beforehand. Will not commit nor re-create the MSG package.</div></div>",412:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype412\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> translate_message(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pms_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message.pms_name<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pms_text&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message.pms_text<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pms_pml_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_language.pml_name<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pms_description&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message.pms_description<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to translate a given message. Use this procedure as a shortcut for an already existing message, if the only task is to translate it.</div></div>",414:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype414\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> validate_translatable_item(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_translatable_item<span class=\"SHKeyword\">%rowtype</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to validate a translatable item</div></div>",415:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype415\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> merge_translatable_item(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pti_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_translatable_item.pti_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pti_pml_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_language.pml_name<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pti_pmg_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pti_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_translatable_item.pti_name<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pti_display_name&nbsp;</td><td class=\"PType\">pit_translatable_item.pti_display_name<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_pti_description&nbsp;</td><td class=\"PType\">pit_translatable_item.pti_description<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to create a or change a translatable item. Is used to create or change a translatable item.&nbsp; Any item may have up to three different text items assotiated with it to allow for short, medium and longer versions of a text item.</div></div>",416:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype416\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> merge_translatable_item(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> pit_translatable_item<span class=\"SHKeyword\">%rowtype</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to merge a translatable item. Overloaded version with a row record</div></div>",417:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype417\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_translatable_item(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pti_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_translatable_item.pti_id<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_pti_pmg_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to create a or change a translatable item and all its translations.</div></div>",419:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype419\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> create_context_toggle(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_toggle_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_module_list&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_context_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_comment&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to create a context toggle. Is called to have PIT toggle it\'s context settings based on entering a module or a list of modules. A toggle switches the debug settings if the package or procedure mentioned in the toggle is entered.</div></div>",420:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype420\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_context_toggle(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_toggle_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to remove a context toggle</div></div>",421:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype421\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> create_named_context(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_context_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_log_level&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in number</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_trace_level&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in number</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_trace_timing&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_module_list&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_comment&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to create a named context to control debug settings.</div></div>",422:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype422\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> create_named_context(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_context_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_settings&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_comment&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to create a named context. Overload for a settings string.</div></div>",423:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype423\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_named_context(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_context_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to delete a named context</div></div>",425:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype425\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> create_installation_script(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pmg_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_target&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_file_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">out nocopy</span> pit_util.ora_name_type,</td></tr><tr><td class=\"PName first\">p_script&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">out nocopy clob</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to get items of a group as a script of API calls to PIT_ADMIN package.</div></div>",426:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype426\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_installation_script(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pmg_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_target&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return clob</span></div></div><div class=\"TTSummary\">Method to get items of a group as a script of API calls to PIT_ADMIN package.</div></div>",427:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype427\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> create_translation_xml(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_target_language&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_language.pml_name<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pmg_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_target&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_file_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">out nocopy</span> pit_util.ora_name_type,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_xliff&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">out nocopy</span> xmltype</td><td></td><td class=\"last\"></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to generate an XML file in format XLIFF to translate items.</div></div>",428:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype428\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_translation_xml(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_target_language&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_language.pml_name<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pmg_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_target&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td></td><td class=\"last\"></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return clob</span></div></div><div class=\"TTSummary\">Method to directly create a translation XLIFF file and return it as CLOB.</div></div>",429:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype429\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> apply_translation(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_xliff&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> xmltype,</td></tr><tr><td class=\"PName first\">p_target&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to import translated items into the database.</div></div>",430:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype430\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_translation(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pml_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_message_language.pml_name<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_target&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to delete a translation.</div></div>",431:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype431\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> register_translation(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pml_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_message_language.pml_name<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to register a translated message, if not yet registered.</div></div>"});