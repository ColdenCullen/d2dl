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
module test.linktest1;

import ddl.Linker;
import ddl.all;

import std.stdio;

import tango.io.Stdout;

/**
	Basic Linkage test
	- loads external in-situ module
	- loads phobos
	- loads snn
	- loads the actual test module
	- gets exports for the add function and hello world functions
	- tests those exported handles
*/

private import test.testclassinterface;

void main(){
	Stdout.println("Starting.");
	
	auto linker = new Linker(new DefaultRegistry());
	linker.loadAndRegister("test\\linktest1.ddl");
	linker.loadAndRegister("snn.lib");
	linker.loadAndRegister("phobos.lib");
	
	Stdout.println("Loading test module");
	auto testLibrary = linker.loadAndLink("test\\testmodule.obj");
	auto addFun = testLibrary.getDExport!(uint function(uint,uint),"test.testmodule.add")();
	
	Stdout.println("add: 42+69 = %d",addFun(42,69));
	Stdout.println("printf: %0.8X test printf: %0.8X",&printf,*cast(void**)testLibrary.getSymbol("_D4test10testmodule6foobarPv").address);
	
	auto verify = testLibrary.getDExport!(bool function(void*),"test.testmodule.verifyPrintf")();
	char[] result = verify(&printf) ? "true" : "false";
	Stdout.println("verifyPrintf: %s",result);
	
	auto getPrintf = testLibrary.getDExport!(void* function(),"test.testmodule.getPrintf")();
	Stdout.println("printf: %0.8X getPrintf: %0.8X",&printf,getPrintf());
		
	void* testString = testLibrary.getSymbol("_D4test10testmodule10testStringAa").address;
	Stdout.println("testString: %0.8X [%0.8X %0.8X]",testString,*cast(uint*)testString,*cast(uint*)(testString+4));

	auto getTestString = testLibrary.getDExport!(void* function(),"test.testmodule.getTestString")();
	Stdout.println("getTestString: %0.8X",getTestString());
	Stdout.println(*cast(char[]*)getTestString());
	
	auto helloWorld = testLibrary.getDExport!(void function(),"test.testmodule.helloWorld")();
	helloWorld();
	
	auto getWritefln = testLibrary.getDExport!(void* function(),"test.testmodule.getTestString")();
	Stdout.println("getWritefln: %0.8X (%0.8X)",getWritefln,&writefln);
	
	auto helloWorld2 = testLibrary.getDExport!(void function(),"test.testmodule.helloWorld2")();
	helloWorld2();	
	
	auto classTest = testLibrary.getDExport!(void function(),"test.testmodule.classTest")();
	
	classTest();
	
    // Create a class using two different constructors. We need to specify
    // the interface we'll be using (in this case, ITestClass).
   
	// Constructor with no parameters
	auto newTestClass = testLibrary.getCtor!(ITestClass, "test.testmodule.TestClass")();
	auto a = newTestClass();  

	// Constructor with one parameter
	auto newTestClass1 = testLibrary.getCtor!(ITestClass, "test.testmodule.TestClass", int)();
	auto b = newTestClass1(31415);

	// Call a member function of the interface
	a.callable();
	b.callable();
	
	Stdout.println("Done.");
}