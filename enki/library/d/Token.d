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
module enki.library.d.Token;
/**
	D Token definitions
*/

private import enki.types;
private import enki.library.d.Keyword;
private import enki.library.d.Operator;

//TODO: get rid of std.string and std.utf
private import std.string; // used for conversion
private import std.utf; // used for conversion
alias ulong IntegerValue; //TODO: turn into a more advanced type

struct FloatingPointValue{
	IntegerValue whole;
	IntegerValue fraction;
	IntegerValue exponent;
	bool exponentSign;
	bool imaginary;
	
	static FloatingPointValue opCall(IntegerValue whole,IntegerValue fraction,IntegerValue exponent,bool exponentSign){
		FloatingPointValue _this;
		_this.whole = whole;
		_this.fraction = fraction;
		_this.exponent = exponent;
		_this.exponentSign = exponentSign;
		return _this;
	}
	
	public String render(){
		char[] sign = exponentSign ? "+" : "-";
		char[] img = imaginary ? "i" : "";
		
		return toUTF32(std.string.toString(whole) ~ "." ~ 	std.string.toString(fraction) ~ sign ~ "e" ~ img);
	}
}

struct LineDirectiveValue{
	IntegerValue line;
	String filespec;
	
	static LineDirectiveValue opCall(IntegerValue line,String filespec){
		LineDirectiveValue _this;
		_this.line = line;
		_this.filespec = filespec;
		return _this;
	}
}

enum TokenSubtype{
	None = 0,
	Char,
	DChar,
	WChar,
	LongInteger,
	UnsignedInteger,
	LongUnsignedInteger,
	Float,
	Real,
}

enum Tok: uint{	
	/*keyword types */

	Abstract,
	Alia,
	Align,
	Asm,
	Assert,
	Auto,
	Body,
	Bool,
	Break,
	Byte,
	Case,
	Cast,
	Catch,
	Cdouble,
	Cent,
	Cfloat,
	Char,
	Cla,
	Const,
	Continue,
	Creal,
	Dchar,
	Debug,
	Default,
	Delegate,
	Delete,
	Deprecated,
	Do,
	Double,
	Else,
	Enum,
	Export,
	Extern,
	False,
	Final,
	Finally,
	Float,
	For,
	Foreach,
	Function,
	Goto,
	Idouble,
	If,
	Ifloat,
	Import,
	In,
	Inout,
	Int,
	Interface,
	Invariant,
	Ireal,
	Is,
	Long,
	Mixin,
	Module,
	New,
	Null,
	Out,
	Override,
	Package,
	Pragma,
	Private,
	Protected,
	Public,
	Real,
	Return,
	Scope,
	Short,
	Static,
	Struct,
	Super,
	Switch,
	Synchronized,
	Template,
	Thi,
	Throw,
	True,
	Try,
	Typedef,
	Typeid,
	Typeof,
	Ubyte,
	Ucent,
	UInt,
	Ulong,
	Union,
	Unittest,
	Ushort,
	Version,
	Void,
	Volatile,
	Wchar,
	While,
	With,

	/* operator types */
	DivAssign,
	Div,
	Elipsis,
	Slice,
	Dot,
	AndAssign,
	AndAnd,
	And,
	OrAssign,
	OrOr,
	Or,
	MinusMinus,
	MinusAssign,
	Minus,
	PlusPlus,
	PlusAssign,
	Plus,
	LessEquals,
	LessLess,
	LessLessEquals,
	LessGreater,
	LessGreaterEquals,
	Less,
	GreaterGreaterGreater,
	GreaterGreaterGreaterEquals,
	GreaterGreaterEquals,
	GreaterGreater,
	GreaterEquals,
	Greater,
	NotEqualsEquals,
	NotEquals,
	NotGreaterLess,
	NotGreaterLessEquals,
	NotLess,
	NotLessEquals,
	NotGreater,
	NotGreaterEquals,
	NotCat,
	Not,
	OpenParen,
	CloseParen,
	OpenBracket,
	CloseBracket,
	OpenCurl,
	CloseCurl,
	Question,
	Comma,
	Semi,
	Colon,
	Dollar,
	EqualsEqualsEquals,
	EqualsEquals,
	Equals,
	StarEquals,
	Star,
	ModEquals,
	Mod,
	InverseEquals,
	Inverse,
	CatEquals,
	CatCat,
	Cat	
}

struct Token{
	uint type;
	TokenSubtype subtype;
	
	enum{
		Identifier,
		Keyword,
		Operator,
		Comment,
		StringLiteral,
		CharLiteral,
		Integer,
		FloatingPoint,
		Special,
		LineDirective,
	}
	
	union ValueUnion{
		Tok token;
		String strValue;
		IntegerValue integerValue;
		FloatingPointValue floatingValue;
		LineDirectiveValue lineDirective;
	}
	
	ValueUnion value;

	public static Token identifier(String value){
		Token _this;
		if(value in keywordToken){
			_this.type = Keyword; // override to keyword if applicable
			_this.value.token = keywordToken[value];
		}
		else{
			_this.type = Identifier;
			_this.value.strValue = value;
		}
		return _this;
	}
	
	public static Token keyword(Tok id){
		Token _this;
		_this.type = Keyword;
		_this.value.token = id;
		return _this;
	}
	
	public static Token operator(Tok id){
		Token _this;
		_this.type = Operator;
		_this.value.token = id;
		return _this;
	}
	
	public static Token comment(String id){
		Token _this;
		_this.type = Comment;
		_this.value.strValue = id;
		return _this;
	}
		
	public static Token stringLiteral(String value,TokenSubtype subtype){
		Token _this;
		_this.type = StringLiteral;
		_this.subtype = subtype;
		_this.value.strValue = value;
		return _this;
	}
		
	public static Token charLiteral(String value){
		Token _this;
		_this.type = CharLiteral;
		_this.value.strValue = value;
		return _this;
	}
		
	public static Token integerLiteral(IntegerValue value,TokenSubtype subtype){
		Token _this;
		_this.type = Integer;
		_this.subtype = subtype;
		_this.value.integerValue = value;
		return _this;
	}
		
	public static Token floatingLiteral(FloatingPointValue value,TokenSubtype subtype,bool isImaginary){
		Token _this;
		_this.type = FloatingPoint;
		_this.subtype = subtype;
		_this.value.floatingValue = value;
		_this.value.floatingValue.imaginary = isImaginary;
		return _this;
	}	
	
	public static Token special(String value){
		Token _this;
		_this.type = Special;
		_this.value.strValue = value;
		return _this;
	}
	
	public static Token lineDirective(IntegerValue line,String filespec){
		Token _this;
		_this.type = LineDirective;
		_this.value.lineDirective = LineDirectiveValue(line,filespec);
		return _this;
	}
		
	String render(){
		switch(type){
		case Identifier:
			return value.strValue;
		case Keyword:
			return keywordXref[value.token];
		case Operator:
			return operatorXref[value.token];
		case Comment:
		case StringLiteral:
		case CharLiteral:
			return value.strValue;		
			return value.strValue;
		case FloatingPoint:
			return value.floatingValue.render();
		case Integer:
			return toUTF32(std.string.toString(value.integerValue));
		case Special:
			//TODO: fix me
			return value.strValue;
		case LineDirective:
		default:
			return "";
		}
	}
}