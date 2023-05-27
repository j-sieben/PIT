﻿NDSummary.OnToolTipsLoaded("SQLClass:PIT_ADMIN_Body",{452:"<div class=\"NDToolTip TClass LSQL\"><div class=\"TTSummary\">Implements PIT administration methods</div></div>",470:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype470\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> check_error(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\">pit_message<span class=\"SHKeyword\">%rowtype</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Helper to check whether a predefined Oracle error is to be overwritten.</div></div>",471:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype471\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_export_group_script(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pmg_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return varchar2</span></div></div><div class=\"TTSummary\">Method to create a script snippet for ex- or importing a message group</div></div>",359:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype359\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> script_messages(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pmg_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_script&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">out nocopy clob</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Helper method to generate a message install script. Is called internally by create_installation_script</div></div>",363:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype363\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> script_translatable_items(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pmg_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_script&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">out nocopy clob</span></td><td></td><td class=\"last\"></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Helper method to generate a translatable items install script.&nbsp; Is called internally by create_installation_script</div></div>",474:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype474\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> analyze_xliff(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_xliff&nbsp;</td><td class=\"PType last\">xmltype,</td></tr><tr><td class=\"PName first\">p_pml_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">out nocopy</span> pit_message_language.pml_name<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_pmg_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">out nocopy</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to extract language and group from an XLIFF envelope. Is used to extract information from an XLIFF header.</div></div>",475:"<div class=\"NDToolTip TFunction LSQL\"><div class=\"TTSummary\">Helper method to extract XLIFF instance into &lt;PIT_MESSAGE&gt;. Is called internally by apply_translations.</div></div>",476:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype476\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> translate_translatable_items(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_xliff&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> xmltype</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Helper method to extract XLIFF instance into &lt;PIT_TRANSLATABLE_ITEM&gt;.&nbsp; Is called internally by apply_translations.</div></div>",477:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype477\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_pms_xml(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_target_language&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_language.pml_name<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pmg_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> xmltype</div></div><div class=\"TTSummary\">Help method to generate XLIFF compatible translation entries for messages.&nbsp; &lt;Is called internally by get_translation_xml&gt; to allow for different target types.</div></div>",478:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype478\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_pti_xml(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_target_language&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_language.pml_name<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pmg_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> xmltype</div></div><div class=\"TTSummary\">Help method to generate XLIFF compatible translation entries for translatable items.&nbsp; Is called internally by get_translation_xml to allow for different target types.</div></div>",479:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype479\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> initialize</div></div><div class=\"TTSummary\">Initialization procedure.</div></div>",481:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype481\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> set_language_settings(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pml_list&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.max_sql_char</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PIT_ADMIN.set_language_settings</div></div>",482:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype482\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> create_message_package (</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_directory&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PIT_ADMIN.create_message_package</div></div>",483:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype483\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_message_text(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pms_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message.pms_name<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pms_pml_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_language.pml_name<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;:=&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return varchar2</span></div></div><div class=\"TTSummary\">See PIT_ADMIN.get_message_text</div></div>",485:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype485\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> validate_message_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> pit_message_group<span class=\"SHKeyword\">%rowtype</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See &lt;PIT_ADMIN.validate_message_group&gt;</div></div>",486:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype486\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> merge_message_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pmg_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pmg_description&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_description<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_pmg_error_prefix&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_error_prefix<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_pmg_error_postfix&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_error_postfix<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PIT_ADMIN.merge_message_group</div></div>",487:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype487\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> merge_message_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> pit_message_group<span class=\"SHKeyword\">%rowtype</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PIT_ADMIN.merge_message_group</div></div>",488:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype488\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_message_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pmg_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_force&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\">false</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PIT_ADMIN.delete_message_group</div></div>",489:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype489\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> validate_message(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> pit_message<span class=\"SHKeyword\">%rowtype</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See &lt;PIT_ADMIN.validate_message&gt;</div></div>",490:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype490\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> merge_message(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pms_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message.pms_name<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pms_text&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message.pms_text<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pms_pse_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message.pms_pse_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pms_description&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message.pms_description<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_pms_pmg_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_pms_pml_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_language.pml_name<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_error_number&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message.pms_custom_error<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PIT_ADMIN.merge_message</div></div>",491:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype491\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> merge_message(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> pit_message<span class=\"SHKeyword\">%rowtype</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PIT_ADMIN.merge_message</div></div>",492:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype492\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_message(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pms_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_message.pms_name<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_pms_pml_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_message_language.pml_name<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PIT_ADMIN.delete_message</div></div>",493:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype493\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_all_messages(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pmg_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PIT_ADMIN.delete_all_messages</div></div>",494:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype494\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> translate_message(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pms_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message.pms_name<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pms_text&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message.pms_text<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pms_pml_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_language.pml_name<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pms_description&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message.pms_description<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PIT_ADMIN.translate_message</div></div>",496:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype496\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> validate_translatable_item(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_translatable_item<span class=\"SHKeyword\">%rowtype</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PIT_ADMIN.validate_translatable_item</div></div>",497:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype497\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> merge_translatable_item(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> pit_translatable_item<span class=\"SHKeyword\">%rowtype</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PIT_ADMIN.merge_translatable_item</div></div>",498:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype498\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> merge_translatable_item(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pti_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_translatable_item.pti_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pti_pml_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_language.pml_name<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pti_pmg_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pti_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_translatable_item.pti_name<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pti_display_name&nbsp;</td><td class=\"PType\">pit_translatable_item.pti_display_name<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_pti_description&nbsp;</td><td class=\"PType\">pit_translatable_item.pti_description<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PIT_ADMIN.merge_translatable_item</div></div>",499:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype499\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_translatable_item(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pti_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_translatable_item.pti_id<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_pti_pmg_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PIT_ADMIN.delete_translatable_item</div></div>",501:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype501\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> create_context_toggle(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_toggle_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_module_list&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_context_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_comment&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PIT_ADMIN.create_context_toggle</div></div>",502:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype502\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_context_toggle(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_toggle_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PIT_ADMIN.delete_context_toggle</div></div>",503:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype503\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> create_named_context(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_context_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_log_level&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in number</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_trace_level&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in number</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_trace_timing&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_module_list&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_comment&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PIT_ADMIN.create_named_context</div></div>",504:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype504\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> create_named_context(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_context_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_settings&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_comment&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PIT_ADMIN.create_named_context</div></div>",505:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype505\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_named_context(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_context_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PIT_ADMIN.delete_named_context</div></div>",367:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype367\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> create_installation_script(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pmg_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_target&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_script&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">out nocopy clob</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_target_language&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_language.pml_name<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PIT_ADMIN.create_installation_script</div></div>",508:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype508\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_installation_script(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pmg_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_target&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return clob</span></div></div><div class=\"TTSummary\">See PIT_ADMIN.get_installation_script</div></div>",448:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype448\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> create_translation_xml(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_target_language&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_language.pml_name<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pmg_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_target&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_file_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_util.ora_name_type,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_xliff&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">out nocopy</span> xmltype</td><td></td><td class=\"last\"></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PIT_ADMIN.create_translation_xml</div></div>",510:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype510\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_translation_xml(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_target_language&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_language.pml_name<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pmg_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_target&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td></td><td class=\"last\"></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return clob</span></div></div><div class=\"TTSummary\">See PIT_ADMIN.get_translation_xml</div></div>",511:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype511\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> apply_translation(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_xliff&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> xmltype,</td></tr><tr><td class=\"PName first\">p_target&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PIT_ADMIN.apply_translation</div></div>",512:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype512\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_translation(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pml_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_message_language.pml_name<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_target&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PIT_ADMIN.delete_translation</div></div>",513:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype513\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> register_translation(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pml_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_message_language.pml_name<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See PIT_ADMIN.register_translation</div></div>"});