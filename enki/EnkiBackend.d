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
module enki.EnkiBackend;

private import enki.types;
private import enki.BaseParser;
private import enki.CodeGenerator;
private import enki.Expression;
private import enki.Directive;
private import enki.Rule;

debug private import tango.io.Stdout;

interface SyntaxLine{
	public void semanticPass(BaseEnkiParser root);
	public String toBNF();
}

struct UserProduction{
	String returnType;
	String name;
	String description;
	bool isTerminal;
		
	static UserProduction opCall(String returnType,String name,String description=null,bool isTerminal=true){
		UserProduction _this;
		_this.returnType = returnType;
		_this.name = name;
		_this.description = description ? description : name;
		_this.isTerminal = isTerminal;
		return _this;
	}
}

class BaseEnkiParser : BaseParser{
	SyntaxLine[] lines;
	Rule[String] rules;
	String[] imports;
	String baseclass;
	String classname;
	String moduleName;
	String typelib;
	String parseType;
	String boilerplate;
	String header;
	String utf;
	UserProduction[String] userProductions;

	protected void clearErrors(){
		debug writefln("** clearErrors() **");
		super.clearErrors();
	}		
	
	public this(){
		this.baseclass = "BaseParser";
		this.classname = "Parser";
		this.typelib = "enki.types";
		this.parseType = "String";
		this.utf = "8";
	}
	
	public void createSyntax(SyntaxLine[] lines){
		this.lines = lines;
	}
	
	public void add(BaseEnkiParser other){
		// aggregate and perform nested semantic pass on directives
		debug writefln("Running Non-Root Semantic Pass on aggregated lines.");
		
		foreach(line; other.lines){
			Directive directive = cast(Directive)line;
			if(directive && directive.type == Directive.FirstPass){
				directive.semanticPass(this);
			}
			else{
				this.lines ~= line;
			}
		}		
	}
	
	public void setImport(String imp){
		imports ~= imp;
	}
	
	public void setBaseClass(String name){
		baseclass = name;
	}
	
	public void setClassname(String name){
		classname = name;
	}
	
	public void setModulename(String name){
		moduleName = name;
	}
	
	public void setBoilerplate(String value){
		boilerplate ~= value;
	}	
	
	public void setHeader(String value){
		header ~= value;
	}
		
	public void defineUserProduction(String returnType,String name,String description){
		if(name in rules || name in userProductions){
			throw new Exception("Rule '" ~ name ~ "' is already defined.");
		}
		debug writefln("defined user production: %s",name);
		userProductions[name] = UserProduction(returnType,name,description);
	}
	
	public void setTypelibName(String name){
		typelib = name;
	}
	
	public void setParseType(String name){
		debug writefln("parse type set to: %s",name);
		parseType = name;
	}
	
	public String getParseType(){
		return parseType;
	}
	
	public void setUTF(String value){
		utf = value;
	}
	
	public void aliasRule(String ruleName,String aliasName){
		if(ruleName in rules){
			rules[aliasName] = rules[ruleName];
		}
		else if(ruleName in userProductions){
			debug writefln("%s aliased to user production %s",aliasName,ruleName);
			userProductions[aliasName] = userProductions[ruleName];
		}
		else{
			throw new Exception("Cannot alias '" ~ aliasName ~ "'. Rule '" ~ ruleName ~ "' is not defined.");
		}
	}
	
	public void addRule(String name,Rule rule){
		if(name in rules) throw new Exception("Rule '" ~ name ~ "' is already defined.");
		rules[name] = rule;
	}
	
	public Rule[String] getRules(){
		return this.rules;
	}
	
	public String getTypeForRule(String name){
		String type;
		if(name in userProductions){
			type = userProductions[name].returnType;
		}
		if(!type){
			if(!(name in rules)){
				throw new Exception("Cannot find rule '" ~ name ~ "'.");
			}
			type = rules[name].getType(this);
		}
		return type;
	}
	
	public bool isTerminal(String name){
		if(name in userProductions){
			return userProductions[name].isTerminal;
		}		
		return true;
	}
	
	public String getTerminalName(String terminalName){
		String name;
		if(name in userProductions){
			return userProductions[name].description;
		}
		if(!name) name = terminalName;
		return name;
	}
	
	public void semanticPass(){
		// first/root pass
		debug writefln("-- Root/First Semantic Pass --");
		foreach(line; lines){		
			Directive directive = cast(Directive)line;
			if(directive && (directive.type == Directive.FirstPass || directive.type == Directive.RootOnly)){
				directive.semanticPass(this);
			}
		}
		
		// gather production names
		foreach(line; lines){
			Rule rule = cast(Rule)line;
			if(rule){
				rules[rule.name] = rule;
			}
		}

		// second pass - realize all other directives
		debug writefln("-- Second Semantic Pass --");
		foreach(line; lines){
			Directive directive = cast(Directive)line;
			if(directive && (directive.type == Directive.SecondPass)){
				directive.semanticPass(this);
			}
		}
				
		// resolve all rules last
		debug writefln("-- Final Semantic Pass --");
		foreach(name,rule; rules){
			debug writefln("-- Semantic Pass for rule %s --",name);
			rule.semanticPass(this);
		}
		
	}
		
	String render(){
		auto CodeGenerator generator = new CodeGenerator(this.parseType);
		with(generator){
			// boilerplate section
			emit("//Generated by Enki v1.2");
			emit("");
			emit(boilerplate);
			
			// module and imports section
			emit("");
			if(moduleName){
				emit("module " ~ moduleName ~ ";");
			}
			emit("version(build) pragma(export_version,EnkiUTF" ~ utf ~ ");");
			emit("");
			emit("debug private import tango.io.Stdout;");
			
			if(typelib != ""){
				emit("private import " ~ typelib ~ ";");
			}
			foreach(imp; imports){
				emit("private import " ~ imp ~ ";");
			}
			emit("");
			
			// header section
			emit(header);
			emit("");			
			
			// parser class definition
			if(baseclass){
				emit("class " ~ classname ~ " : " ~ baseclass ~ "{");
			}
			else{
				emit("class " ~ classname ~ "{");				
			}
			emit("");
			
			foreach(line; lines){
				auto renderable = cast(IRenderable)line;
				if(renderable){
					render(renderable);
				}
			}
			
			emit("}");
		}	
		return generator.toString();
	}
	
	public String toBNF(){
		String result = "";
		foreach(line; lines){
			result ~= line.toBNF();
		}
		return result;
	}
}

class Comment : SyntaxLine{
	String text;
	public this(String text){
		this.text = text;
	}
	
	public void semanticPass(BaseEnkiParser root){
		//do nothing
	}	
	
	public String toBNF(){
		return "# " ~ text ~ "\n";
	}
}