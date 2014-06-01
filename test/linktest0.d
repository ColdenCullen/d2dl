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
module test.linktest0;
import ddl.Linker;
import ddl.all;

import test.testconfig;

import tango.io.Stdout;

/**
	Covers the following scenarios:
	- static module initialization
*/

private import test.testclassinterface;

private import std.moduleinit;

void main(){
	Stdout.println("Starting.");
	
	Stdout.println("%d modules: ",_moduleinfo_array.length);
	for(uint i=0; i<_moduleinfo_array.length; i++){
		ModuleInfo* mi = &(_moduleinfo_array[i]);
		Stdout.println("mi: %s [%0.8X]",mi.name,*cast(void**)mi);
	}
		
	auto linker = new Linker(new DefaultRegistry());
	linker.loadAndRegister("test\\linktest0.ddl");
	linker.loadAndRegister(dmPath ~ "lib\\snn.lib");
	linker.loadAndRegister(dmdPath ~ "lib\\phobos.lib");
	linker.loadAndRegister(dmPath ~ "lib\\kernel32.lib");
	linker.loadAndRegister(dmPath ~ "lib\\user32.lib");
	
	Stdout.println("Loading test module");
	auto testLibrary = linker.loadAndLink("test\\testmodule.obj");
	assert(testLibrary != null,"testmodule failed to load.");
	
	auto result = cast(uint)testLibrary.getSymbol("_D4test10testmodule10intializedk").address;
	assert(result,"Testmodule static ctor was never run.");
	Stdout.println("Module Init Test Passed.");	
	Stdout.println("Done.");
}