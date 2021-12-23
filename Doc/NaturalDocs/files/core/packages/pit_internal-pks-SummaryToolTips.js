﻿NDSummary.OnToolTipsLoaded("File:core/packages/pit_internal.pks",{227:"<div class=\"NDToolTip TClass LSQL\"><div class=\"TTSummary\">Declares the core PIT logic. This package is called by PIT as the API for PIT_PKG only.</div></div>",229:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype229\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> initialize</div></div><div class=\"TTSummary\">Initialization procedure.</div></div>",231:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype231\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> check_datatype(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_value&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_type&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_format_mask&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_accept_null&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in boolean</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">Implements a data type check for a given VARCHAR2 value.</div></div>",232:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype232\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> enter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_action&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.ora_name_type,</td></tr><tr><td class=\"PName first\">p_params&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> msg_params,</td></tr><tr><td class=\"PName first\">p_trace_level&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in pls_integer</span>,</td></tr><tr><td class=\"PName first\">p_client_info&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Traces entering a method and maintains a call stack.</div></div>",233:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype233\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_active_message</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> message_type</div></div><div class=\"TTSummary\">Retrieves the actually instantiated message instance.</div></div>",234:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype234\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_message(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_message_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.ora_name_type,</td></tr><tr><td class=\"PName first\">p_msg_args&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> msg_args,</td></tr><tr><td class=\"PName first\">p_affected_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.max_sql_char,</td></tr><tr><td class=\"PName first\">p_error_code&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> message_type</div></div><div class=\"TTSummary\">Returns an instance of type MESSAGE_TYPE. It takes the message_name, constructs an instance of MESSAGE_TYPE and returns the message instance.</div></div>",235:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype235\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_message_text(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_message_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.ora_name_type,</td></tr><tr><td class=\"PName first\">p_msg_args&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> msg_args</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return clob</span></div></div><div class=\"TTSummary\">Returns the text of a message. It takes the message_name, constructs an instance of MESSAGE_TYPE and returns the message text.</div></div>",236:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype236\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_trans_item(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pti_pmg_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_pti_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_translatable_item.pti_id<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_msg_args&nbsp;</td><td class=\"PType last\">msg_args,</td></tr><tr><td class=\"PName first\">p_pti_pml_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_message_language.pml_name<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> pit_util.translatable_item_rec</div></div><div class=\"TTSummary\">Function to retrieve a PIT translatable item (PTI).</div></div>",237:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype237\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> handle_error(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_severity&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in pls_integer</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_message_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_util.ora_name_type</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_msg_args&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> msg_args</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_affected_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_util.max_sql_char</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_error_code&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_params&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> msg_params</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Handels an error. It takes the message_name and constructs an instance of MESSAGE_TYPE for it.&nbsp; It then calls raises an error with the respective message that can be caught by the exception block.&nbsp; Messages with severity error or fatal have an associated error called &lt;MESSAGE_NAME&gt;_ERR that can be used to capture the error.</div></div>",238:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype238\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> leave(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_trace_level&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in pls_integer</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_params&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> msg_params,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_severity&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in binary_integer</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Traces leaving a method, calculates timing information if requested and maintains a call stack.</div></div>",239:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype239\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> log_event(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_severity&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in pls_integer</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_message_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_util.ora_name_type</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_msg_args&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> msg_args</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_affected_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_util.max_sql_char</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_error_code&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Logs messages. It takes the message_name and constructs an instance of MESSAGE_TYPE for it.&nbsp; It then calls any log procedure of all active output modules and passes the message.</div></div>",240:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype240\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> log_explicit(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_message_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.ora_name_type,</td></tr><tr><td class=\"PName first\">p_affected_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.max_sql_char,</td></tr><tr><td class=\"PName first\">p_error_code&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_msg_args&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> msg_args,</td></tr><tr><td class=\"PName first\">p_log_threshold&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_message.pms_pse_id<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_log_modules&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.max_sql_char</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Logs messages regardless of log settings. It takes the message_name and constructs an instance of MESSAGE_TYPE for it. It then calls any log procedure of all active output modules and passes the message, regardless of the actual log settings.</div></div>",241:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype241\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> log_state(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_params&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> msg_params,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_severity&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_severity.pse_id<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Logs parameters. It expects an instance of MSG_PARAMS, containing variable names and their actual value. Useful if you want to log the state of variables without the context of a method call, fi to debug state within a loop.</div></div>",242:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype242\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> notify(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_message_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.ora_name_type,</td></tr><tr><td class=\"PName first\">p_affected_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.max_sql_char,</td></tr><tr><td class=\"PName first\">p_msg_args&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> msg_args,</td></tr><tr><td class=\"PName first\">p_log_threshold&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_message.pms_pse_id<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_log_modules&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.max_sql_char</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Notifies output modules.It takes the message_name and constructs an instance of MESSAGE_TYPE for it.&nbsp; It then calls any notify procedure of all active output modules and passes the message.</div></div>",243:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype243\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> print(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_message_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.ora_name_type,</td></tr><tr><td class=\"PName first\">p_msg_args&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> msg_args</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Prints a message to the output modules. Used to pass user information to the view layer.&nbsp; It takes the message_name and constructs an instance of MESSAGE_TYPE for it.&nbsp; It then calls any print procedure of all active output modules and passes the message.</div></div>",244:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype244\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> purge_log(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_date_before&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in date</span>,</td></tr><tr><td class=\"PName first\">p_severity_lower_equal&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in pls_integer</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Purges the message stack after a given point in time.</div></div>",245:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype245\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> raise_error(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_severity&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in pls_integer</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_message_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_util.ora_name_type</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_msg_args&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> msg_args</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_affected_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_util.max_sql_char</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_error_code&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Raises an error. It takes the message_name and constructs an instance of MESSAGE_TYPE for it.&nbsp; It then calls raises an error with the respective message that can be caught by the exception block.&nbsp; Messages with severity error or fatal have an associated error called &lt;MESSAGE_NAME&gt;_ERR that can be used to capture the error.</div></div>",247:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype247\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> set_context(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_context_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_log_level&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in integer</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_trace_level&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in integer</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_trace_timing&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_log_modules&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to change the settings in the global PIT_CONTEXT.</div></div>",248:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype248\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_context_value(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return varchar2</span></div></div><div class=\"TTSummary\">Method to get a context value eplicitly. Is used to retrieves sert values from the context.&nbsp; This allows for maintaining information such as a test flag in a cross session aware manner.</div></div>",249:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype249\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> set_context_value(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_value&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to set a context value eplicitly. Is used to persist arbitrary values at the context.&nbsp; This allows for maintaining information such as a test flag in a cross session aware manner.&nbsp; Setting an attribute to NULL eliminates this attribute from the context.</div></div>",251:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype251\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_collect_least_severity</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> binary_integer</div></div><div class=\"TTSummary\">Method to retrieve the actually least severity during collect mode.</div></div>",252:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype252\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_collect_mode</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">Method to read the actually set collection mode.</div></div>",253:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype253\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> set_collect_mode(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_mode&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in boolean</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to toggle PIT collection mode.</div></div>",254:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype254\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_message_collection</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> pit_message_table</div></div><div class=\"TTSummary\">Method to retrieve the collection of messages raised since setting PIT to collect mode.</div></div>"});