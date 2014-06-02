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

module ddl.ddl.DDLLoader;

import ddl.DynamicLibrary;
import ddl.DynamicModule;
import ddl.DynamicLibraryLoader;
import ddl.LoaderRegistry;
import ddl.FileBuffer;

import ddl.ddl.DDLLibrary;

class DDLLoader : DynamicLibraryLoader
{
	public static string typeName = "DDL";
	public static string fileExtension = "ddl";

	public override string getLibraryType()
	{
		return typeName;
	}

	public string getFileExtension()
	{
		return fileExtension;
	}

	public override bool canLoadLibrary(FileBuffer file)
	{
		return file.data[0..4] == cast(ubyte[])"DDL!"c;
	}

	public override DynamicLibrary load(LoaderRegistry registry,FileBuffer file)
	{
		return new DDLLibrary(registry,file);
	}
}
