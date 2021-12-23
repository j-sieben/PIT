﻿NDSummary.OnToolTipsLoaded("SQLClass:PIT_INTERNAL_Body",{348:"<div class=\"NDToolTip TClass LSQL\"><div class=\"TTSummary\">Implements the core PIT logic.</div></div>",350:"<div class=\"NDToolTip TType LSQL\"><div class=\"TTSummary\">Subtype of VARCHAR2, limited to 64 byte.</div></div>",560:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype560\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> load_adapter</div></div><div class=\"TTSummary\">Loads and instantiates an adapter to read client information.</div></div>",562:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype562\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_language</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return varchar2</span></div></div><div class=\"TTSummary\">Helper method to retrieve the actual session language</div></div>",563:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype563\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> push_message(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_message&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> message_type</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Pushes a method on the message stack if in message collection mode.</div></div>",564:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype564\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> raise_event(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_event&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in pls_integer</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_message&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> message_type</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_call_stack&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_call_stack_type</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_log_state&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_log_state_type</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_context&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_context_type</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_date_before&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in date</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_severity_lower_equal&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in pls_integer</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Central method to distribute any message to all actively parameterized output modules.&nbsp; Called internally as a generic helper to throw messages to output modules</div></div>",565:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype565\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> set_context(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_context&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_context_type</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Helper method to set the context and raise a changed event if required</div></div>",567:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype567\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> initialize</div></div><div class=\"TTSummary\">See &lt;PIT_INTERNAL.initialize&gt;</div></div>",568:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype568\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> log_event(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_severity&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in pls_integer</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_message_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_util.ora_name_type</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_msg_args&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> msg_args</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_affected_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_util.max_sql_char</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_error_code&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See &lt;PIT_INTERNAL.log_event&gt;</div></div>",569:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype569\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> log_state(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_params&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> msg_params,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_severity&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> pit_message_severity.pse_id<span class=\"SHKeyword\">%type</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See &lt;PIT_INTERNAL.log_state&gt;</div></div>",570:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype570\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> log_explicit(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_message_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.ora_name_type,</td></tr><tr><td class=\"PName first\">p_affected_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.max_sql_char,</td></tr><tr><td class=\"PName first\">p_error_code&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_msg_args&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> msg_args,</td></tr><tr><td class=\"PName first\">p_log_threshold&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_message.pms_pse_id<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_log_modules&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.max_sql_char</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See &lt;PIT_INTERNAL.log_explicit&gt;</div></div>",571:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype571\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> enter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_action&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.ora_name_type,</td></tr><tr><td class=\"PName first\">p_params&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> msg_params,</td></tr><tr><td class=\"PName first\">p_trace_level&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in pls_integer</span>,</td></tr><tr><td class=\"PName first\">p_client_info&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See &lt;PIT_INTERNAL.enter&gt;</div></div>",572:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype572\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> leave(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_trace_level&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in pls_integer</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_params&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> msg_params,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_severity&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in binary_integer</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See &lt;PIT_INTERNAL.leave&gt;</div></div>",573:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype573\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> print(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_message_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.ora_name_type,</td></tr><tr><td class=\"PName first\">p_msg_args&nbsp;</td><td class=\"PType last\">msg_args</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See &lt;PIT_INTERNAL.print&gt;</div></div>",574:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype574\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> notify(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_message_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.ora_name_type,</td></tr><tr><td class=\"PName first\">p_affected_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.max_sql_char,</td></tr><tr><td class=\"PName first\">p_msg_args&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> msg_args,</td></tr><tr><td class=\"PName first\">p_log_threshold&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_message.pms_pse_id<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_log_modules&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.max_sql_char</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See &lt;PIT_INTERNAL.notify&gt;</div></div>",575:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype575\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> raise_error(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_severity&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in pls_integer</span>,</td></tr><tr><td class=\"PName first\">p_message_name&nbsp;</td><td class=\"PType last\">pit_util.ora_name_type,</td></tr><tr><td class=\"PName first\">p_msg_args&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> msg_args,</td></tr><tr><td class=\"PName first\">p_affected_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.max_sql_char,</td></tr><tr><td class=\"PName first\">p_error_code&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See &lt;PIT_INTERNAL.raise_error&gt;</div></div>",576:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype576\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> handle_error(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_severity&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in pls_integer</span>,</td></tr><tr><td class=\"PName first\">p_message_name&nbsp;</td><td class=\"PType last\">pit_util.ora_name_type,</td></tr><tr><td class=\"PName first\">p_msg_args&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> msg_args,</td></tr><tr><td class=\"PName first\">p_affected_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.max_sql_char,</td></tr><tr><td class=\"PName first\">p_error_code&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_params&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> msg_params</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See &lt;PIT_INTERNAL.handle_error&gt;</div></div>",577:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype577\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> purge_log(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_date_before&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in date</span>,</td></tr><tr><td class=\"PName first\">p_severity_lower_equal&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in pls_integer</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See &lt;PIT_INTERNAL.purge_log&gt;</div></div>",578:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype578\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_message(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_message_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.ora_name_type,</td></tr><tr><td class=\"PName first\">p_msg_args&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> msg_args,</td></tr><tr><td class=\"PName first\">p_affected_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.max_sql_char,</td></tr><tr><td class=\"PName first\">p_error_code&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> message_type</div></div><div class=\"TTSummary\">See &lt;PIT_INTERNAL.get_message&gt;</div></div>",579:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype579\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_active_message</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> message_type</div></div><div class=\"TTSummary\">See &lt;PIT_INTERNAL.get_active_message&gt;</div></div>",580:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype580\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> check_datatype(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_value&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_type&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_format_mask&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_accept_null&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in boolean</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">See &lt;PIT_INTERNAL.check_datatype&gt;</div></div>",581:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype581\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_message_text(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_message_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_util.ora_name_type,</td></tr><tr><td class=\"PName first\">p_msg_args&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> msg_args</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return clob</span></div></div><div class=\"TTSummary\">See &lt;PIT_INTERNAL.get_message_text&gt;</div></div>",582:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype582\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_trans_item(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_pti_pmg_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_message_group.pmg_name<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_pti_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_translatable_item.pti_id<span class=\"SHKeyword\">%type</span>,</td></tr><tr><td class=\"PName first\">p_msg_args&nbsp;</td><td class=\"PType last\">msg_args,</td></tr><tr><td class=\"PName first\">p_pti_pml_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_message_language.pml_name<span class=\"SHKeyword\">%type</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> pit_util.translatable_item_rec</div></div><div class=\"TTSummary\">See &lt;PIT_INTERNAL.get_trans_item&gt;</div></div>",583:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype583\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> set_context(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_context_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_log_level&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in integer</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_trace_level&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in integer</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_trace_timing&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_log_modules&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See &lt;PIT_INTERNAL.set_context&gt;</div></div>",584:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype584\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> set_context_value(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_value&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See &lt;PIT_INTERNAL.set_context_value&gt;</div></div>",585:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype585\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_context_value(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return varchar2</span></div></div><div class=\"TTSummary\">See &lt;PIT_INTERNAL.get_context_value&gt;</div></div>",586:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype586\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> set_collect_mode(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_mode&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in boolean</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">See &lt;PIT_INTERNAL.set_collect_mode&gt;</div></div>",587:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype587\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_collect_mode</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return boolean</span></div></div><div class=\"TTSummary\">See &lt;PIT_INTERNAL.get_collect_mode&gt;</div></div>",588:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype588\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_collect_least_severity</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> binary_integer</div></div><div class=\"TTSummary\">See &lt;PIT_INTERNAL.get_collect_least_severity&gt;</div></div>",589:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype589\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_message_collection</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> pit_message_table</div></div><div class=\"TTSummary\">See &lt;PIT_INTERNAL.get_message_collection&gt;</div></div>"});