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

struct ImportBinding{
	String name;
	String binding;
	
	static ImportBinding opCall(String name, String binding){
		ImportBinding _this;
		_this.name = name;
		_this.binding = binding;
		return _this;
	}
}

struct Import{
	String name;
	String impAlias;
	ImportBinding bindings;
	
	//NOTE: throws away original import 'imp'
	static Import opCall(Import imp,ImportBinding[] bindings){
		Import _this;
		_this.name = imp.name;
		_this.impAlias = imp.impAlias;
		_this.bindings = bindings;
		return _this;
	}
	
	static Import opCall(String name,String impAlias){
		Import _this;
		_this.name = name;
		_this.impAlias = impAlias;
		return _this;		
	}	
}

class ImportDeclaration : Declaration{
	public this(bool isStatic,Import[] imports){
	}
}