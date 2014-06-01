/+
	Copyright (c) 2005-2007 Eric Anderton
	        
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
/// DDL info utility
module utils.ddlinfo;

private import utils.ddlinfo_bn;
private import utils.ArgParser;

private import ddl.all;
private import ddl.DDLException;
private import ddl.FileBuffer;

private import tango.io.Stdout;

char[] helpText = 
"DDL Info - DDL information utility - V1.2 Build {0}
Copyright (C) 2005-2006 Eric Anderton
Documentation: http://www.dsource.org/projects/ddl

Displays information about a ddl or object file.

Usage: 
  ddlinfo <object file> {{ -switch }
  
  -r       raw output instead of friendly names/symbols.
  -a       attributes only
  -s       symbols only
  -x	   x-ray - show *everything*
";

int main(char[][] args){
	DefaultRegistry regsitry = new DefaultRegistry();
	
	if(args.length == 1){
		Stdout.format(helpText,auto_build_number).newline;
		Stdout.format("Supported Object Types:").newline;
		foreach(char[] ext; regsitry.getSupportedTypes){
			Stdout.format("{0} ",ext);	
		}
		Stdout.newline;
		return 0;
	}
		
	// pick through the options (if any)
	bool rawOutput = false;
	bool displayAttribs = false;
	bool displaySymbols = false;
	bool xRay = false;
	char[] filename = "";
	
	// configure the arg parser
	ArgParser parser = new ArgParser(delegate uint(char[] value,uint ordinal){
		if(ordinal > 0) throw new DDLException("Invalid argument {0}",value);
		filename = value;
		return value.length;
	});
			
	parser.bind("-", "r",delegate void(){
		rawOutput=true;
	});
	
	parser.bind("-", "a",delegate void(){
		displayAttribs=true;
	});
	
	parser.bind("-", "s",delegate void(){
		displaySymbols=true;
	});
	
	parser.bind("-", "x",delegate void(){
		xRay=true;
	});
	
	// parse the arguments
	parser.parse(args[1..$]);

	if(!displaySymbols && !displayAttribs){
		displaySymbols = true;
		displayAttribs = true;
	}
	
	if(filename == ""){
		throw new DDLException("No filename specified.");
	}
	
	// get the file
	FileBuffer file = FileBuffer(filename);	

	//TODO: validate a few things
/*	if(!file.exists){
		Stdout.format("file '{0}' does not exist.",file.filename).newline;
		return 1;
	}
*/		
	// (attempt to) load the binary file
	DynamicLibrary lib = regsitry.load(file);
	
	
	if(!lib){
		Stdout.format("file '{0}' is not supported.",file.getPath.toString()).newline;
		return 1;
	}

	Stdout.format("filename: '{0}'",file.getPath.toString()).newline;
	Stdout.format("type: '{0}'",lib.getType).newline;
	
	if(xRay){
		Stdout.format("{0}",lib.toString()).newline;
	}
	else{
		if(displayAttribs){
			if(lib.getAttributes.length > 0){
				Stdout.format("attributes: ").newline;
				foreach(char[] name,char[] value; lib.getAttributes){
					Stdout.format("{0} - {1}",name,value).newline;
				}
			}
		}
		if(displaySymbols){
			Stdout.format("\nModules ({0}):",lib.getModules.length).newline;
			foreach(DynamicModule mod; lib.getModules()){
				Stdout.format("\n{0}",mod.getName()).newline;
				Stdout.format("\nSymbols ({0}):",mod.getSymbols.length).newline;
				
				foreach(symbol; mod.getSymbols){
					if(rawOutput){
						Stdout.format("{0} {1}",symbol.getTypeName,symbol.name).newline;
					}
					else{
						Stdout.format("{0} {1}",symbol.getTypeName,demangleSymbol(symbol.name)).newline;
					}				
				}
			}
		}
	}

	return 0;
}