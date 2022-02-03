﻿NDContentPage.OnToolTipsLoaded({178:"<div class=\"NDToolTip TType LSQL\"><div class=\"TTSummary\">Core message type. Is used to collect the message, severity and other useful information around messages</div></div>",548:"<div class=\"NDToolTip TClass LSQL\"><div class=\"TTSummary\">PIT-API package. Declares the API that is required to use PIT.</div></div>",933:"<div class=\"NDToolTip TClass LSQL\"><div class=\"TTSummary\">Output module to send debug messages per mail. Extends PIT_MODULE.</div></div>",948:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype948\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">procedure</span> send_daily</div></div><div class=\"TTSummary\">Method sends messages of severity greater than LEVEL_FATAL on a daily basis.</div></div>",949:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype949\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> log (</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_message&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in</span> message_type</td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to send log information per mail.</div></div>",950:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype950\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> purge(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_date_until&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in date</span>,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_severity_greater_equal&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in number</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">Method to purge log information from table &lt;PIT_MAIL_QUEUE&gt; according to the filter set by &lt;P_DATE_UNTIL&gt; and &lt;P_SEVERITY_GREATER_EQUAL&gt;.</div></div>",959:"<div class=\"NDToolTip TClass LSQL\"><div class=\"TTSummary\">Package to wrap sending mails via UTL_SMTP</div></div>",1046:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype1046\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> prepare_message(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_message&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in</span> message_type,</td><td></td><td class=\"last\"></td></tr><tr><td class=\"PName first\">p_amount&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in number</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_first_date&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in date</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span>,</td></tr><tr><td class=\"PName first\">p_last_date&nbsp;</td><td class=\"PType\"><span class=\"SHKeyword\">in date</span></td><td class=\"PDefaultValueSeparator\">&nbsp;<span class=\"SHKeyword\">default</span>&nbsp;</td><td class=\"PDefaultValue last\"><span class=\"SHKeyword\">null</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return clob</span></div></div><div class=\"TTSummary\">Method to convert a MESSAGE_TYPE.message into a string. Is used to cast a message text into a CLOB text instance</div></div>"});