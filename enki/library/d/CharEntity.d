/+
    Copyright (c) 2006 Eric Anderton
    Permission is hereby granted, free of charge, to any person
    obtaining a copy of this software and associated documentation
    files (the "Software"), to deal in the Software without
    restriction, including without limitation the rights to use,
    copy, modify, merge, publish, distribute, sublicense, and/or
    sell copies of the Software, and to permit persons to whom the
    Software is furnished to do so, subject to the following
    conditions:

    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
    OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
    NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
    HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
    WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
    OTHER DEALINGS IN THE SOFTWARE.
+/
module enki.library.d.CharEntity;

private import enki.types;

String charEntity[String];
String entityXref[String];

static this(){
	charEntity["quot"]		= "&quot;";
	charEntity["amp"]		= "&amp;";
	charEntity["lt"]		= "&lt;";
	charEntity["gt"]		= "&gt;";
	charEntity["oelig"]		= "&OElig;";
	charEntity["oelig"]		= "&oelig;";
	charEntity["scaron"]	= "&Scaron;";
	charEntity["scaron"]	= "&scaron;";
	charEntity["yuml"]		= "&Yuml;";
	charEntity["circ"]		= "&circ;";
	charEntity["tilde"]		= "&tilde;";
	charEntity["ensp"]		= "&ensp;";
	charEntity["emsp"]		= "&emsp;";
	charEntity["thinsp"]	= "&thinsp;";
	charEntity["zwnj"]		= "&zwnj;";
	charEntity["zwj"]		= "&zwj;";
	charEntity["lrm"]		= "&lrm;";
	charEntity["rlm"]		= "&rlm;";
	charEntity["ndash"]		= "&ndash;";
	charEntity["mdash"]		= "&mdash;";
	charEntity["lsquo"]		= "&lsquo;";
	charEntity["rsquo"]		= "&rsquo;";
	charEntity["sbquo"]		= "&sbquo;";
	charEntity["ldquo"]		= "&ldquo;";
	charEntity["rdquo"]		= "&rdquo;";
	charEntity["bdquo"]		= "&bdquo;";
	charEntity["dagger"]	= "&dagger;";
	charEntity["dagger"]	= "&Dagger;";
	charEntity["permil"]	= "&permil;";
	charEntity["lsaquo"]	= "&lsaquo;";
	charEntity["rsaquo"]	= "&rsaquo;";
	charEntity["euro"]		= "&euro;";

	//Latin-1 (ISO-8859-1) Entities

	charEntity["nbsp"]		= "&nbsp;";
	charEntity["iexcl"]		= "&iexcl;";
	charEntity["cent"]		= "&cent;";
	charEntity["pound"]		= "&pound;";
	charEntity["curren"]	= "&curren;";
	charEntity["yen"]		= "&yen;";
	charEntity["brvbar"]	= "&brvbar;";
	charEntity["sect"]		= "&sect;";
	charEntity["uml"]		= "&uml;";
	charEntity["copy"]		= "&copy;";
	charEntity["ordf"]		= "&ordf;";
	charEntity["laquo"]		= "&laquo;";
	charEntity["not"]		= "&not;";
	charEntity["shy"]		= "&shy;";
	charEntity["reg"]		= "&reg;";
	charEntity["macr"]		= "&macr;";
	charEntity["deg"]		= "&deg;";
	charEntity["plusmn"]	= "&plusmn;";
	charEntity["sup2"]		= "&sup2;";
	charEntity["sup3"]		= "&sup3;";
	charEntity["acute"]		= "&acute;";
	charEntity["micro"]		= "&micro;";
	charEntity["para"]		= "&para;";
	charEntity["middot"]	= "&middot;";
	charEntity["cedil"]		= "&cedil;";
	charEntity["sup1"]		= "&sup1;";
	charEntity["ordm"]		= "&ordm;";
	charEntity["raquo"]		= "&raquo;";
	charEntity["frac14"]	= "&frac14;";
	charEntity["frac12"]	= "&frac12;";
	charEntity["frac34"]	= "&frac34;";
	charEntity["iquest"]	= "&iquest;";
	charEntity["agrave"]	= "&Agrave;";
	charEntity["aacute"]	= "&Aacute;";
	charEntity["acirc"]		= "&Acirc;";
	charEntity["atilde"]	= "&Atilde;";
	charEntity["auml"]		= "&Auml;";
	charEntity["aring"]		= "&Aring;";
	charEntity["aelig"]		= "&AElig;";
	charEntity["ccedil"]	= "&Ccedil;";
	charEntity["egrave"]	= "&Egrave;";
	charEntity["eacute"]	= "&Eacute;";
	charEntity["ecirc"]		= "&Ecirc;";
	charEntity["euml"]		= "&Euml;";
	charEntity["igrave"]	= "&Igrave;";
	charEntity["iacute"]	= "&Iacute;";
	charEntity["icirc"]		= "&Icirc;";
	charEntity["iuml"]		= "&Iuml;";
	charEntity["eth"]		= "&ETH;";
	charEntity["ntilde"]	= "&Ntilde;";
	charEntity["ograve"]	= "&Ograve;";
	charEntity["oacute"]	= "&Oacute;";
	charEntity["ocirc"]		= "&Ocirc;";
	charEntity["otilde"]	= "&Otilde;";
	charEntity["ouml"]		= "&Ouml;";
	charEntity["times"]		= "&times;";
	charEntity["oslash"]	= "&Oslash;";
	charEntity["ugrave"]	= "&Ugrave;";
	charEntity["uacute"]	= "&Uacute;";
	charEntity["ucirc"]		= "&Ucirc;";
	charEntity["uuml"]		= "&Uuml;";
	charEntity["yacute"]	= "&Yacute;";
	charEntity["thorn"]		= "&THORN;";
	charEntity["szlig"]		= "&szlig;";
	charEntity["agrave"]	= "&agrave;";
	charEntity["aacute"]	= "&aacute;";
	charEntity["acirc"]		= "&acirc;";
	charEntity["atilde"]	= "&atilde;";
	charEntity["auml"]		= "&auml;";
	charEntity["aring"]		= "&aring;";
	charEntity["aelig"]		= "&aelig;";
	charEntity["ccedil"]	= "&ccedil;";
	charEntity["egrave"]	= "&egrave;";
	charEntity["eacute"]	= "&eacute;";
	charEntity["ecirc"]		= "&ecirc;";
	charEntity["euml"]		= "&euml;";
	charEntity["igrave"]	= "&igrave;";
	charEntity["iacute"]	= "&iacute;";
	charEntity["icirc"]		= "&icirc;";
	charEntity["iuml"]		= "&iuml;";
	charEntity["eth"]		= "&eth;";
	charEntity["ntilde"]	= "&ntilde;";
	charEntity["ograve"]	= "&ograve;";
	charEntity["oacute"]	= "&oacute;";
	charEntity["ocirc"]		= "&ocirc;";
	charEntity["otilde"]	= "&otilde;";
	charEntity["ouml"]		= "&ouml;";
	charEntity["divide"]	= "&divide;";
	charEntity["oslash"]	= "&oslash;";
	charEntity["ugrave"]	= "&ugrave;";
	charEntity["uacute"]	= "&uacute;";
	charEntity["ucirc"]		= "&ucirc;";
	charEntity["uuml"]		= "&uuml;";
	charEntity["yacute"]	= "&yacute;";
	charEntity["thorn"]		= "&thorn;";
	charEntity["yuml"]		= "&yuml;";

	//Symbols and Greek letter entities

	charEntity["fnof"]		= "&fnof;";
	charEntity["alpha"]		= "&Alpha;";
	charEntity["beta"]		= "&Beta;";
	charEntity["gamma"]		= "&Gamma;";
	charEntity["delta"]		= "&Delta;";
	charEntity["epsilon"]	= "&Epsilon;";
	charEntity["zeta"]		= "&Zeta;";
	charEntity["eta"]		= "&Eta;";
	charEntity["theta"]		= "&Theta;";
	charEntity["iota"]		= "&Iota;";
	charEntity["kappa"]		= "&Kappa;";
	charEntity["lambda"]	= "&Lambda;";
	charEntity["mu"]		= "&Mu;";
	charEntity["nu"]		= "&Nu;";
	charEntity["xi"]		= "&Xi;";
	charEntity["omicron"]	= "&Omicron;";
	charEntity["pi"]		= "&Pi;";
	charEntity["rho"]		= "&Rho;";
	charEntity["sigma"]		= "&Sigma;";
	charEntity["tau"]		= "&Tau;";
	charEntity["upsilon"]	= "&Upsilon;";
	charEntity["phi"]		= "&Phi;";
	charEntity["chi"]		= "&Chi;";
	charEntity["psi"]		= "&Psi;";
	charEntity["omega"]		= "&Omega;";
	charEntity["alpha"]		= "&alpha;";
	charEntity["beta"]		= "&beta;";
	charEntity["gamma"]		= "&gamma;";
	charEntity["delta"]		= "&delta;";
	charEntity["epsilon"]	= "&epsilon;";
	charEntity["zeta"]		= "&zeta;";
	charEntity["eta"]		= "&eta;";
	charEntity["theta"]		= "&theta;";
	charEntity["iota"]		= "&iota;";
	charEntity["kappa"]		= "&kappa;";
	charEntity["lambda"]	= "&lambda;";
	charEntity["mu"]		= "&mu;";
	charEntity["nu"]		= "&nu;";
	charEntity["xi"]		= "&xi;";
	charEntity["omicron"]	= "&omicron;";
	charEntity["pi"]		= "&pi;";
	charEntity["rho"]		= "&rho;";
	charEntity["sigmaf"]	= "&sigmaf;";
	charEntity["sigma"]		= "&sigma;";
	charEntity["tau"]		= "&tau;";
	charEntity["upsilon"]	= "&upsilon;";
	charEntity["phi"]		= "&phi;";
	charEntity["chi"]		= "&chi;";
	charEntity["psi"]		= "&psi;";
	charEntity["omega"]		= "&omega;";
	charEntity["thetasym"]	= "&thetasym;";
	charEntity["upsih"]		= "&upsih;";
	charEntity["piv"]		= "&piv;";
	charEntity["bull"]		= "&bull;";
	charEntity["hellip"]	= "&hellip;";
	charEntity["prime"]		= "&prime;";
	charEntity["prime"]		= "&Prime;";
	charEntity["oline"]		= "&oline;";
	charEntity["frasl"]		= "&frasl;";
	charEntity["weierp"]	= "&weierp;";
	charEntity["image"]		= "&image;";
	charEntity["real"]		= "&real;";
	charEntity["trade"]		= "&trade;";
	charEntity["alefsym"]	= "&alefsym;";
	charEntity["larr"]		= "&larr;";
	charEntity["uarr"]		= "&uarr;";
	charEntity["rarr"]		= "&rarr;";
	charEntity["darr"]		= "&darr;";
	charEntity["harr"]		= "&harr;";
	charEntity["crarr"]		= "&crarr;";
	charEntity["larr"]		= "&lArr;";
	charEntity["uarr"]		= "&uArr;";
	charEntity["rarr"]		= "&rArr;";
	charEntity["darr"]		= "&dArr;";
	charEntity["harr"]		= "&hArr;";
	charEntity["forall"]	= "&forall;";
	charEntity["part"]		= "&part;";
	charEntity["exist"]		= "&exist;";
	charEntity["empty"]		= "&empty;";
	charEntity["nabla"]		= "&nabla;";
	charEntity["isin"]		= "&isin;";
	charEntity["notin"]		= "&notin;";
	charEntity["ni"]		= "&ni;";
	charEntity["prod"]		= "&prod;";
	charEntity["sum"]		= "&sum;";
	charEntity["minus"]		= "&minus;";
	charEntity["lowast"]	= "&lowast;";
	charEntity["radic"]		= "&radic;";
	charEntity["prop"]		= "&prop;";
	charEntity["infin"]		= "&infin;";
	charEntity["ang"]		= "&ang;";
	charEntity["and"]		= "&and;";
	charEntity["or"]		= "&or;";
	charEntity["cap"]		= "&cap;";
	charEntity["cup"]		= "&cup;";
	charEntity["int"]		= "&int;";
	charEntity["there4"]	= "&there4;";
	charEntity["sim"]		= "&sim;";
	charEntity["cong"]		= "&cong;";
	charEntity["asymp"]		= "&asymp;";
	charEntity["ne"]		= "&ne;";
	charEntity["equiv"]		= "&equiv;";
	charEntity["le"]		= "&le;";
	charEntity["ge"]		= "&ge;";
	charEntity["sub"]		= "&sub;";
	charEntity["sup"]		= "&sup;";
	charEntity["nsub"]		= "&nsub;";
	charEntity["sube"]		= "&sube;";
	charEntity["supe"]		= "&supe;";
	charEntity["oplus"]		= "&oplus;";
	charEntity["otimes"]	= "&otimes;";
	charEntity["perp"]		= "&perp;";
	charEntity["sdot"]		= "&sdot;";
	charEntity["lceil"]		= "&lceil;";
	charEntity["rceil"]		= "&rceil;";
	charEntity["lfloor"]	= "&lfloor;";
	charEntity["rfloor"]	= "&rfloor;";
	charEntity["lang"]		= "&lang;";
	charEntity["rang"]		= "&rang;";
	charEntity["loz"]		= "&loz;";
	charEntity["spades"]	= "&spades;";
	charEntity["clubs"]		= "&clubs;";
	charEntity["hearts"]	= "&hearts;";
	charEntity["diams"]		= "&diams;";
	
	
	foreach(key,value; charEntity){
		entityXref[value] = key;
	}		
}