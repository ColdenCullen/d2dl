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
module utils.insitu;

// DDL insitu utility

private import ddl.all;
private import ddl.DDLException;
private import ddl.FileBuffer;
private import ddl.insitu.all;

private import utils.insitu_bn;
private import utils.ArgParser;

private import tango.io.Stdout;
private import tango.io.FileConduit;
private import Text = tango.text.Util;

char[] helpText = 
"InSitu - Optimized in situ module generator - V1.1 {0}
Copyright (C) 2005 Eric Anderton
Documentation: http://www.dsource.org/projects/ddl

Creates a .situ file that contains optmized .map file
data specifically for the DDL in situ module loader.

Usage: 
  insitu <map file>  {{ -switch }
  
  -f	Specify output file
  -c	Compression level for data (1-9 where 9 is default)
  
  When the output file is not specified, a file in the
  form of <filename>.situ will be used by instead. 
  
  Map files are expected to be the same format as provided
  by DMD.
";

int main(char[][] args){
	DefaultRegistry registry = new DefaultRegistry();
	
	if(args.length == 1 || args.length > 3){
		Stdout.format(helpText,auto_build_number).newline;
		Stdout.format("Supported Object Types:").newline;
		foreach(char[] ext; registry.getSupportedTypes){
			Stdout.format("{0} ",ext);
		}
		Stdout.newline;
		return 0;
	}
			
	// determine the output file
	char[] outputFilename = "";
	bool filenameOverride = false;
	char[] filename = "";
	
	ubyte compressionLevel = 9;
		
	// Configure the parser and parse the command line	
	ArgParser parser = new ArgParser(delegate uint(char[] value,uint ordinal){
		if(ordinal > 0) throw new DDLException("Invalid argument {0}",value);
		filename = value;
		return value.length;
	});	
	
	parser.bind("-", "f",delegate uint(char[] value){
		filenameOverride = true;
		outputFilename = value;
		return value.length;
	});
		
	parser.bind("-", "c",delegate uint(char[] value){
		char ch = value[0];
		if(ch < '1' || ch > '9'){
			throw new Exception("Unknown compression level '" ~ ch ~ "'");
		}
		compressionLevel = ch - '1';
		return 1;
	});
	
	parser.parse(args[1..$]);
	
	if(filename == ""){
		throw new DDLException("No filename specified.");
	}
	
	// get the file
	FileBuffer inputFile = FileBuffer(filename);		
		
	if(outputFilename == ""){
		outputFilename = inputFile.getPath.toString;		
	}	
	
	// load the .map file and get what we need
	InSituMapBinary inputBinary = new InSituMapBinary();
	inputBinary.load(inputFile);
	
	debug debugLog("{0} bytes loaded",inputFile.buffer.length);
	debug debugLog("{0} exports total",inputBinary.getAllSymbols().values.length);
	if(!filenameOverride){
		foreach_reverse(split,ch; outputFilename){
			if(ch == '.'){
				outputFilename = outputFilename[0..split] ~ ".situ";
				goto filenameOverrideDone;
			}
		}
		// just append by default
		outputFilename ~= ".situ";	
		filenameOverrideDone: {}
	}
	
	FileBuffer outputFile = FileBuffer(outputFilename,null);
			
	// commit the data to the lib-style binary
	InSituLibBinary outputBinary = new InSituLibBinary();
	outputBinary.setAllSymbols(inputBinary.getAllSymbols());
	outputBinary.save(outputFile,compressionLevel);
	
	outputFile.save();

	return 0;
}