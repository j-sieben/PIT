﻿NDSummary.OnToolTipsLoaded("File:context/packages/utl_context.pks",{38:"<div class=\"NDToolTip TClass LSQL\"><div class=\"TTSummary\">Generic maintenance of globally accessed contexts.</div></div>",48:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype48\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> set_value(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_context&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_attribute&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_value&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in varchar2</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_client_id&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">varchar2</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Sets a parameter value for a given parameter in the context requested. When using the &lt;p_client_id&gt; attribute, a parameter may be set for a given session only and be invisible to other sessions.</div></div>",49:"<div class=\"NDToolTip TFunction LSQL\"><div class=\"TTSummary\">Reads a parameter value for a given parameter from the context requested. When using the &lt;p_client_id&gt; attribute, a parameter may be read that is private for a given session.</div></div>",50:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype50\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> reset_context(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_context&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Procedure to reset one of the available contexts.</div></div>"});