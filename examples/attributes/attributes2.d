module attributes2;

import ddl.all;
import ddl.ddl.DDLBinary;
import tango.io.Stdout;
import tango.io.FileConduit;

void main(){	
	// load the .ddl binary file
	DDLBinary binary = new DDLBinary();	
	auto inBuffer = new FileBuffer("mylib.ddl");
	binary.load(inBuffer);
	inBuffer.flush();
	inBuffer.getConduit().close();
	
	// manipulate some attributes
	binary.attributes["HaHa"] = "I'm on the internet.";
	
	// write the file out
	auto outBuffer = new FileBuffer("mylib.ddl",FileStyle.ReadWriteCreate);
	binary.save(outBuffer);	
	outBuffer.flush();
	outBuffer.getConduit().close();
}