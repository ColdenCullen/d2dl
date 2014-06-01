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
module enki.library.d.Operator;

private import enki.types;
private import enki.library.d.Token;

Tok operatorToken[String];
String operatorXref[Tok];

static this(){
	operatorToken["/="] 	= Tok.DivAssign;
	operatorToken["/"] 		= Tok.Div;
	operatorToken["..."] 	= Tok.Elipsis;
	operatorToken[".."] 	= Tok.Slice;
	operatorToken["."] 		= Tok.Dot;
	operatorToken["&="] 	= Tok.AndAssign;
	operatorToken["&&"] 	= Tok.AndAnd;
	operatorToken["&"] 		= Tok.And;
	operatorToken["|="] 	= Tok.OrAssign;
	operatorToken["||"] 	= Tok.OrOr;
	operatorToken["|"] 		= Tok.Or;
	operatorToken["--"] 	= Tok.MinusMinus;
	operatorToken["-="] 	= Tok.MinusAssign;
	operatorToken["-"] 		= Tok.Minus;
	operatorToken["++"] 	= Tok.PlusPlus;
	operatorToken["+="] 	= Tok.PlusAssign;
	operatorToken["+"] 		= Tok.Plus;
	operatorToken["<="] 	= Tok.LessEquals;
	operatorToken["<<"] 	= Tok.LessLess;
	operatorToken["<<="] 	= Tok.LessLessEquals;
	operatorToken["<>"] 	= Tok.LessGreater;
	operatorToken["<>="] 	= Tok.LessGreaterEquals;
	operatorToken["<"] 		= Tok.Less;
	operatorToken[">>>"] 	= Tok.GreaterGreaterGreater;
	operatorToken[">>>="]	= Tok.GreaterGreaterGreaterEquals;
	operatorToken[">>="] 	= Tok.GreaterGreaterEquals;
	operatorToken[">>"] 	= Tok.GreaterGreater;
	operatorToken[">="] 	= Tok.GreaterEquals;
	operatorToken[">"] 		= Tok.Greater;
	operatorToken["!=="] 	= Tok.NotEqualsEquals;
	operatorToken["!="] 	= Tok.NotEquals;
	operatorToken["!<>"] 	= Tok.NotGreaterLess;
	operatorToken["!<>="] 	= Tok.NotGreaterLessEquals;
	operatorToken["!<"] 	= Tok.NotLess;
	operatorToken["!<="] 	= Tok.NotLessEquals;
	operatorToken["!>"] 	= Tok.NotGreater;
	operatorToken["!>="] 	= Tok.NotGreaterEquals;
	operatorToken["!~"] 	= Tok.NotCat;
	operatorToken["!"] 		= Tok.Not;
	operatorToken["("] 		= Tok.OpenParen;
	operatorToken[")"] 		= Tok.CloseParen;
	operatorToken["["] 		= Tok.OpenBracket;
	operatorToken["]"] 		= Tok.CloseBracket;
	operatorToken["{"] 		= Tok.OpenCurl;
	operatorToken["}"] 		= Tok.CloseCurl;
	operatorToken["?"] 		= Tok.Question;
	operatorToken[","]		= Tok.Comma;
	operatorToken[";"] 		= Tok.Semi;
	operatorToken[":"] 		= Tok.Colon;
	operatorToken["$"] 		= Tok.Dollar;
	operatorToken["==="] 	= Tok.EqualsEqualsEquals;
	operatorToken["=="] 	= Tok.EqualsEquals;
	operatorToken["="] 		= Tok.Equals;
	operatorToken["*="] 	= Tok.StarEquals;
	operatorToken["*"] 		= Tok.Star;
	operatorToken["%="] 	= Tok.ModEquals;
	operatorToken["%"] 		= Tok.Mod;
	operatorToken["^="] 	= Tok.InverseEquals;
	operatorToken["^"] 		= Tok.Inverse;
	operatorToken["~="] 	= Tok.CatEquals;
	operatorToken["~~"] 	= Tok.CatCat;
	operatorToken["~"]    	= Tok.Cat;
	
	foreach(key,value; operatorToken){
		operatorXref[value] = key;
	}	
}