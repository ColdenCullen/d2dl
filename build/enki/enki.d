#!/usr/bin/build -exec
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
module build.enki.sdk;

import utils.Script;
import build.enki.ver;

void main(){
	auto packageName = "../downloads/enki." ~ enkiBinVersion ~ ".zip";
	
	writefln("\n* Building Enki Bootstrap");
	
	utils.Script.build("-full -version=Bootstrap","enki/bootstrap.d");
	run("enki/bootstrap");
	
	writefln("\n* Building Enki");
	
	utils.Script.build("-full","enki/enki.d");
		
	writefln("\n* Packaging Binaries");
		
	char[][] fileListing; 
	fileListing ~= listdir("build/enki","*.d");
	fileListing ~= listdir("doc/enki","*.d");
	fileListing ~= listdir("enki/library","*.d");
	fileListing ~= listdir("enki/library","*.bnf");
	fileListing ~= exeFile("enki/enki");
	fileListing ~= "enki/BaseParser.d";
	fileListing ~= "enki/IParser.d";
	fileListing ~= "enki/types.d";
	
	removeFile(packageName);
	zip(packageName,fileListing);
	
	writefln("\n* Done");
}
