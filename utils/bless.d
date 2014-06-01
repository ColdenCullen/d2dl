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
// DDL bless utility
module utils.bless;

private import ddl.all;
private import ddl.FileBuffer;
private import ddl.Attributes;
private import ddl.DDLException;
private import ddl.DDLReader;

private import ddl.ddl.DDLLoader;
private import ddl.ddl.DDLBinary;

private import tango.io.File;
private import tango.io.Stdout;
private import tango.io.FilePath;
private import tango.io.FileConduit;

private import tango.text.stream.LineIterator;

private import utils.bless_bn;
private import utils.ArgParser;

enum PathPart{
	Ext = 1,
	Name = 2,
	Path = 4,
	Root = 8,
	Suffix = 16
}

char[] filePathPart(FilePath path,PathPart parts){
	char[] result;
	
	if(parts | PathPart.Root) result ~= path.root;
	if(parts | PathPart.Path) result ~= path.path;
	if(parts | PathPart.Name) result ~= path.name;
	if(parts | PathPart.Suffix) result ~= path.suffix;
	if(parts | PathPart.Ext) result ~= path.ext;
	
	return result;	
}


char[] helpText = 
"Bless - DDL wrapper utility - V1.2 Build {0}
Copyright (C) 2005,2006 Eric Anderton
Documentation: http://www.dsource.org/projects/ddl

Creates a .ddl file that wraps the provided object file.
The new file name will adopt the name of the provided
object file with a 'ddl' extension by default.

Usage: 
  bless <object file> {{ -switch }

  -v       verbose output
  -x       (curse) extract object file from .ddl
  -n       no-create (for test purposes)
  -f<file> output to file 'file' (overrides default name)
  -a<attr> adds an attribute (name=value) to the ddl
  -p<file> uses the property file 'file' for attributes
  
";

int main(char[][] args){
	DefaultRegistry registry = new DefaultRegistry();
	
	if(args.length == 1){
		Stdout.format(helpText,auto_build_number).newline;
		Stdout.format("Supported Object Types:").newline;
		foreach(char[] ext; registry.getSupportedTypes){
			Stdout.format("{0} ",ext);	
		}
		Stdout.newline;
		return 0;
	}
		
	// get the filename

	// pick through the options (if any)
	bool verbose = false;
	bool extract = false;
	bool noCreate = false;
	char[] outputFileName = "";
	char[] filename = "";
	Attributes attributes;
	
	// configure the arg parser
	ArgParser parser = new ArgParser(delegate uint(char[] value,uint ordinal){
		if(ordinal > 0) throw new DDLException("Invalid argument {0}",value);
		filename = value;
		return value.length;
	});
	
	parser.bind("-", "v",delegate void(){
		verbose=true;
	});
	
	parser.bind("-", "n",delegate void(){
		noCreate=true;
	});	
	
	parser.bind("-", "x",delegate void(){
		extract=true;
	});	
		
	parser.bind("-", "f",delegate uint(char[] value){
		outputFileName=value;
		return value.length;
	});
	
	char[] trim(char[] token){
		uint start;
		uint end;
		for(start=0; start<token.length && token[start] <= 32; start++){} // leading whitespace
		for(end=token.length-1; end>=0 && token[end] <= 32; end--){} // trailing whitespace
		return token[start..end+1];
	}
	
	void parseAttribute(char[] line){
		if(line.length == 0 || line[0] == '#') return;
		uint split;
		for(split=0; split<line.length && line[split] != '='; split++){} // token
		if(split < line.length-1){
			attributes[trim(line[0..split])] = trim(line[split+1..$]);
		}
	}
	
	parser.bind("-", "a",delegate uint(char[] value){
		parseAttribute(value);
		return value.length;
	});
	
	parser.bind("-", "p",delegate uint(char[] value){
		auto path = new FilePath(value);
		if(path.exists){
			auto file = new FileConduit(path);
			auto iter = new LineIterator!(char)(file);
			while(iter.next){
				parseAttribute(iter.get);
			}
			return value.length;
		}
		else{
			throw new Exception("Cannot find properties file: '" ~ value ~ "'");
		}
	});
	
	// parse the arguments
	parser.parse(args[1..$]);
		
	if(filename == ""){
		throw new DDLException("No filename specified.");
	}
	
	// get the file
	FileBuffer file = FileBuffer(filename);
	char[] originalOutputFile = filePathPart(file.getPath,PathPart.Root | PathPart.Path | PathPart.Name | PathPart.Suffix);
	
	if(outputFileName == ""){
		outputFileName = originalOutputFile;
	}
	
	if(noCreate){
		Stdout.format("loaded attributes:").newline;
		foreach(char[] name,char[] value; attributes){
			Stdout.format("{0} = {1}",name,value).newline;
		}
	}
	
	// validate a few things
	/*
	if(!file.exists){
		Stdout.format("File '{0}' does not exist.",file.filename).newline;
		return 1;
	}
	*/
	
	// load it up!
	//NOTE: rather than just be satisfied with what loader likes this file
	// we load the entire file via its loader to ensure that it will work later.
	DynamicLibrary lib = registry.load(file.getPath.toString());
		
	if(!lib){
		Stdout.format("Cannot load '{0}'",file.getPath.toString()).newline;
		return 1;
	}
		
	// output
	if(verbose){
		Stdout.format("filename: '{0}'",file.getPath.toString()).newline;
		Stdout.format("type: '{0}'",lib.getType).newline;
	}	
		
	if(extract){
		if(lib.getType != DDLLoader.typeName){
			Stdout.format("cannot extract from a non-ddl file ('{0}').",file.getPath.toString()).newline;
			return 1;
		}
	}	
	else if(lib.getType == DDLLoader.typeName){
		Stdout.format("'{0}' already appears to be a ddl file.",file.getPath.toString()).newline;
		return 1;
	}
	
	if(extract){
		// coerce complete load of the ddl binary file
		DDLBinary binary = new DDLBinary();
		binary.load(FileBuffer(file.getPath));
		
		// save to output file
		if(outputFileName == originalOutputFile){
			DynamicLibraryLoader loader = registry.getLoader(binary.binaryType);
			if("std.filename" in binary.attributes){
				outputFileName = binary.attributes["std.filename"];
			}
			else{
				outputFileName = originalOutputFile ~ ".bin";
			}
		}
				
		if(verbose) Stdout.format("out file: '{0}'",outputFileName).newline;
		
		if(!noCreate){
			File destFile = new File(outputFileName);
			destFile.write(binary.getBinaryData);
			if(verbose) Stdout.format("Created '{0}'",outputFileName).newline;
		}
	}
	else{
		if(verbose) Stdout.format("out file: '{0}'",outputFileName).newline;

		// create the file and save it
		DDLBinary binary = new DDLBinary();
		DDLReader reader = new DDLReader(file);
		void[] data;

		// save the easy fields	
		binary.binaryType = lib.getType;
		binary.attributes = attributes;		
		
		reader.getAll(data);
		binary.binaryData = cast(ubyte[])data;
								
		if(!("std.filename" in attributes)){
			attributes["std.filename"] = file.getPath.name ~ "." ~ file.getPath.ext;
		}

		// get the defined namespaces and imported modules
		foreach(DynamicModule mod; lib.getModules()){
			DemangleType demangleType;
			char[] result;

			foreach(sym; mod.getSymbols){
				demangleType = getDemangleType(sym.name);
				if(demangleType == DemangleType.ModuleInfo){
					if(sym.type == SymbolType.Strong || SymbolType.Weak){					
						binary.definedNamespaces ~= sym.name;
						if(verbose) Stdout.format("module {0}",demangleSymbol(sym.name)).newline;
					}
					else{
						binary.importedModules ~= sym.name;
						if(verbose) Stdout.format("module {0}",demangleSymbol(sym.name)).newline;
					}
				}
			}
		}
				
		if(!noCreate){
			FileBuffer outputFile = FileBuffer(outputFileName,null);
			binary.save(outputFile);						
			outputFile.save();
			
			if(verbose) Stdout.format("Created '{0}'",outputFileName).newline;
		}
	}
	
	return 0;
}