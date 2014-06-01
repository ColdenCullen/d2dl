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


abstract class Statement{
}

class LabeledStatement{
	public this(String name,Statement stmt){
	}
}

class BlockStatement{
	public this(Statement[] statements){
	}
}


class DeclarationStatement{
	public this(Variable[] vars){
	}
}


class Variable{
	public this(Type type,String name,Initializer init){
	}
}


class IfStatement{
	public this(IfCondition cond,Statement trueBranch,Statement falseBranch){
	}
}


abstract class IfCondition{
}

class ExpressionIfCondition{
	public this(Expression expr){
	}
}

class AutoIfCondition{
	public this(String name,Expression expr){
	}
}

class DeclaratorIfCondition{
	public this(Declarator decl,Expression expr){
	}
}


class WhileStatement{
	public this(Statement stmt,Expression test){
	}
}

class DoStatement{
	public this(Statement stmt,Expression test){
	}
}

class ForStatement{
	public this(Expression startExpr,Declaration startDecl,Expression test,Expression increment){
	}
}


struct ForeachType{
	static ForeachType opCall(bool isInout,Type type,String name){
		ForeachType _this;
		return _this;
	}
}

class ForeachStatement{
	public this(ForeachType[] types,Expression expr,Statement stmt){
	}
}


class SwitchStatement{
	public this(Expression expr,BlockStatement stmt){
	}
}

class CaseStatement{
	public this(Expression[] expressions,Statement stmt){
	}
}

class DefaultStatement{
	public this(Statement stmt){
	}
}


class ContinueStatement{
	public this(String label){
	}
}

class BreakStatement{
	public this(String label){
	}
}

class ReturnStatement{
	public this(Expression expr){
	}
}


abstract class GotoStatement : Statement{
}

class GotoLabelStatement{
	public this(String label){
	}
}

class GotoLabelStatement{
	public this(){
	}
}

class GotoCaseStatement{
	public this(Expression expr){
	}
}


abstract class WithStatement : Statement{
}

class WithExpressionStatement{
	public this(Expression expr){
	}
}

class WithTemplateStatement{
	public this(TemplateInstance ti){
	}
}

class WithSymbolStatement{
	public this(String symbol){
	}
}

class SynchronizeStatement{
	public this(Statment stmt,Expression expr){
	}
}

class SynchronizeStatement{
	public this(Statment stmt,Expression expr){
	}
}

class TryStatement{
	public this(BlockStatment stmt,Catch[] catches,FinallyStatement fin){
	}
}


class Catch : Statment{
	public this(BlockStatment stmt){
	}
	public this(Declarator decl,BlockStatment stmt){
	}
}

class FinallyStatement{
	public this(BlockStatement stmt){
	}
}

class ThrowStatement{
	public this(Expression expr){
	}
}


class ScopeStatement : Statement{
	enum{ Exit,Success,Failure }
	uint type;
	Statement stmt;
	
	public this(uint type,Statement stmt){
		this.type = type;
		this.stmt = stmt;
	}
}

class VolatileStatement : Statement{
	public this(Statement stmt){
	}
}

class AsmStatement : Statement{
	public this(AsmInstruction[] instructions){
	}
}

class PragmaStatement : Statement{
	public this(Pragma prag,Statement stmt){
	}
}