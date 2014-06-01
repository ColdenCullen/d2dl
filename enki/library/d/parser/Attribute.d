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


abstract class : Attribute{
}

class BasicAttribute : Attribute{
	enum{
    	Deprecated,
    	Private,
    	Package,
    	Protected,
    	Public,
    	Export,
    	Static,
    	Final,
    	Override,
    	Abstract,
    	Const,
    	Auto	
	}
	uint type;
	
	public this(uint type){
		this.type = type;
	}
}

class LinkageType : Attribute{
	enum{
		C,
		D,
		Cpp,
		Windows,
		Pascal
	}
	uint type;
	
	public this(uint type){
		this.type = type;
	}
}

class AlignAttribute : Attribute{
	Integer amount;
	
	public this(Integer amount){
		this.amount = amount;
	}
}

class Pragma : Attribute{
	String name;
	Expression[] expressions;
	
	public this(String name,Expression[] expressions){
		this.name = name;
		this.expressions = expressions;
	}
}

