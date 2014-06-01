module enki.codegen.d.CodeGenerator;

private import enki.types;

abstract class Scope{
	public String[] code;
	public void render(CodeGenerator generator);
}

class RootScope : Scope{
	String toString(){
		String result = "";
		foreach(line; code){
			result ~= line ~ "\n";
		}
		return result;
	}
	
	public void render(CodeGenerator generator){
	}
}

class Module : Scope{
	String[String] settings;
	String[] imports;
	
	public this(String[String] settings,String[] imports){
		this.settings = settings;
		this.imports = imports;
	}
	
	public void render(CodeGenerator generator){
		with(generator){
			emit("//Generated by Enki v1.2");
			emit("");
			emit(settings["boilerplate"]);
			
			// module and imports section
			emit("");
			if(settings["moduleName"]){
				emit("module " ~ settings["moduleName"] ~ ";");
			}
			emit("version(build) pragma(export_version,EnkiUTF" ~ settings["utf"] ~ ");");
			emit("");
			emit("debug private import std.stdio;");
			
			if(settings["typelib"] != ""){
				emit("private import " ~ settings["typelib"] ~ ";");
			}
			foreach(imp; imports){
				emit("private import " ~ imp ~ ";");
			}
			emit("");
			
			// header section
			emit(settings["header"]);
			emit("");			
			
			// parser class definition
			if(settings["baseclass"]){
				emit("class " ~ settings["classname"] ~ " : " ~ settings["baseclass"] ~ "{");
			}
			else{
				emit("class " ~ settings["classname"] ~ "{");				
			}
			emit("");
			
			indent();
				emit(code);
			indent();
			
			emit("}");
		}		
	}	
}

struct RuleRef{
	String name;
	String[] args;
	
	String render(){
		String result = "name(";
		foreach(i,arg; args){
			if(i > 0) result ~= ",";
			result ~= arg;
		}
		result ~= ")";
		
		return result;		
	}
}

class Method : Scope{
	struct Param{
		String type;
		String name;
	}
	
	String name;
	String type;
	Param[] params;
	
	public this(String type,String name){
		this.type = type;
		this.name = name;
	}
	
	public void addParam(String type,String name){
		Param param;
		param.type = type;
		param.name = name;
		
		params ~= param;
	}
	
	public void render(CodeGenerator generator){
		with(generator){
			String result = "public ResultT!(" ~ type ~ ") parse_" ~ name ~ "(";
			foreach(param; params){
				result ~= param.type ~ " " ~ param.name;
			}
			result ~= "){";
			emit(result);
			
			indent();
				emit(code);
			unindent();
			
			emit("}");
		}
	}
}

struct SectionRef{
	Section section;
	String sectionLabel;
	
	public void render(CodeGenerator generator){
		generator.emit("goto " ~ sectionLabel ~ ";");
	}
}

class Section : Scope{
	String commentText;
	String label;
	bool hasStart;
	bool hasEnd;
	
	protected SectionRef getSubSection(String subName){
		SectionRef ref;
		ref.section = this;
		ref.sectionLabel = label ~ subName;
		return ref;
	}
	
	public this(String commentText,String label){
		this.commentText = commentText;
		this.label = label;
	}
	
	public void render(CodeGenerator generator){
		with(generator){
			emit("{//" ~ commentText);
			if(hasStart) emit(label ~ "_start");
			indent();
				emit(code);
			unindent();
			if(hasEnd) emit(label ~ "_end");
			emit("}");
		}
	}
	
	public SectionRef start(){
		hasStart = true;
		return getSubSection("_start");
	}
	
	public SectionRef end(){
		hasEnd = true;
		return getSubSection("_end");
	}
}

class Loop : Section{
	String name;
	
	public this(String commentText,String label){
		super(commentText,label);
	}
	
	public void render(CodeGenerator generator){
		with(generator){
			emit("{//" ~ commentText);
			if(hasStart) emit(label ~ "_start");
			indent();
			//TODO: loop internals
				emit(code);
			unindent();
			if(hasEnd) emit(label ~ "_end");
			emit("}");
		}
	}	
}

struct PositionHandle{
	String label;
}

class CodeGenerator{
	protected String parseType;
	protected bool errorsEnabled;
	protected uint labelIndex;
	protected String tabs;
	
	protected Scope[] scopes;
	protected Scope current;
	
	protected void pushScope(Scope sc){
		scopes ~= sc;
		current = sc;
	}
	
	protected void popScope(){
		scopes.length = scopes.length - 1;
		current = scopes[$-1];
	}
	
	protected void indent(){
		tabs = tabs ~ "\t";
	}
	
	protected void unindent(){
		tabs = tabs[0..$-1];
	}	
	
	protected void emit(String text){
		current.code ~= tabs ~ text;
	}
	
	protected void emit(String[] text){
		current.code ~= text;
	}
	
	protected String getUniqueLabel(){
		labelIndex++;
		return "_" ~ std.string.toString(labelIndex);
	}	
	
	/* Construction and Settings */
	public this(){
		pushScope(new RootScope());
	}
		
	void setParseType(String type){
		parseType = type;
	}
	
	void setErrorHandling(bool isEnabled){
		errorsEnabled = isEnabled;
	}
	
	void comment(char[] comment){
		emit("/*" ~ comment ~ "*/");
	}
	
	/* Scope Management */
			
	Module startModule(String[String] settings,String[] imports){
		auto mod = new Module(settings,imports);
		pushScope(mod);
		return mod;		
	}
	
	Section startSection(char[] commentText){
		auto section = new Section(commentText,"sect" ~ getUniqueLabel);
		pushScope(section);
		return section;
	}

	Method startMethod(String type,String name){
		auto method = new Method(type,name);
		pushScope(method);
		return method;		
	}
	
	Loop startLoop(String commentText){
		auto loop = new Loop(commentText,"loop" ~ getUniqueLabel);
		pushScope(loop);
		return loop;	
	}	
	
	/// ends the current scope, whatever it may be
	void endScope(){
		popScope();
	}
	
	/// Posts the scope's data into the current scope (where possible)
	void render(Scope sc){
		sc.render(this);
	}
	
	/* Position Handles */
	
	PositionHandle getPositionHandle(){
		PositionHandle handle;
		handle.label = "pos" ~ getUniqueLabel;
		return handle;
	}
	
	void savePosition(PositionHandle handle){
		emit("uint " ~ handle.label ~ " = position;");
	}
	
	/// convienence method - combines getPositionHandle and savePosition(handle)
	PositionHandle savePosition(){
		auto handle = getPositionHandle();
		savePosition(handle);
		return handle;
	}
	
	/* ProductionCall Support */
	
	//RuleRef productionCall(
	
	protected void renderProductionTestInternal(String target,SectionRef pass,SectionRef fail){
		if(pass == SectionRef.init && fail == SectionRef.init){
			emit(target ~ ";");
		}
		else if(pass == SectionRef.init){
			emit("if(!(" ~ target ~ ")){");
				indent();
				fail.render(this);
				unindent();						
			emit("}");			
		}
		else if(fail == SectionRef.init){
			emit("if(" ~ target ~ "){");
				indent();
				pass.render(this);
				unindent();						
			emit("}");
		}
		else{
			emit("if(" ~ target ~ "){");
				indent();
				pass.render(this);
				unindent();
			emit("}else{");
				indent();
				fail.render(this);
				unindent();
			emit("}");
		}		
	}
	
	void renderProductionTest(RuleRef target,SectionRef pass,SectionRef fail){
		renderProductionTestInternal(target.render,pass,fail);		
	}
	
	/// The target set is organized OR by AND, from outer dimension to inner dimension.
	void renderProductionTest(RuleRef[][] targets,SectionRef pass,SectionRef fail){
		String test = "";
		
		foreach(i,callSet; targets){
			if(i > 0) test ~= " || ";
			test ~= "(";
			foreach(j,call; callSet){
				if(j > 0) test ~= " && ";
				test ~= call.render();
			}
			test ~= ")";
		}
		
		renderProductionTestInternal(test,pass,fail);
	}
		
	void assignSlice(String type,String varName,PositionHandle sliceFrom,PositionHandle sliceTo=null){
		emit(
	}
	
	/* terminal expressions */
					
	void regexpTest(String regexp,Binding bind,Statement pass,Statement fail){
	}	
	stringTerminalTest(String value,Binding bind,Statement pass,Statement fail);
	terminalTest(String value,Binding bind,Statement pass,Statement fail);
	rangeTest(String start,String end);

	/*	
	unwind(positionHandle unwindTo);

	void addRuleAlias(String from, String to){
		
	}*/
	
	public String toString(){
		return current.toString();
	}
}

/+
	public void render(CodeGenerator generator,Statement pass,Statement fail){
		with(generator){
			comment(this.toBNF());
			auto method = startMethod(type,decl.params);
				debugOut(method.name);
				auto startPos = savePosition();
				
				pred.renderDeclarations(generator,decl.paramXRef);
				
				foreach(param; params){
					renderBinding(param);
				}
				
				auto passStmt = startSection();
					debugOut(method.name," PASS");
					pred.renderPass(generator,startPos);
				endStatement;

				auto failStmt = startSection();
					debugOut(method.name," FAIL");
					pred.renderFail(generator,startPos);
				endStatement;
				
				render(expr,passStmt,failStmt);
				
				render(passStmt);
				render(failStmt);
			endMethod();
			render(method);
		}

	// ZeroOrMoreExpr example
	public void render(CodeGenerator generator,Statement pass,Statement fail){
		Statement exprFail;
		
		with(generator){
			startSection("ZeroOrMoreExpr");
				auto loop = startLoop(binding);
					if(term){
						render(term,loop.end);
					}
					else{
						exprFail = loop.end;
					}
					render(expr,loop.next,exprFail);
				endLoop;
				render(pass);
			endSection;
		}
	}+/