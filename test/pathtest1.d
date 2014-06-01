/+
	Copyright (c) 2006-2007 Eric Anderton
        
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
module test.pathtest1;

import ddl.PathLibrary;
import ddl.Linker;
import ddl.all;

import test.testconfig;

import tango.io.Stdout;
/**
	This test searches the D library namespace located in DMD's lib subdirectory.
*/
void main(){
	Stdout.println("Starting.");
	
	auto lib = new PathLibrary(dmdPath ~ "lib",new DefaultRegistry());
	auto mod = lib.getModuleForSymbol("_D3std5stdio8writeflnFYv");
	
	assert(!(mod is null),"Module Loading Test Failed - module doesn't exist for symbol");
	Stdout.println("Module Loading Test Passed.");
	Stdout.println("mod: %s",mod.toString());
	
	auto sym = lib.getSymbol("_D3std5stdio8writeflnFYv");
	assert(!(mod is null),"Symbol Loading Test Failed - symbol doesn't exist");
	Stdout.println("Symbol Loading Test Passed.");
	Stdout.println("sym: %s %s [%0.8X]",sym.getTypeName,sym.name,sym.address);
}