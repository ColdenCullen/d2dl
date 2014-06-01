module example.xml.xmldemo;

import example.xml.XMLParser;
import tango.io.Stdout;
import tango.io.File;

alias char[] String;
alias XMLParserT!(char) XMLParser;
alias XMLParser.ASTNode ASTNode;


void main(char[][] args){
	if(args.length == 1 || args[1].length == 0){
		Stdout("XML Demo").newline;
		Stdout("use: xmldemo <filename.xml>").newline;
		return;
	}
	auto parser = new XMLParser();
	auto inFile = new File(args[1]);
	parser.initialize(cast(char[])inFile.read());
		
	if(!parser.parse_document()){
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
