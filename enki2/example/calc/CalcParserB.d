module example.calc.CalcParser;
import example.calc.CalcParserBaseB;

debug import tango.io.Stdout;

class CalcParserB:CalcParserBaseB{
	static char[] getHelp(){
		return "Simple calculator example #3.\r\n\t\r\nThis example parser helps demonstrate Enki\'s ability to use production\r\narguments, and production predicates as a means of evaluating the parsed\r\nexpression.  This increases readability per rule, but creates many\r\nmore rule than the previous technique.\r\n\r\nAs the rule predicates rely on a function return value to behave \r\ncorrectly. So, this uses a different set of support functions than the \r\nprevious example.\r\n";
	}
	
	void cull_WS(){
	    while(hasMore()){
	        switch(data[pos]){
	        case ' ':
	        case '\t':
	        case '\n':
	        case '\r':
	            pos++;
	        default:
	            return;
	        }
	    }
	}
	
	/*
	Syntax
		= double result
		::= Expression:result (eoi | Error);

	*/
	double value_Syntax;
	bool parse_Syntax(){
		debug Stdout("parse_Syntax").newline;
		double var_result;

		// AndGroup
			auto position3 = pos;
				cull_WS();// Production
				if(!parse_Expression()){
					goto fail4;
				}
				smartAssign(var_result,value_Expression);
			term5:
				cull_WS();// OrGroup pass0
					cull_WS();// Production
					if(parse_eoi()){
						goto pass0;
					}
				term6:
					cull_WS();// Production
					if(parse_Error()){
						goto pass0;
					}
			fail4:
			pos = position3;
			goto fail1;
		// Rule
		pass0:
			value_Syntax = var_result;
			debug Stdout.format("\tparse_Syntax passed: {0}",value_Syntax).newline;
			return true;
		fail1:
			value_Syntax = (double).init;
			debug Stdout.format("\tparse_Syntax failed").newline;
			return false;
	}

	/*
	Expression
		= double result
		::= Addition:result [Factorial!(result)];

	*/
	double value_Expression;
	bool parse_Expression(){
		debug Stdout("parse_Expression").newline;
		double var_result;

		// AndGroup
			auto position3 = pos;
				cull_WS();// Production
				if(!parse_Addition()){
					goto fail4;
				}
				smartAssign(var_result,value_Addition);
			term5:
				cull_WS();// Optional
					cull_WS();// Production
					if(parse_Factorial(var_result)){
						goto pass0;
					}
					goto pass0;
			fail4:
			pos = position3;
			goto fail1;
		// Rule
		pass0:
			value_Expression = var_result;
			debug Stdout.format("\tparse_Expression passed: {0}",value_Expression).newline;
			return true;
		fail1:
			value_Expression = (double).init;
			debug Stdout.format("\tparse_Expression failed").newline;
			return false;
	}

	/*
	Factorial(double value)
		= double fac(double value)
		::= "!";

	*/
	double value_Factorial;
	bool parse_Factorial(double var_value){
		debug Stdout("parse_Factorial").newline;

		cull_WS();// Terminal
		if(!match("!")){
			goto fail1;
		}
		// Rule
		pass0:
			value_Factorial = fac(var_value);
			debug Stdout.format("\tparse_Factorial passed: {0}",value_Factorial).newline;
			return true;
		fail1:
			value_Factorial = (double).init;
			debug Stdout.format("\tparse_Factorial failed").newline;
			return false;
	}

	/*
	Addition
		= double result
		::= Multipulcation:result [Add!(result):result | Sub!(result):result];

	*/
	double value_Addition;
	bool parse_Addition(){
		debug Stdout("parse_Addition").newline;
		double var_result;

		// AndGroup
			auto position3 = pos;
				cull_WS();// Production
				if(!parse_Multipulcation()){
					goto fail4;
				}
				smartAssign(var_result,value_Multipulcation);
			term5:
				cull_WS();// Optional
					// OrGroup pass0
						cull_WS();// Production
						if(parse_Add(var_result)){
							smartAssign(var_result,value_Add);
							goto pass0;
						}
					term6:
						cull_WS();// Production
						if(parse_Sub(var_result)){
							smartAssign(var_result,value_Sub);
							goto pass0;
						}
					goto pass0;
			fail4:
			pos = position3;
			goto fail1;
		// Rule
		pass0:
			value_Addition = var_result;
			debug Stdout.format("\tparse_Addition passed: {0}",value_Addition).newline;
			return true;
		fail1:
			value_Addition = (double).init;
			debug Stdout.format("\tparse_Addition failed").newline;
			return false;
	}

	/*
	Add(double lvalue)
		= double add(double lvalue,double rvalue)
		::= "+" Addition:rvalue;

	*/
	double value_Add;
	bool parse_Add(double var_lvalue){
		debug Stdout("parse_Add").newline;
		double var_rvalue;

		// AndGroup
			auto position3 = pos;
				cull_WS();// Terminal
				if(!match("+")){
					goto fail4;
				}
			term5:
				cull_WS();// Production
				if(parse_Addition()){
					smartAssign(var_rvalue,value_Addition);
					goto pass0;
				}
			fail4:
			pos = position3;
			goto fail1;
		// Rule
		pass0:
			value_Add = add(var_lvalue,var_rvalue);
			debug Stdout.format("\tparse_Add passed: {0}",value_Add).newline;
			return true;
		fail1:
			value_Add = (double).init;
			debug Stdout.format("\tparse_Add failed").newline;
			return false;
	}

	/*
	Sub(double lvalue)
		= double add(double lvalue,double rvalue)
		::= "+" Addition:rvalue;

	*/
	double value_Sub;
	bool parse_Sub(double var_lvalue){
		debug Stdout("parse_Sub").newline;
		double var_rvalue;

		// AndGroup
			auto position3 = pos;
				cull_WS();// Terminal
				if(!match("+")){
					goto fail4;
				}
			term5:
				cull_WS();// Production
				if(parse_Addition()){
					smartAssign(var_rvalue,value_Addition);
					goto pass0;
				}
			fail4:
			pos = position3;
			goto fail1;
		// Rule
		pass0:
			value_Sub = add(var_lvalue,var_rvalue);
			debug Stdout.format("\tparse_Sub passed: {0}",value_Sub).newline;
			return true;
		fail1:
			value_Sub = (double).init;
			debug Stdout.format("\tparse_Sub failed").newline;
			return false;
	}

	/*
	Multipulcation
		= double result
		::= Exponent:result [Mul!(result):result | Div!(result):result | Mod!(result):result];

	*/
	double value_Multipulcation;
	bool parse_Multipulcation(){
		debug Stdout("parse_Multipulcation").newline;
		double var_result;

		// AndGroup
			auto position3 = pos;
				cull_WS();// Production
				if(!parse_Exponent()){
					goto fail4;
				}
				smartAssign(var_result,value_Exponent);
			term5:
				cull_WS();// Optional
					// OrGroup pass0
						cull_WS();// Production
						if(parse_Mul(var_result)){
							smartAssign(var_result,value_Mul);
							goto pass0;
						}
					term6:
						cull_WS();// Production
						if(parse_Div(var_result)){
							smartAssign(var_result,value_Div);
							goto pass0;
						}
					term7:
						cull_WS();// Production
						if(parse_Mod(var_result)){
							smartAssign(var_result,value_Mod);
							goto pass0;
						}
					goto pass0;
			fail4:
			pos = position3;
			goto fail1;
		// Rule
		pass0:
			value_Multipulcation = var_result;
			debug Stdout.format("\tparse_Multipulcation passed: {0}",value_Multipulcation).newline;
			return true;
		fail1:
			value_Multipulcation = (double).init;
			debug Stdout.format("\tparse_Multipulcation failed").newline;
			return false;
	}

	/*
	Mul(double lvalue)
		= double mul(double lvalue,double rvalue)
		::= "*" Multipulcation:rvalue;

	*/
	double value_Mul;
	bool parse_Mul(double var_lvalue){
		debug Stdout("parse_Mul").newline;
		double var_rvalue;

		// AndGroup
			auto position3 = pos;
				cull_WS();// Terminal
				if(!match("*")){
					goto fail4;
				}
			term5:
				cull_WS();// Production
				if(parse_Multipulcation()){
					smartAssign(var_rvalue,value_Multipulcation);
					goto pass0;
				}
			fail4:
			pos = position3;
			goto fail1;
		// Rule
		pass0:
			value_Mul = mul(var_lvalue,var_rvalue);
			debug Stdout.format("\tparse_Mul passed: {0}",value_Mul).newline;
			return true;
		fail1:
			value_Mul = (double).init;
			debug Stdout.format("\tparse_Mul failed").newline;
			return false;
	}

	/*
	Div(double lvalue)
		= double div(double lvalue,double rvalue)
		::= "/" Multipulcation:rvalue;

	*/
	double value_Div;
	bool parse_Div(double var_lvalue){
		debug Stdout("parse_Div").newline;
		double var_rvalue;

		// AndGroup
			auto position3 = pos;
				cull_WS();// Terminal
				if(!match("/")){
					goto fail4;
				}
			term5:
				cull_WS();// Production
				if(parse_Multipulcation()){
					smartAssign(var_rvalue,value_Multipulcation);
					goto pass0;
				}
			fail4:
			pos = position3;
			goto fail1;
		// Rule
		pass0:
			value_Div = div(var_lvalue,var_rvalue);
			debug Stdout.format("\tparse_Div passed: {0}",value_Div).newline;
			return true;
		fail1:
			value_Div = (double).init;
			debug Stdout.format("\tparse_Div failed").newline;
			return false;
	}

	/*
	Mod(double lvalue)
		= double mod(double lvalue,double rvalue)
		::= "%" Multipulcation:rvalue;

	*/
	double value_Mod;
	bool parse_Mod(double var_lvalue){
		debug Stdout("parse_Mod").newline;
		double var_rvalue;

		// AndGroup
			auto position3 = pos;
				cull_WS();// Terminal
				if(!match("%")){
					goto fail4;
				}
			term5:
				cull_WS();// Production
				if(parse_Multipulcation()){
					smartAssign(var_rvalue,value_Multipulcation);
					goto pass0;
				}
			fail4:
			pos = position3;
			goto fail1;
		// Rule
		pass0:
			value_Mod = mod(var_lvalue,var_rvalue);
			debug Stdout.format("\tparse_Mod passed: {0}",value_Mod).newline;
			return true;
		fail1:
			value_Mod = (double).init;
			debug Stdout.format("\tparse_Mod failed").newline;
			return false;
	}

	/*
	Exponent
		= double result
		::= Unary:result Pow!(result)*;

	*/
	double value_Exponent;
	bool parse_Exponent(){
		debug Stdout("parse_Exponent").newline;
		double var_result;

		// AndGroup
			auto position3 = pos;
				cull_WS();// Production
				if(!parse_Unary()){
					goto fail4;
				}
				smartAssign(var_result,value_Unary);
			term5:
				cull_WS();// Iterator
				start6:
					// (terminator)
					if(!hasMore()){
						goto end7;
					}
					// (expression)
					expr8:
						// Production
						if(!parse_Pow(var_result)){
							goto end7;
						}
					goto start6;
				end7:
					goto pass0;
			fail4:
			pos = position3;
			goto fail1;
		// Rule
		pass0:
			value_Exponent = var_result;
			debug Stdout.format("\tparse_Exponent passed: {0}",value_Exponent).newline;
			return true;
		fail1:
			value_Exponent = (double).init;
			debug Stdout.format("\tparse_Exponent failed").newline;
			return false;
	}

	/*
	Pow(double lvalue)
		= double pow(double lvalue,double rvalue)
		::= ("^" | "**") Unary:value;

	*/
	double value_Pow;
	bool parse_Pow(double var_lvalue){
		debug Stdout("parse_Pow").newline;
		double var_rvalue;
		double var_value;

		// AndGroup
			auto position3 = pos;
				cull_WS();// OrGroup term5
					cull_WS();// Terminal
					if(match("^")){
						goto term5;
					}
				term6:
					cull_WS();// Terminal
					if(!match("**")){
						goto fail4;
					}
			term5:
				cull_WS();// Production
				if(parse_Unary()){
					smartAssign(var_value,value_Unary);
					goto pass0;
				}
			fail4:
			pos = position3;
			goto fail1;
		// Rule
		pass0:
			value_Pow = pow(var_lvalue,var_rvalue);
			debug Stdout.format("\tparse_Pow passed: {0}",value_Pow).newline;
			return true;
		fail1:
			value_Pow = (double).init;
			debug Stdout.format("\tparse_Pow failed").newline;
			return false;
	}

	/*
	Unary
		= double result
		::= Pos:result | Neg:result | Parenthetical:result;

	*/
	double value_Unary;
	bool parse_Unary(){
		debug Stdout("parse_Unary").newline;
		double var_result;

		// OrGroup pass0
			cull_WS();// Production
			if(parse_Pos()){
				smartAssign(var_result,value_Pos);
				goto pass0;
			}
		term2:
			cull_WS();// Production
			if(parse_Neg()){
				smartAssign(var_result,value_Neg);
				goto pass0;
			}
		term3:
			cull_WS();// Production
			if(!parse_Parenthetical()){
				goto fail1;
			}
			smartAssign(var_result,value_Parenthetical);
		// Rule
		pass0:
			value_Unary = var_result;
			debug Stdout.format("\tparse_Unary passed: {0}",value_Unary).newline;
			return true;
		fail1:
			value_Unary = (double).init;
			debug Stdout.format("\tparse_Unary failed").newline;
			return false;
	}

	/*
	Pos
		= double result
		::= "+" Parenthetical:result;

	*/
	double value_Pos;
	bool parse_Pos(){
		debug Stdout("parse_Pos").newline;
		double var_result;

		// AndGroup
			auto position3 = pos;
				cull_WS();// Terminal
				if(!match("+")){
					goto fail4;
				}
			term5:
				cull_WS();// Production
				if(parse_Parenthetical()){
					smartAssign(var_result,value_Parenthetical);
					goto pass0;
				}
			fail4:
			pos = position3;
			goto fail1;
		// Rule
		pass0:
			value_Pos = var_result;
			debug Stdout.format("\tparse_Pos passed: {0}",value_Pos).newline;
			return true;
		fail1:
			value_Pos = (double).init;
			debug Stdout.format("\tparse_Pos failed").newline;
			return false;
	}

	/*
	Neg
		= double neg(double result)
		::= "-" Parenthetical:result;

	*/
	double value_Neg;
	bool parse_Neg(){
		debug Stdout("parse_Neg").newline;
		double var_result;

		// AndGroup
			auto position3 = pos;
				cull_WS();// Terminal
				if(!match("-")){
					goto fail4;
				}
			term5:
				cull_WS();// Production
				if(parse_Parenthetical()){
					smartAssign(var_result,value_Parenthetical);
					goto pass0;
				}
			fail4:
			pos = position3;
			goto fail1;
		// Rule
		pass0:
			value_Neg = neg(var_result);
			debug Stdout.format("\tparse_Neg passed: {0}",value_Neg).newline;
			return true;
		fail1:
			value_Neg = (double).init;
			debug Stdout.format("\tparse_Neg failed").newline;
			return false;
	}

	/*
	Parenthetical
		= double result
		::= "(" Expression:result ")" | Absolute:result;

	*/
	double value_Parenthetical;
	bool parse_Parenthetical(){
		debug Stdout("parse_Parenthetical").newline;
		double var_result;

		// OrGroup pass0
			// AndGroup
				auto position4 = pos;
					cull_WS();// Terminal
					if(!match("(")){
						goto fail5;
					}
				term6:
					cull_WS();// Production
					if(!parse_Expression()){
						goto fail5;
					}
					smartAssign(var_result,value_Expression);
				term7:
					cull_WS();// Terminal
					if(match(")")){
						goto pass0;
					}
				fail5:
				pos = position4;
		term2:
			cull_WS();// Production
			if(!parse_Absolute()){
				goto fail1;
			}
			smartAssign(var_result,value_Absolute);
		// Rule
		pass0:
			value_Parenthetical = var_result;
			debug Stdout.format("\tparse_Parenthetical passed: {0}",value_Parenthetical).newline;
			return true;
		fail1:
			value_Parenthetical = (double).init;
			debug Stdout.format("\tparse_Parenthetical failed").newline;
			return false;
	}

	/*
	Absolute
		= double result
		::= Abs:result | Function:result | Number:result | Error;

	*/
	double value_Absolute;
	bool parse_Absolute(){
		debug Stdout("parse_Absolute").newline;
		double var_result;

		// OrGroup pass0
			cull_WS();// Production
			if(parse_Abs()){
				smartAssign(var_result,value_Abs);
				goto pass0;
			}
		term2:
			cull_WS();// Production
			if(parse_Function()){
				smartAssign(var_result,value_Function);
				goto pass0;
			}
		term3:
			cull_WS();// Production
			if(parse_Number()){
				smartAssign(var_result,value_Number);
				goto pass0;
			}
		term4:
			cull_WS();// Production
			if(!parse_Error()){
				goto fail1;
			}
		// Rule
		pass0:
			value_Absolute = var_result;
			debug Stdout.format("\tparse_Absolute passed: {0}",value_Absolute).newline;
			return true;
		fail1:
			value_Absolute = (double).init;
			debug Stdout.format("\tparse_Absolute failed").newline;
			return false;
	}

	/*
	Abs
		= double abs(double value)
		::= "|" Expression:result "|" @abs!(result);

	*/
	double value_Abs;
	bool parse_Abs(){
		debug Stdout("parse_Abs").newline;
		double var_result;
		double var_value;

		// AndGroup
			auto position3 = pos;
				cull_WS();// Terminal
				if(!match("|")){
					goto fail4;
				}
			term5:
				cull_WS();// Production
				if(!parse_Expression()){
					goto fail4;
				}
				smartAssign(var_result,value_Expression);
			term6:
				cull_WS();// Terminal
				if(!match("|")){
					goto fail4;
				}
			term7:
				cull_WS();// Literal
					abs(var_result);
					goto pass0;
			fail4:
			pos = position3;
			goto fail1;
		// Rule
		pass0:
			value_Abs = abs(var_value);
			debug Stdout.format("\tparse_Abs passed: {0}",value_Abs).newline;
			return true;
		fail1:
			value_Abs = (double).init;
			debug Stdout.format("\tparse_Abs failed").newline;
			return false;
	}

	/*
	Function
		= double result
		::= Sin:result | Cos:result | Tan:result | Pi2:result | Pi:result;

	*/
	double value_Function;
	bool parse_Function(){
		debug Stdout("parse_Function").newline;
		double var_result;

		// OrGroup pass0
			cull_WS();// Production
			if(parse_Sin()){
				smartAssign(var_result,value_Sin);
				goto pass0;
			}
		term2:
			cull_WS();// Production
			if(parse_Cos()){
				smartAssign(var_result,value_Cos);
				goto pass0;
			}
		term3:
			cull_WS();// Production
			if(parse_Tan()){
				smartAssign(var_result,value_Tan);
				goto pass0;
			}
		term4:
			cull_WS();// Production
			if(parse_Pi2()){
				smartAssign(var_result,value_Pi2);
				goto pass0;
			}
		term5:
			cull_WS();// Production
			if(!parse_Pi()){
				goto fail1;
			}
			smartAssign(var_result,value_Pi);
		// Rule
		pass0:
			value_Function = var_result;
			debug Stdout.format("\tparse_Function passed: {0}",value_Function).newline;
			return true;
		fail1:
			value_Function = (double).init;
			debug Stdout.format("\tparse_Function failed").newline;
			return false;
	}

	/*
	Sin
		= double sin(double result)
		::= "sin" "(" Expression:result ")";

	*/
	double value_Sin;
	bool parse_Sin(){
		debug Stdout("parse_Sin").newline;
		double var_result;

		// AndGroup
			auto position3 = pos;
				cull_WS();// Terminal
				if(!match("sin")){
					goto fail4;
				}
			term5:
				cull_WS();// Terminal
				if(!match("(")){
					goto fail4;
				}
			term6:
				cull_WS();// Production
				if(!parse_Expression()){
					goto fail4;
				}
				smartAssign(var_result,value_Expression);
			term7:
				cull_WS();// Terminal
				if(match(")")){
					goto pass0;
				}
			fail4:
			pos = position3;
			goto fail1;
		// Rule
		pass0:
			value_Sin = sin(var_result);
			debug Stdout.format("\tparse_Sin passed: {0}",value_Sin).newline;
			return true;
		fail1:
			value_Sin = (double).init;
			debug Stdout.format("\tparse_Sin failed").newline;
			return false;
	}

	/*
	Cos
		= double cos(double result)
		::= "cos" "(" Expression:result ")";

	*/
	double value_Cos;
	bool parse_Cos(){
		debug Stdout("parse_Cos").newline;
		double var_result;

		// AndGroup
			auto position3 = pos;
				cull_WS();// Terminal
				if(!match("cos")){
					goto fail4;
				}
			term5:
				cull_WS();// Terminal
				if(!match("(")){
					goto fail4;
				}
			term6:
				cull_WS();// Production
				if(!parse_Expression()){
					goto fail4;
				}
				smartAssign(var_result,value_Expression);
			term7:
				cull_WS();// Terminal
				if(match(")")){
					goto pass0;
				}
			fail4:
			pos = position3;
			goto fail1;
		// Rule
		pass0:
			value_Cos = cos(var_result);
			debug Stdout.format("\tparse_Cos passed: {0}",value_Cos).newline;
			return true;
		fail1:
			value_Cos = (double).init;
			debug Stdout.format("\tparse_Cos failed").newline;
			return false;
	}

	/*
	Tan
		= double tan(double result)
		::= "tan" "(" Expression:result ")";

	*/
	double value_Tan;
	bool parse_Tan(){
		debug Stdout("parse_Tan").newline;
		double var_result;

		// AndGroup
			auto position3 = pos;
				cull_WS();// Terminal
				if(!match("tan")){
					goto fail4;
				}
			term5:
				cull_WS();// Terminal
				if(!match("(")){
					goto fail4;
				}
			term6:
				cull_WS();// Production
				if(!parse_Expression()){
					goto fail4;
				}
				smartAssign(var_result,value_Expression);
			term7:
				cull_WS();// Terminal
				if(match(")")){
					goto pass0;
				}
			fail4:
			pos = position3;
			goto fail1;
		// Rule
		pass0:
			value_Tan = tan(var_result);
			debug Stdout.format("\tparse_Tan passed: {0}",value_Tan).newline;
			return true;
		fail1:
			value_Tan = (double).init;
			debug Stdout.format("\tparse_Tan failed").newline;
			return false;
	}

	/*
	Pi2
		= double pi2()
		::= "pi2";

	*/
	double value_Pi2;
	bool parse_Pi2(){
		debug Stdout("parse_Pi2").newline;
		cull_WS();// Terminal
		if(!match("pi2")){
			goto fail1;
		}
		// Rule
		pass0:
			value_Pi2 = pi2();
			debug Stdout.format("\tparse_Pi2 passed: {0}",value_Pi2).newline;
			return true;
		fail1:
			value_Pi2 = (double).init;
			debug Stdout.format("\tparse_Pi2 failed").newline;
			return false;
	}

	/*
	Pi
		= double pi()
		::= "pi";

	*/
	double value_Pi;
	bool parse_Pi(){
		debug Stdout("parse_Pi").newline;
		cull_WS();// Terminal
		if(!match("pi")){
			goto fail1;
		}
		// Rule
		pass0:
			value_Pi = pi();
			debug Stdout.format("\tparse_Pi passed: {0}",value_Pi).newline;
			return true;
		fail1:
			value_Pi = (double).init;
			debug Stdout.format("\tparse_Pi failed").newline;
			return false;
	}

	/*
	Error
		::= @err!("Expected Mathematical Expression");

	*/
	bool value_Error;
	bool parse_Error(){
		debug Stdout("parse_Error").newline;

		cull_WS();// Literal
			err("Expected Mathematical Expression");
		// Rule
		pass0:
			debug Stdout("passed").newline;
			return true;
		fail1:
			debug Stdout.format("\tparse_Error failed").newline;
			return false;
	}
}
