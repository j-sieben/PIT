﻿NDSummary.OnToolTipsLoaded("File:core/packages/pit_call_stack.pks",{219:"<div class=\"NDToolTip TClass LSQL\"><div class=\"TTSummary\">Helper package to implement the Call Stack functionality for PIT.</div></div>",221:"<div class=\"NDToolTip TType LSQL\"><div class=\"TTSummary\">Type to store a list of pit_call_stack_type instances. Indexed by binary_integer.</div></div>",223:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype223\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> initialize</div></div><div class=\"TTSummary\">Method to initialize the package. Is called during &lt;PIT_INTERNAL&gt; package initialization</div></div>",224:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype224\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> push_stack(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_user_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_session_id&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_module&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_action&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_client_info&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_params&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> msg_params,</td></tr><tr><td class=\"PName first\">p_trace_level&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in binary_integer</span>,</td></tr><tr><td class=\"PName first\">p_trace_context&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_context_type</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> pit_call_stack_type</div></div><div class=\"TTSummary\">Method to push an entry to the call stack. Called from the ENTER method.</div></div>",225:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype225\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> pop_stack(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_params&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> msg_params,</td></tr><tr><td class=\"PName first\">p_severity&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in binary_integer</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return</span> pit_call_stack_tab</div></div><div class=\"TTSummary\">Method to pop one or more entries from the call stack. Called from &lt;LEAVE&gt;-method.</div></div>",226:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype226\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> long_op(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_sofar&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in number</span>,</td></tr><tr><td class=\"PName first\">p_total&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in number</span>,</td></tr><tr><td class=\"PName first\">p_target&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_units&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_op_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Sets dbms_application_info.</div></div>"});