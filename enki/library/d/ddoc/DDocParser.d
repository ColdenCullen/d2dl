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

module d.ddoc.DDocParser.d;

private import enki.types;
private import enki.BaseParser;

private import std.string;

DDocParser : BaseParser{
	public this(){		
	}
	
	// case insensitive terminal implementation
	public ResultString terminal(String str){
		uint start = pos;
		//writefln("match: %s %d (%d) %d",str,position,data[pos],data.length);
		if(position >= data.length || 
			str.length > data.length - pos || 
			toUpper(data[pos..pos+str.length]) != toUpper(str)){
				
			setError("Expected '" ~ str ~ "'");
			return ResultString();
		}
		pos += str.length;
		return ResultString(data[start..pos]);
	}		
}

struct Docpart{
	String name;
	String[] args;
	bool isMacro;
		
	static macro(String name,String[] args){
		this.name = name;
		this.args = args;
	}
	
	static text(String value){
		name = value;
	}
}

struct Section{
	String name;
	Docpart[] parts;
	
	static Section opCall(String name,Docpart[] parts){
		Section _this;
		_this.name = name;
		_this.parts = parts;
		return _this;
	}
}

struct DocComment{
	Docpart[] summary;
	Docpart[] description;
	Section[] sections;
	
	static DocComment opCall(Docpart[] summary,Docpart[] desc,Section[] sections){
		DocComment _this;
		_this.summary = summary;
		_this.description = desc;
		_this.sections = sections;
		return _this;
	}
}