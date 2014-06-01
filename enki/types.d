/+
    Copyright (c) 2006 Eric Anderton, Tomasz Stachowiak

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
module enki.types;

/+private import std.string;
private import std.utf;
private import std.conv;+/
import tango.text.Util;
import tango.text.Unicode;
import tango.util.Convert;
static import tango.text.convert.Utf;

version(EnkiUTF32){
	alias dchar[] String;
	alias dchar Char;
	alias to!(dchar[]) transcodeToString;
	alias to!(char[]) transcodeToUTF8;
}
else version(EnkiUTF16){
	alias wchar[] String;
	alias wchar Char;
	alias to!(wchar[]) transcodeToString;
	alias to!(char[]) transcodeToUTF8;
}
else{
	alias char[] String;
	alias char Char;
	alias to!(char[]) transcodeToString;
	char[] transcodeToUTF8(char[] value){ return value; }
}

alias to!(char[]) toString;


// implicitly converable
template convert(V,U : V){
	U convert(V value){
		return value; 	
	}
}

// conversion to string
template convert(V,U:String){
	String convert(V value){
		static if(is(V == struct) || is(V == class)){
			return value.toString();
		}
		else{
			static if(is(V == char[]) || is(V == wchar[])){
				return transcodeToString(value);
			}
			else{
				static if(is(V == dchar) || is(V == wchar) || is(V == char)){
					Char[] temp = new Char[1];
					temp[0] = value;
					return transcodeToString(temp);
				}
				else{
					return transcodeToString(to!(char[])(value));
				}
			}
		}
	}
}

// conversion from string
template convert(V:String,U){
	U convert(V value){
		static if(is(U == int)){
			return to!(U)(value);
		}
		else static if(is(U == uint)){
			return to!(U)(value);
		}		
		else static if(is(U == long)){
			return to!(U)(value);
		}		
		else static if(is(U == ulong)){
			return to!(U)(value);
		}		
		else static if(is(U == short)){
			return to!(U)(value);
		}		
		else static if(is(U == ushort)){
			return to!(U)(value);
		}		
		else static if(is(U == byte)){
			return to!(U)(value);
		}		
		else static if(is(U == ubyte)){
			return to!(U)(value);
		}	
		else static if(is(U == float)){
			return to!(U)(value);
		}
		else static if(is(U == double)){
			return to!(U)(value);
		}
		else static if(is(U == real)){
			return to!(U)(value);
		}
		else static if(is(U == bool)){
			return (value != null && value.length > 0);
		}
		else static if(is(U == char)){
			static assert(false);
		}				
		else static if(is(U == wchar)){
			static assert(false);
		}
		else static if(is(U == dchar)){
			static assert(false);
		}	
		else{
			// last ditch effort
			return cast(U)value;
		}
	}
}

template convert(V,U : U[]){
	U convert(V value){
		return cast(U)value;
	}
}

// else
template convert(V,U){
	U convert(V value){
		static if(is(U : V)){
			return value;
		}
		else{
			return cast(U)value;
		}
	}
}

template smartAssignCat(U,V){
	void smartAssignCat(inout U u,V v){
		u = convert!(V,U)(v);
	}	
}

template smartAssignCat(U : U[],V : U){
   void smartAssignCat(inout U[] u,V v){
      u ~= v;
   }   
}

template smartAssignCat(U : U[],V){
	void smartAssignCat(inout U[] u,V v){
		u ~= convert!(V,U[])(v);
	}	
}

template smartAssign(U,V){
	void smartAssign(inout U u,V v){
		u = convert!(V,U)(v);
	}	
}
/*
template smartAssign(U : U[],V){
	void smartAssign(inout U[] u,V v){
		static if(is(V : U[])){
			u = convert!(V,U[])(v);
		}
		else{
			u = convert!(V,U[])(v);
			//u[0] = convert!(V,U[])(v);
		}
	}	
}*/

// template tuple type to help with parsing
struct ResultT(T){
	T result;
	bool success;
	
	alias T Type;
	alias typeof(*this) ThisType;
	
	public static ThisType opCall(T result){ 
		ThisType _this;
		_this.result = result; 
		_this.success = true;
		return _this;
	}
	
	public static ThisType opCall(T result,bool success){ 
		ThisType _this;
		_this.result = result;
		_this.success = success;
		return _this;
	}
				
	public static ThisType opCall(){ 
		ThisType _this;
		_this.success = false;
		return _this;
	}	
		
	public bool assignCat(V)(inout V value){
		if(this.success) smartAssignCat!(V,Type)(value,this.result);
		return this.success;
	}
	
	public bool assign(V)(inout V value){
		if(this.success) smartAssign!(V,Type)(value,this.result);;
		return this.success;
	}
	
	public bool opCast(){
		return this.success;
	}
}

