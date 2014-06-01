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

struct InterfaceRef{
	enum{ Public, Package, Private, Export };
	
	uint type;
	String name;
	
	static InterfaceRef opCall(uint type,String name){
		InterfaceRef _this;
		_this.type = type;
		_this.name = name;
		return _this;
	}
}

class Class{
	public this(String name,InterfaceRef[] bases,Declaration[] classBody){
	}
}

class Constructor : Declaration{
	public this(Parameter[] params,FunctionBody functionBody){
	}
}
class Destructor : Declaration{
	public this(FunctionBody functionBody){
	}
}

class StaticConstructor : Declaration{
	public this(FunctionBody functionBody){
	}
}
class StaticDestructor : Declaration{
	public this(FunctionBody functionBody){
	}
}
class Invariant : Declaration{
	public this(FunctionBody functionBody){
	}
}
class UnitTtest : Declaration{
	public this(FunctionBody functionBody){
	}
}

class ClassAllocator : Declaration{
	public this(Parameter[] params,FunctionBody functionBody){
	}
}
class ClassDeallocator : Declaration{
	public this(Parameter[] params,FunctionBody functionBody){
	}
}

class NewAnonClassExpression : Expression{
	public this(Expression[] newArgs,Expression[] classArgs,String superClass,String[] interfaces,Declaration[] classBody){
	}
}