/+
    Copyright (c) 2008 Eric Anderton

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
module enki.generator.JavascriptGenerator;

import enki.types;
import enki.generator.TextGenerator;
import enki.generator.BNFGenerator;
import enkilib.d.ParserException;

import tango.io.model.IBuffer;
import tango.text.Util;

debug import tango.io.Stdout;

//TODO: port to Javascript
//TODO: use named breaks to simulate goto
/*
	label: {
		break label;
	}
*/
class JavascriptGenerator: TextGenerator{
	alias BNFGenerator BNFGenerator;
	
	public AttributeSet attrs;	
	uint identifierId;	
	
	public static char[] getHelp(){
		return 
`Javascript Generator for Enki V2.0
Copyright (c) 2008 Eric Anderton

Work in Progress

Generates a parser based on the input 
EBNF that is suitable for use with 
Javascript 2.0.

The support code for running the 
generated parser is available in the 
Enki SDK, under /enkilib/js/.
`;
	}

	public this(){
		attrs.set("js","header","");
		attrs.set("js","baseclass","CharParser");
		attrs.set("js","filename","Parser.js");
		attrs.set("js","classname","Parser");
	}

	public char[] getFilename(){
		return attrs.get("java","filename");
	}

	protected void visitList(T,S,V...)(T[] list,S delim,V args){
		foreach(i,item; list){
			if(i > 0) emit(delim);
			this.visit(item,args);
		}
	}

	protected void visitList(T,S1,S2,V...)(T[] list,S1 prefix,S2 delim,V args){
		foreach(i,item; list){
			if(i > 0) emit(delim);
			emit(prefix);
			this.visit(item,args);
		}
	}

	protected String safeString(String value){
		String result = value;

		result = substitute(result,"\\",`\\`);
		result = substitute(result,"\n",`\n`);
		result = substitute(result,"\r",`\r`);
		result = substitute(result,"\t",`\t`);
		result = substitute(result,"\"",`\"`);
		result = substitute(result,"\x2A\x2F",`\x2A\x2F`); // slash-star closing
		result = substitute(result,"\x2A\x2B",`\x2A\x2B`); // slash-plus closing
		return result;
	}
	
	void startIdGen(){
		identifierId = 0;
	}

	String getId(String kind=""){
		String id = Integer.toString(identifierId);
		identifierId++;
		return id;
	}

	String getPassId(){
		return getId("pass");
	}

	String getFailId(){
		return getId("fail");
	}

	String getTermId(){
		return getId("term");
	}

	void emitId(String id){
		emitln("case {0}:",id);
	}

	void emitGoto(String id){
		emitln("__state = {0}; break;",id);
	}

	String savePositionId(){
		String id = "position" ~ Integer.toString(identifierId);
		identifierId++;
		emitln("var {0} = getPos();",id);
		return id;
	}

	void assignSlice(Binding binding,String startPositionId){
		if(binding.isConcat){
			emitln("smartAppend(var_{0},slice({1},getPos()));",binding.name,startPositionId);
		}
		else{
			emitln("smartAssign(var_{0},slice({1},getPos()));",binding.name,startPositionId);
		}
	}

	void assignResults(Binding binding,String predicateType){
		if(binding.isConcat){
			emitln("smartAppend(var_{0},getMatchValue!({1})());",binding.name,predicateType);
		}
		else{
			emitln("smartAssign(var_{0},getMatchValue!({1})());",binding.name,predicateType);
		}
	}

	void unwind(String posId){
		emitln("setPos({0});",posId);
	}

	void visit(AttributeSet attrs){
		this.attrs.mesh(attrs);
	}

	void visit(RuleSet ruleSet){
		auto header = attrs.get("js","header");
		auto baseclass = attrs.get("js","baseclass");
		auto classname = attrs.get("js","classname");

		// header
		emitln(header);
		
		// classname and baseclass
		newline;
		emitln("function {0}{{",classname);
		indent;
			emitln("this = {0}();",baseclass);
			emitln("return this;");
		unindent;
		emitln("}");

		// class body
		foreach(rule;ruleSet.getRules()){
			newline;
			visit(rule);
		}
	}

	void visit(Rule obj){
		startIdGen();
		auto bnf = new BNFGenerator(this);

		// emit as comment w/complete BNF data
		emitln("/*");
			//bnf.indent;
			bnf.visit(obj);
			//bnf.unindent;
		emitln("*/");

		// generate code for rule

		if(cast(RuleAlias) obj)           visit(cast(RuleAlias) obj);
		else if(cast(RulePrototype) obj)  visit(cast(RulePrototype) obj);
		else if(cast(RuleDefinition) obj) visit(cast(RuleDefinition) obj);
		else if(cast(Comment) obj)        visit(cast(Comment) obj);

	}

	void visit(RuleAlias obj){
		//do nothing
		emitln("function.prototype.parse_{0} = function(){",obj.aliasRule);
		indent;
			emitln("return this.parse_{0}.call(arguments);",obj.name);
		unindent;
		emitln("}");
	}

	void visit(RulePrototype obj){
		//do nothing
	}

	void visit(RuleDefinition obj){
		auto startId = getId();
		auto passId = getId();
		auto failId = getId();
		
		with(obj){			
			emit("{0}.prototype.parse_{1} = function(",attrs.get("js","classname"),name);
			if(ruleParameters.length > 0){
				bool first = true;
				foreach(var; variableRefs.all){
					if(var.flavor == VariableRef.RuleParameter){
						if(!first) emit(",");
						emit("var_{0}",var.name);
						first = false;
					}
				}
			}
			emitln("){{");
			indent;
				emitln("if(debug) console.info(\"parse_{0} \");",name);
				emitln("var __state = {0};",startId);
				foreach(var; variableRefs.all){
					if(var.flavor != VariableRef.RuleParameter) visit(var);
				}
				if(variableRefs.all.length > 0){
					newline;
				}
				emitln("while(true) switch(__state){{");
				emitId(startId);
				
				visit(expr,passId,failId);
	
				emitln("// Rule");
				emitId(passId);
				indent;
					auto fnPred = cast(FunctionPredicate)pred;
					if(fnPred && fnPred.decl.type == "void"){
						visit(pred);
						emitln(";");
						emitln("if(debug) console.info(\"passed\");");
					}
					else if(type != "void"){
						emit("setMatchValue(");
						visit(pred);
						emitln(");");
						emitln("if(debug) console.info(\"\\tparse_{0} passed: \",getMatchValue({1}));",name,type);
					}
					emitln("return true;");
				unindent;
				emitId(failId);
				indent;
					if(type != "void"){
						emitln("setMatchValue(undefined);",type);
					}
					emitln("if(debug) console.info(\"\\t parse_{0} failed\");",name);
					emitln("return false;");
				unindent;
				emitln("}");
			unindent;
			emitln("}");
		}
	}

	void visit(Comment obj){
		//do nothing
		newline;
		emitln("/*");
		emitln(substitute(obj.comment,"\x2A\x2F",`\x2A\x2F`));
		emitln("*/");
		newline;
	}

	void visit(VariableRef obj){
		if(obj.name){
			auto param = cast(Param)obj;
			if(param && param.value){
				emitln("var var_{0} = \"{1}\";",param.name,safeString(param.value));
			}
			else{
				emitln("var var_{0};",obj.name);
			}
		}
	}

	// visitor dispatch routine
	void visit(Expression obj,String passId,String failId){
		if(cast(AndGroup) obj)               visit(cast(AndGroup) obj,passId,failId);
		else if(cast(Optional) obj)          visit(cast(Optional) obj,passId,failId);
		else if(cast(CharRange) obj)         visit(cast(CharRange) obj,passId,failId);
		else if(cast(OrGroup) obj)           visit(cast(OrGroup) obj,passId,failId);
		else if(cast(CustomTerminal) obj)    visit(cast(CustomTerminal) obj,passId,failId);
		else if(cast(Production) obj)        visit(cast(Production) obj,passId,failId);
		else if(cast(Group) obj)             visit(cast(Group) obj,passId,failId);
		else if(cast(RegularExpression) obj) visit(cast(RegularExpression) obj,passId,failId);
		else if(cast(Iterator) obj)          visit(cast(Iterator) obj,passId,failId);
		else if(cast(Substitution) obj)      visit(cast(Substitution) obj,passId,failId);
		else if(cast(Literal) obj)           visit(cast(Literal) obj,passId,failId);
		else if(cast(Terminal) obj)          visit(cast(Terminal) obj,passId,failId);
		else if(cast(Negate) obj)            visit(cast(Negate) obj,passId,failId);
		else if(cast(Test) obj)              visit(cast(Test) obj,passId,failId);
		else if(cast(ErrorPoint) obj)	     visit(cast(ErrorPoint) obj,passId,failId);
	}

	void visit(AndGroup obj,String parentPassId,String parentFailId){
		auto passId = parentPassId;
		auto failId = parentFailId;
		String posId;
		bool exprNeedsUnwind = obj.exprs.length > 1;

		with(obj){
			emitln("// AndGroup");
			indent;
			if(binding || exprNeedsUnwind){
				posId = savePositionId();
				failId = getFailId();
			}
			foreach(i,expr; exprs){
				if(!binding && i == exprs.length-1){
					indent;
						visit(expr,passId,failId);
					unindent;
				}
				else{
					auto termId = getTermId();
					indent;
						visit(expr,termId,failId);
					unindent;
					emitId(termId);
				}
			}
			if(binding){
				assignSlice(binding,posId);
				emitGoto(passId);
			}
			if(exprNeedsUnwind){
				emitId(failId);
				unwind(posId);
				emitGoto(parentFailId);
			}
			unindent;
		}
	}

	void visit(Optional obj,String parentPassId,String parentFailId){
		with(obj){
			emitln("// Optional");
			indent;
				if(binding){
					String posId = savePositionId();
					String passId = getPassId();
					String failId = getFailId();

					indent;
						visit(expr,passId,failId);
					unindent;

					emitId(passId);
					indent;
						assignSlice(binding,posId);
					unindent;
					emitId(failId);
					indent;
						emitGoto(parentPassId);
					unindent;
				}
				else{
					visit(expr,parentPassId,parentPassId);
				}
			unindent;
		}
	}

	void visit(CharRange obj,String parentPassId,String parentFailId){
		with(obj){
			emitln("// CharRange");
			if(noRange){
				emitln(`if(match('\x{0:X}')){{`,start);
			}
			else{
				emitln(`if(match('\x{0:X}','\x{1:X}')){{`,start,end);
			}
			indent;
				if(binding){
					assignResults(binding,"String"); //TODO: fix me!
				}
				emitGoto(parentPassId);
			unindent;
			emitln("}");
			emitln("else{{");
			indent;
				emitGoto(parentFailId);
			unindent;
			emitln("}");
		}
	}

	void visit(OrGroup obj,String parentPassId,String parentFailId){
		auto passId = parentPassId;
		auto failId = parentFailId;
		String posId;
		with(obj){
			emitln("// OrGroup");
			if(binding){
				posId = savePositionId();
				passId = getPassId();
			}
			bool unwindNext = false;
			foreach(i,expr; exprs){
				indent;
				if(unwindNext){
					unwind(posId);
				}
				if(!binding && i == exprs.length-1){
					visit(expr,passId,failId);
					unindent;
				}
				else{
					auto termId = getTermId();
					visit(expr,passId,termId);
					unindent;
					emitId(termId);
				}
			}
			if(binding){
				emitId(passId);
				indent;
					assignSlice(binding,posId);
					emitGoto(parentPassId);
				unindent;
			}
		}
	}

	void visit(CustomTerminal obj,String parentPassId,String parentFailId){
		with(obj){
			emitln("// CustomTerminal");
			emitln("if(match({0})){{",name);
			indent;
				if(binding){
					assignResults(binding,"String"); //TODO: FIX ME
				}
				emitGoto(parentPassId);
			unindent;
			emitln("}");
			emitln("else{{");
			indent;
				emitGoto(parentFailId);
			unindent;
			emitln("}");
		}
	}

	void visit(Production obj,String parentPassId,String parentFailId){
		String posId;		
		with(obj){
			debug Stdout.format("visit Production: {1:6} {0:20} '{2}'",name,passComplete,type).newline;

			emitln("// Production");
			if(type == "void"){
				posId = savePositionId();				
			}
			emit("if(parse_{0}(",name);
			visitList(args,",");
			emitln(")){{");
			indent;
				if(binding){
					if(type != "void"){
						assignResults(binding,type);
					}
					else{
						assignSlice(binding,posId);
					}
				}
				emitGoto(parentPassId);
			unindent;
			emitln("}");
			emitln("else{{");
			indent;
				emitGoto(parentFailId);
			unindent;
			emitln("}");
		}
	}

	void visit(Group obj,String parentPassId,String parentFailId){
		auto passId = parentPassId;
		auto failId = parentFailId;
		String posId;
		with(obj){
			emitln("// Group");
			indent;
				if(binding){
					posId = savePositionId();
					passId = getPassId();
				}
				visit(expr,passId,failId);
				if(binding){
					emitId(passId);
					assignSlice(binding,posId);
				}
				emitGoto(parentPassId);
			unindent;
		}
	}

	void visit(RegularExpression obj,String parentPassId,String parentFailId){
		with(obj){
			emitln("// RegularExpression");
			emitln("if(regex(`{0}`)){{",text);
			indent;
				if(binding){
					assignResults(binding,"String"); //TODO: fix me
				}
				emitGoto(parentPassId);
			unindent;
			emitln("}");
			emitln("else{{");
			indent;
				emitGoto(parentFailId);
			unindent;
			emitln("}");
		}
	}

	void visit(Iterator obj,String parentPassId,String parentFailId){
		String loopStartId;
		String loopEndId;
		String exprId;
		String counterId;
		String incrementId;
		String delimeterId;
		String oneOrMoreTestId;
		String rangeTestId;
		bool hasRanges = obj.ranges && obj.ranges.length > 0;
		bool hasCounter = hasRanges;

		with(obj){
			// loop setup
			loopStartId = getId("start");
			loopEndId = parentPassId;
			exprId = getId("expr");

			// hook end of loop if needed
			if(hasRanges){
				rangeTestId = getId("ranges");
				loopEndId = rangeTestId;
			}

			// hook end of loop if needed
			if(!allowZero){
				oneOrMoreTestId = getId("nonZeroTest");
				loopEndId = oneOrMoreTestId;
				hasCounter = true;
				emitln("// OneOrMore");
			}
			else{
				emitln("// ZeroOrMore");
			}

			if(delim){
				delimeterId = getId("delimeter");
			}

			indent;
				if(hasCounter){
					counterId = getId("counter");
					emitln("size_t {0} = 0;",counterId);
					incrementId = getId("increment");
				}

				// terminator: continue loop on fail, terminate loop on pass
				emitId(loopStartId);
				if(term){
					emitln("// (terminator)");
					indent;
						if(hasCounter){
							visit(term,loopEndId,exprId);
						}
						else{
							visit(term,loopEndId,exprId);
						}
					unindent;
				}

				// expression
				emitln("// (iterator expression)");
				emitId(exprId);
				indent;
					if(hasCounter){
						visit(expr,incrementId,loopEndId);
					}
					else if(delim){	
						visit(expr,delimeterId,loopEndId);
					}
					else{
						visit(expr,loopStartId,loopEndId);
					}
				unindent;


				// increment counter (if applicable)
				if(hasCounter){
					emitln("// (increment expr count)");
					emitId(incrementId);
					indent;
						emitln("{0} ++;",counterId);
						if(!delim){
							emitGoto(loopStartId);
						}
					unindent;
				}

				// delimiter: trigger parent failure on fail, continue loop on pass
				if(delim){
					emitln("// (delimeter)");
					emitId(delimeterId);
					indent;
						visit(delim,loopStartId,parentFailId);
					unindent;
				}

				// test for at least one entry (if applicable)
				if(!allowZero){
					emitln("// (one or more test)");
					emitId(oneOrMoreTestId);
					indent;
						emitln("if({0} >= 1){{",counterId);
						indent;
							if(hasRanges){
								emitGoto(rangeTestId);
							}
							else{
								emitGoto(parentPassId);
							}
						unindent;
						emitln("}else{{");
						indent;
							emitGoto(parentFailId);
						unindent;
						emitln("}");
					unindent;
				}

				// test ranges (if applicable)
				if(hasRanges){
					emitln("// (range test)");
					emitId(rangeTestId);
					indent;
//TODO: range tests
						/*\\
						emitln("if({0} >= 1){");
						indent;
							emitGoto(rangeTestPass);
						unindent;
						emitln("}else{");
						indent;
							emitGoto(rangeTestFail);
						unindent;
						emitln("}");*/
					unindent;
				}
			unindent;
		}
	}

	void visit(Substitution obj,String parentPassId,String parentFailId){
		with(obj){
			emitln("// Substitution");
			emitln("if(match(var_{0})){{",subBinding.name);
			indent;
				if(binding){
					assignResults(binding,subBinding.type);
				}
				emitGoto(parentPassId);
			unindent;
			emitln("}");
			emitln("else{{");
			indent;
				emitGoto(parentFailId);
			unindent;
			emitln("}");
		}
	}

	void visit(Literal obj,String parentPassId,String parentFailId){
		with(obj){
			emitln("// Literal");
			emit("if({0}",literalName);
			if(args.length > 0){
				emit("(");
				visitList(args,",");
				emit(")");
			}
			emitln("){{");
			indent;
			/* TODO: figure out rule for binding to a literal predicate
				if(binding){
					assignResults(binding,type);
					visit(binding);
				}
			*/
				emitGoto(parentPassId);
			unindent;
			emitln("}");
			emitln("else{{");
			indent;
				emitGoto(parentFailId);
			unindent;
			emitln("}");
		}
	}

	void visit(Terminal obj,String parentPassId,String parentFailId){
		with(obj){
			emitln("// Terminal");
			emitln("if(match(\"{0}\")){{",safeString(text));
			indent;
				if(binding){
					assignResults(binding,"String"); //TODO: fix me
				}
				emitGoto(parentPassId);
			unindent;
			emitln("}");
			emitln("else{{");
			indent;
				emitGoto(parentFailId);
			unindent;
			emitln("}");
		}
	}

	void visit(Negate obj,String parentPassId,String parentFailId){
		with(obj){
			emitln("// Negate");
			indent;
				visit(expr,parentFailId,parentPassId);
			unindent;
		}
	}

	void visit(Test obj,String parentPassId,String parentFailId){
		auto failId = getFailId();
		with(obj){
			emitln("// Test");
			auto posId = savePositionId();
			indent;
				visit(expr,failId,parentPassId);
			unindent;
			emitId(failId);
			indent;
				unwind(posId);
				emitGoto(parentPassId);
			unindent;
		}
	}

	void visit(ErrorPoint obj,String parentPassId,String parentFailId){
		auto failId = getFailId();
		String posId;
		with(obj){
			emitln("// ErrorPoint");
			indent;
				visit(expr,parentPassId,failId);
			unindent;
			emitId(failId);
			indent;
				emit("error(");
				visit(errMessage);
				emitln(");");
				emitGoto(parentFailId);
			unindent;
		}
	}

	void visit(ProductionArg obj){
		if(cast(StringProductionArg) obj)  visit(cast(StringProductionArg) obj);
		else visit(cast(BindingProductionArg) obj);
	}

	void visit(StringProductionArg obj){
		emit("\"{0}\"",safeString(obj.value));
	}

	void visit(BindingProductionArg obj){
		emit("var_{0}",obj.name);
	}

	void visit(RulePredicate obj){
		if(cast(BindingPredicate) obj)  visit(cast(BindingPredicate) obj);
		else if(cast(FunctionPredicate) obj)  visit(cast(FunctionPredicate) obj);
		else if(cast(ClassPredicate) obj)  visit(cast(ClassPredicate) obj);
		else if(cast(DefaultPredicate) obj)  visit(cast(DefaultPredicate) obj);
		else throw new Exception("unknown predicate type");
	}

	void visit(BindingPredicate obj){
		with(obj){
			emit("var_{0}",decl.name);
		}
	}

	void visit(Param obj,String format){
		with(obj){
			emit(format,type,name);
		}
	}

	void visit(FunctionPredicate obj){
		with(obj){
			emit("{0}(",decl.name);
			visitList(params,",");
			emit(")");
		}
	}

	void visit(ClassPredicate obj){
		with(obj){
			emit("new {0}(",type);
			visitList(params,",");
			emit(")");
		}
	}

	void visit(DefaultPredicate obj){
		//do nothing
	}

	void visit(Param obj){
		emit("var_{0}",obj.name);
	}
}


