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
module build.enki.doc;

import utils.Script;

void main(){	
	build("-nolink doc/enki/xhtml.ddoc -Dd./doc/enki/html -full","enki/enki.d");   
	build("-nolink doc/enki/xhtml.ddoc -Dd./doc/enki/html -full","enki/bootstrap.d");    
	build("-nolink doc/enki/xhtml.ddoc -Dd./doc/enki/html -full","enki/EnkiParser.d");
	         
	// create an index for the doc tree	
	compile("-c -o- doc/enki/modules.ddoc doc/enki/index.ddoc -Df./doc/enki/html/index.html","enki/enki.d");
}


