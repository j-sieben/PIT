﻿NDContentPage.OnToolTipsLoaded({116:"<div class=\"NDToolTip TType LSQL\"><div class=\"TTSummary\">List type of MESSAGE_TYPE, used to collect messages on a stack</div></div>",507:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype507\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> export_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_target&nbsp;</td><td class=\"PType last\">pit_util.ora_name_type,</td></tr><tr><td class=\"PName first\">p_group_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.ora_name_type,</td></tr><tr><td class=\"PName first\">p_target_language&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.ora_name_type,</td></tr><tr><td class=\"PName first\">p_script&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">out nocopy clob</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to create a script for all parameters within a parameter group as a clob instance.</div></div>",509:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype509\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> translate_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_target_language&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_language.pml_name<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pmg_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_target&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_file_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_util.ora_name_type,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_xliff&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">out nocopy</span> xmltype</td><td></td><td class=\"last\"></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to generate an XML file in format XLIFF to translate items.</div></div>",668:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype668\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_pit_message_table</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> pit_message_table <span class=\"SHMetadata\">pipelined</span></div></div><div class=\"TTSummary\">Method to return the content of PIT_MESSAGE</div></div>",669:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype669\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_parameter_type_table</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> parameter_type_table <span class=\"SHMetadata\">pipelined</span></div></div><div class=\"TTSummary\">Method to return the content of PARAMETER_TYPE</div></div>",670:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype670\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_parameter_realm_table</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> parameter_realm_table <span class=\"SHMetadata\">pipelined</span></div></div><div class=\"TTSummary\">Method to return the content of PARAMETER_REALM</div></div>",671:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype671\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_parameter_realm_view</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> parameter_realm_v_table <span class=\"SHMetadata\">pipelined</span></div></div><div class=\"TTSummary\">Method to return the content of PARAMETER_REALM_V</div></div>",672:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype672\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_parameter_group_table</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> parameter_group_table <span class=\"SHMetadata\">pipelined</span></div></div><div class=\"TTSummary\">Method to return the content of PARAMETER_GROUP</div></div>",673:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype673\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_parameter_table</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> parameter_table <span class=\"SHMetadata\">pipelined</span></div></div><div class=\"TTSummary\">Method to return the content of PARAMETER</div></div>",674:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype674\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_pit_message_language_table</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> pit_message_language_table <span class=\"SHMetadata\">pipelined</span></div></div><div class=\"TTSummary\">Method to return the content of PIT_MESSAGE_LANGUAGE_V</div></div>",676:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype676\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_pit_message_group_table</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> pit_message_group_table <span class=\"SHMetadata\">pipelined</span></div></div><div class=\"TTSummary\">Method to return the content of PIT_MESSAGE_GROUP</div></div>",677:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype677\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_pit_trace_level_table</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> pit_trace_level_table <span class=\"SHMetadata\">pipelined</span></div></div><div class=\"TTSummary\">Method to return the content of PIT_TRACE_LEVEL_V</div></div>",679:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype679\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> allows_toggles</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">Metho d to check whether toggles are actually allowed.</div></div>",680:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype680\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> apply_translation(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_xliff&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> xmltype,</td></tr><tr><td class=\"PName first\">p_target&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to import translated items into the database.</div></div>",681:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype681\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> check_name(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_util.ora_name_type,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_prefix&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return varchar2</span></div></div><div class=\"TTSummary\">Method to check whether a name conforms to the internal naming standards.&nbsp; Is used as a wrapper to reduce code on various validate methods</div></div>",682:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype682\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> create_named_context(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_context_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_log_level&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in number</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_trace_level&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in number</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_trace_timing&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_module_list&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_comment&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to create a named context to control debug settings.</div></div>",683:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype683\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_realm</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return varchar2</span></div></div><div class=\"TTSummary\">Retrieve the actually set realm</div></div>",684:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype684\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> has_translatable_items</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">Method to check whether translatable items are present. Is used to toggle the visibility of a region.</div></div>",685:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype685\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> has_local_parameters</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">Method to check whether local parameters are present. Is used to toggle the visibility of a region.</div></div>",686:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype686\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> parameter_group_is_modifiable(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pgr_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_name_type</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> pit_flag_type</div></div><div class=\"TTSummary\">Method checks whether the parameter group requested is modifiable</div></div>",687:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype687\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_context_toggle(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_toggle_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to remove a context toggle</div></div>",688:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype688\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_pit_message(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pms_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message.pms_name<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_pms_pml_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_language.pml_name<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to delete a single pit_message. Will delete all translations as well. Is called to remove mistyped or unnecessary messages in all languages. Will not commit nor re-create the MSG package.</div></div>",689:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype689\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_pit_message_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pmg_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_force&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\">false</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to delete a message group. Does not delete a message group if messages exists within that group, unless specified by setting the &lt;P_FORCE&gt; parameter to true. Will not commit nor re-create the MSG package.</div></div>",690:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype690\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_named_context(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_context_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to delete a named context</div></div>",691:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype691\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_parameter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_par_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_v.par_id<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_par_pgr_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_v.par_pgr_id<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to delete a parameter</div></div>",692:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype692\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_parameter_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pgr_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_group.pgr_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_force&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\">false</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to delete a parameter group.</div></div>",693:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype693\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_parameter_realm(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pre_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> parameter_realm.pre_id<span class=\"SHKeyword\">%type</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_force&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\">false</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to delete a parameter realm</div></div>",694:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype694\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_realm_parameter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_par_id&nbsp;</td><td class=\"PType last\">parameter_v.par_id<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_par_pgr_id&nbsp;</td><td class=\"PType last\">parameter_v.par_pgr_id<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_par_pre_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_realm.pre_id<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Resets a realm parameter to the default value</div></div>",696:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype696\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> merge_context_toggle(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_toggle_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_module_list&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_context_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_comment&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to create a context toggle. Is called to have PIT toggle it\'s context settings based on entering a module or a list of modules. A toggle switches the debug settings if the package or procedure mentioned in the toggle is entered.</div></div>",697:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype697\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> merge_message(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> pit_message_rowtype</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to merge a message. Overload with a row record.</div></div>",698:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype698\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_message(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> pit_message_rowtype</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to delete a message. Overload with a row record.</div></div>",699:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype699\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> merge_message_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> pit_message_group_rowtype</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to maintain a message group.</div></div>",700:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype700\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> delete_message_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_message_group_rowtype,</td></tr><tr><td class=\"PName first\">p_force&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in boolean</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to delete a message group. Overload with a row record.</div></div>",701:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype701\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> merge_parameter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_v_rowtype</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to edit a parameter</div></div>",702:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype702\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> merge_parameter_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_group_rowtype</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to change the definition of a parameter group.</div></div>",703:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype703\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> merge_parameter_realm(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_realm_rowtype</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to change the definition of a parameter realm.</div></div>",704:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype704\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> merge_realm_parameter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_v_rowtype</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Sets a realm parameter value.</div></div>",705:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype705\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> set_allow_toggles(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_allowed&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in boolean</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to set the allow toggle switch.</div></div>",706:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype706\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> set_language_settings(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pml_list&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.max_sql_char</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to set default language settings.</div></div>",708:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype708\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> validate_context_toggle(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_toggle_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> pit_util.ora_name_type,</td></tr><tr><td class=\"PName first\">p_context_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> pit_util.ora_name_type,</td></tr><tr><td class=\"PName first\">p_module_list&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.max_sql_char</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to check whether a toggle has valid settings</div></div>",709:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype709\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> validate_data_type(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> parameter_v_rowtype</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to check whether a parameter value conforms to the parameter data types.</div></div>",710:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype710\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> validate_message_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> pit_message_group_rowtype</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to check whether a PIT message group is valid.</div></div>",711:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype711\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> validate_message(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> pit_message_rowtype</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to check whether a PIT message is valid.</div></div>",712:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype712\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> validate_parameter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> parameter_v_rowtype</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to validate a parameter if a validation string exists</div></div>",713:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype713\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> validate_parameter_group(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> parameter_group_rowtype</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to validate a parameter group entry prior to writing it to db</div></div>",714:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype714\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> validate_realm_parameter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_row&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> parameter_v_rowtype</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to validate a realm based parameter if a validation string exists.</div></div>"});