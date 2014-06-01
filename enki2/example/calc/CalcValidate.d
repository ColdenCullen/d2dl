module example.calc.CalcParser;
import example.calc.CalcParserBase;

debug import tango.io.Stdout;

class CalcValidate:CalcParserBase{
	static char[] getHelp(){
		return "Simple calculator example #1\r\n\t\r\nThis example is a validator for the calculator grammar.\r\n\r\nWhen developing an Enki grammar, it is recommended to start\r\nwith a bare-bones grammar without any annotations or productions\r\nto get a good grasp of the overall language.\r\n\r\nThe only part of this grammar not represented in EBNF is the\r\nproduction for \'Number\', which is handled by Tango\'s Float.parse().  \r\nSometimes it is best to stick with a hand-coded parser when \r\nhandling discrete grammars like that for floating point numbers.  \r\nAs a bonus, the production also converts the number back to a \r\ndouble, which can be used in an annotated grammar.\r\n\r\nAlso note that while this grammar could be represented recursively,\r\niterators have been used for efficiency.\r\n";
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
		::= Expression (eoi | Error);

	*/
	bool value_Syntax;
	bool parse_Syntax(){
		debug Stdout("parse_Syntax").newline;
		// AndGroup
			auto position3 = pos;
				cull_WS();// Production
				if(!parse_Expression()){
					goto fail4;
				}
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
			debug Stdout("passed").newline;
			return true;
		fail1:
			debug Stdout.format("\tparse_Syntax failed").newline;
			return false;
	}

	/*
	Expression
		::= Addition ["!"];

	*/
	bool value_Expression;
	bool parse_Expression(){
		debug Stdout("parse_Expression").newline;
		// AndGroup
			auto position3 = pos;
				cull_WS();// Production
				if(!parse_Addition()){
					goto fail4;
				}
			term5:
				cull_WS();// Optional
					cull_WS();// Terminal
					if(match("!")){
						goto pass0;
					}
					goto pass0;
			fail4:
			pos = position3;
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			return true;
		fail1:
			debug Stdout.format("\tparse_Expression failed").newline;
			return false;
	}

	/*
	Addition
		::= Multipulcation ("+" Multipulcation | "-" Multipulcation)*;

	*/
	bool value_Addition;
	bool parse_Addition(){
		debug Stdout("parse_Addition").newline;
		// AndGroup
			auto position3 = pos;
				cull_WS();// Production
				if(!parse_Multipulcation()){
					goto fail4;
				}
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
									if(parse_Multipulcation()){
										goto start6;
									}
								fail12:
								pos = position11;
						term9:
							// AndGroup
								auto position15 = pos;
									cull_WS();// Terminal
									if(!match("-")){
										goto fail16;
									}
								term17:
									cull_WS();// Production
									if(parse_Multipulcation()){
										goto start6;
									}
								fail16:
								pos = position15;
								goto end7;
					goto start6;
				end7:
					goto pass0;
			fail4:
			pos = position3;
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			return true;
		fail1:
			debug Stdout.format("\tparse_Addition failed").newline;
			return false;
	}

	/*
	Multipulcation
		::= Exponent ("*" Exponent | "/" Exponent | "%" Exponent)*;

	*/
	bool value_Multipulcation;
	bool parse_Multipulcation(){
		debug Stdout("parse_Multipulcation").newline;
		// AndGroup
			auto position3 = pos;
				cull_WS();// Production
				if(!parse_Exponent()){
					goto fail4;
				}
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
									if(parse_Exponent()){
										goto start6;
									}
								fail12:
								pos = position11;
						term9:
							// AndGroup
								auto position16 = pos;
									cull_WS();// Terminal
									if(!match("/")){
										goto fail17;
									}
								term18:
									cull_WS();// Production
									if(parse_Exponent()){
										goto start6;
									}
								fail17:
								pos = position16;
						term14:
							// AndGroup
								auto position20 = pos;
									cull_WS();// Terminal
									if(!match("%")){
										goto fail21;
									}
								term22:
									cull_WS();// Production
									if(parse_Exponent()){
										goto start6;
									}
								fail21:
								pos = position20;
								goto end7;
					goto start6;
				end7:
					goto pass0;
			fail4:
			pos = position3;
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			return true;
		fail1:
			debug Stdout.format("\tparse_Multipulcation failed").newline;
			return false;
	}

	/*
	Exponent
		::= Unary ("^" Unary | "**" Unary)*;

	*/
	bool value_Exponent;
	bool parse_Exponent(){
		debug Stdout("parse_Exponent").newline;
		// AndGroup
			auto position3 = pos;
				cull_WS();// Production
				if(!parse_Unary()){
					goto fail4;
				}
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
									if(parse_Unary()){
										goto start6;
									}
								fail12:
								pos = position11;
						term9:
							// AndGroup
								auto position15 = pos;
									cull_WS();// Terminal
									if(!match("**")){
										goto fail16;
									}
								term17:
									cull_WS();// Production
									if(parse_Unary()){
										goto start6;
									}
								fail16:
								pos = position15;
								goto end7;
					goto start6;
				end7:
					goto pass0;
			fail4:
			pos = position3;
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			return true;
		fail1:
			debug Stdout.format("\tparse_Exponent failed").newline;
			return false;
	}

	/*
	Unary
		::= "+" Parenthetical | "-" Parenthetical | Parenthetical;

	*/
	bool value_Unary;
	bool parse_Unary(){
		debug Stdout("parse_Unary").newline;
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
					if(parse_Parenthetical()){
						goto pass0;
					}
				fail10:
				pos = position9;
		term7:
			cull_WS();// Production
			if(!parse_Parenthetical()){
				goto fail1;
			}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			return true;
		fail1:
			debug Stdout.format("\tparse_Unary failed").newline;
			return false;
	}

	/*
	Parenthetical
		::= "(" Expression ")" | Absolute;

	*/
	bool value_Parenthetical;
	bool parse_Parenthetical(){
		debug Stdout("parse_Parenthetical").newline;
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
		// Rule
		pass0:
			debug Stdout("passed").newline;
			return true;
		fail1:
			debug Stdout.format("\tparse_Parenthetical failed").newline;
			return false;
	}

	/*
	Absolute
		::= "|" Expression "|" | Function | Number | Error;

	*/
	bool value_Absolute;
	bool parse_Absolute(){
		debug Stdout("parse_Absolute").newline;
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
				term7:
					cull_WS();// Terminal
					if(match("|")){
						goto pass0;
					}
				fail5:
				pos = position4;
		term2:
			cull_WS();// Production
			if(parse_Function()){
				goto pass0;
			}
		term8:
			cull_WS();// Production
			if(parse_Number()){
				goto pass0;
			}
		term9:
			cull_WS();// Production
			if(!parse_Error()){
				goto fail1;
			}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			return true;
		fail1:
			debug Stdout.format("\tparse_Absolute failed").newline;
			return false;
	}

	/*
	Function
		::= "sin" "(" Expression ")" | "cos" "(" Expression ")" | "tan" "(" Expression ")" | "pi2" | "pi";

	*/
	bool value_Function;
	bool parse_Function(){
		debug Stdout("parse_Function").newline;
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
				term8:
					cull_WS();// Terminal
					if(match(")")){
						goto pass0;
					}
				fail5:
				pos = position4;
		term2:
			// AndGroup
				auto position11 = pos;
					cull_WS();// Terminal
					if(!match("cos")){
						goto fail12;
					}
				term13:
					cull_WS();// Terminal
					if(!match("(")){
						goto fail12;
					}
				term14:
					cull_WS();// Production
					if(!parse_Expression()){
						goto fail12;
					}
				term15:
					cull_WS();// Terminal
					if(match(")")){
						goto pass0;
					}
				fail12:
				pos = position11;
		term9:
			// AndGroup
				auto position18 = pos;
					cull_WS();// Terminal
					if(!match("tan")){
						goto fail19;
					}
				term20:
					cull_WS();// Terminal
					if(!match("(")){
						goto fail19;
					}
				term21:
					cull_WS();// Production
					if(!parse_Expression()){
						goto fail19;
					}
				term22:
					cull_WS();// Terminal
					if(match(")")){
						goto pass0;
					}
				fail19:
				pos = position18;
		term16:
			cull_WS();// Terminal
			if(match("pi2")){
				goto pass0;
			}
		term23:
			cull_WS();// Terminal
			if(!match("pi")){
				goto fail1;
			}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			return true;
		fail1:
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
