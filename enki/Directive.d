/+
    Copyright (c) 2006 Eric Anderton, BCS

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
module enki.Directive;

private import enki.types;
private import enki.EnkiBackend;
private import enki.CodeGenerator;

debug private import tango.io.Stdout;

/*
	RootOnly:
		.baseclass
		.classname
		.module
		.typelib
		.parsetype
		.utf
		.boilerplate
		
	FirstPass:
		.import
		.define
		.include
		.header
		
	SecondPass:
		.alias
		.code
*/


abstract class Directive : SyntaxLine, IRenderable{
	enum: uint{	
		RootOnly,	
		FirstPass,
		SecondPass,
	}		
	
	public uint type(){
		return Directive.SecondPass;
	}
	
	public void semanticPass(BaseEnkiParser root){
		//do nothing
	}
	
	public String toBNF(){
		// do nothing
		return "";
	}
	
	public String toString(){
		// do nothing
		return "";
	}

	public void render(CodeGenerator generator,Statement passterm,Statement failterm){
		// do nothing
	}
}

class ImportDirective : Directive{
	String imp;
	
	public uint type(){
		return Directive.FirstPass;
	}	
		
	public this(String imp){
		this.imp = imp;
	}
	
	public void semanticPass(BaseEnkiParser root){
		root.setImport(imp);
	}
	
	public String toBNF(){
		return ".import(\"" ~ imp ~ "\");\n";
	}
	
	public String toString(){
		return "Import Directive";
	}

}

class BaseClassDirective : Directive{
	String name;
	
	public uint type(){
		return Directive.RootOnly;
	}	
	
	public this(String name){
		this.name = name;
	}
	
	public void semanticPass(BaseEnkiParser root){
		root.setBaseClass(name);
	}		
	
	public String toBNF(){
		return ".baseclass(\"" ~ name ~ "\");\n";
	}
	
	public String toString(){
		return "Base Class Directive";
	}	
}

class ClassnameDirective : Directive{
	String name;
	
	public uint type(){
		return Directive.RootOnly;
	}
	
	public this(String name){
		this.name = name;
	}
	
	public void semanticPass(BaseEnkiParser root){
		root.setClassname(name);
	}
	
	public String toBNF(){
		return ".classname(\"" ~ name ~ "\");\n";
	}
	
	public String toString(){
		return "Classname Directive";
	}	
}

class DefineDirective : Directive{
	String returnType;
	String name;
	String description;
	bool isTerminal;
	
	public uint type(){
		return Directive.FirstPass;
	}
	
	public this(String returnType,String name,bool isTerminal,String description){
		this.name = name;
		this.returnType = returnType;
		this.isTerminal = isTerminal;
		this.description = description;
	}
	
	public void semanticPass(BaseEnkiParser root){
		root.defineUserProduction(returnType,name,description);
	}
	
	public String toBNF(){
		String terminalStr = isTerminal ? "true" : "false";
		if(description){			
			return ".define(\"" ~ returnType ~ "\",\"" ~ name ~ "\",\"" ~ terminalStr ~ "\",\"" ~ description ~ "\");\n";
		}
		else{
			return ".define(\"" ~ returnType ~ "\",\"" ~ name ~ "\",\"" ~ terminalStr ~ "\");\n";
		}
	}
	
	public String toString(){
		return "Define Directive";
	}	
}


// cannot reference the parser duing bootstrap - it doesn't exist yet
version(Bootstrap){}
else{
	private import enki.EnkiParser;
	private import tango.io.FilePath;
	private import tango.io.File;
}

class IncludeDirective : Directive{
	String filename;
	
	public uint type(){
		return Directive.FirstPass;
	}
	
	public this(String filename){
		this.filename = filename;
	}
	
	public void semanticPass(BaseEnkiParser root){
		// cannot reference the parser duing bootstrap - it doesn't exist yet
		version(Bootstrap){
			throw new Exception("Include directive is meaningless during bootstrap phase.");
		} 
		else{
			if(!FilePath(filename).exists){
				throw new Exception("Cannot include '" ~ filename ~ "'; file doesn't exist.");
			}
				
			auto parser = new EnkiParser();
			parser.initalize(cast(char[])File(filename).read());
			auto result = parser.parse_Syntax();
			
			if(result.success){
				auto syntax = result.result;
				root.add(parser);
			}
			else{
				throw new Exception("In file '" ~ filename ~ "':\n" ~ parser.getErrorReport());
			}
		}		
	}
				
	public String toBNF(){
		return "#.include(\"" ~ filename ~ "\");\n";
	}
	
	public String toString(){
		return "Include Directive";
	}	
}


class AliasDirective : Directive{
	String rule;
	String ruleAlias;
	
	public uint type(){
		return Directive.SecondPass;
	}
	
	public this(String rule,String ruleAlias){
		this.rule = rule;
		this.ruleAlias = ruleAlias;
	}
	
	public void semanticPass(BaseEnkiParser root){
		root.aliasRule(rule,ruleAlias);
	}
	
	public String toBNF(){
		return ".alias(\"" ~ rule ~ "\",\"" ~ ruleAlias ~ "\");\n";
	}
	
	public String toString(){
		return "Alias Directive";
	}	
	
	public void render(CodeGenerator generator,Statement passterm,Statement failterm){
		generator.emit("alias parse_" ~ rule ~ " parse_" ~ ruleAlias ~ ";");
	}
}

class ModuleDirective : Directive{
	String moduleName;
	
	public uint type(){
		return Directive.RootOnly;
	}
	
	public this(String moduleName){
		this.moduleName = moduleName;
	}
	
	public void semanticPass(BaseEnkiParser root){
		root.setModulename(moduleName);
	}
	
	public String toBNF(){
		return ".module(\"" ~ moduleName ~ "\");\n";
	}
	
	public String toString(){
		return "Module Directive";
	}	
}


class CodeDirective : Directive{
	String code;
	
	public uint type(){
		return Directive.SecondPass;
	}
		
	public this(String code){
		this.code = code;
	}
	
	public void semanticPass(BaseEnkiParser root){
		//do nothing
	}
	
	public String toBNF(){
		return ".code{{{" ~ code ~ "}}}\n";
	}
	
	public String toString(){
		return "Code Directive";
	}	
	
	public void render(CodeGenerator generator,Statement passterm,Statement failterm){
		generator.emit(code);
	}	
}

class TypelibDirective : Directive{
	String moduleName;
	
	public uint type(){
		return Directive.RootOnly;
	}
	
	public this(String moduleName){
		this.moduleName = moduleName;
	}
	
	public void semanticPass(BaseEnkiParser root){
		root.setTypelibName(moduleName);
	}
	
	public String toBNF(){
		return ".typelib(\"" ~ moduleName ~ "\");\n";
	}
	
	public String toString(){
		return "Typelib Directive";
	}	
}

class ParseTypeDirective : Directive{
	String typeName;
	
	public uint type(){
		return Directive.RootOnly;
	}
	
	public this(String typeName){
		this.typeName = typeName;
	}
	
	public void semanticPass(BaseEnkiParser root){
		root.setParseType(typeName);
	}
	
	public String toBNF(){
		return ".parsetype(\"" ~ typeName ~ "\");\n";
	}
	
	public String toString(){
		return "Parse-Type Directive";
	}	
}


class BoilerplateDirective : Directive{
	String code;
	
	public uint type(){
		return Directive.RootOnly;
	}
		
	public this(String code){
		this.code = code;
	}
	
	public void semanticPass(BaseEnkiParser root){
		root.setBoilerplate(code);
	}
	
	public String toBNF(){
		return ".boilerplate{{{" ~ code ~ "}}}\n";
	}
	
	public String toString(){
		return "Boilerplate Directive";
	}	
}

class HeaderDirective : Directive{
	String code;
	
	public uint type(){
		return Directive.FirstPass;
	}
		
	public this(String code){
		this.code = code;
	}
	
	public void semanticPass(BaseEnkiParser root){
		root.setHeader(code);
	}
	
	public String toBNF(){
		return ".header{{{" ~ code ~ "}}}\n";
	}
	
	public String toString(){
		return "Header Directive";
	}
}

class UTFDirective : Directive{
	String value;
	
	public uint type(){
		return Directive.RootOnly;
	}
		
	public this(String value){
		this.value = value;
	}
	
	public void semanticPass(BaseEnkiParser root){
		switch(value){
		case "8":
		case "32":
		case "16":
			break;
		default:
			throw new Exception("The value '" ~ value ~ "' is not a valid UTF parameter.  Expected '8', '16' or '32'");
		}
		root.setUTF(value);		
	}
	
	public String toBNF(){
		return ".utf(\"" ~ value ~ "\");\n";
	}	
	
	public String toString(){
		return "UTF Directive";
	}
}