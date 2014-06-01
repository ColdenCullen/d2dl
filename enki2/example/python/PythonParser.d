module example.python.PythonParser;
import enkilib.d.AST;
import enkilib.d.PositionalCharParser;

debug import tango.io.Stdout;

class PythonParserT(CharT):ASTParserT!(PositionalCharParserT!(CharT)){

	/*
	nop = bool;
	*/

	/*
	any = bool;
	*/

	/*
	eoi = bool;
	*/

	/*
	INDENT
		::= (" " | "\t")*;
	*/
	bool parse_INDENT(){
		debug Stdout("parse_INDENT").newline;
		auto __astNode = createASTNode("INDENT");
		// Iterator
		start2:
			// (terminator)
			if(!hasMore()){
				goto end3;
			}
			// (expression)
			expr4:
				// OrGroup start2
					// Terminal
					if(match(" ")){
						goto start2;
					}
				term5:
					// Terminal
					if(!match("\t")){
						goto end3;
					}
			goto start2;
		end3:
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_INDENT failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	DEDENT
		::= (" " | "\t")*;
	*/
	bool parse_DEDENT(){
		debug Stdout("parse_DEDENT").newline;
		auto __astNode = createASTNode("DEDENT");
		// Iterator
		start2:
			// (terminator)
			if(!hasMore()){
				goto end3;
			}
			// (expression)
			expr4:
				// OrGroup start2
					// Terminal
					if(match(" ")){
						goto start2;
					}
				term5:
					// Terminal
					if(!match("\t")){
						goto end3;
					}
			goto start2;
		end3:
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_DEDENT failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	NEWLINE
		::= "\n" | "\r\n" | "\r";
	*/
	bool parse_NEWLINE(){
		debug Stdout("parse_NEWLINE").newline;
		auto __astNode = createASTNode("NEWLINE");
		// OrGroup pass0
			// Terminal
			if(match("\n")){
				goto pass0;
			}
		term2:
			// Terminal
			if(match("\r\n")){
				goto pass0;
			}
		term3:
			// Terminal
			if(!match("\r")){
				goto fail1;
			}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_NEWLINE failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	identifier
		::= (letter | "_") (letter | digit | "_")*;
	*/
	bool parse_identifier(){
		debug Stdout("parse_identifier").newline;
		auto __astNode = createASTNode("identifier");
		// AndGroup
			auto position3 = getPos();
				// OrGroup term5
					// Production
					if(parse_letter()){
						addASTChild(__astNode,"letter",getASTResult());
						goto term5;
					}
				term6:
					// Terminal
					if(!match("_")){
						goto fail4;
					}
			term5:
				// Iterator
				start7:
					// (terminator)
					if(!hasMore()){
						goto end8;
					}
					// (expression)
					expr9:
						// OrGroup start7
							// Production
							if(parse_letter()){
								addASTChild(__astNode,"letter",getASTResult());
								goto start7;
							}
						term10:
							// Production
							if(parse_digit()){
								addASTChild(__astNode,"digit",getASTResult());
								goto start7;
							}
						term11:
							// Terminal
							if(!match("_")){
								goto end8;
							}
					goto start7;
				end8:
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_identifier failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	letter
		::= lowercase | uppercase;
	*/
	bool parse_letter(){
		debug Stdout("parse_letter").newline;
		auto __astNode = createASTNode("letter");
		// OrGroup pass0
			// Production
			if(parse_lowercase()){
				addASTChild(__astNode,"lowercase",getASTResult());
				goto pass0;
			}
		term2:
			// Production
			if(!parse_uppercase()){
				goto fail1;
			}
			addASTChild(__astNode,"uppercase",getASTResult());
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_letter failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	lowercase
		::= #41-#5A;
	*/
	bool parse_lowercase(){
		debug Stdout("parse_lowercase").newline;
		auto __astNode = createASTNode("lowercase");
		// CharRange
		if(!match(0x41,0x5A)){
			goto fail1;
		}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_lowercase failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	uppercase
		::= #61-#7A;
	*/
	bool parse_uppercase(){
		debug Stdout("parse_uppercase").newline;
		auto __astNode = createASTNode("uppercase");
		// CharRange
		if(!match(0x61,0x7A)){
			goto fail1;
		}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_uppercase failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	digit
		::= #30-#39;
	*/
	bool parse_digit(){
		debug Stdout("parse_digit").newline;
		auto __astNode = createASTNode("digit");
		// CharRange
		if(!match(0x30,0x39)){
			goto fail1;
		}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_digit failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	stringliteral
		::= [stringprefix] (shortstring | longstring);
	*/
	bool parse_stringliteral(){
		debug Stdout("parse_stringliteral").newline;
		auto __astNode = createASTNode("stringliteral");
		// AndGroup
			auto position3 = getPos();
				// Optional
					// Production
					if(!parse_stringprefix()){
						goto term5;
					}
					addASTChild(__astNode,"stringprefix",getASTResult());
			term5:
				// OrGroup pass0
					// Production
					if(parse_shortstring()){
						addASTChild(__astNode,"shortstring",getASTResult());
						goto pass0;
					}
				term6:
					// Production
					if(parse_longstring()){
						addASTChild(__astNode,"longstring",getASTResult());
						goto pass0;
					}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_stringliteral failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	stringprefix
		::= "r" | "u" | "ur" | "R" | "U" | "UR" | "Ur" | "uR";
	*/
	bool parse_stringprefix(){
		debug Stdout("parse_stringprefix").newline;
		auto __astNode = createASTNode("stringprefix");
		// OrGroup pass0
			// Terminal
			if(match("r")){
				goto pass0;
			}
		term2:
			// Terminal
			if(match("u")){
				goto pass0;
			}
		term3:
			// Terminal
			if(match("ur")){
				goto pass0;
			}
		term4:
			// Terminal
			if(match("R")){
				goto pass0;
			}
		term5:
			// Terminal
			if(match("U")){
				goto pass0;
			}
		term6:
			// Terminal
			if(match("UR")){
				goto pass0;
			}
		term7:
			// Terminal
			if(match("Ur")){
				goto pass0;
			}
		term8:
			// Terminal
			if(!match("uR")){
				goto fail1;
			}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_stringprefix failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	shortstring
		::= "\'" (escapeseq | !"\n")* "\'" | "\"" (escapeseq | !"\n")* "\"";
	*/
	bool parse_shortstring(){
		debug Stdout("parse_shortstring").newline;
		auto __astNode = createASTNode("shortstring");
		// OrGroup pass0
			// AndGroup
				auto position4 = getPos();
					// Terminal
					if(!match("\'")){
						goto fail5;
					}
				term6:
					// Iterator
					start7:
						// (terminator)
							// Terminal
							if(match("\'")){
								goto end8;
							}
						// (expression)
						expr9:
							// OrGroup start7
								// Production
								if(parse_escapeseq()){
									addASTChild(__astNode,"escapeseq",getASTResult());
									goto start7;
								}
							term10:
								// Negate
									// (test expr)
									auto position13 = getPos();
									// Terminal
									if(!match("\n")){
										goto term11;
									}
									fail12:
									setPos(position13);
									goto fail5;
									term11:
									parse_any();
						goto start7;
					end8:
						goto pass0;
				fail5:
				setPos(position4);
		term2:
			// AndGroup
				auto position15 = getPos();
					// Terminal
					if(!match("\"")){
						goto fail16;
					}
				term17:
					// Iterator
					start18:
						// (terminator)
							// Terminal
							if(match("\"")){
								goto end19;
							}
						// (expression)
						expr20:
							// OrGroup start18
								// Production
								if(parse_escapeseq()){
									addASTChild(__astNode,"escapeseq",getASTResult());
									goto start18;
								}
							term21:
								// Negate
									// (test expr)
									auto position24 = getPos();
									// Terminal
									if(!match("\n")){
										goto term22;
									}
									fail23:
									setPos(position24);
									goto fail16;
									term22:
									parse_any();
						goto start18;
					end19:
						goto pass0;
				fail16:
				setPos(position15);
				goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_shortstring failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	longstring
		::= "\'\'\'" (escapeseq | any)* "\'\'\'" | "\"\"\"" (escapeseq | any)* "\"\"\"";
	*/
	bool parse_longstring(){
		debug Stdout("parse_longstring").newline;
		auto __astNode = createASTNode("longstring");
		// OrGroup pass0
			// AndGroup
				auto position4 = getPos();
					// Terminal
					if(!match("\'\'\'")){
						goto fail5;
					}
				term6:
					// Iterator
					start7:
						// (terminator)
							// Terminal
							if(match("\'\'\'")){
								goto end8;
							}
						// (expression)
						expr9:
							// OrGroup start7
								// Production
								if(parse_escapeseq()){
									addASTChild(__astNode,"escapeseq",getASTResult());
									goto start7;
								}
							term10:
								// Production
								if(!parse_any()){
									goto fail5;
								}
								addASTChild(__astNode,"any",getASTResult());
						goto start7;
					end8:
						goto pass0;
				fail5:
				setPos(position4);
		term2:
			// AndGroup
				auto position12 = getPos();
					// Terminal
					if(!match("\"\"\"")){
						goto fail13;
					}
				term14:
					// Iterator
					start15:
						// (terminator)
							// Terminal
							if(match("\"\"\"")){
								goto end16;
							}
						// (expression)
						expr17:
							// OrGroup start15
								// Production
								if(parse_escapeseq()){
									addASTChild(__astNode,"escapeseq",getASTResult());
									goto start15;
								}
							term18:
								// Production
								if(!parse_any()){
									goto fail13;
								}
								addASTChild(__astNode,"any",getASTResult());
						goto start15;
					end16:
						goto pass0;
				fail13:
				setPos(position12);
				goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_longstring failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	escapeseq
		::= "\\" any;
	*/
	bool parse_escapeseq(){
		debug Stdout("parse_escapeseq").newline;
		auto __astNode = createASTNode("escapeseq");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("\\")){
					goto fail4;
				}
			term5:
				// Production
				if(parse_any()){
					addASTChild(__astNode,"any",getASTResult());
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_escapeseq failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	longinteger
		::= integer ("l" | "L");
	*/
	bool parse_longinteger(){
		debug Stdout("parse_longinteger").newline;
		auto __astNode = createASTNode("longinteger");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_integer()){
					goto fail4;
				}
				addASTChild(__astNode,"integer",getASTResult());
			term5:
				// OrGroup pass0
					// Terminal
					if(match("l")){
						goto pass0;
					}
				term6:
					// Terminal
					if(match("L")){
						goto pass0;
					}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_longinteger failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	integer
		::= decimalinteger | octinteger | hexinteger;
	*/
	bool parse_integer(){
		debug Stdout("parse_integer").newline;
		auto __astNode = createASTNode("integer");
		// OrGroup pass0
			// Production
			if(parse_decimalinteger()){
				addASTChild(__astNode,"decimalinteger",getASTResult());
				goto pass0;
			}
		term2:
			// Production
			if(parse_octinteger()){
				addASTChild(__astNode,"octinteger",getASTResult());
				goto pass0;
			}
		term3:
			// Production
			if(!parse_hexinteger()){
				goto fail1;
			}
			addASTChild(__astNode,"hexinteger",getASTResult());
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_integer failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	decimalinteger
		::= nonzerodigit digit* | "0";
	*/
	bool parse_decimalinteger(){
		debug Stdout("parse_decimalinteger").newline;
		auto __astNode = createASTNode("decimalinteger");
		// OrGroup pass0
			// AndGroup
				auto position4 = getPos();
					// Production
					if(!parse_nonzerodigit()){
						goto fail5;
					}
					addASTChild(__astNode,"nonzerodigit",getASTResult());
				term6:
					// Iterator
					start7:
						// (terminator)
						if(!hasMore()){
							goto end8;
						}
						// (expression)
						expr9:
							// Production
							if(!parse_digit()){
								goto end8;
							}
							addASTChild(__astNode,"digit",getASTResult());
						goto start7;
					end8:
						goto pass0;
				fail5:
				setPos(position4);
		term2:
			// Terminal
			if(!match("0")){
				goto fail1;
			}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_decimalinteger failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	octinteger
		::= "0" octdigit+;
	*/
	bool parse_octinteger(){
		debug Stdout("parse_octinteger").newline;
		auto __astNode = createASTNode("octinteger");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("0")){
					goto fail4;
				}
			term5:
				// Iterator
				size_t counter9 = 0;
				start6:
					// (terminator)
					if(!hasMore()){
						goto end7;
					}
					// (expression)
					expr8:
						// Production
						if(!parse_octdigit()){
							goto end7;
						}
						addASTChild(__astNode,"octdigit",getASTResult());
					increment10:
					// (increment expr count)
						counter9 ++;
					goto start6;
				end7:
					// (range test)
						if(((counter9 >= 1))){
							goto pass0;
						}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_octinteger failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	hexinteger
		::= "0" ("x" | "X") hexdigit+;
	*/
	bool parse_hexinteger(){
		debug Stdout("parse_hexinteger").newline;
		auto __astNode = createASTNode("hexinteger");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("0")){
					goto fail4;
				}
			term5:
				// OrGroup term6
					// Terminal
					if(match("x")){
						goto term6;
					}
				term7:
					// Terminal
					if(!match("X")){
						goto fail4;
					}
			term6:
				// Iterator
				size_t counter11 = 0;
				start8:
					// (terminator)
					if(!hasMore()){
						goto end9;
					}
					// (expression)
					expr10:
						// Production
						if(!parse_hexdigit()){
							goto end9;
						}
						addASTChild(__astNode,"hexdigit",getASTResult());
					increment12:
					// (increment expr count)
						counter11 ++;
					goto start8;
				end9:
					// (range test)
						if(((counter11 >= 1))){
							goto pass0;
						}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_hexinteger failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	nonzerodigit
		::= #31-#39;
	*/
	bool parse_nonzerodigit(){
		debug Stdout("parse_nonzerodigit").newline;
		auto __astNode = createASTNode("nonzerodigit");
		// CharRange
		if(!match(0x31,0x39)){
			goto fail1;
		}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_nonzerodigit failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	octdigit
		::= #30-#37;
	*/
	bool parse_octdigit(){
		debug Stdout("parse_octdigit").newline;
		auto __astNode = createASTNode("octdigit");
		// CharRange
		if(!match(0x30,0x37)){
			goto fail1;
		}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_octdigit failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	hexdigit
		::= digit | #41-#46 | #61-#66;
	*/
	bool parse_hexdigit(){
		debug Stdout("parse_hexdigit").newline;
		auto __astNode = createASTNode("hexdigit");
		// OrGroup pass0
			// Production
			if(parse_digit()){
				addASTChild(__astNode,"digit",getASTResult());
				goto pass0;
			}
		term2:
			// CharRange
			if(match(0x41,0x46)){
				goto pass0;
			}
		term3:
			// CharRange
			if(!match(0x61,0x66)){
				goto fail1;
			}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_hexdigit failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	floatnumber
		::= pointfloat | exponentfloat;
	*/
	bool parse_floatnumber(){
		debug Stdout("parse_floatnumber").newline;
		auto __astNode = createASTNode("floatnumber");
		// OrGroup pass0
			// Production
			if(parse_pointfloat()){
				addASTChild(__astNode,"pointfloat",getASTResult());
				goto pass0;
			}
		term2:
			// Production
			if(!parse_exponentfloat()){
				goto fail1;
			}
			addASTChild(__astNode,"exponentfloat",getASTResult());
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_floatnumber failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	pointfloat
		::= [intpart] fraction | intpart ".";
	*/
	bool parse_pointfloat(){
		debug Stdout("parse_pointfloat").newline;
		auto __astNode = createASTNode("pointfloat");
		// OrGroup pass0
			// AndGroup
				auto position4 = getPos();
					// Optional
						// Production
						if(!parse_intpart()){
							goto term6;
						}
						addASTChild(__astNode,"intpart",getASTResult());
				term6:
					// Production
					if(parse_fraction()){
						addASTChild(__astNode,"fraction",getASTResult());
						goto pass0;
					}
				fail5:
				setPos(position4);
		term2:
			// AndGroup
				auto position8 = getPos();
					// Production
					if(!parse_intpart()){
						goto fail9;
					}
					addASTChild(__astNode,"intpart",getASTResult());
				term10:
					// Terminal
					if(match(".")){
						goto pass0;
					}
				fail9:
				setPos(position8);
				goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_pointfloat failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	exponentfloat
		::= (intpart | pointfloat) exponent;
	*/
	bool parse_exponentfloat(){
		debug Stdout("parse_exponentfloat").newline;
		auto __astNode = createASTNode("exponentfloat");
		// AndGroup
			auto position3 = getPos();
				// OrGroup term5
					// Production
					if(parse_intpart()){
						addASTChild(__astNode,"intpart",getASTResult());
						goto term5;
					}
				term6:
					// Production
					if(!parse_pointfloat()){
						goto fail4;
					}
					addASTChild(__astNode,"pointfloat",getASTResult());
			term5:
				// Production
				if(parse_exponent()){
					addASTChild(__astNode,"exponent",getASTResult());
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_exponentfloat failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	intpart
		::= digit+;
	*/
	bool parse_intpart(){
		debug Stdout("parse_intpart").newline;
		auto __astNode = createASTNode("intpart");
		// Iterator
		size_t counter5 = 0;
		start2:
			// (terminator)
			if(!hasMore()){
				goto end3;
			}
			// (expression)
			expr4:
				// Production
				if(!parse_digit()){
					goto end3;
				}
				addASTChild(__astNode,"digit",getASTResult());
			increment6:
			// (increment expr count)
				counter5 ++;
			goto start2;
		end3:
			// (range test)
				if(!((counter5 >= 1))){
					goto fail1;
					goto pass0;
				}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_intpart failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	fraction
		::= "." digit+;
	*/
	bool parse_fraction(){
		debug Stdout("parse_fraction").newline;
		auto __astNode = createASTNode("fraction");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match(".")){
					goto fail4;
				}
			term5:
				// Iterator
				size_t counter9 = 0;
				start6:
					// (terminator)
					if(!hasMore()){
						goto end7;
					}
					// (expression)
					expr8:
						// Production
						if(!parse_digit()){
							goto end7;
						}
						addASTChild(__astNode,"digit",getASTResult());
					increment10:
					// (increment expr count)
						counter9 ++;
					goto start6;
				end7:
					// (range test)
						if(((counter9 >= 1))){
							goto pass0;
						}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_fraction failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	exponent
		::= ("e" | "E") ["+" | "-"] digit+;
	*/
	bool parse_exponent(){
		debug Stdout("parse_exponent").newline;
		auto __astNode = createASTNode("exponent");
		// AndGroup
			auto position3 = getPos();
				// OrGroup term5
					// Terminal
					if(match("e")){
						goto term5;
					}
				term6:
					// Terminal
					if(!match("E")){
						goto fail4;
					}
			term5:
				// Optional
					// OrGroup term7
						// Terminal
						if(match("+")){
							goto term7;
						}
					term8:
						// Terminal
						if(!match("-")){
							goto term7;
						}
			term7:
				// Iterator
				size_t counter12 = 0;
				start9:
					// (terminator)
					if(!hasMore()){
						goto end10;
					}
					// (expression)
					expr11:
						// Production
						if(!parse_digit()){
							goto end10;
						}
						addASTChild(__astNode,"digit",getASTResult());
					increment13:
					// (increment expr count)
						counter12 ++;
					goto start9;
				end10:
					// (range test)
						if(((counter12 >= 1))){
							goto pass0;
						}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_exponent failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	imagnumber
		::= (floatnumber | intpart) ("j" | "J");
	*/
	bool parse_imagnumber(){
		debug Stdout("parse_imagnumber").newline;
		auto __astNode = createASTNode("imagnumber");
		// AndGroup
			auto position3 = getPos();
				// OrGroup term5
					// Production
					if(parse_floatnumber()){
						addASTChild(__astNode,"floatnumber",getASTResult());
						goto term5;
					}
				term6:
					// Production
					if(!parse_intpart()){
						goto fail4;
					}
					addASTChild(__astNode,"intpart",getASTResult());
			term5:
				// OrGroup pass0
					// Terminal
					if(match("j")){
						goto pass0;
					}
				term7:
					// Terminal
					if(match("J")){
						goto pass0;
					}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_imagnumber failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	atom
		::= identifier | literal | enclosure;
	*/
	bool parse_atom(){
		debug Stdout("parse_atom").newline;
		auto __astNode = createASTNode("atom");
		// OrGroup pass0
			// Production
			if(parse_identifier()){
				addASTChild(__astNode,"identifier",getASTResult());
				goto pass0;
			}
		term2:
			// Production
			if(parse_literal()){
				addASTChild(__astNode,"literal",getASTResult());
				goto pass0;
			}
		term3:
			// Production
			if(!parse_enclosure()){
				goto fail1;
			}
			addASTChild(__astNode,"enclosure",getASTResult());
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_atom failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	enclosure
		::= parenth_form | list_display | generator_expression | dict_display | string_conversion | yield_atom;
	*/
	bool parse_enclosure(){
		debug Stdout("parse_enclosure").newline;
		auto __astNode = createASTNode("enclosure");
		// OrGroup pass0
			// Production
			if(parse_parenth_form()){
				addASTChild(__astNode,"parenth_form",getASTResult());
				goto pass0;
			}
		term2:
			// Production
			if(parse_list_display()){
				addASTChild(__astNode,"list_display",getASTResult());
				goto pass0;
			}
		term3:
			// Production
			if(parse_generator_expression()){
				addASTChild(__astNode,"generator_expression",getASTResult());
				goto pass0;
			}
		term4:
			// Production
			if(parse_dict_display()){
				addASTChild(__astNode,"dict_display",getASTResult());
				goto pass0;
			}
		term5:
			// Production
			if(parse_string_conversion()){
				addASTChild(__astNode,"string_conversion",getASTResult());
				goto pass0;
			}
		term6:
			// Production
			if(!parse_yield_atom()){
				goto fail1;
			}
			addASTChild(__astNode,"yield_atom",getASTResult());
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_enclosure failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	literal
		::= stringliteral | integer | longinteger | floatnumber | imagnumber;
	*/
	bool parse_literal(){
		debug Stdout("parse_literal").newline;
		auto __astNode = createASTNode("literal");
		// OrGroup pass0
			// Production
			if(parse_stringliteral()){
				addASTChild(__astNode,"stringliteral",getASTResult());
				goto pass0;
			}
		term2:
			// Production
			if(parse_integer()){
				addASTChild(__astNode,"integer",getASTResult());
				goto pass0;
			}
		term3:
			// Production
			if(parse_longinteger()){
				addASTChild(__astNode,"longinteger",getASTResult());
				goto pass0;
			}
		term4:
			// Production
			if(parse_floatnumber()){
				addASTChild(__astNode,"floatnumber",getASTResult());
				goto pass0;
			}
		term5:
			// Production
			if(!parse_imagnumber()){
				goto fail1;
			}
			addASTChild(__astNode,"imagnumber",getASTResult());
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_literal failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	parenth_form
		::= "(" [expression_list] ")";
	*/
	bool parse_parenth_form(){
		debug Stdout("parse_parenth_form").newline;
		auto __astNode = createASTNode("parenth_form");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("(")){
					goto fail4;
				}
			term5:
				// Optional
					// Production
					if(!parse_expression_list()){
						goto term6;
					}
					addASTChild(__astNode,"expression_list",getASTResult());
			term6:
				// Terminal
				if(match(")")){
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_parenth_form failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	list_display
		::= "[" [expression_list | list_comprehension] "]";
	*/
	bool parse_list_display(){
		debug Stdout("parse_list_display").newline;
		auto __astNode = createASTNode("list_display");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("[")){
					goto fail4;
				}
			term5:
				// Optional
					// OrGroup term6
						// Production
						if(parse_expression_list()){
							addASTChild(__astNode,"expression_list",getASTResult());
							goto term6;
						}
					term7:
						// Production
						if(!parse_list_comprehension()){
							goto term6;
						}
						addASTChild(__astNode,"list_comprehension",getASTResult());
			term6:
				// Terminal
				if(match("]")){
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_list_display failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	list_comprehension
		::= expression list_for;
	*/
	bool parse_list_comprehension(){
		debug Stdout("parse_list_comprehension").newline;
		auto __astNode = createASTNode("list_comprehension");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_expression()){
					goto fail4;
				}
				addASTChild(__astNode,"expression",getASTResult());
			term5:
				// Production
				if(parse_list_for()){
					addASTChild(__astNode,"list_for",getASTResult());
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_list_comprehension failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	list_for
		::= "for" target_list "in" old_expression_list [list_iter];
	*/
	bool parse_list_for(){
		debug Stdout("parse_list_for").newline;
		auto __astNode = createASTNode("list_for");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("for")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_target_list()){
					goto fail4;
				}
				addASTChild(__astNode,"target_list",getASTResult());
			term6:
				// Terminal
				if(!match("in")){
					goto fail4;
				}
			term7:
				// Production
				if(!parse_old_expression_list()){
					goto fail4;
				}
				addASTChild(__astNode,"old_expression_list",getASTResult());
			term8:
				// Optional
					// Production
					if(parse_list_iter()){
						addASTChild(__astNode,"list_iter",getASTResult());
						goto pass0;
					}
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_list_for failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	old_expression_list
		::= old_expression [("," old_expression)+ [","]];
	*/
	bool parse_old_expression_list(){
		debug Stdout("parse_old_expression_list").newline;
		auto __astNode = createASTNode("old_expression_list");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_old_expression()){
					goto fail4;
				}
				addASTChild(__astNode,"old_expression",getASTResult());
			term5:
				// Optional
					// Iterator
					size_t counter9 = 0;
					start6:
						// (terminator)
						if(!hasMore()){
							goto end7;
						}
						// (expression)
						expr8:
							// AndGroup
								auto position12 = getPos();
									// Terminal
									if(!match(",")){
										goto fail13;
									}
								term14:
									// Production
									if(parse_old_expression()){
										addASTChild(__astNode,"old_expression",getASTResult());
										goto increment10;
									}
								fail13:
								setPos(position12);
								goto end7;
						increment10:
						// (increment expr count)
							counter9 ++;
						goto start6;
					end7:
						// (range test)
							if(((counter9 >= 1))){
								// Optional
									// Terminal
									if(match(",")){
										goto pass0;
									}
									goto pass0;
							}
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_old_expression_list failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	list_iter
		::= list_for | list_if;
	*/
	bool parse_list_iter(){
		debug Stdout("parse_list_iter").newline;
		auto __astNode = createASTNode("list_iter");
		// OrGroup pass0
			// Production
			if(parse_list_for()){
				addASTChild(__astNode,"list_for",getASTResult());
				goto pass0;
			}
		term2:
			// Production
			if(!parse_list_if()){
				goto fail1;
			}
			addASTChild(__astNode,"list_if",getASTResult());
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_list_iter failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	list_if
		::= "if" old_expression [list_iter];
	*/
	bool parse_list_if(){
		debug Stdout("parse_list_if").newline;
		auto __astNode = createASTNode("list_if");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("if")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_old_expression()){
					goto fail4;
				}
				addASTChild(__astNode,"old_expression",getASTResult());
			term6:
				// Optional
					// Production
					if(parse_list_iter()){
						addASTChild(__astNode,"list_iter",getASTResult());
						goto pass0;
					}
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_list_if failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	generator_expression
		::= "(" expression genexpr_for ")";
	*/
	bool parse_generator_expression(){
		debug Stdout("parse_generator_expression").newline;
		auto __astNode = createASTNode("generator_expression");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("(")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_expression()){
					goto fail4;
				}
				addASTChild(__astNode,"expression",getASTResult());
			term6:
				// Production
				if(!parse_genexpr_for()){
					goto fail4;
				}
				addASTChild(__astNode,"genexpr_for",getASTResult());
			term7:
				// Terminal
				if(match(")")){
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_generator_expression failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	genexpr_for
		::= "for" target_list "in" or_test [genexpr_iter];
	*/
	bool parse_genexpr_for(){
		debug Stdout("parse_genexpr_for").newline;
		auto __astNode = createASTNode("genexpr_for");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("for")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_target_list()){
					goto fail4;
				}
				addASTChild(__astNode,"target_list",getASTResult());
			term6:
				// Terminal
				if(!match("in")){
					goto fail4;
				}
			term7:
				// Production
				if(!parse_or_test()){
					goto fail4;
				}
				addASTChild(__astNode,"or_test",getASTResult());
			term8:
				// Optional
					// Production
					if(parse_genexpr_iter()){
						addASTChild(__astNode,"genexpr_iter",getASTResult());
						goto pass0;
					}
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_genexpr_for failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	genexpr_iter
		::= genexpr_for | genexpr_if;
	*/
	bool parse_genexpr_iter(){
		debug Stdout("parse_genexpr_iter").newline;
		auto __astNode = createASTNode("genexpr_iter");
		// OrGroup pass0
			// Production
			if(parse_genexpr_for()){
				addASTChild(__astNode,"genexpr_for",getASTResult());
				goto pass0;
			}
		term2:
			// Production
			if(!parse_genexpr_if()){
				goto fail1;
			}
			addASTChild(__astNode,"genexpr_if",getASTResult());
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_genexpr_iter failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	genexpr_if
		::= "if" old_expression [genexpr_iter];
	*/
	bool parse_genexpr_if(){
		debug Stdout("parse_genexpr_if").newline;
		auto __astNode = createASTNode("genexpr_if");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("if")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_old_expression()){
					goto fail4;
				}
				addASTChild(__astNode,"old_expression",getASTResult());
			term6:
				// Optional
					// Production
					if(parse_genexpr_iter()){
						addASTChild(__astNode,"genexpr_iter",getASTResult());
						goto pass0;
					}
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_genexpr_if failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	dict_display
		::= "{" [key_datum_list] "}";
	*/
	bool parse_dict_display(){
		debug Stdout("parse_dict_display").newline;
		auto __astNode = createASTNode("dict_display");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("{")){
					goto fail4;
				}
			term5:
				// Optional
					// Production
					if(!parse_key_datum_list()){
						goto term6;
					}
					addASTChild(__astNode,"key_datum_list",getASTResult());
			term6:
				// Terminal
				if(match("}")){
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_dict_display failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	key_datum_list
		::= key_datum ("," key_datum)* [","];
	*/
	bool parse_key_datum_list(){
		debug Stdout("parse_key_datum_list").newline;
		auto __astNode = createASTNode("key_datum_list");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_key_datum()){
					goto fail4;
				}
				addASTChild(__astNode,"key_datum",getASTResult());
			term5:
				// Iterator
				start6:
					// (terminator)
					if(!hasMore()){
						goto end7;
					}
					// (expression)
					expr8:
						// AndGroup
							auto position10 = getPos();
								// Terminal
								if(!match(",")){
									goto fail11;
								}
							term12:
								// Production
								if(parse_key_datum()){
									addASTChild(__astNode,"key_datum",getASTResult());
									goto start6;
								}
							fail11:
							setPos(position10);
							goto end7;
					goto start6;
				end7:
					// Optional
						// Terminal
						if(match(",")){
							goto pass0;
						}
						goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_key_datum_list failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	key_datum
		::= expression ":" expression;
	*/
	bool parse_key_datum(){
		debug Stdout("parse_key_datum").newline;
		auto __astNode = createASTNode("key_datum");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_expression()){
					goto fail4;
				}
				addASTChild(__astNode,"expression",getASTResult());
			term5:
				// Terminal
				if(!match(":")){
					goto fail4;
				}
			term6:
				// Production
				if(parse_expression()){
					addASTChild(__astNode,"expression",getASTResult());
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_key_datum failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	string_conversion
		::= "`" expression_list "`";
	*/
	bool parse_string_conversion(){
		debug Stdout("parse_string_conversion").newline;
		auto __astNode = createASTNode("string_conversion");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("`")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_expression_list()){
					goto fail4;
				}
				addASTChild(__astNode,"expression_list",getASTResult());
			term6:
				// Terminal
				if(match("`")){
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_string_conversion failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	yield_atom
		::= "(" yield_expression ")";
	*/
	bool parse_yield_atom(){
		debug Stdout("parse_yield_atom").newline;
		auto __astNode = createASTNode("yield_atom");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("(")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_yield_expression()){
					goto fail4;
				}
				addASTChild(__astNode,"yield_expression",getASTResult());
			term6:
				// Terminal
				if(match(")")){
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_yield_atom failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	yield_expression
		::= "yield" [expression_list];
	*/
	bool parse_yield_expression(){
		debug Stdout("parse_yield_expression").newline;
		auto __astNode = createASTNode("yield_expression");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("yield")){
					goto fail4;
				}
			term5:
				// Optional
					// Production
					if(parse_expression_list()){
						addASTChild(__astNode,"expression_list",getASTResult());
						goto pass0;
					}
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_yield_expression failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	primary
		::= atom | attributeref | subscription | slicing | call;
	*/
	bool parse_primary(){
		debug Stdout("parse_primary").newline;
		auto __astNode = createASTNode("primary");
		// OrGroup pass0
			// Production
			if(parse_atom()){
				addASTChild(__astNode,"atom",getASTResult());
				goto pass0;
			}
		term2:
			// Production
			if(parse_attributeref()){
				addASTChild(__astNode,"attributeref",getASTResult());
				goto pass0;
			}
		term3:
			// Production
			if(parse_subscription()){
				addASTChild(__astNode,"subscription",getASTResult());
				goto pass0;
			}
		term4:
			// Production
			if(parse_slicing()){
				addASTChild(__astNode,"slicing",getASTResult());
				goto pass0;
			}
		term5:
			// Production
			if(!parse_call()){
				goto fail1;
			}
			addASTChild(__astNode,"call",getASTResult());
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_primary failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	attributeref
		::= primary "." identifier;
	*/
	bool parse_attributeref(){
		debug Stdout("parse_attributeref").newline;
		auto __astNode = createASTNode("attributeref");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_primary()){
					goto fail4;
				}
				addASTChild(__astNode,"primary",getASTResult());
			term5:
				// Terminal
				if(!match(".")){
					goto fail4;
				}
			term6:
				// Production
				if(parse_identifier()){
					addASTChild(__astNode,"identifier",getASTResult());
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_attributeref failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	subscription
		::= primary "[" expression_list "]";
	*/
	bool parse_subscription(){
		debug Stdout("parse_subscription").newline;
		auto __astNode = createASTNode("subscription");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_primary()){
					goto fail4;
				}
				addASTChild(__astNode,"primary",getASTResult());
			term5:
				// Terminal
				if(!match("[")){
					goto fail4;
				}
			term6:
				// Production
				if(!parse_expression_list()){
					goto fail4;
				}
				addASTChild(__astNode,"expression_list",getASTResult());
			term7:
				// Terminal
				if(match("]")){
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_subscription failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	slicing
		::= simple_slicing | extended_slicing;
	*/
	bool parse_slicing(){
		debug Stdout("parse_slicing").newline;
		auto __astNode = createASTNode("slicing");
		// OrGroup pass0
			// Production
			if(parse_simple_slicing()){
				addASTChild(__astNode,"simple_slicing",getASTResult());
				goto pass0;
			}
		term2:
			// Production
			if(!parse_extended_slicing()){
				goto fail1;
			}
			addASTChild(__astNode,"extended_slicing",getASTResult());
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_slicing failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	simple_slicing
		::= primary "[" short_slice "]";
	*/
	bool parse_simple_slicing(){
		debug Stdout("parse_simple_slicing").newline;
		auto __astNode = createASTNode("simple_slicing");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_primary()){
					goto fail4;
				}
				addASTChild(__astNode,"primary",getASTResult());
			term5:
				// Terminal
				if(!match("[")){
					goto fail4;
				}
			term6:
				// Production
				if(!parse_short_slice()){
					goto fail4;
				}
				addASTChild(__astNode,"short_slice",getASTResult());
			term7:
				// Terminal
				if(match("]")){
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_simple_slicing failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	extended_slicing
		::= primary "[" slice_list "]";
	*/
	bool parse_extended_slicing(){
		debug Stdout("parse_extended_slicing").newline;
		auto __astNode = createASTNode("extended_slicing");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_primary()){
					goto fail4;
				}
				addASTChild(__astNode,"primary",getASTResult());
			term5:
				// Terminal
				if(!match("[")){
					goto fail4;
				}
			term6:
				// Production
				if(!parse_slice_list()){
					goto fail4;
				}
				addASTChild(__astNode,"slice_list",getASTResult());
			term7:
				// Terminal
				if(match("]")){
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_extended_slicing failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	slice_list
		::= slice_item ("," slice_item)* [","];
	*/
	bool parse_slice_list(){
		debug Stdout("parse_slice_list").newline;
		auto __astNode = createASTNode("slice_list");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_slice_item()){
					goto fail4;
				}
				addASTChild(__astNode,"slice_item",getASTResult());
			term5:
				// Iterator
				start6:
					// (terminator)
					if(!hasMore()){
						goto end7;
					}
					// (expression)
					expr8:
						// AndGroup
							auto position10 = getPos();
								// Terminal
								if(!match(",")){
									goto fail11;
								}
							term12:
								// Production
								if(parse_slice_item()){
									addASTChild(__astNode,"slice_item",getASTResult());
									goto start6;
								}
							fail11:
							setPos(position10);
							goto end7;
					goto start6;
				end7:
					// Optional
						// Terminal
						if(match(",")){
							goto pass0;
						}
						goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_slice_list failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	slice_item
		::= expression | proper_slice | ellipsis;
	*/
	bool parse_slice_item(){
		debug Stdout("parse_slice_item").newline;
		auto __astNode = createASTNode("slice_item");
		// OrGroup pass0
			// Production
			if(parse_expression()){
				addASTChild(__astNode,"expression",getASTResult());
				goto pass0;
			}
		term2:
			// Production
			if(parse_proper_slice()){
				addASTChild(__astNode,"proper_slice",getASTResult());
				goto pass0;
			}
		term3:
			// Production
			if(!parse_ellipsis()){
				goto fail1;
			}
			addASTChild(__astNode,"ellipsis",getASTResult());
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_slice_item failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	proper_slice
		::= short_slice | long_slice;
	*/
	bool parse_proper_slice(){
		debug Stdout("parse_proper_slice").newline;
		auto __astNode = createASTNode("proper_slice");
		// OrGroup pass0
			// Production
			if(parse_short_slice()){
				addASTChild(__astNode,"short_slice",getASTResult());
				goto pass0;
			}
		term2:
			// Production
			if(!parse_long_slice()){
				goto fail1;
			}
			addASTChild(__astNode,"long_slice",getASTResult());
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_proper_slice failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	short_slice
		::= [lower_bound] ":" [upper_bound];
	*/
	bool parse_short_slice(){
		debug Stdout("parse_short_slice").newline;
		auto __astNode = createASTNode("short_slice");
		// AndGroup
			auto position3 = getPos();
				// Optional
					// Production
					if(!parse_lower_bound()){
						goto term5;
					}
					addASTChild(__astNode,"lower_bound",getASTResult());
			term5:
				// Terminal
				if(!match(":")){
					goto fail4;
				}
			term6:
				// Optional
					// Production
					if(parse_upper_bound()){
						addASTChild(__astNode,"upper_bound",getASTResult());
						goto pass0;
					}
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_short_slice failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	long_slice
		::= short_slice ":" [stride];
	*/
	bool parse_long_slice(){
		debug Stdout("parse_long_slice").newline;
		auto __astNode = createASTNode("long_slice");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_short_slice()){
					goto fail4;
				}
				addASTChild(__astNode,"short_slice",getASTResult());
			term5:
				// Terminal
				if(!match(":")){
					goto fail4;
				}
			term6:
				// Optional
					// Production
					if(parse_stride()){
						addASTChild(__astNode,"stride",getASTResult());
						goto pass0;
					}
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_long_slice failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	lower_bound ::= expression;
	*/
	alias parse_expression parse_lower_bound;

	/*
	upper_bound ::= expression;
	*/
	alias parse_expression parse_upper_bound;

	/*
	stride ::= expression;
	*/
	alias parse_expression parse_stride;

	/*
	ellipsis
		::= "...";
	*/
	bool parse_ellipsis(){
		debug Stdout("parse_ellipsis").newline;
		auto __astNode = createASTNode("ellipsis");
		// Terminal
		if(!match("...")){
			goto fail1;
		}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_ellipsis failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	call
		::= primary "(" [argument_list [","] | expression genexpr_for] ")";
	*/
	bool parse_call(){
		debug Stdout("parse_call").newline;
		auto __astNode = createASTNode("call");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_primary()){
					goto fail4;
				}
				addASTChild(__astNode,"primary",getASTResult());
			term5:
				// Terminal
				if(!match("(")){
					goto fail4;
				}
			term6:
				// Optional
					// OrGroup term7
						// AndGroup
							auto position10 = getPos();
								// Production
								if(!parse_argument_list()){
									goto fail11;
								}
								addASTChild(__astNode,"argument_list",getASTResult());
							term12:
								// Optional
									// Terminal
									if(match(",")){
										goto term7;
									}
									goto term7;
							fail11:
							setPos(position10);
					term8:
						// AndGroup
							auto position14 = getPos();
								// Production
								if(!parse_expression()){
									goto fail15;
								}
								addASTChild(__astNode,"expression",getASTResult());
							term16:
								// Production
								if(parse_genexpr_for()){
									addASTChild(__astNode,"genexpr_for",getASTResult());
									goto term7;
								}
							fail15:
							setPos(position14);
							goto term7;
			term7:
				// Terminal
				if(match(")")){
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_call failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	argument_list
		::= positional_arguments ["," keyword_arguments] ["," "*" expression] ["," "**" expression] | keyword_arguments ["," "*" expression] ["," "**" expression] | "*" expression ["," "**" expression] | "**" expression;
	*/
	bool parse_argument_list(){
		debug Stdout("parse_argument_list").newline;
		auto __astNode = createASTNode("argument_list");
		// OrGroup pass0
			// AndGroup
				auto position4 = getPos();
					// Production
					if(!parse_positional_arguments()){
						goto fail5;
					}
					addASTChild(__astNode,"positional_arguments",getASTResult());
				term6:
					// Optional
						// AndGroup
							auto position9 = getPos();
								// Terminal
								if(!match(",")){
									goto fail10;
								}
							term11:
								// Production
								if(parse_keyword_arguments()){
									addASTChild(__astNode,"keyword_arguments",getASTResult());
									goto term7;
								}
							fail10:
							setPos(position9);
							goto term7;
				term7:
					// Optional
						// AndGroup
							auto position14 = getPos();
								// Terminal
								if(!match(",")){
									goto fail15;
								}
							term16:
								// Terminal
								if(!match("*")){
									goto fail15;
								}
							term17:
								// Production
								if(parse_expression()){
									addASTChild(__astNode,"expression",getASTResult());
									goto term12;
								}
							fail15:
							setPos(position14);
							goto term12;
				term12:
					// Optional
						// AndGroup
							auto position19 = getPos();
								// Terminal
								if(!match(",")){
									goto fail20;
								}
							term21:
								// Terminal
								if(!match("**")){
									goto fail20;
								}
							term22:
								// Production
								if(parse_expression()){
									addASTChild(__astNode,"expression",getASTResult());
									goto pass0;
								}
							fail20:
							setPos(position19);
						goto pass0;
				fail5:
				setPos(position4);
		term2:
			// AndGroup
				auto position25 = getPos();
					// Production
					if(!parse_keyword_arguments()){
						goto fail26;
					}
					addASTChild(__astNode,"keyword_arguments",getASTResult());
				term27:
					// Optional
						// AndGroup
							auto position30 = getPos();
								// Terminal
								if(!match(",")){
									goto fail31;
								}
							term32:
								// Terminal
								if(!match("*")){
									goto fail31;
								}
							term33:
								// Production
								if(parse_expression()){
									addASTChild(__astNode,"expression",getASTResult());
									goto term28;
								}
							fail31:
							setPos(position30);
							goto term28;
				term28:
					// Optional
						// AndGroup
							auto position35 = getPos();
								// Terminal
								if(!match(",")){
									goto fail36;
								}
							term37:
								// Terminal
								if(!match("**")){
									goto fail36;
								}
							term38:
								// Production
								if(parse_expression()){
									addASTChild(__astNode,"expression",getASTResult());
									goto pass0;
								}
							fail36:
							setPos(position35);
						goto pass0;
				fail26:
				setPos(position25);
		term23:
			// AndGroup
				auto position41 = getPos();
					// Terminal
					if(!match("*")){
						goto fail42;
					}
				term43:
					// Production
					if(!parse_expression()){
						goto fail42;
					}
					addASTChild(__astNode,"expression",getASTResult());
				term44:
					// Optional
						// AndGroup
							auto position46 = getPos();
								// Terminal
								if(!match(",")){
									goto fail47;
								}
							term48:
								// Terminal
								if(!match("**")){
									goto fail47;
								}
							term49:
								// Production
								if(parse_expression()){
									addASTChild(__astNode,"expression",getASTResult());
									goto pass0;
								}
							fail47:
							setPos(position46);
						goto pass0;
				fail42:
				setPos(position41);
		term39:
			// AndGroup
				auto position51 = getPos();
					// Terminal
					if(!match("**")){
						goto fail52;
					}
				term53:
					// Production
					if(parse_expression()){
						addASTChild(__astNode,"expression",getASTResult());
						goto pass0;
					}
				fail52:
				setPos(position51);
				goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_argument_list failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	positional_arguments
		::= expression ("," expression)*;
	*/
	bool parse_positional_arguments(){
		debug Stdout("parse_positional_arguments").newline;
		auto __astNode = createASTNode("positional_arguments");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_expression()){
					goto fail4;
				}
				addASTChild(__astNode,"expression",getASTResult());
			term5:
				// Iterator
				start6:
					// (terminator)
					if(!hasMore()){
						goto end7;
					}
					// (expression)
					expr8:
						// AndGroup
							auto position10 = getPos();
								// Terminal
								if(!match(",")){
									goto fail11;
								}
							term12:
								// Production
								if(parse_expression()){
									addASTChild(__astNode,"expression",getASTResult());
									goto start6;
								}
							fail11:
							setPos(position10);
							goto end7;
					goto start6;
				end7:
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_positional_arguments failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	keyword_arguments
		::= keyword_item ("," keyword_item)*;
	*/
	bool parse_keyword_arguments(){
		debug Stdout("parse_keyword_arguments").newline;
		auto __astNode = createASTNode("keyword_arguments");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_keyword_item()){
					goto fail4;
				}
				addASTChild(__astNode,"keyword_item",getASTResult());
			term5:
				// Iterator
				start6:
					// (terminator)
					if(!hasMore()){
						goto end7;
					}
					// (expression)
					expr8:
						// AndGroup
							auto position10 = getPos();
								// Terminal
								if(!match(",")){
									goto fail11;
								}
							term12:
								// Production
								if(parse_keyword_item()){
									addASTChild(__astNode,"keyword_item",getASTResult());
									goto start6;
								}
							fail11:
							setPos(position10);
							goto end7;
					goto start6;
				end7:
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_keyword_arguments failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	keyword_item
		::= identifier "=" expression;
	*/
	bool parse_keyword_item(){
		debug Stdout("parse_keyword_item").newline;
		auto __astNode = createASTNode("keyword_item");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_identifier()){
					goto fail4;
				}
				addASTChild(__astNode,"identifier",getASTResult());
			term5:
				// Terminal
				if(!match("=")){
					goto fail4;
				}
			term6:
				// Production
				if(parse_expression()){
					addASTChild(__astNode,"expression",getASTResult());
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_keyword_item failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	power
		::= primary ["**" u_expr];
	*/
	bool parse_power(){
		debug Stdout("parse_power").newline;
		auto __astNode = createASTNode("power");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_primary()){
					goto fail4;
				}
				addASTChild(__astNode,"primary",getASTResult());
			term5:
				// Optional
					// AndGroup
						auto position7 = getPos();
							// Terminal
							if(!match("**")){
								goto fail8;
							}
						term9:
							// Production
							if(parse_u_expr()){
								addASTChild(__astNode,"u_expr",getASTResult());
								goto pass0;
							}
						fail8:
						setPos(position7);
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_power failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	u_expr
		::= power | "-" u_expr | "+" u_expr | "~" u_expr;
	*/
	bool parse_u_expr(){
		debug Stdout("parse_u_expr").newline;
		auto __astNode = createASTNode("u_expr");
		// OrGroup pass0
			// Production
			if(parse_power()){
				addASTChild(__astNode,"power",getASTResult());
				goto pass0;
			}
		term2:
			// AndGroup
				auto position5 = getPos();
					// Terminal
					if(!match("-")){
						goto fail6;
					}
				term7:
					// Production
					if(parse_u_expr()){
						addASTChild(__astNode,"u_expr",getASTResult());
						goto pass0;
					}
				fail6:
				setPos(position5);
		term3:
			// AndGroup
				auto position10 = getPos();
					// Terminal
					if(!match("+")){
						goto fail11;
					}
				term12:
					// Production
					if(parse_u_expr()){
						addASTChild(__astNode,"u_expr",getASTResult());
						goto pass0;
					}
				fail11:
				setPos(position10);
		term8:
			// AndGroup
				auto position14 = getPos();
					// Terminal
					if(!match("~")){
						goto fail15;
					}
				term16:
					// Production
					if(parse_u_expr()){
						addASTChild(__astNode,"u_expr",getASTResult());
						goto pass0;
					}
				fail15:
				setPos(position14);
				goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_u_expr failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	m_expr
		::= u_expr | m_expr "*" u_expr | m_expr "//" u_expr | m_expr "/" u_expr | m_expr "%" u_expr;
	*/
	bool parse_m_expr(){
		debug Stdout("parse_m_expr").newline;
		auto __astNode = createASTNode("m_expr");
		// OrGroup pass0
			// Production
			if(parse_u_expr()){
				addASTChild(__astNode,"u_expr",getASTResult());
				goto pass0;
			}
		term2:
			// AndGroup
				auto position5 = getPos();
					// Production
					if(!parse_m_expr()){
						goto fail6;
					}
					addASTChild(__astNode,"m_expr",getASTResult());
				term7:
					// Terminal
					if(!match("*")){
						goto fail6;
					}
				term8:
					// Production
					if(parse_u_expr()){
						addASTChild(__astNode,"u_expr",getASTResult());
						goto pass0;
					}
				fail6:
				setPos(position5);
		term3:
			// AndGroup
				auto position11 = getPos();
					// Production
					if(!parse_m_expr()){
						goto fail12;
					}
					addASTChild(__astNode,"m_expr",getASTResult());
				term13:
					// Terminal
					if(!match("//")){
						goto fail12;
					}
				term14:
					// Production
					if(parse_u_expr()){
						addASTChild(__astNode,"u_expr",getASTResult());
						goto pass0;
					}
				fail12:
				setPos(position11);
		term9:
			// AndGroup
				auto position17 = getPos();
					// Production
					if(!parse_m_expr()){
						goto fail18;
					}
					addASTChild(__astNode,"m_expr",getASTResult());
				term19:
					// Terminal
					if(!match("/")){
						goto fail18;
					}
				term20:
					// Production
					if(parse_u_expr()){
						addASTChild(__astNode,"u_expr",getASTResult());
						goto pass0;
					}
				fail18:
				setPos(position17);
		term15:
			// AndGroup
				auto position22 = getPos();
					// Production
					if(!parse_m_expr()){
						goto fail23;
					}
					addASTChild(__astNode,"m_expr",getASTResult());
				term24:
					// Terminal
					if(!match("%")){
						goto fail23;
					}
				term25:
					// Production
					if(parse_u_expr()){
						addASTChild(__astNode,"u_expr",getASTResult());
						goto pass0;
					}
				fail23:
				setPos(position22);
				goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_m_expr failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	a_expr
		::= m_expr | a_expr "+" m_expr | a_expr "-" m_expr;
	*/
	bool parse_a_expr(){
		debug Stdout("parse_a_expr").newline;
		auto __astNode = createASTNode("a_expr");
		// OrGroup pass0
			// Production
			if(parse_m_expr()){
				addASTChild(__astNode,"m_expr",getASTResult());
				goto pass0;
			}
		term2:
			// AndGroup
				auto position5 = getPos();
					// Production
					if(!parse_a_expr()){
						goto fail6;
					}
					addASTChild(__astNode,"a_expr",getASTResult());
				term7:
					// Terminal
					if(!match("+")){
						goto fail6;
					}
				term8:
					// Production
					if(parse_m_expr()){
						addASTChild(__astNode,"m_expr",getASTResult());
						goto pass0;
					}
				fail6:
				setPos(position5);
		term3:
			// AndGroup
				auto position10 = getPos();
					// Production
					if(!parse_a_expr()){
						goto fail11;
					}
					addASTChild(__astNode,"a_expr",getASTResult());
				term12:
					// Terminal
					if(!match("-")){
						goto fail11;
					}
				term13:
					// Production
					if(parse_m_expr()){
						addASTChild(__astNode,"m_expr",getASTResult());
						goto pass0;
					}
				fail11:
				setPos(position10);
				goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_a_expr failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	shift_expr
		::= a_expr | shift_expr ("<<" | ">>") a_expr;
	*/
	bool parse_shift_expr(){
		debug Stdout("parse_shift_expr").newline;
		auto __astNode = createASTNode("shift_expr");
		// OrGroup pass0
			// Production
			if(parse_a_expr()){
				addASTChild(__astNode,"a_expr",getASTResult());
				goto pass0;
			}
		term2:
			// AndGroup
				auto position4 = getPos();
					// Production
					if(!parse_shift_expr()){
						goto fail5;
					}
					addASTChild(__astNode,"shift_expr",getASTResult());
				term6:
					// OrGroup term7
						// Terminal
						if(match("<<")){
							goto term7;
						}
					term8:
						// Terminal
						if(!match(">>")){
							goto fail5;
						}
				term7:
					// Production
					if(parse_a_expr()){
						addASTChild(__astNode,"a_expr",getASTResult());
						goto pass0;
					}
				fail5:
				setPos(position4);
				goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_shift_expr failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	and_expr
		::= shift_expr | and_expr "&" shift_expr;
	*/
	bool parse_and_expr(){
		debug Stdout("parse_and_expr").newline;
		auto __astNode = createASTNode("and_expr");
		// OrGroup pass0
			// Production
			if(parse_shift_expr()){
				addASTChild(__astNode,"shift_expr",getASTResult());
				goto pass0;
			}
		term2:
			// AndGroup
				auto position4 = getPos();
					// Production
					if(!parse_and_expr()){
						goto fail5;
					}
					addASTChild(__astNode,"and_expr",getASTResult());
				term6:
					// Terminal
					if(!match("&")){
						goto fail5;
					}
				term7:
					// Production
					if(parse_shift_expr()){
						addASTChild(__astNode,"shift_expr",getASTResult());
						goto pass0;
					}
				fail5:
				setPos(position4);
				goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_and_expr failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	xor_expr
		::= and_expr | xor_expr "^" and_expr;
	*/
	bool parse_xor_expr(){
		debug Stdout("parse_xor_expr").newline;
		auto __astNode = createASTNode("xor_expr");
		// OrGroup pass0
			// Production
			if(parse_and_expr()){
				addASTChild(__astNode,"and_expr",getASTResult());
				goto pass0;
			}
		term2:
			// AndGroup
				auto position4 = getPos();
					// Production
					if(!parse_xor_expr()){
						goto fail5;
					}
					addASTChild(__astNode,"xor_expr",getASTResult());
				term6:
					// Terminal
					if(!match("^")){
						goto fail5;
					}
				term7:
					// Production
					if(parse_and_expr()){
						addASTChild(__astNode,"and_expr",getASTResult());
						goto pass0;
					}
				fail5:
				setPos(position4);
				goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_xor_expr failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	or_expr
		::= xor_expr | or_expr "|" xor_expr;
	*/
	bool parse_or_expr(){
		debug Stdout("parse_or_expr").newline;
		auto __astNode = createASTNode("or_expr");
		// OrGroup pass0
			// Production
			if(parse_xor_expr()){
				addASTChild(__astNode,"xor_expr",getASTResult());
				goto pass0;
			}
		term2:
			// AndGroup
				auto position4 = getPos();
					// Production
					if(!parse_or_expr()){
						goto fail5;
					}
					addASTChild(__astNode,"or_expr",getASTResult());
				term6:
					// Terminal
					if(!match("|")){
						goto fail5;
					}
				term7:
					// Production
					if(parse_xor_expr()){
						addASTChild(__astNode,"xor_expr",getASTResult());
						goto pass0;
					}
				fail5:
				setPos(position4);
				goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_or_expr failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	comparison
		::= or_expr (comp_operator or_expr)*;
	*/
	bool parse_comparison(){
		debug Stdout("parse_comparison").newline;
		auto __astNode = createASTNode("comparison");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_or_expr()){
					goto fail4;
				}
				addASTChild(__astNode,"or_expr",getASTResult());
			term5:
				// Iterator
				start6:
					// (terminator)
					if(!hasMore()){
						goto end7;
					}
					// (expression)
					expr8:
						// AndGroup
							auto position10 = getPos();
								// Production
								if(!parse_comp_operator()){
									goto fail11;
								}
								addASTChild(__astNode,"comp_operator",getASTResult());
							term12:
								// Production
								if(parse_or_expr()){
									addASTChild(__astNode,"or_expr",getASTResult());
									goto start6;
								}
							fail11:
							setPos(position10);
							goto end7;
					goto start6;
				end7:
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_comparison failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	comp_operator
		::= "<" | ">" | "==" | ">=" | "<=" | "<>" | "!=" | "is" ["not"] | ["not"] "in";
	*/
	bool parse_comp_operator(){
		debug Stdout("parse_comp_operator").newline;
		auto __astNode = createASTNode("comp_operator");
		// OrGroup pass0
			// Terminal
			if(match("<")){
				goto pass0;
			}
		term2:
			// Terminal
			if(match(">")){
				goto pass0;
			}
		term3:
			// Terminal
			if(match("==")){
				goto pass0;
			}
		term4:
			// Terminal
			if(match(">=")){
				goto pass0;
			}
		term5:
			// Terminal
			if(match("<=")){
				goto pass0;
			}
		term6:
			// Terminal
			if(match("<>")){
				goto pass0;
			}
		term7:
			// Terminal
			if(match("!=")){
				goto pass0;
			}
		term8:
			// AndGroup
				auto position11 = getPos();
					// Terminal
					if(!match("is")){
						goto fail12;
					}
				term13:
					// Optional
						// Terminal
						if(match("not")){
							goto pass0;
						}
						goto pass0;
				fail12:
				setPos(position11);
		term9:
			// AndGroup
				auto position15 = getPos();
					// Optional
						// Terminal
						if(!match("not")){
							goto term17;
						}
				term17:
					// Terminal
					if(match("in")){
						goto pass0;
					}
				fail16:
				setPos(position15);
				goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_comp_operator failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	expression
		::= conditional_expression | lambda_form;
	*/
	bool parse_expression(){
		debug Stdout("parse_expression").newline;
		auto __astNode = createASTNode("expression");
		// OrGroup pass0
			// Production
			if(parse_conditional_expression()){
				addASTChild(__astNode,"conditional_expression",getASTResult());
				goto pass0;
			}
		term2:
			// Production
			if(!parse_lambda_form()){
				goto fail1;
			}
			addASTChild(__astNode,"lambda_form",getASTResult());
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_expression failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	old_expression
		::= or_test | old_lambda_form;
	*/
	bool parse_old_expression(){
		debug Stdout("parse_old_expression").newline;
		auto __astNode = createASTNode("old_expression");
		// OrGroup pass0
			// Production
			if(parse_or_test()){
				addASTChild(__astNode,"or_test",getASTResult());
				goto pass0;
			}
		term2:
			// Production
			if(!parse_old_lambda_form()){
				goto fail1;
			}
			addASTChild(__astNode,"old_lambda_form",getASTResult());
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_old_expression failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	conditional_expression
		::= or_test ["if" or_test "else" expression];
	*/
	bool parse_conditional_expression(){
		debug Stdout("parse_conditional_expression").newline;
		auto __astNode = createASTNode("conditional_expression");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_or_test()){
					goto fail4;
				}
				addASTChild(__astNode,"or_test",getASTResult());
			term5:
				// Optional
					// AndGroup
						auto position7 = getPos();
							// Terminal
							if(!match("if")){
								goto fail8;
							}
						term9:
							// Production
							if(!parse_or_test()){
								goto fail8;
							}
							addASTChild(__astNode,"or_test",getASTResult());
						term10:
							// Terminal
							if(!match("else")){
								goto fail8;
							}
						term11:
							// Production
							if(parse_expression()){
								addASTChild(__astNode,"expression",getASTResult());
								goto pass0;
							}
						fail8:
						setPos(position7);
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_conditional_expression failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	or_test
		::= and_test | or_test "or" and_test;
	*/
	bool parse_or_test(){
		debug Stdout("parse_or_test").newline;
		auto __astNode = createASTNode("or_test");
		// OrGroup pass0
			// Production
			if(parse_and_test()){
				addASTChild(__astNode,"and_test",getASTResult());
				goto pass0;
			}
		term2:
			// AndGroup
				auto position4 = getPos();
					// Production
					if(!parse_or_test()){
						goto fail5;
					}
					addASTChild(__astNode,"or_test",getASTResult());
				term6:
					// Terminal
					if(!match("or")){
						goto fail5;
					}
				term7:
					// Production
					if(parse_and_test()){
						addASTChild(__astNode,"and_test",getASTResult());
						goto pass0;
					}
				fail5:
				setPos(position4);
				goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_or_test failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	and_test
		::= not_test | and_test "and" not_test;
	*/
	bool parse_and_test(){
		debug Stdout("parse_and_test").newline;
		auto __astNode = createASTNode("and_test");
		// OrGroup pass0
			// Production
			if(parse_not_test()){
				addASTChild(__astNode,"not_test",getASTResult());
				goto pass0;
			}
		term2:
			// AndGroup
				auto position4 = getPos();
					// Production
					if(!parse_and_test()){
						goto fail5;
					}
					addASTChild(__astNode,"and_test",getASTResult());
				term6:
					// Terminal
					if(!match("and")){
						goto fail5;
					}
				term7:
					// Production
					if(parse_not_test()){
						addASTChild(__astNode,"not_test",getASTResult());
						goto pass0;
					}
				fail5:
				setPos(position4);
				goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_and_test failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	not_test
		::= comparison | "not" not_test;
	*/
	bool parse_not_test(){
		debug Stdout("parse_not_test").newline;
		auto __astNode = createASTNode("not_test");
		// OrGroup pass0
			// Production
			if(parse_comparison()){
				addASTChild(__astNode,"comparison",getASTResult());
				goto pass0;
			}
		term2:
			// AndGroup
				auto position4 = getPos();
					// Terminal
					if(!match("not")){
						goto fail5;
					}
				term6:
					// Production
					if(parse_not_test()){
						addASTChild(__astNode,"not_test",getASTResult());
						goto pass0;
					}
				fail5:
				setPos(position4);
				goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_not_test failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	lambda_form
		::= "lambda" [parameter_list]:expression;
	*/
	bool parse_lambda_form(){
		debug Stdout("parse_lambda_form").newline;
		auto __astNode = createASTNode("lambda_form");
		String var_expression;

		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("lambda")){
					goto fail4;
				}
			term5:
				// Optional
					auto position6 = getPos();
						// Production
						if(!parse_parameter_list()){
							goto fail8;
						}
						addASTChild(__astNode,"parameter_list",getASTResult());
					pass7:
						smartAssign(var_expression,slice(position6,getPos()));
						addASTChildValue(__astNode,"expression",slice(position6,getPos()));
					fail8:
						goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_lambda_form failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	old_lambda_form
		::= "lambda" [parameter_list]:old_expression;
	*/
	bool parse_old_lambda_form(){
		debug Stdout("parse_old_lambda_form").newline;
		auto __astNode = createASTNode("old_lambda_form");
		String var_old_expression;

		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("lambda")){
					goto fail4;
				}
			term5:
				// Optional
					auto position6 = getPos();
						// Production
						if(!parse_parameter_list()){
							goto fail8;
						}
						addASTChild(__astNode,"parameter_list",getASTResult());
					pass7:
						smartAssign(var_old_expression,slice(position6,getPos()));
						addASTChildValue(__astNode,"old_expression",slice(position6,getPos()));
					fail8:
						goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_old_lambda_form failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	expression_list
		::= expression ("," expression)* [","];
	*/
	bool parse_expression_list(){
		debug Stdout("parse_expression_list").newline;
		auto __astNode = createASTNode("expression_list");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_expression()){
					goto fail4;
				}
				addASTChild(__astNode,"expression",getASTResult());
			term5:
				// Iterator
				start6:
					// (terminator)
					if(!hasMore()){
						goto end7;
					}
					// (expression)
					expr8:
						// AndGroup
							auto position10 = getPos();
								// Terminal
								if(!match(",")){
									goto fail11;
								}
							term12:
								// Production
								if(parse_expression()){
									addASTChild(__astNode,"expression",getASTResult());
									goto start6;
								}
							fail11:
							setPos(position10);
							goto end7;
					goto start6;
				end7:
					// Optional
						// Terminal
						if(match(",")){
							goto pass0;
						}
						goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_expression_list failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	simple_stmt
		::= expression_stmt | assert_stmt | assignment_stmt | augmented_assignment_stmt | pass_stmt | del_stmt | print_stmt | return_stmt | yield_stmt | raise_stmt | break_stmt | continue_stmt | import_stmt | global_stmt | exec_stmt;
	*/
	bool parse_simple_stmt(){
		debug Stdout("parse_simple_stmt").newline;
		auto __astNode = createASTNode("simple_stmt");
		// OrGroup pass0
			// Production
			if(parse_expression_stmt()){
				addASTChild(__astNode,"expression_stmt",getASTResult());
				goto pass0;
			}
		term2:
			// Production
			if(parse_assert_stmt()){
				addASTChild(__astNode,"assert_stmt",getASTResult());
				goto pass0;
			}
		term3:
			// Production
			if(parse_assignment_stmt()){
				addASTChild(__astNode,"assignment_stmt",getASTResult());
				goto pass0;
			}
		term4:
			// Production
			if(parse_augmented_assignment_stmt()){
				addASTChild(__astNode,"augmented_assignment_stmt",getASTResult());
				goto pass0;
			}
		term5:
			// Production
			if(parse_pass_stmt()){
				addASTChild(__astNode,"pass_stmt",getASTResult());
				goto pass0;
			}
		term6:
			// Production
			if(parse_del_stmt()){
				addASTChild(__astNode,"del_stmt",getASTResult());
				goto pass0;
			}
		term7:
			// Production
			if(parse_print_stmt()){
				addASTChild(__astNode,"print_stmt",getASTResult());
				goto pass0;
			}
		term8:
			// Production
			if(parse_return_stmt()){
				addASTChild(__astNode,"return_stmt",getASTResult());
				goto pass0;
			}
		term9:
			// Production
			if(parse_yield_stmt()){
				addASTChild(__astNode,"yield_stmt",getASTResult());
				goto pass0;
			}
		term10:
			// Production
			if(parse_raise_stmt()){
				addASTChild(__astNode,"raise_stmt",getASTResult());
				goto pass0;
			}
		term11:
			// Production
			if(parse_break_stmt()){
				addASTChild(__astNode,"break_stmt",getASTResult());
				goto pass0;
			}
		term12:
			// Production
			if(parse_continue_stmt()){
				addASTChild(__astNode,"continue_stmt",getASTResult());
				goto pass0;
			}
		term13:
			// Production
			if(parse_import_stmt()){
				addASTChild(__astNode,"import_stmt",getASTResult());
				goto pass0;
			}
		term14:
			// Production
			if(parse_global_stmt()){
				addASTChild(__astNode,"global_stmt",getASTResult());
				goto pass0;
			}
		term15:
			// Production
			if(!parse_exec_stmt()){
				goto fail1;
			}
			addASTChild(__astNode,"exec_stmt",getASTResult());
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_simple_stmt failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	expression_stmt ::= expression_list;
	*/
	alias parse_expression_list parse_expression_stmt;

	/*
	assert_stmt
		::= "assert" expression ["," expression];
	*/
	bool parse_assert_stmt(){
		debug Stdout("parse_assert_stmt").newline;
		auto __astNode = createASTNode("assert_stmt");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("assert")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_expression()){
					goto fail4;
				}
				addASTChild(__astNode,"expression",getASTResult());
			term6:
				// Optional
					// AndGroup
						auto position8 = getPos();
							// Terminal
							if(!match(",")){
								goto fail9;
							}
						term10:
							// Production
							if(parse_expression()){
								addASTChild(__astNode,"expression",getASTResult());
								goto pass0;
							}
						fail9:
						setPos(position8);
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_assert_stmt failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	assignment_stmt
		::= (target_list "=")+ (expression_list | yield_expression);
	*/
	bool parse_assignment_stmt(){
		debug Stdout("parse_assignment_stmt").newline;
		auto __astNode = createASTNode("assignment_stmt");
		// Iterator
		size_t counter5 = 0;
		start2:
			// (terminator)
				// OrGroup end3
					// Production
					if(parse_expression_list()){
						addASTChild(__astNode,"expression_list",getASTResult());
						goto end3;
					}
				term7:
					// Production
					if(parse_yield_expression()){
						addASTChild(__astNode,"yield_expression",getASTResult());
						goto end3;
					}
			// (expression)
			expr4:
				// AndGroup
					auto position9 = getPos();
						// Production
						if(!parse_target_list()){
							goto fail10;
						}
						addASTChild(__astNode,"target_list",getASTResult());
					term11:
						// Terminal
						if(match("=")){
							goto increment6;
						}
					fail10:
					setPos(position9);
					goto fail1;
			increment6:
			// (increment expr count)
				counter5 ++;
			goto start2;
		end3:
			// (range test)
				if(!((counter5 >= 1))){
					goto fail1;
					goto pass0;
				}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_assignment_stmt failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	target_list
		::= target ("," target)* [","];
	*/
	bool parse_target_list(){
		debug Stdout("parse_target_list").newline;
		auto __astNode = createASTNode("target_list");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_target()){
					goto fail4;
				}
				addASTChild(__astNode,"target",getASTResult());
			term5:
				// Iterator
				start6:
					// (terminator)
					if(!hasMore()){
						goto end7;
					}
					// (expression)
					expr8:
						// AndGroup
							auto position10 = getPos();
								// Terminal
								if(!match(",")){
									goto fail11;
								}
							term12:
								// Production
								if(parse_target()){
									addASTChild(__astNode,"target",getASTResult());
									goto start6;
								}
							fail11:
							setPos(position10);
							goto end7;
					goto start6;
				end7:
					// Optional
						// Terminal
						if(match(",")){
							goto pass0;
						}
						goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_target_list failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	target
		::= identifier | "(" target_list ")" | "[" target_list "]" | attributeref | subscription | slicing;
	*/
	bool parse_target(){
		debug Stdout("parse_target").newline;
		auto __astNode = createASTNode("target");
		// OrGroup pass0
			// Production
			if(parse_identifier()){
				addASTChild(__astNode,"identifier",getASTResult());
				goto pass0;
			}
		term2:
			// AndGroup
				auto position5 = getPos();
					// Terminal
					if(!match("(")){
						goto fail6;
					}
				term7:
					// Production
					if(!parse_target_list()){
						goto fail6;
					}
					addASTChild(__astNode,"target_list",getASTResult());
				term8:
					// Terminal
					if(match(")")){
						goto pass0;
					}
				fail6:
				setPos(position5);
		term3:
			// AndGroup
				auto position11 = getPos();
					// Terminal
					if(!match("[")){
						goto fail12;
					}
				term13:
					// Production
					if(!parse_target_list()){
						goto fail12;
					}
					addASTChild(__astNode,"target_list",getASTResult());
				term14:
					// Terminal
					if(match("]")){
						goto pass0;
					}
				fail12:
				setPos(position11);
		term9:
			// Production
			if(parse_attributeref()){
				addASTChild(__astNode,"attributeref",getASTResult());
				goto pass0;
			}
		term15:
			// Production
			if(parse_subscription()){
				addASTChild(__astNode,"subscription",getASTResult());
				goto pass0;
			}
		term16:
			// Production
			if(!parse_slicing()){
				goto fail1;
			}
			addASTChild(__astNode,"slicing",getASTResult());
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_target failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	augmented_assignment_stmt
		::= target augop (expression_list | yield_expression);
	*/
	bool parse_augmented_assignment_stmt(){
		debug Stdout("parse_augmented_assignment_stmt").newline;
		auto __astNode = createASTNode("augmented_assignment_stmt");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_target()){
					goto fail4;
				}
				addASTChild(__astNode,"target",getASTResult());
			term5:
				// Production
				if(!parse_augop()){
					goto fail4;
				}
				addASTChild(__astNode,"augop",getASTResult());
			term6:
				// OrGroup pass0
					// Production
					if(parse_expression_list()){
						addASTChild(__astNode,"expression_list",getASTResult());
						goto pass0;
					}
				term7:
					// Production
					if(parse_yield_expression()){
						addASTChild(__astNode,"yield_expression",getASTResult());
						goto pass0;
					}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_augmented_assignment_stmt failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	augop
		::= "+=" | "-=" | "*=" | "/=" | "%=" | "**=" | ">>=" | "<<=" | "&=" | "^=" | "|=";
	*/
	bool parse_augop(){
		debug Stdout("parse_augop").newline;
		auto __astNode = createASTNode("augop");
		// OrGroup pass0
			// Terminal
			if(match("+=")){
				goto pass0;
			}
		term2:
			// Terminal
			if(match("-=")){
				goto pass0;
			}
		term3:
			// Terminal
			if(match("*=")){
				goto pass0;
			}
		term4:
			// Terminal
			if(match("/=")){
				goto pass0;
			}
		term5:
			// Terminal
			if(match("%=")){
				goto pass0;
			}
		term6:
			// Terminal
			if(match("**=")){
				goto pass0;
			}
		term7:
			// Terminal
			if(match(">>=")){
				goto pass0;
			}
		term8:
			// Terminal
			if(match("<<=")){
				goto pass0;
			}
		term9:
			// Terminal
			if(match("&=")){
				goto pass0;
			}
		term10:
			// Terminal
			if(match("^=")){
				goto pass0;
			}
		term11:
			// Terminal
			if(!match("|=")){
				goto fail1;
			}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_augop failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	pass_stmt
		::= "pass";
	*/
	bool parse_pass_stmt(){
		debug Stdout("parse_pass_stmt").newline;
		auto __astNode = createASTNode("pass_stmt");
		// Terminal
		if(!match("pass")){
			goto fail1;
		}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_pass_stmt failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	del_stmt
		::= "del" target_list;
	*/
	bool parse_del_stmt(){
		debug Stdout("parse_del_stmt").newline;
		auto __astNode = createASTNode("del_stmt");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("del")){
					goto fail4;
				}
			term5:
				// Production
				if(parse_target_list()){
					addASTChild(__astNode,"target_list",getASTResult());
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_del_stmt failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	print_stmt
		::= "print" [expression ("," expression)* [","] | ">>" expression [("," expression)+ [","]]];
	*/
	bool parse_print_stmt(){
		debug Stdout("parse_print_stmt").newline;
		auto __astNode = createASTNode("print_stmt");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("print")){
					goto fail4;
				}
			term5:
				// Optional
					// OrGroup pass0
						// AndGroup
							auto position8 = getPos();
								// Production
								if(!parse_expression()){
									goto fail9;
								}
								addASTChild(__astNode,"expression",getASTResult());
							term10:
								// Iterator
								start11:
									// (terminator)
									if(!hasMore()){
										goto end12;
									}
									// (expression)
									expr13:
										// AndGroup
											auto position15 = getPos();
												// Terminal
												if(!match(",")){
													goto fail16;
												}
											term17:
												// Production
												if(parse_expression()){
													addASTChild(__astNode,"expression",getASTResult());
													goto start11;
												}
											fail16:
											setPos(position15);
											goto end12;
									goto start11;
								end12:
									// Optional
										// Terminal
										if(match(",")){
											goto pass0;
										}
										goto pass0;
							fail9:
							setPos(position8);
					term6:
						// AndGroup
							auto position19 = getPos();
								// Terminal
								if(!match(">>")){
									goto fail20;
								}
							term21:
								// Production
								if(!parse_expression()){
									goto fail20;
								}
								addASTChild(__astNode,"expression",getASTResult());
							term22:
								// Optional
									// Iterator
									size_t counter26 = 0;
									start23:
										// (terminator)
										if(!hasMore()){
											goto end24;
										}
										// (expression)
										expr25:
											// AndGroup
												auto position29 = getPos();
													// Terminal
													if(!match(",")){
														goto fail30;
													}
												term31:
													// Production
													if(parse_expression()){
														addASTChild(__astNode,"expression",getASTResult());
														goto increment27;
													}
												fail30:
												setPos(position29);
												goto end24;
										increment27:
										// (increment expr count)
											counter26 ++;
										goto start23;
									end24:
										// (range test)
											if(((counter26 >= 1))){
												// Optional
													// Terminal
													if(match(",")){
														goto pass0;
													}
													goto pass0;
											}
									goto pass0;
							fail20:
							setPos(position19);
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_print_stmt failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	return_stmt
		::= "return" [expression_list];
	*/
	bool parse_return_stmt(){
		debug Stdout("parse_return_stmt").newline;
		auto __astNode = createASTNode("return_stmt");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("return")){
					goto fail4;
				}
			term5:
				// Optional
					// Production
					if(parse_expression_list()){
						addASTChild(__astNode,"expression_list",getASTResult());
						goto pass0;
					}
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_return_stmt failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	yield_stmt ::= yield_expression;
	*/
	alias parse_yield_expression parse_yield_stmt;

	/*
	raise_stmt
		::= "raise" [expression ["," expression ["," expression]]];
	*/
	bool parse_raise_stmt(){
		debug Stdout("parse_raise_stmt").newline;
		auto __astNode = createASTNode("raise_stmt");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("raise")){
					goto fail4;
				}
			term5:
				// Optional
					// AndGroup
						auto position7 = getPos();
							// Production
							if(!parse_expression()){
								goto fail8;
							}
							addASTChild(__astNode,"expression",getASTResult());
						term9:
							// Optional
								// AndGroup
									auto position11 = getPos();
										// Terminal
										if(!match(",")){
											goto fail12;
										}
									term13:
										// Production
										if(!parse_expression()){
											goto fail12;
										}
										addASTChild(__astNode,"expression",getASTResult());
									term14:
										// Optional
											// AndGroup
												auto position16 = getPos();
													// Terminal
													if(!match(",")){
														goto fail17;
													}
												term18:
													// Production
													if(parse_expression()){
														addASTChild(__astNode,"expression",getASTResult());
														goto pass0;
													}
												fail17:
												setPos(position16);
											goto pass0;
									fail12:
									setPos(position11);
								goto pass0;
						fail8:
						setPos(position7);
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_raise_stmt failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	break_stmt
		::= "break";
	*/
	bool parse_break_stmt(){
		debug Stdout("parse_break_stmt").newline;
		auto __astNode = createASTNode("break_stmt");
		// Terminal
		if(!match("break")){
			goto fail1;
		}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_break_stmt failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	continue_stmt
		::= "continue";
	*/
	bool parse_continue_stmt(){
		debug Stdout("parse_continue_stmt").newline;
		auto __astNode = createASTNode("continue_stmt");
		// Terminal
		if(!match("continue")){
			goto fail1;
		}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_continue_stmt failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	import_stmt
		::= "import" module ["as" name] ("," module ["as" name])* | "from" relative_module "import" identifier ["as" name] ("," identifier ["as" name])* | "from" relative_module "import" "(" identifier ["as" name] ("," identifier ["as" name])* [","] ")" | "from" module "import" "*";
	*/
	bool parse_import_stmt(){
		debug Stdout("parse_import_stmt").newline;
		auto __astNode = createASTNode("import_stmt");
		// OrGroup pass0
			// AndGroup
				auto position4 = getPos();
					// Terminal
					if(!match("import")){
						goto fail5;
					}
				term6:
					// Production
					if(!parse_module()){
						goto fail5;
					}
					addASTChild(__astNode,"module",getASTResult());
				term7:
					// Optional
						// AndGroup
							auto position10 = getPos();
								// Terminal
								if(!match("as")){
									goto fail11;
								}
							term12:
								// Production
								if(parse_name()){
									addASTChild(__astNode,"name",getASTResult());
									goto term8;
								}
							fail11:
							setPos(position10);
							goto term8;
				term8:
					// Iterator
					start13:
						// (terminator)
						if(!hasMore()){
							goto end14;
						}
						// (expression)
						expr15:
							// AndGroup
								auto position17 = getPos();
									// Terminal
									if(!match(",")){
										goto fail18;
									}
								term19:
									// Production
									if(!parse_module()){
										goto fail18;
									}
									addASTChild(__astNode,"module",getASTResult());
								term20:
									// Optional
										// AndGroup
											auto position22 = getPos();
												// Terminal
												if(!match("as")){
													goto fail23;
												}
											term24:
												// Production
												if(parse_name()){
													addASTChild(__astNode,"name",getASTResult());
													goto start13;
												}
											fail23:
											setPos(position22);
										goto start13;
								fail18:
								setPos(position17);
								goto end14;
						goto start13;
					end14:
						goto pass0;
				fail5:
				setPos(position4);
		term2:
			// AndGroup
				auto position27 = getPos();
					// Terminal
					if(!match("from")){
						goto fail28;
					}
				term29:
					// Production
					if(!parse_relative_module()){
						goto fail28;
					}
					addASTChild(__astNode,"relative_module",getASTResult());
				term30:
					// Terminal
					if(!match("import")){
						goto fail28;
					}
				term31:
					// Production
					if(!parse_identifier()){
						goto fail28;
					}
					addASTChild(__astNode,"identifier",getASTResult());
				term32:
					// Optional
						// AndGroup
							auto position35 = getPos();
								// Terminal
								if(!match("as")){
									goto fail36;
								}
							term37:
								// Production
								if(parse_name()){
									addASTChild(__astNode,"name",getASTResult());
									goto term33;
								}
							fail36:
							setPos(position35);
							goto term33;
				term33:
					// Iterator
					start38:
						// (terminator)
						if(!hasMore()){
							goto end39;
						}
						// (expression)
						expr40:
							// AndGroup
								auto position42 = getPos();
									// Terminal
									if(!match(",")){
										goto fail43;
									}
								term44:
									// Production
									if(!parse_identifier()){
										goto fail43;
									}
									addASTChild(__astNode,"identifier",getASTResult());
								term45:
									// Optional
										// AndGroup
											auto position47 = getPos();
												// Terminal
												if(!match("as")){
													goto fail48;
												}
											term49:
												// Production
												if(parse_name()){
													addASTChild(__astNode,"name",getASTResult());
													goto start38;
												}
											fail48:
											setPos(position47);
										goto start38;
								fail43:
								setPos(position42);
								goto end39;
						goto start38;
					end39:
						goto pass0;
				fail28:
				setPos(position27);
		term25:
			// AndGroup
				auto position52 = getPos();
					// Terminal
					if(!match("from")){
						goto fail53;
					}
				term54:
					// Production
					if(!parse_relative_module()){
						goto fail53;
					}
					addASTChild(__astNode,"relative_module",getASTResult());
				term55:
					// Terminal
					if(!match("import")){
						goto fail53;
					}
				term56:
					// Terminal
					if(!match("(")){
						goto fail53;
					}
				term57:
					// Production
					if(!parse_identifier()){
						goto fail53;
					}
					addASTChild(__astNode,"identifier",getASTResult());
				term58:
					// Optional
						// AndGroup
							auto position61 = getPos();
								// Terminal
								if(!match("as")){
									goto fail62;
								}
							term63:
								// Production
								if(parse_name()){
									addASTChild(__astNode,"name",getASTResult());
									goto term59;
								}
							fail62:
							setPos(position61);
							goto term59;
				term59:
					// Iterator
					start65:
						// (terminator)
						if(!hasMore()){
							goto end66;
						}
						// (expression)
						expr67:
							// AndGroup
								auto position69 = getPos();
									// Terminal
									if(!match(",")){
										goto fail70;
									}
								term71:
									// Production
									if(!parse_identifier()){
										goto fail70;
									}
									addASTChild(__astNode,"identifier",getASTResult());
								term72:
									// Optional
										// AndGroup
											auto position74 = getPos();
												// Terminal
												if(!match("as")){
													goto fail75;
												}
											term76:
												// Production
												if(parse_name()){
													addASTChild(__astNode,"name",getASTResult());
													goto start65;
												}
											fail75:
											setPos(position74);
										goto start65;
								fail70:
								setPos(position69);
								goto end66;
						goto start65;
					end66:
						// Optional
							// Terminal
							if(!match(",")){
								goto term64;
							}
				term64:
					// Terminal
					if(match(")")){
						goto pass0;
					}
				fail53:
				setPos(position52);
		term50:
			// AndGroup
				auto position78 = getPos();
					// Terminal
					if(!match("from")){
						goto fail79;
					}
				term80:
					// Production
					if(!parse_module()){
						goto fail79;
					}
					addASTChild(__astNode,"module",getASTResult());
				term81:
					// Terminal
					if(!match("import")){
						goto fail79;
					}
				term82:
					// Terminal
					if(match("*")){
						goto pass0;
					}
				fail79:
				setPos(position78);
				goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_import_stmt failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	module
		::= (identifier ".")* identifier;
	*/
	bool parse_module(){
		debug Stdout("parse_module").newline;
		auto __astNode = createASTNode("module");
		// Iterator
		start2:
			// (terminator)
				// Production
				if(parse_identifier()){
					addASTChild(__astNode,"identifier",getASTResult());
					goto end3;
				}
			// (expression)
			expr4:
				// AndGroup
					auto position6 = getPos();
						// Production
						if(!parse_identifier()){
							goto fail7;
						}
						addASTChild(__astNode,"identifier",getASTResult());
					term8:
						// Terminal
						if(match(".")){
							goto start2;
						}
					fail7:
					setPos(position6);
					goto fail1;
			goto start2;
		end3:
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_module failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	relative_module
		::= "."* module | "."+;
	*/
	bool parse_relative_module(){
		debug Stdout("parse_relative_module").newline;
		auto __astNode = createASTNode("relative_module");
		// OrGroup pass0
			// Iterator
			start3:
				// (terminator)
					// Production
					if(parse_module()){
						addASTChild(__astNode,"module",getASTResult());
						goto end4;
					}
				// (expression)
				expr5:
					// Terminal
					if(!match(".")){
						goto term2;
					}
				goto start3;
			end4:
				goto pass0;
		term2:
			// Iterator
			size_t counter9 = 0;
			start6:
				// (terminator)
				if(!hasMore()){
					goto end7;
				}
				// (expression)
				expr8:
					// Terminal
					if(!match(".")){
						goto end7;
					}
				increment10:
				// (increment expr count)
					counter9 ++;
				goto start6;
			end7:
				// (range test)
					if(!((counter9 >= 1))){
						goto fail1;
						goto pass0;
					}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_relative_module failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	name ::= identifier;
	*/
	alias parse_identifier parse_name;

	/*
	global_stmt
		::= "global" identifier ("," identifier)*;
	*/
	bool parse_global_stmt(){
		debug Stdout("parse_global_stmt").newline;
		auto __astNode = createASTNode("global_stmt");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("global")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_identifier()){
					goto fail4;
				}
				addASTChild(__astNode,"identifier",getASTResult());
			term6:
				// Iterator
				start7:
					// (terminator)
					if(!hasMore()){
						goto end8;
					}
					// (expression)
					expr9:
						// AndGroup
							auto position11 = getPos();
								// Terminal
								if(!match(",")){
									goto fail12;
								}
							term13:
								// Production
								if(parse_identifier()){
									addASTChild(__astNode,"identifier",getASTResult());
									goto start7;
								}
							fail12:
							setPos(position11);
							goto end8;
					goto start7;
				end8:
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_global_stmt failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	exec_stmt
		::= "exec" or_expr ["in" expression ["," expression]];
	*/
	bool parse_exec_stmt(){
		debug Stdout("parse_exec_stmt").newline;
		auto __astNode = createASTNode("exec_stmt");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("exec")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_or_expr()){
					goto fail4;
				}
				addASTChild(__astNode,"or_expr",getASTResult());
			term6:
				// Optional
					// AndGroup
						auto position8 = getPos();
							// Terminal
							if(!match("in")){
								goto fail9;
							}
						term10:
							// Production
							if(!parse_expression()){
								goto fail9;
							}
							addASTChild(__astNode,"expression",getASTResult());
						term11:
							// Optional
								// AndGroup
									auto position13 = getPos();
										// Terminal
										if(!match(",")){
											goto fail14;
										}
									term15:
										// Production
										if(parse_expression()){
											addASTChild(__astNode,"expression",getASTResult());
											goto pass0;
										}
									fail14:
									setPos(position13);
								goto pass0;
						fail9:
						setPos(position8);
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_exec_stmt failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	compound_stmt
		::= if_stmt | while_stmt | for_stmt | try_stmt | with_stmt | funcdef | classdef;
	*/
	bool parse_compound_stmt(){
		debug Stdout("parse_compound_stmt").newline;
		auto __astNode = createASTNode("compound_stmt");
		// OrGroup pass0
			// Production
			if(parse_if_stmt()){
				addASTChild(__astNode,"if_stmt",getASTResult());
				goto pass0;
			}
		term2:
			// Production
			if(parse_while_stmt()){
				addASTChild(__astNode,"while_stmt",getASTResult());
				goto pass0;
			}
		term3:
			// Production
			if(parse_for_stmt()){
				addASTChild(__astNode,"for_stmt",getASTResult());
				goto pass0;
			}
		term4:
			// Production
			if(parse_try_stmt()){
				addASTChild(__astNode,"try_stmt",getASTResult());
				goto pass0;
			}
		term5:
			// Production
			if(parse_with_stmt()){
				addASTChild(__astNode,"with_stmt",getASTResult());
				goto pass0;
			}
		term6:
			// Production
			if(parse_funcdef()){
				addASTChild(__astNode,"funcdef",getASTResult());
				goto pass0;
			}
		term7:
			// Production
			if(!parse_classdef()){
				goto fail1;
			}
			addASTChild(__astNode,"classdef",getASTResult());
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_compound_stmt failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	suite
		::= stmt_list NEWLINE | NEWLINE INDENT statement+ DEDENT;
	*/
	bool parse_suite(){
		debug Stdout("parse_suite").newline;
		auto __astNode = createASTNode("suite");
		// OrGroup pass0
			// AndGroup
				auto position4 = getPos();
					// Production
					if(!parse_stmt_list()){
						goto fail5;
					}
					addASTChild(__astNode,"stmt_list",getASTResult());
				term6:
					// Production
					if(parse_NEWLINE()){
						addASTChild(__astNode,"NEWLINE",getASTResult());
						goto pass0;
					}
				fail5:
				setPos(position4);
		term2:
			// AndGroup
				auto position8 = getPos();
					// Production
					if(!parse_NEWLINE()){
						goto fail9;
					}
					addASTChild(__astNode,"NEWLINE",getASTResult());
				term10:
					// Production
					if(!parse_INDENT()){
						goto fail9;
					}
					addASTChild(__astNode,"INDENT",getASTResult());
				term11:
					// Iterator
					size_t counter15 = 0;
					start12:
						// (terminator)
							// Production
							if(parse_DEDENT()){
								addASTChild(__astNode,"DEDENT",getASTResult());
								goto end13;
							}
						// (expression)
						expr14:
							// Production
							if(!parse_statement()){
								goto fail9;
							}
							addASTChild(__astNode,"statement",getASTResult());
						increment16:
						// (increment expr count)
							counter15 ++;
						goto start12;
					end13:
						// (range test)
							if(((counter15 >= 1))){
								goto pass0;
							}
				fail9:
				setPos(position8);
				goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_suite failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	statement
		::= stmt_list NEWLINE | compound_stmt;
	*/
	bool parse_statement(){
		debug Stdout("parse_statement").newline;
		auto __astNode = createASTNode("statement");
		// OrGroup pass0
			// AndGroup
				auto position4 = getPos();
					// Production
					if(!parse_stmt_list()){
						goto fail5;
					}
					addASTChild(__astNode,"stmt_list",getASTResult());
				term6:
					// Production
					if(parse_NEWLINE()){
						addASTChild(__astNode,"NEWLINE",getASTResult());
						goto pass0;
					}
				fail5:
				setPos(position4);
		term2:
			// Production
			if(!parse_compound_stmt()){
				goto fail1;
			}
			addASTChild(__astNode,"compound_stmt",getASTResult());
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_statement failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	stmt_list
		::= simple_stmt (";" simple_stmt)* [";"];
	*/
	bool parse_stmt_list(){
		debug Stdout("parse_stmt_list").newline;
		auto __astNode = createASTNode("stmt_list");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_simple_stmt()){
					goto fail4;
				}
				addASTChild(__astNode,"simple_stmt",getASTResult());
			term5:
				// Iterator
				start6:
					// (terminator)
					if(!hasMore()){
						goto end7;
					}
					// (expression)
					expr8:
						// AndGroup
							auto position10 = getPos();
								// Terminal
								if(!match(";")){
									goto fail11;
								}
							term12:
								// Production
								if(parse_simple_stmt()){
									addASTChild(__astNode,"simple_stmt",getASTResult());
									goto start6;
								}
							fail11:
							setPos(position10);
							goto end7;
					goto start6;
				end7:
					// Optional
						// Terminal
						if(match(";")){
							goto pass0;
						}
						goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_stmt_list failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	if_stmt
		::= "if" expression ":" suite ("elif" expression ":" suite)* ["else" ":" suite];
	*/
	bool parse_if_stmt(){
		debug Stdout("parse_if_stmt").newline;
		auto __astNode = createASTNode("if_stmt");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("if")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_expression()){
					goto fail4;
				}
				addASTChild(__astNode,"expression",getASTResult());
			term6:
				// Terminal
				if(!match(":")){
					goto fail4;
				}
			term7:
				// Production
				if(!parse_suite()){
					goto fail4;
				}
				addASTChild(__astNode,"suite",getASTResult());
			term8:
				// Iterator
				start9:
					// (terminator)
					if(!hasMore()){
						goto end10;
					}
					// (expression)
					expr11:
						// AndGroup
							auto position13 = getPos();
								// Terminal
								if(!match("elif")){
									goto fail14;
								}
							term15:
								// Production
								if(!parse_expression()){
									goto fail14;
								}
								addASTChild(__astNode,"expression",getASTResult());
							term16:
								// Terminal
								if(!match(":")){
									goto fail14;
								}
							term17:
								// Production
								if(parse_suite()){
									addASTChild(__astNode,"suite",getASTResult());
									goto start9;
								}
							fail14:
							setPos(position13);
							goto end10;
					goto start9;
				end10:
					// Optional
						// AndGroup
							auto position19 = getPos();
								// Terminal
								if(!match("else")){
									goto fail20;
								}
							term21:
								// Terminal
								if(!match(":")){
									goto fail20;
								}
							term22:
								// Production
								if(parse_suite()){
									addASTChild(__astNode,"suite",getASTResult());
									goto pass0;
								}
							fail20:
							setPos(position19);
						goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_if_stmt failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	while_stmt
		::= "while" expression ":" suite ["else" ":" suite];
	*/
	bool parse_while_stmt(){
		debug Stdout("parse_while_stmt").newline;
		auto __astNode = createASTNode("while_stmt");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("while")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_expression()){
					goto fail4;
				}
				addASTChild(__astNode,"expression",getASTResult());
			term6:
				// Terminal
				if(!match(":")){
					goto fail4;
				}
			term7:
				// Production
				if(!parse_suite()){
					goto fail4;
				}
				addASTChild(__astNode,"suite",getASTResult());
			term8:
				// Optional
					// AndGroup
						auto position10 = getPos();
							// Terminal
							if(!match("else")){
								goto fail11;
							}
						term12:
							// Terminal
							if(!match(":")){
								goto fail11;
							}
						term13:
							// Production
							if(parse_suite()){
								addASTChild(__astNode,"suite",getASTResult());
								goto pass0;
							}
						fail11:
						setPos(position10);
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_while_stmt failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	for_stmt
		::= "for" target_list "in" expression_list ":" suite ["else" ":" suite];
	*/
	bool parse_for_stmt(){
		debug Stdout("parse_for_stmt").newline;
		auto __astNode = createASTNode("for_stmt");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("for")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_target_list()){
					goto fail4;
				}
				addASTChild(__astNode,"target_list",getASTResult());
			term6:
				// Terminal
				if(!match("in")){
					goto fail4;
				}
			term7:
				// Production
				if(!parse_expression_list()){
					goto fail4;
				}
				addASTChild(__astNode,"expression_list",getASTResult());
			term8:
				// Terminal
				if(!match(":")){
					goto fail4;
				}
			term9:
				// Production
				if(!parse_suite()){
					goto fail4;
				}
				addASTChild(__astNode,"suite",getASTResult());
			term10:
				// Optional
					// AndGroup
						auto position12 = getPos();
							// Terminal
							if(!match("else")){
								goto fail13;
							}
						term14:
							// Terminal
							if(!match(":")){
								goto fail13;
							}
						term15:
							// Production
							if(parse_suite()){
								addASTChild(__astNode,"suite",getASTResult());
								goto pass0;
							}
						fail13:
						setPos(position12);
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_for_stmt failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	try_stmt
		::= try1_stmt | try2_stmt;
	*/
	bool parse_try_stmt(){
		debug Stdout("parse_try_stmt").newline;
		auto __astNode = createASTNode("try_stmt");
		// OrGroup pass0
			// Production
			if(parse_try1_stmt()){
				addASTChild(__astNode,"try1_stmt",getASTResult());
				goto pass0;
			}
		term2:
			// Production
			if(!parse_try2_stmt()){
				goto fail1;
			}
			addASTChild(__astNode,"try2_stmt",getASTResult());
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_try_stmt failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	try1_stmt
		::= "try" ":" suite ("except" [expression ["," target]] ":" suite)+ ["else" ":" suite] ["finally" ":" suite];
	*/
	bool parse_try1_stmt(){
		debug Stdout("parse_try1_stmt").newline;
		auto __astNode = createASTNode("try1_stmt");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("try")){
					goto fail4;
				}
			term5:
				// Terminal
				if(!match(":")){
					goto fail4;
				}
			term6:
				// Production
				if(!parse_suite()){
					goto fail4;
				}
				addASTChild(__astNode,"suite",getASTResult());
			term7:
				// Iterator
				size_t counter12 = 0;
				start9:
					// (terminator)
					if(!hasMore()){
						goto end10;
					}
					// (expression)
					expr11:
						// AndGroup
							auto position15 = getPos();
								// Terminal
								if(!match("except")){
									goto fail16;
								}
							term17:
								// Optional
									// AndGroup
										auto position20 = getPos();
											// Production
											if(!parse_expression()){
												goto fail21;
											}
											addASTChild(__astNode,"expression",getASTResult());
										term22:
											// Optional
												// AndGroup
													auto position24 = getPos();
														// Terminal
														if(!match(",")){
															goto fail25;
														}
													term26:
														// Production
														if(parse_target()){
															addASTChild(__astNode,"target",getASTResult());
															goto term18;
														}
													fail25:
													setPos(position24);
												goto term18;
										fail21:
										setPos(position20);
										goto term18;
							term18:
								// Terminal
								if(!match(":")){
									goto fail16;
								}
							term27:
								// Production
								if(parse_suite()){
									addASTChild(__astNode,"suite",getASTResult());
									goto increment13;
								}
							fail16:
							setPos(position15);
							goto end10;
					increment13:
					// (increment expr count)
						counter12 ++;
					goto start9;
				end10:
					// (range test)
						if(!((counter12 >= 1))){
							goto fail4;
							// Optional
								// AndGroup
									auto position29 = getPos();
										// Terminal
										if(!match("else")){
											goto fail30;
										}
									term31:
										// Terminal
										if(!match(":")){
											goto fail30;
										}
									term32:
										// Production
										if(parse_suite()){
											addASTChild(__astNode,"suite",getASTResult());
											goto term8;
										}
									fail30:
									setPos(position29);
									goto term8;
						}
			term8:
				// Optional
					// AndGroup
						auto position34 = getPos();
							// Terminal
							if(!match("finally")){
								goto fail35;
							}
						term36:
							// Terminal
							if(!match(":")){
								goto fail35;
							}
						term37:
							// Production
							if(parse_suite()){
								addASTChild(__astNode,"suite",getASTResult());
								goto pass0;
							}
						fail35:
						setPos(position34);
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_try1_stmt failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	try2_stmt
		::= "try" ":" suite "finally" ":" suite;
	*/
	bool parse_try2_stmt(){
		debug Stdout("parse_try2_stmt").newline;
		auto __astNode = createASTNode("try2_stmt");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("try")){
					goto fail4;
				}
			term5:
				// Terminal
				if(!match(":")){
					goto fail4;
				}
			term6:
				// Production
				if(!parse_suite()){
					goto fail4;
				}
				addASTChild(__astNode,"suite",getASTResult());
			term7:
				// Terminal
				if(!match("finally")){
					goto fail4;
				}
			term8:
				// Terminal
				if(!match(":")){
					goto fail4;
				}
			term9:
				// Production
				if(parse_suite()){
					addASTChild(__astNode,"suite",getASTResult());
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_try2_stmt failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	with_stmt
		::= "with" expression ["as" target] ":" suite;
	*/
	bool parse_with_stmt(){
		debug Stdout("parse_with_stmt").newline;
		auto __astNode = createASTNode("with_stmt");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("with")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_expression()){
					goto fail4;
				}
				addASTChild(__astNode,"expression",getASTResult());
			term6:
				// Optional
					// AndGroup
						auto position9 = getPos();
							// Terminal
							if(!match("as")){
								goto fail10;
							}
						term11:
							// Production
							if(parse_target()){
								addASTChild(__astNode,"target",getASTResult());
								goto term7;
							}
						fail10:
						setPos(position9);
						goto term7;
			term7:
				// Terminal
				if(!match(":")){
					goto fail4;
				}
			term12:
				// Production
				if(parse_suite()){
					addASTChild(__astNode,"suite",getASTResult());
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_with_stmt failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	funcdef
		::= [decorators] "def" funcname "(" [parameter_list] ")" ":" suite;
	*/
	bool parse_funcdef(){
		debug Stdout("parse_funcdef").newline;
		auto __astNode = createASTNode("funcdef");
		// AndGroup
			auto position3 = getPos();
				// Optional
					// Production
					if(!parse_decorators()){
						goto term5;
					}
					addASTChild(__astNode,"decorators",getASTResult());
			term5:
				// Terminal
				if(!match("def")){
					goto fail4;
				}
			term6:
				// Production
				if(!parse_funcname()){
					goto fail4;
				}
				addASTChild(__astNode,"funcname",getASTResult());
			term7:
				// Terminal
				if(!match("(")){
					goto fail4;
				}
			term8:
				// Optional
					// Production
					if(!parse_parameter_list()){
						goto term9;
					}
					addASTChild(__astNode,"parameter_list",getASTResult());
			term9:
				// Terminal
				if(!match(")")){
					goto fail4;
				}
			term10:
				// Terminal
				if(!match(":")){
					goto fail4;
				}
			term11:
				// Production
				if(parse_suite()){
					addASTChild(__astNode,"suite",getASTResult());
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_funcdef failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	decorators
		::= decorator+;
	*/
	bool parse_decorators(){
		debug Stdout("parse_decorators").newline;
		auto __astNode = createASTNode("decorators");
		// Iterator
		size_t counter5 = 0;
		start2:
			// (terminator)
			if(!hasMore()){
				goto end3;
			}
			// (expression)
			expr4:
				// Production
				if(!parse_decorator()){
					goto end3;
				}
				addASTChild(__astNode,"decorator",getASTResult());
			increment6:
			// (increment expr count)
				counter5 ++;
			goto start2;
		end3:
			// (range test)
				if(!((counter5 >= 1))){
					goto fail1;
					goto pass0;
				}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_decorators failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	decorator
		::= "@" dotted_name ["(" [argument_list [","]] ")"] NEWLINE;
	*/
	bool parse_decorator(){
		debug Stdout("parse_decorator").newline;
		auto __astNode = createASTNode("decorator");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("@")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_dotted_name()){
					goto fail4;
				}
				addASTChild(__astNode,"dotted_name",getASTResult());
			term6:
				// Optional
					// AndGroup
						auto position9 = getPos();
							// Terminal
							if(!match("(")){
								goto fail10;
							}
						term11:
							// Optional
								// AndGroup
									auto position14 = getPos();
										// Production
										if(!parse_argument_list()){
											goto fail15;
										}
										addASTChild(__astNode,"argument_list",getASTResult());
									term16:
										// Optional
											// Terminal
											if(match(",")){
												goto term12;
											}
											goto term12;
									fail15:
									setPos(position14);
									goto term12;
						term12:
							// Terminal
							if(match(")")){
								goto term7;
							}
						fail10:
						setPos(position9);
						goto term7;
			term7:
				// Production
				if(parse_NEWLINE()){
					addASTChild(__astNode,"NEWLINE",getASTResult());
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_decorator failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	dotted_name
		::= identifier ("." identifier)*;
	*/
	bool parse_dotted_name(){
		debug Stdout("parse_dotted_name").newline;
		auto __astNode = createASTNode("dotted_name");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_identifier()){
					goto fail4;
				}
				addASTChild(__astNode,"identifier",getASTResult());
			term5:
				// Iterator
				start6:
					// (terminator)
					if(!hasMore()){
						goto end7;
					}
					// (expression)
					expr8:
						// AndGroup
							auto position10 = getPos();
								// Terminal
								if(!match(".")){
									goto fail11;
								}
							term12:
								// Production
								if(parse_identifier()){
									addASTChild(__astNode,"identifier",getASTResult());
									goto start6;
								}
							fail11:
							setPos(position10);
							goto end7;
					goto start6;
				end7:
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_dotted_name failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	parameter_list
		::= defparameter ("," defparameter)* ["," "*" identifier] ["," ("**") identifier] [","];
	*/
	bool parse_parameter_list(){
		debug Stdout("parse_parameter_list").newline;
		auto __astNode = createASTNode("parameter_list");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_defparameter()){
					goto fail4;
				}
				addASTChild(__astNode,"defparameter",getASTResult());
			term5:
				// Iterator
				start7:
					// (terminator)
					if(!hasMore()){
						goto end8;
					}
					// (expression)
					expr9:
						// AndGroup
							auto position11 = getPos();
								// Terminal
								if(!match(",")){
									goto fail12;
								}
							term13:
								// Production
								if(parse_defparameter()){
									addASTChild(__astNode,"defparameter",getASTResult());
									goto start7;
								}
							fail12:
							setPos(position11);
							goto end8;
					goto start7;
				end8:
					// Optional
						// AndGroup
							auto position15 = getPos();
								// Terminal
								if(!match(",")){
									goto fail16;
								}
							term17:
								// Terminal
								if(!match("*")){
									goto fail16;
								}
							term18:
								// Production
								if(parse_identifier()){
									addASTChild(__astNode,"identifier",getASTResult());
									goto term6;
								}
							fail16:
							setPos(position15);
							goto term6;
			term6:
				// Optional
					// AndGroup
						auto position21 = getPos();
							// Terminal
							if(!match(",")){
								goto fail22;
							}
						term23:
							// Terminal
							if(!match("**")){
								goto fail22;
							}
						term24:
							// Production
							if(parse_identifier()){
								addASTChild(__astNode,"identifier",getASTResult());
								goto term19;
							}
						fail22:
						setPos(position21);
						goto term19;
			term19:
				// Optional
					// Terminal
					if(match(",")){
						goto pass0;
					}
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_parameter_list failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	defparameter
		::= parameter ["=" expression];
	*/
	bool parse_defparameter(){
		debug Stdout("parse_defparameter").newline;
		auto __astNode = createASTNode("defparameter");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_parameter()){
					goto fail4;
				}
				addASTChild(__astNode,"parameter",getASTResult());
			term5:
				// Optional
					// AndGroup
						auto position7 = getPos();
							// Terminal
							if(!match("=")){
								goto fail8;
							}
						term9:
							// Production
							if(parse_expression()){
								addASTChild(__astNode,"expression",getASTResult());
								goto pass0;
							}
						fail8:
						setPos(position7);
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_defparameter failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	sublist
		::= parameter ("," parameter)* [","];
	*/
	bool parse_sublist(){
		debug Stdout("parse_sublist").newline;
		auto __astNode = createASTNode("sublist");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_parameter()){
					goto fail4;
				}
				addASTChild(__astNode,"parameter",getASTResult());
			term5:
				// Iterator
				start6:
					// (terminator)
					if(!hasMore()){
						goto end7;
					}
					// (expression)
					expr8:
						// AndGroup
							auto position10 = getPos();
								// Terminal
								if(!match(",")){
									goto fail11;
								}
							term12:
								// Production
								if(parse_parameter()){
									addASTChild(__astNode,"parameter",getASTResult());
									goto start6;
								}
							fail11:
							setPos(position10);
							goto end7;
					goto start6;
				end7:
					// Optional
						// Terminal
						if(match(",")){
							goto pass0;
						}
						goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_sublist failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	parameter
		::= identifier | "(" sublist ")";
	*/
	bool parse_parameter(){
		debug Stdout("parse_parameter").newline;
		auto __astNode = createASTNode("parameter");
		// OrGroup pass0
			// Production
			if(parse_identifier()){
				addASTChild(__astNode,"identifier",getASTResult());
				goto pass0;
			}
		term2:
			// AndGroup
				auto position4 = getPos();
					// Terminal
					if(!match("(")){
						goto fail5;
					}
				term6:
					// Production
					if(!parse_sublist()){
						goto fail5;
					}
					addASTChild(__astNode,"sublist",getASTResult());
				term7:
					// Terminal
					if(match(")")){
						goto pass0;
					}
				fail5:
				setPos(position4);
				goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_parameter failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	funcname ::= identifier;
	*/
	alias parse_identifier parse_funcname;

	/*
	classdef
		::= "class" classname [inheritance] ":" suite;
	*/
	bool parse_classdef(){
		debug Stdout("parse_classdef").newline;
		auto __astNode = createASTNode("classdef");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("class")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_classname()){
					goto fail4;
				}
				addASTChild(__astNode,"classname",getASTResult());
			term6:
				// Optional
					// Production
					if(!parse_inheritance()){
						goto term7;
					}
					addASTChild(__astNode,"inheritance",getASTResult());
			term7:
				// Terminal
				if(!match(":")){
					goto fail4;
				}
			term8:
				// Production
				if(parse_suite()){
					addASTChild(__astNode,"suite",getASTResult());
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_classdef failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	inheritance
		::= "(" [expression_list] ")";
	*/
	bool parse_inheritance(){
		debug Stdout("parse_inheritance").newline;
		auto __astNode = createASTNode("inheritance");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("(")){
					goto fail4;
				}
			term5:
				// Optional
					// Production
					if(!parse_expression_list()){
						goto term6;
					}
					addASTChild(__astNode,"expression_list",getASTResult());
			term6:
				// Terminal
				if(match(")")){
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_inheritance failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	classname ::= identifier;
	*/
	alias parse_identifier parse_classname;

	/*
	file_input
		::= (NEWLINE | statement)*;
	*/
	bool parse_file_input(){
		debug Stdout("parse_file_input").newline;
		auto __astNode = createASTNode("file_input");
		// Iterator
		start2:
			// (terminator)
			if(!hasMore()){
				goto end3;
			}
			// (expression)
			expr4:
				// OrGroup start2
					// Production
					if(parse_NEWLINE()){
						addASTChild(__astNode,"NEWLINE",getASTResult());
						goto start2;
					}
				term5:
					// Production
					if(!parse_statement()){
						goto end3;
					}
					addASTChild(__astNode,"statement",getASTResult());
			goto start2;
		end3:
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_file_input failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	interactive_input
		::= [stmt_list] NEWLINE | compound_stmt NEWLINE;
	*/
	bool parse_interactive_input(){
		debug Stdout("parse_interactive_input").newline;
		auto __astNode = createASTNode("interactive_input");
		// OrGroup pass0
			// AndGroup
				auto position4 = getPos();
					// Optional
						// Production
						if(!parse_stmt_list()){
							goto term6;
						}
						addASTChild(__astNode,"stmt_list",getASTResult());
				term6:
					// Production
					if(parse_NEWLINE()){
						addASTChild(__astNode,"NEWLINE",getASTResult());
						goto pass0;
					}
				fail5:
				setPos(position4);
		term2:
			// AndGroup
				auto position8 = getPos();
					// Production
					if(!parse_compound_stmt()){
						goto fail9;
					}
					addASTChild(__astNode,"compound_stmt",getASTResult());
				term10:
					// Production
					if(parse_NEWLINE()){
						addASTChild(__astNode,"NEWLINE",getASTResult());
						goto pass0;
					}
				fail9:
				setPos(position8);
				goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_interactive_input failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	eval_input
		::= expression_list NEWLINE*;
	*/
	bool parse_eval_input(){
		debug Stdout("parse_eval_input").newline;
		auto __astNode = createASTNode("eval_input");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_expression_list()){
					goto fail4;
				}
				addASTChild(__astNode,"expression_list",getASTResult());
			term5:
				// Iterator
				start6:
					// (terminator)
					if(!hasMore()){
						goto end7;
					}
					// (expression)
					expr8:
						// Production
						if(!parse_NEWLINE()){
							goto end7;
						}
						addASTChild(__astNode,"NEWLINE",getASTResult());
					goto start6;
				end7:
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_eval_input failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	input_input
		::= expression_list NEWLINE;
	*/
	bool parse_input_input(){
		debug Stdout("parse_input_input").newline;
		auto __astNode = createASTNode("input_input");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_expression_list()){
					goto fail4;
				}
				addASTChild(__astNode,"expression_list",getASTResult());
			term5:
				// Production
				if(parse_NEWLINE()){
					addASTChild(__astNode,"NEWLINE",getASTResult());
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_input_input failed").newline;
			clearASTResult(__astNode);
			return false;
	}
}
