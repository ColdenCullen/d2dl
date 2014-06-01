module attributes;
import ddl.DefaultRegistry;
import ddl.DynamicLibrary;
import tango.io.Stdout;

void main(){
	auto registry = new DefaultRegistry();
	auto lib = registry.load("mylib.ddl");
	
	auto helloWorld = lib.getAttributes["hello"];
	Stdout("value of 'hello' is "c)(helloWorld).newline;
}