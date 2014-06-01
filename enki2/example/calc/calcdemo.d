module example.calc.calcdemo;
import example.calc.CalcValidate;

import tango.io.Stdout;
import tango.io.Console;
import tango.text.Util: join;

void main(char[][] args){
	auto parser = new CalcValidate();
    
	if(args.length == 1 || args[1].length == 0){
		Stdout("Calculator Validation Demo").newline;
		Stdout("use: calcdemo <mathematical expression>").newline;
        Stdout.newline;
        Stdout(parser.getHelp()).newline;
		return;
	}
		
	char[] input = join(args[1..$]," ");	
	parser.initialize(input);
	if(parser.parse_Syntax()){
        Stdout("syntax valid");
    }
}