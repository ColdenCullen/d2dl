
class Declaration{
	public this(bool isTypedef,bool isAlias,Decl decl){
	}
}

abstract class Decl{
}

class MemberDecl : Decl{
	public this(StorageClass sc,BasicType type,Declarator[] decls){
	}
}

class MethodDecl : Decl{
	public this(StorageClass sc,BasicType type,Declarator decl,FunctionBody body){
	}
}
	
class AutoDeclaration : Decl{
	public this(StorageClass sc,String name,AssignExpression init){
	}
}

class DeclaratorSet{
	public this(DeclaratorInitializer init,DeclaratorIdentifier[] decls){
	}
}

class DeclaratorInitializer{
	public this(Declarator decl,Initializer[] init){
	}
}

class DeclaratorIdentifier{
	public this(String name,Initializer[] init){
	}
}

struct BasicType{
	enum{
		Bool,
		Byte, 	
		UByte,	
		Short,	
		UShort,	
		Int,		
		UInt,	
		Long,	
		ULong,	
		Char,	
		WChar,	
		DChar,	
		Float,	
		Double,	
		Real,	
		IFloat,	
		IDouble,	
		IReal,	
		CFloat,	
		CDouble,	
		CReal,	
		Void,
		User,
		Typeof,
	}
	
	uint type;
	String ident;
	
	static BasicType opCall(uint type,String ident){
		BasicType _this;
		_this.type = type;
		_this.ident = ident;
		return _this;
	}
}


class Parameter{
	enum{ In,Out,Inout };
	public this(uint inoutSpec,Declarator decl,AssignExpression init){
	}
	
	static Parameter Elipsis; // placeholder
	static this(){
		Parameter.Elipsis = new Parameter(0,null,null);
	}
}

abstract class Initializer{
}

class AssignExpressionInitializer: Initializer{
	public this(AssignExpression init){
	}
}

class ArrayInitializer : Initializer{
	public this(AssignExpression keyInit,AssignExpression valueInit){
	}
}

class StructMemberInitializer : Initializer{
	public this(String name,AssignExpression init){
	}
}
