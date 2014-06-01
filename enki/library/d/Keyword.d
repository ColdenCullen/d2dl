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
module enki.library.d.Keyword;

private import enki.types;
private import enki.library.d.Token;

Tok keywordToken[String];
String keywordXref[Tok];

static this(){
	keywordToken["abstract"]	= Tok.Abstract;
	keywordToken["alias"] 		= Tok.Alia;
	keywordToken["align"] 		= Tok.Align;
	keywordToken["asm"] 		= Tok.Asm;
	keywordToken["assert"] 		= Tok.Assert;
	keywordToken["auto"] 		= Tok.Auto;
	keywordToken["body"] 		= Tok.Body;
	keywordToken["bool"] 		= Tok.Bool;
	keywordToken["break"] 		= Tok.Break;
	keywordToken["byte"] 		= Tok.Byte;
	keywordToken["case"] 		= Tok.Case;
	keywordToken["cast"] 		= Tok.Cast;
	keywordToken["catch"] 		= Tok.Catch;
	keywordToken["cdouble"] 	= Tok.Cdouble;
	keywordToken["cent"] 		= Tok.Cent;
	keywordToken["cfloat"] 		= Tok.Cfloat;
	keywordToken["char"] 		= Tok.Char;
	keywordToken["class"] 		= Tok.Cla;
	keywordToken["const"] 		= Tok.Const;
	keywordToken["continue"] 	= Tok.Continue;
	keywordToken["creal"] 		= Tok.Creal;
	keywordToken["dchar"] 		= Tok.Dchar;
	keywordToken["debug"] 		= Tok.Debug;
	keywordToken["default"] 	= Tok.Default;
	keywordToken["delegate"] 	= Tok.Delegate;
	keywordToken["delete"] 		= Tok.Delete;
	keywordToken["deprecated"] 	= Tok.Deprecated;
	keywordToken["do"] 			= Tok.Do;
	keywordToken["double"] 		= Tok.Double;
	keywordToken["else"] 		= Tok.Else;
	keywordToken["enum"] 		= Tok.Enum;
	keywordToken["export"] 		= Tok.Export;
	keywordToken["extern"] 		= Tok.Extern;
	keywordToken["false"] 		= Tok.False;
	keywordToken["final"] 		= Tok.Final;
	keywordToken["finally"] 	= Tok.Finally;
	keywordToken["float"] 		= Tok.Float;
	keywordToken["for"] 		= Tok.For;
	keywordToken["foreach"] 	= Tok.Foreach;
	keywordToken["function"] 	= Tok.Function;
	keywordToken["goto"] 		= Tok.Goto;
	keywordToken["idouble"] 	= Tok.Idouble;
	keywordToken["if"] 			= Tok.If;
	keywordToken["ifloat"] 		= Tok.Ifloat;
	keywordToken["import"] 		= Tok.Import;
	keywordToken["in"] 			= Tok.In;
	keywordToken["inout"] 		= Tok.Inout;
	keywordToken["int"] 		= Tok.Int;
	keywordToken["interface"] 	= Tok.Interface;
	keywordToken["invariant"] 	= Tok.Invariant;
	keywordToken["ireal"] 		= Tok.Ireal;
	keywordToken["is"] 			= Tok.Is;
	keywordToken["long"] 		= Tok.Long;
	keywordToken["mixin"] 		= Tok.Mixin;
	keywordToken["module"] 		= Tok.Module;
	keywordToken["new"] 		= Tok.New;
	keywordToken["null"] 		= Tok.Null;
	keywordToken["out"] 		= Tok.Out;
	keywordToken["override"] 	= Tok.Override;
	keywordToken["package"] 	= Tok.Package;
	keywordToken["pragma"] 		= Tok.Pragma;
	keywordToken["private"] 	= Tok.Private;
	keywordToken["protected"] 	= Tok.Protected;
	keywordToken["public"] 		= Tok.Public;
	keywordToken["real"] 		= Tok.Real;
	keywordToken["return"] 		= Tok.Return;
	keywordToken["scope"] 		= Tok.Scope;
	keywordToken["short"] 		= Tok.Short;
	keywordToken["static"] 		= Tok.Static;
	keywordToken["struct"] 		= Tok.Struct;
	keywordToken["super"] 		= Tok.Super;
	keywordToken["switch"] 		= Tok.Switch;
	keywordToken["synchronized"]= Tok.Synchronized;
	keywordToken["template"] 	= Tok.Template;
	keywordToken["this"] 		= Tok.Thi;
	keywordToken["throw"] 		= Tok.Throw;
	keywordToken["true"] 		= Tok.True;
	keywordToken["try"] 		= Tok.Try;
	keywordToken["typedef"] 	= Tok.Typedef;
	keywordToken["typeid"] 		= Tok.Typeid;
	keywordToken["typeof"] 		= Tok.Typeof;
	keywordToken["ubyte"] 		= Tok.Ubyte;
	keywordToken["ucent"] 		= Tok.Ucent;
	keywordToken["uint"] 		= Tok.UInt;
	keywordToken["ulong"] 		= Tok.Ulong;
	keywordToken["union"] 		= Tok.Union;
	keywordToken["unittest"] 	= Tok.Unittest;
	keywordToken["ushort"] 		= Tok.Ushort;
	keywordToken["version"] 	= Tok.Version;
	keywordToken["void"] 		= Tok.Void;
	keywordToken["volatile"] 	= Tok.Volatile;
	keywordToken["wchar"] 		= Tok.Wchar;
	keywordToken["while"] 		= Tok.While;
	keywordToken["with"]		= Tok.With;
	
	foreach(key,value; keywordToken){
		keywordXref[value] = key;
	}
}