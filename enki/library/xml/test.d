/+
    Copyright (c) 2006 Eric Anderton

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
module xml.test;

private import enki.BaseParser;
private import xml.XMLParser;

private import std.stdio;
private import std.file;
private import std.utf;

void main(char[][] args){
	char[] inputFilename = args[1];
	
	char[] inputdata = cast(char[])std.file.read(inputFilename);
	
	writefln("%s",inputdata);
	
	//TODO: perform BOM detection
	dchar[] data = toUTF32(inputdata);
		
	writefln("parsing");
	auto parser = new XMLParser();
	parser.initalize(data);
	auto result = parser.parse_Document();
	
	if(result.success){
		writefln("success");
	}
	else{
		writefln("\nErrors:\n%s",parser.getErrorReport());	
	}
}