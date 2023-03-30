﻿NDContentPage.OnToolTipsLoaded({109:"<div class=\"NDToolTip TType LSQL\"><div class=\"TTSummary\">CHAR based version of MSG_ARGS. Required if params are to be saved in a table.</div></div>",122:"<div class=\"NDToolTip TType LSQL\"><div class=\"TTSummary\">Array of up to 50 entries of type &lt;ora_name_type&gt;.&nbsp; Is used to pass in a variable&nbsp; list of parameter values</div></div>",141:"<div class=\"NDToolTip TType LSQL\"><div class=\"TTSummary\">Basic array of MESSAGE_TYPE parameters</div></div>",153:"<div class=\"NDToolTip TType LSQL\"><div class=\"TTSummary\">Basic char table, used in many methods</div></div>",259:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype259\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_call_stack</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return varchar2</span></div></div><div class=\"TTSummary\">Wrapper around UTL_CALL_STACK to get the call stack</div></div>",260:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype260\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_error_stack</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return varchar2</span></div></div><div class=\"TTSummary\">Wrapper around UTL_CALL_STACK to get the call stack</div></div>",261:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype261\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> get_module_and_action(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_module&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy varchar2</span>,</td></tr><tr><td class=\"PName first\">p_action&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Reads module and action from UTL_CALL_STACK</div></div>",262:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype262\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_user</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> ora_name_type</div></div><div class=\"TTSummary\">Getter for SYS.STANDARD-USER to avoid SQL environment changes</div></div>",263:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype263\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> check_error_number_exists(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pms_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_message.pms_name<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_pms_custom_error&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_message.pms_custom_error<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> predefined_error_rec</div></div><div class=\"TTSummary\">Method to check whether an Oracle error number is already a named error</div></div>",264:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype264\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_max_message_length(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pmg_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> binary_integer</div></div><div class=\"TTSummary\">Method retrieves the maximum length of a message for a given message group.</div></div>",266:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype266\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> bulk_replace(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_string&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_chunks&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> char_table</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return varchar2</span></div></div><div class=\"TTSummary\">Helper to bulk-replace chunks in a text. Is called to replace more replacement anchors at once</div></div>",267:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype267\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> clob_append(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_clob&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy clob</span>,</td></tr><tr><td class=\"PName first\">p_chunk&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in clob</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Helper to append CLOB. Wrapper for DBMS_LOB.APPEND that takes care to instantiate P_CLOB if it\'s not yet there and append only if P_CHUNK is not null</div></div>",268:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype268\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> concatenate(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_chunk_list&nbsp;</td><td class=\"PType\">char_table,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_delimiter&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_keep_null&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\">true</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return varchar2</span></div></div><div class=\"TTSummary\">Helper to concatenate text.</div></div>",269:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype269\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> harmonize_sql_name(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_prefix&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_max_length&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">number</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return varchar2</span></div></div><div class=\"TTSummary\">Helper function to convert a SQL primary key name according to the naming convention.&nbsp; Is called to harmonize the naming of alphanumeric primary key items.</div></div>",270:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype270\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> harmonize_name(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_prefix&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return varchar2</span></div></div><div class=\"TTSummary\">Helper function to harmonize a given name.&nbsp; &lt;P_NAME&gt; will be uppercased and &lt;P_PREFIX&gt; prefixes &lt;P_NAME&gt;</div></div>",272:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype272\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> check_context_settings(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_context_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> ora_name_type,</td></tr><tr><td class=\"PName first\">p_settings&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Helper to validate named context settings. Is called to verify that entered settings are correct.</div></div>",273:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype273\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> check_toggle_settings(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_toggle_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> ora_name_type,</td></tr><tr><td class=\"PName first\">p_module_list&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_context_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> ora_name_type</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Helper to validate toggle settings.&nbsp; Is called from PIT_ADMIN.CREATE_CONTEXT_TOGGLE to validate settings</div></div>",275:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype275\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> cast_to_msg_args_char(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_msg_args&nbsp;</td><td class=\"PType last\">msg_args</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> msg_args_char</div></div><div class=\"TTSummary\">Methods to cast an instance of type MSG_ARGS to MSG_ARGS_CHAR.</div></div>",276:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype276\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> cast_to_msg_args(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_msg_args&nbsp;</td><td class=\"PType last\">msg_args_char</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> msg_args</div></div><div class=\"TTSummary\">Methods to cast an instance of type MSG_ARGS_CHAR to MSG_ARGS.</div></div>",277:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype277\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> string_to_table(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_string_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_delimiter&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;:=&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHString\">\':\'</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> pit_args</div></div><div class=\"TTSummary\">Helper to convert a string with a given separator into an instance of type PIT_ARGS.&nbsp; Internal helper to split a string into an array of chars.</div></div>",278:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype278\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> table_to_string(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_table&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_args,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_delimiter&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;:=&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHString\">\':\'</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return varchar2</span></div></div><div class=\"TTSummary\">Helper to convert a PIT_ARGS instance to a string with a given separator.</div></div>",279:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype279\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> to_bool(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_boolean&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in boolean</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> flag_type</div></div><div class=\"TTSummary\">Method to convert a boolean to a bool flag of type FLAG_TYPE.</div></div>",282:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype282\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> recompile_invalid_objects</div></div><div class=\"TTSummary\">Procedure to recompile invalid objects.</div></div>"});