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
module enki.library.d.TokenizerBase;

private import enki.types;
private import enki.BaseParser;

private import enki.library.d.Token;

class TokenizerBase : BaseParser{
	
	public this(){
	}
		
	dchar hexToChar(String value){
		dchar result;
		
		Char hexValue(Char ch){
			if(ch >= 'a' && ch <= 'f') return ch - 'a'+10;
			else if(ch >= 'A' && ch <= 'F') return ch - 'A'+10;
			else return ch - '0';
		}
		//NOTE: assumes little-endian	
		result = (hexValue(value[0]) << 4) + hexValue(value[1]);
		if(value.length > 2){
			result = (result << 8) + 
				(hexValue(value[2]) << 4) + hexValue(value[3]);
			
		}
		if(value.length > 4){				
			result = (result << 16) +
				(hexValue(value[4]) << 4) + (hexValue(value[5]) << 8) +
				(hexValue(value[6]) << 12) + hexValue(value[7]);
		}

		return result;
	}
	
	dchar octToChar(String value){
		dchar result;
				
		result = value[0] - '0';
		if(value.length > 1){
			result = result*8 + value[1] - '0';
		}
		if(value.length > 2){				
			result = result*8 + value[2] - '0';
		}

		return result;
	}
	
	IntegerValue convertToHex(String value){
		ubyte hexValue(Char ch){
			if(ch >= 'a' && ch <= 'f') return ch - 'a'+10;
			else if(ch >= 'A' && ch <= 'F') return ch - 'A'+10;
			else return ch - '0';
		}
		
		IntegerValue result = 0;
		
		foreach(ch; value){
			result = (result << 4) + hexValue(ch);
		}
		return result;
	}
	import std.stdio;
	
	IntegerValue convertToDecimal(String value){
		IntegerValue result = 0;
				
		foreach(ch; value){
			result = (result * 10) + (ch - '0');
		}
		return result;
	}
	
	IntegerValue convertToOctal(String value){
		IntegerValue result = 0;
		
		foreach(ch; value){
			result = (result * 8) + (ch - '0');
		}
		return result;
	}
	
	IntegerValue convertToBinary(String value){
		IntegerValue result = 0;
		
		foreach(ch; value){
			result = result << 1;
			if(ch == '1') result++;
		}
		return result;
	}
	
	// shim to help with direct assignment of token values
	String literal(String value){
		return value;
	}
}