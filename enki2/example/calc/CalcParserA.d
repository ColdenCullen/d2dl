module example.calc.CalcParser;
import example.calc.CalcParserBaseA;

debug import tango.io.Stdout;

class CalcParserA:CalcParserBaseA{
	static char[] getHelp(){
		return "Simple calculator example #2.\r\n\t\r\nThis example parser helps demonstrate Enki\'s ability to in-line \r\nfunction-calls, in order to create a more compact grammar.\r\nThe result sacrifices some readability within each production\r\ndefintion for a much more readable overall grammar, with\r\nfewer total productions, and no back-tracking.\r\n";
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
		::= Addition:result ["!" @fac!(result)];

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
					// AndGroup
						auto position7 = pos;
							cull_WS();// Terminal
							if(!match("!")){
								goto fail8;
							}
						term9:
							cull_WS();// Literal
								fac(var_result);
								goto pass0;
						fail8:
						pos = position7;
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
	Addition
		= double result
		::= Multipulcation:result ("+" Multipulcation:value @add!(result,value) | "-" Multipulcation:value @sub!(result,value))*;

	*/
	double value_Addition;
	bool parse_Addition(){
		debug Stdout("parse_Addition").newline;
		double var_result;
		double var_value;

		// AndGroup
			auto position3 = pos;
				cull_WS();// Production
				if(!parse_Multipulcation()){
					goto fail4;
				}
				smartAssign(var_result,value_Multipulcation);
			term5:
				cull_WS();// Iterator
				start6:
					// (terminator)
					if(!hasMore()){
						goto end7;
					}
					// (expression)
					expr8:
						// OrGroup start6
							// AndGroup
								auto position11 = pos;
									cull_WS();// Terminal
									if(!match("+")){
										goto fail12;
									}
								term13:
									cull_WS();// Production
									if(!parse_Multipulcation()){
										goto fail12;
									}
									smartAssign(var_value,value_Multipulcation);
								term14:
									cull_WS();// Literal
										add(var_result,var_value);
										goto start6;
								fail12:
								pos = position11;
						term9:
							// AndGroup
								auto position16 = pos;
									cull_WS();// Terminal
									if(!match("-")){
										goto fail17;
									}
								term18:
									cull_WS();// Production
									if(!parse_Multipulcation()){
										goto fail17;
									}
									smartAssign(var_value,value_Multipulcation);
								term19:
									cull_WS();// Literal
										sub(var_result,var_value);
										goto start6;
								fail17:
								pos = position16;
								goto end7;
					goto start6;
				end7:
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
	Multipulcation
		= double result
		::= Exponent:result ("*" Exponent:value @mul!(result,value) | "/" Exponent:value @div!(result,value) | "%" Exponent:value @mod!(result,value))*;

	*/
	double value_Multipulcation;
	bool parse_Multipulcation(){
		debug Stdout("parse_Multipulcation").newline;
		double var_result;
		double var_value;

		// AndGroup
			auto position3 = pos;
				cull_WS();// Production
				if(!parse_Exponent()){
					goto fail4;
				}
				smartAssign(var_result,value_Exponent);
			term5:
				cull_WS();// Iterator
				start6:
					// (terminator)
					if(!hasMore()){
						goto end7;
					}
					// (expression)
					expr8:
						// OrGroup start6
							// AndGroup
								auto position11 = pos;
									cull_WS();// Terminal
									if(!match("*")){
										goto fail12;
									}
								term13:
									cull_WS();// Production
									if(!parse_Exponent()){
										goto fail12;
									}
									smartAssign(var_value,value_Exponent);
								term14:
									cull_WS();// Literal
										mul(var_result,var_value);
										goto start6;
								fail12:
								pos = position11;
						term9:
							// AndGroup
								auto position17 = pos;
									cull_WS();// Terminal
									if(!match("/")){
										goto fail18;
									}
								term19:
									cull_WS();// Production
									if(!parse_Exponent()){
										goto fail18;
									}
									smartAssign(var_value,value_Exponent);
								term20:
									cull_WS();// Literal
										div(var_result,var_value);
										goto start6;
								fail18:
								pos = position17;
						term15:
							// AndGroup
								auto position22 = pos;
									cull_WS();// Terminal
									if(!match("%")){
										goto fail23;
									}
								term24:
									cull_WS();// Production
									if(!parse_Exponent()){
										goto fail23;
									}
									smartAssign(var_value,value_Exponent);
								term25:
									cull_WS();// Literal
										mod(var_result,var_value);
										goto start6;
								fail23:
								pos = position22;
								goto end7;
					goto start6;
				end7:
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
	Exponent
		= double result
		::= Unary:result ("^" Unary:value @pow!(result,value) | "**" Unary:value @pow!(result,value))*;

	*/
	double value_Exponent;
	bool parse_Exponent(){
		debug Stdout("parse_Exponent").newline;
		double var_result;
		double var_value;

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
						// OrGroup start6
							// AndGroup
								auto position11 = pos;
									cull_WS();// Terminal
									if(!match("^")){
										goto fail12;
									}
								term13:
									cull_WS();// Production
									if(!parse_Unary()){
										goto fail12;
									}
									smartAssign(var_value,value_Unary);
								term14:
									cull_WS();// Literal
										pow(var_result,var_value);
										goto start6;
								fail12:
								pos = position11;
						term9:
							// AndGroup
								auto position16 = pos;
									cull_WS();// Terminal
									if(!match("**")){
										goto fail17;
									}
								term18:
									cull_WS();// Production
									if(!parse_Unary()){
										goto fail17;
									}
									smartAssign(var_value,value_Unary);
								term19:
									cull_WS();// Literal
										pow(var_result,var_value);
										goto start6;
								fail17:
								pos = position16;
								goto end7;
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
	Unary
		= double result
		::= "+" Parenthetical:result | "-" Parenthetical:result @neg!(result) | Parenthetical:result;

	*/
	double value_Unary;
	bool parse_Unary(){
		debug Stdout("parse_Unary").newline;
		double var_result;

		// OrGroup pass0
			// AndGroup
				auto position4 = pos;
					cull_WS();// Terminal
					if(!match("+")){
						goto fail5;
					}
				term6:
					cull_WS();// Production
					if(parse_Parenthetical()){
						smartAssign(var_result,value_Parenthetical);
						goto pass0;
					}
				fail5:
				pos = position4;
		term2:
			// AndGroup
				auto position9 = pos;
					cull_WS();// Terminal
					if(!match("-")){
						goto fail10;
					}
				term11:
					cull_WS();// Production
					if(!parse_Parenthetical()){
						goto fail10;
					}
					smartAssign(var_result,value_Parenthetical);
				term12:
					cull_WS();// Literal
						neg(var_result);
						goto pass0;
				fail10:
				pos = position9;
		term7:
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
		::= "|" Expression:result "|" @abs!(result) | Function:result | Number:result | Error;

	*/
	double value_Absolute;
	bool parse_Absolute(){
		debug Stdout("parse_Absolute").newline;
		double var_result;

		// OrGroup pass0
			// AndGroup
				auto position4 = pos;
					cull_WS();// Terminal
					if(!match("|")){
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
					if(!match("|")){
						goto fail5;
					}
				term8:
					cull_WS();// Literal
						abs(var_result);
						goto pass0;
				fail5:
				pos = position4;
		term2:
			cull_WS();// Production
			if(parse_Function()){
				smartAssign(var_result,value_Function);
				goto pass0;
			}
		term9:
			cull_WS();// Production
			if(parse_Number()){
				smartAssign(var_result,value_Number);
				goto pass0;
			}
		term10:
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
	Function
		= double result
		::= "sin" "(" Expression:result ")" @sin!(result) | "cos" "(" Expression:result ")" @cos!(result) | "tan" "(" Expression:result ")" @tan!(result) | "pi2" @pi2!(result) | "pi" @pi!(result);

	*/
	double value_Function;
	bool parse_Function(){
		debug Stdout("parse_Function").newline;
		double var_result;

		// OrGroup pass0
			// AndGroup
				auto position4 = pos;
					cull_WS();// Terminal
					if(!match("sin")){
						goto fail5;
					}
				term6:
					cull_WS();// Terminal
					if(!match("(")){
						goto fail5;
					}
				term7:
					cull_WS();// Production
					if(!parse_Expression()){
						goto fail5;
					}
					smartAssign(var_result,value_Expression);
				term8:
					cull_WS();// Terminal
					if(!match(")")){
						goto fail5;
					}
				term9:
					cull_WS();// Literal
						sin(var_result);
						goto pass0;
				fail5:
				pos = position4;
		term2:
			// AndGroup
				auto position12 = pos;
					cull_WS();// Terminal
					if(!match("cos")){
						goto fail13;
					}
				term14:
					cull_WS();// Terminal
					if(!match("(")){
						goto fail13;
					}
				term15:
					cull_WS();// Production
					if(!parse_Expression()){
						goto fail13;
					}
					smartAssign(var_result,value_Expression);
				term16:
					cull_WS();// Terminal
					if(!match(")")){
						goto fail13;
					}
				term17:
					cull_WS();// Literal
						cos(var_result);
						goto pass0;
				fail13:
				pos = position12;
		term10:
			// AndGroup
				auto position20 = pos;
					cull_WS();// Terminal
					if(!match("tan")){
						goto fail21;
					}
				term22:
					cull_WS();// Terminal
					if(!match("(")){
						goto fail21;
					}
				term23:
					cull_WS();// Production
					if(!parse_Expression()){
						goto fail21;
					}
					smartAssign(var_result,value_Expression);
				term24:
					cull_WS();// Terminal
					if(!match(")")){
						goto fail21;
					}
				term25:
					cull_WS();// Literal
						tan(var_result);
						goto pass0;
				fail21:
				pos = position20;
		term18:
			// AndGroup
				auto position28 = pos;
					cull_WS();// Terminal
					if(!match("pi2")){
						goto fail29;
					}
				term30:
					cull_WS();// Literal
						pi2(var_result);
						goto pass0;
				fail29:
				pos = position28;
		term26:
			// AndGroup
				auto position32 = pos;
					cull_WS();// Terminal
					if(!match("pi")){
						goto fail33;
					}
				term34:
					cull_WS();// Literal
						pi(var_result);
						goto pass0;
				fail33:
				pos = position32;
				goto fail1;
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
