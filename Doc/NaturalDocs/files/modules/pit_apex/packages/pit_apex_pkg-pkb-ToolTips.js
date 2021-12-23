﻿NDContentPage.OnToolTipsLoaded({53:"<div class=\"NDToolTip TType LSQL\"><div class=\"TTSummary\">Core message type. Is used to collect the message, severity and other useful information around messages</div></div>",60:"<div class=\"NDToolTip TType LSQL\"><div class=\"TTSummary\">Is used to collect a call stack entry</div></div>",372:"<div class=\"NDToolTip TClass LSQL\"><div class=\"TTSummary\">PIT-API package. Declares the API that is required to use PIT.</div></div>",511:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype511\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">function</span> get_apex_triggered_context</div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return varchar2</span></div></div><div class=\"TTSummary\">Method to retrieve the name of the context that is used for logging if APEX is set to DEBUG mode.&nbsp; Is called from the APEX session adapter PIT_APEX_ADAPTER</div></div>",512:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype512\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> log(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_message&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> message_type</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to write log information to the APEX debug stack.&nbsp; Method implements the PIT_APEX.log member procedure and writes the message attributes to the APEX debug stack.</div></div>",608:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype608\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> print(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_message&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> message_type</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to write general information to the APEX application.&nbsp; Method implements the PIT_APEX.print member procedure of type PIT_APEX and writes the message attributes to the APEX http stream.</div></div>",637:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype637\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> notify(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_message&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> message_type</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to write log information to the APEX application.</div></div>",638:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype638\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> enter(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_call_stack&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_call_stack_type</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to write call stack information on enter to the APEX debug stack.</div></div>",639:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype639\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> leave(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_call_stack&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> pit_call_stack_type</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to write call stack information on leave to the APEX debug stack.</div></div>",640:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype640\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> initialize_module(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">self&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> pit_apex</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Initialization method for &lt;PIT_MODULE.PIT_APEX&gt; output module.</div></div>",646:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype646\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> initialize_module(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">self&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> pit_apex</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">see PIT_APEX_PKG.initialize_module</div></div>",647:"<div class=\"NDToolTip TClass LSQL\"><div class=\"TTSummary\">Output module for an APEX environment. Extends PIT_MODULE.</div></div>"});