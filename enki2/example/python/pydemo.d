module example.python.pydemo;

import example.python.PythonParser;
import tango.io.Stdout;
import tango.io.File;

alias char[] String;
alias PythonParserT!(char) PythonParser;
alias PythonParser.ASTNode ASTNode;

void main(char[][] args){
	if(args.length == 1 || args[1].length == 0){
		Stdout("Python Demo").newline;
		Stdout("use: pydemo <filename.py>").newline;
		return;
	}
	auto parser = new PythonParser();
	auto inFile = new File(args[1]);
	parser.initialize(cast(char[])inFile.read());
		
	if(!parser.parse_file_input()){
		Stdout("Unspecified parse failure.").newline;
		return;
	}
		
	void printAST(ASTNode node,String prefix = ""){
		if(node is null){
			Stdout(prefix)("<null>").newline;
			return;
		}
		Stdout(prefix)(node.name)(" '")(node.slice)("' ");
		Stdout.newline;
		
		auto newPrefix = prefix ~ "  ";
		foreach(child; node.children){
			printAST(child,newPrefix);
		}
	}
	Stdout("AST Tree:").newline;
	printAST(parser.getASTResult());
}
