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
module enki.bootstrap;

/**
	Bootstrap module for Enki.
	
	Generates EnkiParser.d and enki.bnf from parse-tree declared in this module.
	
	Build using "-version=Bootstrap".
*/

private import enki.types;
private import enki.EnkiBackend;
private import enki.CodeGenerator;
private import enki.Expression;
private import enki.Directive;
private import enki.Rule;

import tango.text.Util;
import tango.text.Unicode;
import tango.io.Stdout;
import tango.io.File;

// helper functions
public SubExpression[] makeTerm(SubExpression[] factors...){
	return factors.dup;
}

public SubExpression[][] orExpr(SubExpression[][] terms...){
	return terms.dup;
}

class EmptyLine : SyntaxLine{
	public void semanticPass(BaseEnkiParser root){
	}
	
	public String toBNF(){
		return "\n";
	}
	public String toString(){
		return "";
	}
}

static EmptyLine empty;
static this(){ empty = new EmptyLine(); }

void main(){
	SyntaxLine[] lines;
			
	lines ~= new BoilerplateDirective(`/+
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
+/`);

	lines ~= empty;
	lines ~= new Comment(" Enki Grammar Definition (self-hosting frontend)");
	lines ~= new ModuleDirective("enki.EnkiParser");
	lines ~= empty;
	lines ~= new ImportDirective("enki.EnkiBackend");
	lines ~= new ImportDirective("enki.Rule");
	lines ~= new ImportDirective("enki.Expression");
	lines ~= new ImportDirective("enki.Directive");
	
	lines ~= empty;
	lines ~= new DefineDirective("bool","eoi",true,"End of Input");
	lines ~= new DefineDirective("bool","eol",true,"End of Line");
	lines ~= new DefineDirective("bool","err",true,"Error");
	lines ~= new DefineDirective("String","letter",true,"Letter");
	lines ~= new DefineDirective("String","digit",true,"Digit");
	lines ~= new DefineDirective("String","hexdigit",true,"Hexdigit");
	lines ~= new DefineDirective("String","any",true,"any");
	lines ~= new DefineDirective("String","newline",true,"Newline");
	lines ~= new DefineDirective("String","sp",true,"Space(s)");
	lines ~= new DefineDirective("String","ws",false,"Whitespace");
	
	lines ~= empty;				
	lines ~= new ParseTypeDirective("String");
	lines ~= new UTFDirective("8");
	
	lines ~= empty;				
	lines ~= new BaseClassDirective("BaseEnkiParser");
	lines ~= new ClassnameDirective("EnkiParser");
	
	// SUPPORT
	lines ~= empty;
	lines ~= new Rule("WS",
		new DefaultPredicate(),
		new Expression(
			new Production("ws",null),
			new OptionalExpr(
				new Expression(
					new GroupExpr(
						new Expression(
							orExpr(
								makeTerm(new Production("SlashSlashComment",null)),
								makeTerm(new Production("SlashStarComment",null))
							)
						),
						null
					),
					new Production("WS",null)
				),
				null
			)
		)
	);	
	
	// SYNTAX
	lines ~= empty;
	lines ~= new Rule("Syntax",
		new FunctionPredicate(
			new Param(false,"void","createSyntax"),
			new Param(true,"SyntaxLine","lines")
		),
		new Expression(
			new Production("WS",null),
			new ZeroOrMoreExpr(
				new Expression(
					new GroupExpr(
						new Expression(
							orExpr(
								makeTerm(new Production("Rule",new Binding(true,"lines"))),
								makeTerm(new Production("Comment",new Binding(true,"lines"))),
								makeTerm(new Production("Directive",new Binding(true,"lines")))
							)
						),
						null
					),
					new Production("WS",null)
				),
				null,
				new Production("eoi",null)
			)
		)
	);
	
	lines ~= empty;
	lines ~= new Comment("");
	lines ~= new Comment(" Rule and Predicate");
	lines ~= new Comment("");

	//RULE
	lines ~= new Rule("Rule",
		new ClassPredicate(
			"Rule",
			new Param("name"),
			new Param("pred"),
			new Param("expr"),
			new Param("decl")
		),
		new Expression(
			new Production("Identifier",new Binding(false,"name")),
			new Production("WS",null),
			new OptionalExpr(
				new Expression(
					new Production("RuleDecl",new Binding(false,"decl")),
					new Production("WS",null)
				),
				null
			),
			new OptionalExpr(
				new Expression(
					new Production("RulePredicate",new Binding(false,"pred"))
				),
				null
			),
			new Production("WS",null),
			new Terminal("::=",null),
			new Production("WS",null),
			new Production("Expression",new Binding(false,"expr")),
			new Production("WS",null),
			new Terminal(";",null)
		)
	);
	
	lines ~= new Rule("RuleDecl",
		new ClassPredicate("RuleDecl",new Param(true,"Param","params")),
		new Expression(
			new Production("ParamsExpr",new Binding(false,"params"))
		)
	);

	lines ~= new Rule("RulePredicate",
		new BindingPredicate(new Param(false,"RulePredicate","pred")),
		new Expression(
			new Terminal("=",null),
			new Production("WS",null),
			new GroupExpr(
				new Expression(
					orExpr(
						makeTerm(new Production("ClassPredicate",new Binding(false,"pred"))),
						makeTerm(new Production("FunctionPredicate",new Binding(false,"pred"))),
						makeTerm(new Production("BindingPredicate",new Binding(false,"pred")))
					)
				),
				null
			)
		)
	);

	lines ~= new Rule("ClassPredicate",
		new ClassPredicate("ClassPredicate",
			new Param("name"),
			new Param("params")
		),
		new Expression(
			new Terminal("new",null),
			new Production("WS",null),
			new Production("Identifier",new Binding(false,"name")),
			new Production("WS",null),
			new Production("ParamsExpr",new Binding(false,"params"))
		)
	);

	lines ~= new Rule("FunctionPredicate",
		new ClassPredicate("FunctionPredicate",
			new Param("decl"),
			new Param("params")
		),
		new Expression(
			new Production("ExplicitParam",new Binding(false,"decl")),
			new Production("WS",null),
			new Production("ParamsExpr",new Binding(false,"params"))
		)
	);

	lines ~= new Rule("BindingPredicate",
		new ClassPredicate("BindingPredicate",
			new Param("param")
		),
		new Expression(
			new Production("Param",new Binding(false,"param"))
		)
	);

	lines ~= new Rule("ParamsExpr",
		new BindingPredicate(new Param(true,"Param","params")),
		new Expression(
			new Terminal("(",null),
			new Production("WS",null),
			new OptionalExpr(
				new Expression(
					new Production("Param",new Binding(true,"params")),
					new Production("WS",null),
					new ZeroOrMoreExpr(
						new Expression(
							new Terminal(",",null),
							new Production("WS",null),
							new Production("Param",new Binding(true,"params")),
							new Production("WS",null)
						),
						null,
						null
					)
				),
				null
			),
			new Terminal(")",null)
		)
	);

	lines ~= new Rule("Param",
		new BindingPredicate(new Param("param")),
		new Expression(
			orExpr(
				makeTerm(new Production("ExplicitParam",new Binding(false,"param"))),
				makeTerm(new Production("WeakParam",new Binding(false,"param")))
			)
		)
	);
	
	lines ~= new Rule("WeakParam",
		new ClassPredicate("Param",
			new Param("name")
		),
		new Expression(
			new Production("Identifier",new Binding(false,"name"))
		)
	);
	
	lines ~= new Rule("ExplicitParam",
		new ClassPredicate("Param",
			new Param(false,"bool","isArray"),
			new Param("type"),
			new Param("name")
		),
		new Expression(
			new Production("Identifier",new Binding(false,"type")),
			new Production("WS",null),
			new OptionalExpr(
				new Expression(
					new Terminal("[]",new Binding(false,"isArray")),
					new Production("Brackets",null),
					new Production("WS",null)
				),
				null
			),
			new Production("Identifier",new Binding(false,"name"))
		)
	);
	
 	lines ~= new Rule("Brackets",
 		new DefaultPredicate(),
 		new Expression(
 			new OptionalExpr(
 				new Expression(
 					new Terminal("[]",null),
 					new Production("Brackets",null)
 				),
 				null
 			)
 		)
 	);
	
	lines ~= new Comment("");
	lines ~= new Comment(" Expressions");
	lines ~= new Comment("");
	
	lines ~= new Rule("Expression",		
		new ClassPredicate("Expression",
			new Param(true,"Term","terms")
		),
		new Expression(
			new Production("Term",new Binding(true,"terms")),
			new Production("WS",null),
			new ZeroOrMoreExpr(
				new Expression(
					new Terminal("|",null),
					new Production("WS",null),
					new Production("Term",new Binding(true,"terms")),
					new Production("WS",null)
				),
				null,
				null
			)
		)
	);
	
	
	lines ~= new Rule("Term",		
		new BindingPredicate(new Param(true,"SubExpression","factors")),
		new Expression(
			new Production("SubExpression",new Binding(true,"factors")),
			new Production("WS",null),
			new ZeroOrMoreExpr(
				new Expression(
					new Production("SubExpression",new Binding(true,"factors")),
					new Production("WS",null)
				),
				null,
				null
			)
		)
	);
		
	lines ~= new Rule("SubExpression",
		new BindingPredicate(new Param(false,"SubExpression","expr")),
		new Expression(
			orExpr(
				makeTerm(new Production("Production",new Binding(false,"expr"))),
				makeTerm(new Production("Substitution",new Binding(false,"expr"))),
				makeTerm(new Production("Terminal",new Binding(false,"expr"))),
				makeTerm(new Production("Range",new Binding(false,"expr"))),
				makeTerm(new Production("Regexp",new Binding(false,"expr"))),
				makeTerm(new Production("GroupExpr",new Binding(false,"expr"))),
				makeTerm(new Production("OptionalExpr",new Binding(false,"expr"))),
				makeTerm(new Production("ZeroOrMoreExpr",new Binding(false,"expr"))),
				makeTerm(new Production("NegateExpr",new Binding(false,"expr"))),
				makeTerm(new Production("TestExpr",new Binding(false,"expr"))),
				makeTerm(new Production("LiteralExpr",new Binding(false,"expr"))),
				makeTerm(new Production("CustomTerminal",new Binding(false,"expr")))
			)
		)
	);	

	lines ~= new Rule("Production",
		new ClassPredicate("Production",
			new Param("name"),
			new Param("binding"),
			new Param(true,"ProductionArg","args")
		),
		new Expression(
			new Production("Identifier",new Binding(false,"name")),
			new Production("WS",null),
			new OptionalExpr(
				new Expression(
					new Terminal("!(",null),
					new Production("WS",null),
					new Production("ProductionArg",new Binding(true,"args")),
					new ZeroOrMoreExpr(
						new Expression(
							new Production("WS",null),
							new Terminal(",",null),
							new Production("WS",null),
							new Production("ProductionArg",new Binding(true,"args"))
						),
						null,
						new Terminal(")",null)
					)
				),
				null
			),
			new OptionalExpr(
				new Expression(
					new Production("Binding",new Binding(false,"binding"))
				),
				null
			)
		)
	);

	lines ~= new Rule("ProductionArg",
		new BindingPredicate(new Param(false,"ProductionArg","arg")),
		new Expression(
			orExpr(
				makeTerm(new Production("StringProductionArg",new Binding(false,"arg"))),
				makeTerm(new Production("BindingProductionArg",new Binding(false,"arg")))
			)
		)
	);
	
	lines ~= new Rule("StringProductionArg",
		new ClassPredicate("StringProductionArg",new Param(false,"String","value")),
		new Expression(
			new Production("String",new Binding(false,"value"))
		)
	);
	

	lines ~= new Rule("BindingProductionArg",
		new ClassPredicate("BindingProductionArg",new Param(false,"String","value")),
		new Expression(
			new Production("Identifier",new Binding(false,"value"))
		)
	);

	lines ~= new Rule("Substitution",
		new ClassPredicate("Substitution",
			new Param(false,"String","name"),
			new Param(false,"Binding","binding")
		),
		new Expression(
			new Terminal(".",null),
			new Production("Identifier",new Binding(false,"name")),
			new Production("WS",null),
			new OptionalExpr(
				new Expression(
					new Production("Binding",new Binding(false,"binding"))
				),
				null
			)
		)
	);
	
	lines ~= new Rule("GroupExpr",
		new ClassPredicate("GroupExpr",
			new Param("expr"),
			new Param("binding")
		),
		new Expression(
			new Terminal("(",null),
			new Production("WS",null),
			new Production("Expression",new Binding(false,"expr")),
			new Production("WS",null),
			new Terminal(")",null),
			new Production("WS",null),		
			new OptionalExpr(
				new Expression(
					new Production("Binding",new Binding(false,"binding"))
				),
				null
			)
		)
	);    
    
	lines ~= new Rule("OptionalExpr",
		new ClassPredicate("OptionalExpr",
			new Param("expr"),
			new Param("binding")
		),
		new Expression(
			new Terminal("[",null),
			new Production("WS",null),
			new Production("Expression",new Binding(false,"expr")),
			new Production("WS",null),
			new Terminal("]",null),
			new Production("WS",null),		
			new OptionalExpr(
				new Expression(
					new Production("Binding",new Binding(false,"binding"))
				),
				null
			)
		)
	);		
        
	lines ~= new Rule("ZeroOrMoreExpr",
		new ClassPredicate("ZeroOrMoreExpr",
			new Param("expr"),
			new Param("binding"),
			new Param("term")
		),
		new Expression(
			new Terminal("{",null),
			new Production("WS",null),
			new Production("Expression",new Binding(false,"expr")),
			new Production("WS",null),
			new Terminal("}",null),
			new Production("WS",null),		
			new OptionalExpr(
				new Expression(
					new Production("Binding",new Binding(false,"binding")),
					new Production("WS",null)
				),
				null
			),			
			new OptionalExpr(
				new Expression(
					new Production("SubExpression",new Binding(false,"term"))
				),
				null
			)
		)
	);		
		
	lines ~= new Rule("Terminal",
		new ClassPredicate("Terminal",
			new Param("text"),
			new Param("binding")
		),
		new Expression(
			new Production("String",new Binding(false,"text")),
			new Production("WS",null),
			new OptionalExpr(
				new Expression(
					new Production("Binding",new Binding(false,"binding"))
				),
				null
			)
		)
	);
		
	lines ~= new Rule("Range",
		new ClassPredicate("Range",
			new Param("start"),
			new Param("end"),
			new Param("binding")
		),
		new Expression(
			new Production("HexExpr",new Binding(false,"start")),
			new Production("WS",null),
			new OptionalExpr(
				new Expression(
					new Terminal("-",null),
					new Production("WS",null),				
					new Production("HexExpr",new Binding(false,"end")),
					new Production("WS",null)
				),
				null
			),
			new OptionalExpr(
				new Expression(
					new Production("Binding",new Binding(false,"binding"))
				),
				null
			)
		)
	);
	
	lines ~= new Rule("Regexp",
		new ClassPredicate("Regexp",
			new Param("text"),
			new Param("binding")
		),
		new Expression(
			new GroupExpr(
					new Expression(
					orExpr(
						makeTerm(
							new Terminal("r",null),
							new Production("String",new Binding(false,"text"))
						),
						makeTerm(
							new Terminal("`",null),
							new ZeroOrMoreExpr(
								new Expression(
									new Production("any",null)
								),
								new Binding(false,"text"),
								new Terminal("`",null)
							)
						)
					)
				),
				null
			),
			new Production("WS",null),
			new OptionalExpr(
				new Expression(
					new Production("Binding",new Binding(false,"binding"))
				),
				null
			)
		)
	);

	lines ~= new Rule("NegateExpr",
		new ClassPredicate("Negate",
			new Param(false,"SubExpression","expr")
		),
		new Expression(
			new Terminal("!",null),
			new Production("WS",null),
			new Production("SubExpression",new Binding(false,"expr"))
		)
	);

	lines ~= new Rule("TestExpr",
		new ClassPredicate("Test",
			new Param(false,"SubExpression","expr")
		),
		new Expression(
			new Terminal("/",null),
			new Production("WS",null),
			new Production("SubExpression",new Binding(false,"expr"))
		)
	);
	
	lines ~= new Rule("LiteralExpr",
		new ClassPredicate("LiteralExpr",
			new Param(false,"String","name"),
			new Param(false,"Binding","binding"),
			new Param(true,"ProductionArg","args")
		),
		new Expression(
			new Terminal("@",null),
			new Production("Identifier",new Binding(false,"name")),
			new Production("WS",null),
			new OptionalExpr(
				new Expression(
					new Terminal("!(",null),
					new Production("WS",null),
					new Production("ProductionArg",new Binding(true,"args")),
					new ZeroOrMoreExpr(
						new Expression(
							new Production("WS",null),
							new Terminal(",",null),
							new Production("WS",null),
							new Production("ProductionArg",new Binding(true,"args"))
					),
						null,
						new Terminal(")",null)
					)
				),
				null
			),			
			new OptionalExpr(
				new Expression(
					new Production("Binding",new Binding(false,"binding"))
				),
				null
			)
		)
	);
	
	lines ~= new Rule("CustomTerminal",
		new ClassPredicate("CustomTerminal",
			new Param(false,"String","name"),
			new Param(false,"Binding","binding")
		),
		new Expression(
			new Terminal("&",null),
			new Production("Identifier",new Binding(false,"name")),
			new Production("WS",null),
			new OptionalExpr(
				new Expression(
					new Production("Binding",new Binding(false,"binding"))
				),
				null
			)
		)
	);
	lines ~= new Rule("Binding",
		new ClassPredicate("Binding",
			new Param(false,"bool","isConcat"),
			new Param("name")
		),
		new Expression(
			new Terminal(":",null),
			new Production("WS",null),
			new OptionalExpr(
				new Expression(
					new Terminal("~",null)
				),
				new Binding(false,"isConcat")
			),
			new Production("WS",null),
			new Production("Identifier",new Binding(false,"name"))
		)
	);		
		
	lines ~= new Rule("Identifier",
		new BindingPredicate(new Param("value")),
		new Expression(
			new GroupExpr(
				new Expression(
					new Production("IdentifierStartChar",null),
					new ZeroOrMoreExpr(
						new Expression(
							new Production("IdentifierChar",null)
						),
						null,
						null 
					)
				),
				new Binding(false,"value")
			)
		)
	);
	
	lines ~= new Rule("IdentifierStartChar",
		new BindingPredicate(new Param("text")),
		new Expression(
			new GroupExpr(
				new Expression(
					orExpr(
						makeTerm(new Production("letter",null)),
						makeTerm(new Terminal("_",null))
					)
				),
				new Binding(false,"text")
			)
		)
	);
	
	lines ~= new Rule("IdentifierChar",
		new BindingPredicate(new Param("text")),
		new Expression(
			new GroupExpr(
				new Expression(
					orExpr(
						makeTerm(new Production("letter",null)),
						makeTerm(new Production("digit",null)),
						makeTerm(new Terminal("_",null)),
						makeTerm(new Terminal(".",null))
					)
				),
				new Binding(false,"text")
			)
		)
	);	
	
	lines ~= new Rule("String",
		new BindingPredicate(new Param("text")),
		new Expression(
			new GroupExpr(
				new Expression(
					orExpr(
						makeTerm(new Terminal("\\\"",null)),
						makeTerm(new Terminal("\\\'",null))
					)
				),
				new Binding(true,"delim")
			),
			new ZeroOrMoreExpr(
				new Expression(
					new Production("AnyChar",null)
				),
				new Binding(false,"text"),
				new Substitution("delim",null)
			)
		)
	);
	
	lines ~= new Rule("HexExpr",
		new BindingPredicate(new Param(false,"String","text")),
		new Expression(
			new Terminal("#",null),
			new GroupExpr(
				new Expression(
					new Production("hexdigit",null),
					new Production("hexdigit",null),
					new OptionalExpr(
						new Expression(
							new Production("hexdigit",null),
							new Production("hexdigit",null),
							new OptionalExpr(
								new Expression(
									new Production("hexdigit",null),
									new Production("hexdigit",null),
									new Production("hexdigit",null),
									new Production("hexdigit",null),
									new OptionalExpr(
										new Expression(
											new Production("hexdigit",null),
											new Production("hexdigit",null),
											new Production("hexdigit",null),
											new Production("hexdigit",null),
											new Production("hexdigit",null),
											new Production("hexdigit",null),
											new Production("hexdigit",null),
											new Production("hexdigit",null)	
										),
										null
									)	
								),
								null
							)					
						),
						null
					)
				),
				new Binding(false,"text")
			)
		)
	);
	
	lines ~= new Rule("AnyChar",
		new BindingPredicate(new Param("value")),
		new Expression(
			new OptionalExpr(
				new Expression(
					new Terminal("\\\\",new Binding(true,"value"))
				),
				null
			),
			new Production("any",new Binding(true,"value"))
		)
	);
	
	lines ~= empty;
	lines ~= new Comment("");
	lines ~= new Comment(" Comments");
	lines ~= new Comment("");	
	
	lines ~= empty;
	lines ~= new Rule("Comment",
		new ClassPredicate("Comment",new Param("text")),
		new Expression(
			orExpr(
				makeTerm(new Production("PoundComment",new Binding(false,"text"))),
				makeTerm(new Production("SlashSlashComment",new Binding(false,"text"))),
				makeTerm(new Production("SlashStarComment",new Binding(false,"text")))
			)
		)
	);		
	
	lines ~= new Rule("PoundComment",
		new BindingPredicate(new Param(false,"String","text")),
		new Expression(
			new Terminal("#",null),
			new ZeroOrMoreExpr(
				new Expression(
					new Production("any",null)
				),
				new Binding(false,"text"),
				new Production("eol",null)
			)
		)
	);
	
	lines ~= new Rule("SlashSlashComment",
		new BindingPredicate(new Param(false,"String","text")),
		new Expression(
			new Terminal("\\x2F\\x2F",null),
			new ZeroOrMoreExpr(
				new Expression(
					new Production("any",null)
				),
				new Binding(false,"text"),
				new Production("eol",null)
			)
		)
	);
	
	lines ~= new Rule("SlashStarComment",
		new BindingPredicate(new Param(false,"String","text")),
		new Expression(
			new Terminal("\\x2F\\x2A",null),
			new ZeroOrMoreExpr(
				new Expression(
					new Production("any",null)
				),
				new Binding(false,"text"),
				new Terminal("\\x2A\\x2F",null)
			)
		)
	);		
		
	lines ~= empty;
	lines ~= new Comment("");
	lines ~= new Comment(" Directives");
	lines ~= new Comment("");

	lines ~= new Rule("Directive",
		new BindingPredicate(new Param(false,"Directive","dir")),
		new Expression(
			new Terminal(".",null),
			new GroupExpr(
				new Expression(
					orExpr(
						makeTerm(new Production("ImportDirective",new Binding(true,"dir"))),
						makeTerm(new Production("BaseClassDirective",new Binding(true,"dir"))),
						makeTerm(new Production("ClassnameDirective",new Binding(true,"dir"))),
						makeTerm(new Production("DefineDirective",new Binding(true,"dir"))),
						makeTerm(new Production("IncludeDirective",new Binding(true,"dir"))),
						makeTerm(new Production("AliasDirective",new Binding(true,"dir"))),
						makeTerm(new Production("ModuleDirective",new Binding(true,"dir"))),
						makeTerm(new Production("CodeDirective",new Binding(true,"dir"))),
						makeTerm(new Production("TypelibDirective",new Binding(true,"dir"))),
						makeTerm(new Production("ParseTypeDirective",new Binding(true,"dir"))),
						makeTerm(new Production("BoilerplateDirective",new Binding(true,"dir"))),
						makeTerm(new Production("HeaderDirective",new Binding(true,"dir"))),
						makeTerm(new Production("UTFDirective",new Binding(true,"dir")))
					)
				),
				null
			)
		)
	);	
	
	lines ~= new Rule("ImportDirective",
		new ClassPredicate("ImportDirective", new Param("imp")),
		new Expression(
			new Terminal("import",null),
			new Production("WS",null),
			new Terminal("(",null),
			new Production("WS",null),
			new Production("DirectiveArg",new Binding(false,"imp")),
			new Production("WS",null),
			new Terminal(")",null),
			new Production("WS",null),
			new Terminal(";",null)			
		)
	);
	
	lines ~= new Rule("BaseClassDirective",
		new ClassPredicate("BaseClassDirective", new Param("name")),
		new Expression(
			new Terminal("baseclass",null),
			new Production("WS",null),
			new Terminal("(",null),
			new Production("WS",null),
			new Production("DirectiveArg",new Binding(false,"name")),
			new Production("WS",null),
			new Terminal(")",null),
			new Production("WS",null),
			new Terminal(";",null)			
		)
	);
	
	lines ~= new Rule("ClassnameDirective",
		new ClassPredicate("ClassnameDirective", new Param("name")),
		new Expression(
			new Terminal("classname",null),
			new Production("WS",null),
			new Terminal("(",null),
			new Production("WS",null),
			new Production("DirectiveArg",new Binding(false,"name")),
			new Production("WS",null),
			new Terminal(")",null),
			new Production("WS",null),
			new Terminal(";",null)			
		)
	);
		
	lines ~= new Rule("DefineDirective",
		new ClassPredicate("DefineDirective", 
			new Param("returnType"),
			new Param("name"),
			new Param(false,"bool","isTerminal"),
			new Param("description")
			),
		new Expression(
			new Terminal("define",null),
			new Production("WS",null),
			new Terminal("(",null),
			new Production("WS",null),
			new Production("DirectiveArg",new Binding(false,"returnType")),
			new Production("WS",null),
			
			new Terminal(",",null),		
			new Production("WS",null),
			new Production("DirectiveArg",new Binding(false,"name")),
			new Production("WS",null),
			
			new Terminal(",",null),		
			new Production("WS",null),
			new Production("DirectiveArg",new Binding(false,"isTerminal")),
			new Production("WS",null),			
			
			new OptionalExpr(
				new Expression(
					new Terminal(",",null),			
					new Production("WS",null),
					new Production("DirectiveArg",new Binding(false,"description")),
					new Production("WS",null)
				),
				null
			),			
			new Terminal(")",null),
			new Production("WS",null),
			new Terminal(";",null)
		)
	);
					
	lines ~= new Rule("IncludeDirective",
		new ClassPredicate("IncludeDirective", new Param("filename")),
		new Expression(
			new Terminal("include",null),
			new Production("WS",null),
			new Terminal("(",null),
			new Production("WS",null),
			new Production("String",new Binding(false,"filename")),
			new Production("WS",null),
			new Terminal(")",null),
			new Production("WS",null),
			new Terminal(";",null)
		)
	);	
		
	lines ~= new Rule("AliasDirective",
		new ClassPredicate("AliasDirective", 
			new Param("rule"),
			new Param("ruleAlias")
		),
		new Expression(
			new Terminal("alias",null),
			new Production("WS",null),
			new Terminal("(",null),
			new Production("WS",null),
			new Production("DirectiveArg",new Binding(false,"rule")),
			new Production("WS",null),
			new Terminal(",",null),
			new Production("WS",null),
			new Production("DirectiveArg",new Binding(false,"ruleAlias")),
			new Production("WS",null),			
			new Terminal(")",null),
			new Production("WS",null),
			new Terminal(";",null)			
		)
	);	
			
	lines ~= new Rule("ModuleDirective",
		new ClassPredicate("ModuleDirective", new Param("moduleName")),
		new Expression(
			new Terminal("module",null),
			new Production("WS",null),
			new Terminal("(",null),
			new Production("WS",null),
			new Production("DirectiveArg",new Binding(false,"moduleName")),
			new Production("WS",null),
			new Terminal(")",null),
			new Production("WS",null),
			new Terminal(";",null)			
		)
	);	
	
	lines ~= new Rule("CodeDirective",
		new ClassPredicate("CodeDirective", new Param("code")),
		new Expression(
			new Terminal("code",null),
			new Production("WS",null),
			new Terminal("{{{",null),
			new ZeroOrMoreExpr(
				new Expression(
					new Production("any",null)
				),
				new Binding(false,"code"),
				new Terminal("}}}",null)
			)
		)
	);
	
	lines ~= new Rule("TypelibDirective",
		new ClassPredicate("TypelibDirective", new Param("importName")),
		new Expression(
			new Terminal("typelib",null),
			new Production("WS",null),
			new Terminal("(",null),
			new Production("WS",null),
			new Production("DirectiveArg",new Binding(false,"importName")),
			new Production("WS",null),
			new Terminal(")",null),
			new Production("WS",null),
			new Terminal(";",null)			
		)
	);	
	
	lines ~= new Rule("ParseTypeDirective",
		new ClassPredicate("ParseTypeDirective", new Param("typeName")),
		new Expression(
			new Terminal("parsetype",null),
			new Production("WS",null),
			new Terminal("(",null),
			new Production("WS",null),
			new Production("DirectiveArg",new Binding(false,"typeName")),
			new Production("WS",null),
			new Terminal(")",null),
			new Production("WS",null),
			new Terminal(";",null)			
		)
	);	
		
	lines ~= new Rule("BoilerplateDirective",
		new ClassPredicate("BoilerplateDirective", new Param("code")),
		new Expression(
			new Terminal("boilerplate",null),
			new Production("WS",null),
			new Terminal("{{{",null),
			new ZeroOrMoreExpr(
				new Expression(
					new Production("any",null)
				),
				new Binding(false,"code"),
				new Terminal("}}}",null)
			)
		)
	);	
		
	lines ~= new Rule("HeaderDirective",
		new ClassPredicate("HeaderDirective", new Param("code")),
		new Expression(
			new Terminal("header",null),
			new Production("WS",null),
			new Terminal("{{{",null),
			new ZeroOrMoreExpr(
				new Expression(
					new Production("any",null)
				),
				new Binding(false,"code"),
				new Terminal("}}}",null)
			)
		)
	);
	
	lines ~= new Rule("UTFDirective",
		new ClassPredicate("UTFDirective", new Param("value")),
		new Expression(
			new Terminal("utf",null),
			new Production("WS",null),
			new Terminal("(",null),
			new Production("WS",null),
			new Production("DirectiveArg",new Binding(false,"value")),
			new Production("WS",null),
			new Terminal(")",null),
			new Production("WS",null),
			new Terminal(";",null)			
		)
	);
	
	lines ~= new Rule("DirectiveArg",
		new BindingPredicate(new Param("arg")),
		new Expression(
			orExpr(
				makeTerm(new Production("Identifier",new Binding(false,"arg"))),
				makeTerm(new Production("String",new Binding(false,"arg")))
			)
		)
	);
		
		
	// setup the syntax tree
	auto syntax = new BaseEnkiParser();
	syntax.createSyntax(lines);
	syntax.semanticPass();

	// create bnf file
	File("enki/enki.bnf").write(syntax.toBNF());					
	
	// emit the code
	File("enki/EnkiParser.d").write(syntax.render());		
}