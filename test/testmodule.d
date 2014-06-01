/*
	Copyright (c) 2005 Eric Anderton
        
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
*/
module test.testmodule;


private import std.stdio;
import test.testclassinterface;

void* foobar = &printf;

public void* getPrintf(){
	return &printf;
}
class TestClass : ITestClass {
	uint a;
	
	public this(){
		a = 1;
		printf("TestClass created with no parameters\n");
		test();
	}
	public this(int w)
	{
	  a=w;
	  printf("TestClass created with parameter %d\n", w);
	  test();
	  
	}
	public void callable() {
	  printf("In externally callable function, A=%d\n", a);
	}
	
	private void test(){
		printf("A = %d\n",a);
	}
	
	static this(){
		printf("writefln: [%0.8X]\n",&writefln);
		//writefln("");
	}
	
	public void exceptionTest(){
		throw new Exception("From - test.testmodule.TestClass.exceptionTest()");
	}
}

uint intialized = false;

static this(){
	printf("testmodule initalized\n");
	intialized = true;
}

static ~this(){
	printf("testmodule destroyed\n");
}

public uint add(uint a,uint b){
	return a+b;	
}

public bool verifyPrintf(void* externalPrintf){	
	return &printf == externalPrintf;
}

char[] testString = "Hello DDL World!\n";

void* getTestString(){
	return &testString;
}

public void helloWorld(){
	printf("hello world\n");
}

void* getWritefln(){
	return &writefln;
}

public void helloWorld2(){
	writefln("hello world2\n");
}

public void classTest(){
	new TestClass();
}

public void exceptionTest(){
	//printf("Throwing...");
	throw new Exception("From - test.testmodule.exceptionTest()");
	//printf("You shouldn't be here. :(\n");
}

public void exceptionTest2(){
	try{
		exceptionTest();
	}
	catch(Exception e){
	}
}

public void exceptionTest3(){
	throw new Exception("this is also a test");
}
 
/* Eratosthenes Sieve prime number calculation. */
 
bool flags[8191];
 
void sieve(int iterations)
{   int     i, prime, k, count, iter;

    printf("%d iterations\n",iterations);
    for (iter = 1; iter <= iterations; iter++)
    {	count = 0;
		flags[] = true;
		for (i = 0; i < flags.length; i++)
		{   if (flags[i])
		    {	prime = i + i + 3;
			k = i + prime;
			while (k < flags.length)
			{
			    flags[k] = false;
			    k += prime;
			}
			count += 1;
		    }
		}
    }
    printf ("\n%d primes\n", count);
}