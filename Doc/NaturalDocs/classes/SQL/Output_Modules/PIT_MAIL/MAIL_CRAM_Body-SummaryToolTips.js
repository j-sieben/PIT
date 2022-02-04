﻿NDSummary.OnToolTipsLoaded("SQLClass:Output_Modules.PIT_MAIL.MAIL_CRAM_Body",{938:"<div class=\"NDToolTip TClass LSQL\"><div class=\"TTSummary\">Package to allow to authenticate to a CRAM SMTP server</div></div>",940:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype940\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">function</span> get_auth_string(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_user&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_password&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_challenge&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_hash_method&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">return varchar2</span></div></div><div class=\"TTSummary\">Method to create an authorization string. Is used to form an authorization string based on the hash method chosen</div></div>",942:"<div class=\"NDToolTip TFunction LSQL\"><div id=\"NDPrototype942\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection PascalStyle\"><table><tr><td class=\"PBeforeParameters\"><span class=\"SHKeyword\">procedure</span> authenticate(</td><td class=\"PParametersParentCell\"><table class=\"PParameters\"><tr><td class=\"PName first\">p_conn&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in out nocopy</span> utl_smtp.connection,</td></tr><tr><td class=\"PName first\">p_hash_method&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_user_name&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span>,</td></tr><tr><td class=\"PName first\">p_password&nbsp;</td><td class=\"PType last\"><span class=\"SHKeyword\">in varchar2</span></td></tr></table></td><td class=\"PAfterParameters\">)</td></tr></table></div></div><div class=\"TTSummary\">see: MAIL_CRAM.authenticate</div></div>"});