﻿NDContentPage.OnToolTipsLoaded({109:"<div class=\"NDToolTip TType LSQL\"><div class=\"TTSummary\">CHAR based version of MSG_ARGS. Required if params are to be saved in a table.</div></div>",111:"<div class=\"NDToolTip TType LSQL\"><div class=\"TTSummary\">List type of MESSAGE_TYPE, used to collect messages on a stack</div></div>",122:"<div class=\"NDToolTip TType LSQL\"><div class=\"TTSummary\">Array of up to 50 entries of type &lt;ora_name_type&gt;.&nbsp; Is used to pass in a variable&nbsp; list of parameter values</div></div>",141:"<div class=\"NDToolTip TType LSQL\"><div class=\"TTSummary\">Basic array of MESSAGE_TYPE parameters</div></div>",143:"<div class=\"NDToolTip TType LSQL\"><div class=\"TTSummary\">Table of msg_param instances.</div></div>",147:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype147\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">constructor function</span> pit_context_type(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">self&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> pit_context_type</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> self</div></div><div class=\"TTSummary\">Parameterless constructor method to create a new instance</div></div>",155:"<div class=\"NDToolTip TType LSQL\"><div class=\"TTSummary\">List type of PIT_MODULE_META</div></div>",168:"<div class=\"NDToolTip TType LSQL\"><div class=\"TTSummary\">Core message type. Is used to collect the message, severity and other useful information around messages</div></div>",174:"<div class=\"NDToolTip TClass LSQL\"><div class=\"TTSummary\">Auto generated package holding constants for any PIT message.</div></div>",248:"<div class=\"NDToolTip TType LSQL\"><div class=\"TTSummary\">Record to grant access to a translatable item</div></div>",653:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype653\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> log(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_message_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_msg_args&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> msg_args</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_affected_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_affected_ids&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> msg_params</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_error_code&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_log_threshold&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in number</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_log_modules&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Logs a message regardless of the actual log settings.</div></div>",655:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype655\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> sql_exception(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_message_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_msg_args&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> msg_args</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_affected_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_affected_ids&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> msg_params</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_error_code&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_params&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> msg_params</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Exception handler that handles an error and calls leave</div></div>",656:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype656\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> handle_exception(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_message_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_msg_args&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> msg_args</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_affected_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_affected_ids&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> msg_params</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_error_code&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_params&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> msg_params</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Exception handler that handles an error and calls leave</div></div>",657:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype657\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> stop(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_message_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_msg_args&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> msg_args</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_affected_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_affected_ids&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> msg_params</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_error_code&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_params&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> msg_params</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Exception handler that handles an error, calls leave and re-raises the error</div></div>",663:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype663\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> enter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_action&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_params&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> msg_params</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_trace_level&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in number</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\">pit.trace_all,</td></tr><tr><td class=\"PName first\">p_client_info&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Traces entering a method, level &lt;trace_all&gt; or &lt;p_trace_level&gt;</div></div>",667:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype667\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> leave(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_trace_level&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in number</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\">pit.trace_all,</td></tr><tr><td class=\"PName first\">p_params&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> msg_params</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Traces leaving a method, level &lt;trace_all&gt; o &lt;p_trace_level&gt;</div></div>",670:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype670\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> print (</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_message_name&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_msg_args&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> msg_args</td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Passes a message to the view layer.</div></div>",704:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype704\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> reset_context(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_active_session_only&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in boolean</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\">true</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Resets the trace context for the active session to the default values.</div></div>",706:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype706\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> stop_message_collection</div></div><div class=\"TTSummary\">Switches PIT collection mode off</div></div>",709:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype709\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_message_collection</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> pit_message_table</div></div><div class=\"TTSummary\">Retrieves the collection of messages raised since setting PIT to collect mode.</div></div>"});