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
module test.linktest2;

import ddl.Linker;
import ddl.all;
import ddl.Utils;
import test.testconfig;

import tango.io.Stdout;

/**
	Covers the following scenarios:
	- direct invocation of linked ctor
	- cast of object created by direct invocation of ctor
	- class casting from external class creation
	- exception thrown from class member
	- exception thrown from module function
	
	Tests the following DDL capabilities
	- circular module initalization dependencies
	- implib style loading under Windows
*/

private import test.testclassinterface;

void exceptionTest(){
	throw new Exception("this is a test");
}

void localTest(){
	try{
		exceptionTest();
	}
	catch(Exception e){
	}
}

void main(){
	Stdout.println("Starting.");
	
	auto linker = new Linker(new DefaultRegistry());
	linker.loadAndRegister("test\\linktest2.ddl");
	linker.loadAndRegister(dmPath ~ "lib\\snn.lib");
	linker.loadAndRegister(dmdPath ~ "lib\\phobos.lib");
	linker.loadAndRegister(dmPath ~ "lib\\kernel32.lib");
	linker.loadAndRegister(dmPath ~ "lib\\user32.lib");
	
	Stdout.println("Loading test module");
	auto testLibrary = linker.loadAndLink("test\\testmodule.obj");
	
	
	//direct invocation of linked ctor
	auto testCtor = testLibrary.getCtor!(ITestClass,"test.testmodule.TestClass")();
	assert(testCtor != null,"Cannot find ctor for TestClass");
	auto testobj1 = testCtor();
	Stdout.println("Direct Invocation Test Passed.");
	
	// exception test from module function
	auto exceptionTest = testLibrary.getDExport!(void function(),"test.testmodule.exceptionTest")();
	try{
		exceptionTest();
	}catch(Exception e){
		Stdout.println("Exception Test Passed. %s",e.toString());
	}
	
	
	void* exceptionTestAddr = testLibrary.getSymbol("_D4test10testmodule14exceptionTest2FZv").address;
	void* localTestaddr =  &localTest;
		
	assert(exceptionTestAddr != null);
	
	Stdout.println("Remote Data: [%0.8X] \n%s",exceptionTestAddr,dataDumper(exceptionTestAddr,100));
	Stdout.println("Local Data: [%0.8X] \n%s",localTestaddr,dataDumper(localTestaddr,100));
	
	Stdout.println("local:");
	try{
		localTest();
	}
	catch(Exception e){
		Stdout.println("exception: %s",e.toString());
	}	
	
	Stdout.println("remote:");
	try{
		(cast(void function())exceptionTestAddr)();
	}
	catch(Exception e){
		Stdout.println("exception: %s",e.toString());
	}
	
	Stdout.println("Done.");
}