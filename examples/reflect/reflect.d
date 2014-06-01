module reflect;

import ddl.DefaultRegistry;
import tango.io.Stdout;

export void test(){
	Stdout("Hello DDL World"c).newline;
}

void main(){
    auto registry = new DefaultRegistry();
    auto inSitu = registry.load("reflect.map");
    
    auto testFn = inSitu.getDExport!(void function(),"reflect.test")();
    testFn();
}