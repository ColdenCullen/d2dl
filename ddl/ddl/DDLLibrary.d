/+
    Copyright (c) 2005-2007 Eric Anderton

    Based on demangler.d written by James Dunne, Copyright (C) 2005

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

module ddl.ddl.DDLLibrary;

import ddl.ExportSymbol;
import ddl.DynamicLibrary;
import ddl.DynamicModule;
import ddl.LoaderRegistry;
import ddl.DynamicLibraryLoader;
import ddl.FileBuffer;
import ddl.Utils;

import ddl.ddl.DDLBinary;

import tango.io.FilePath;

//TODO: include date/time sensitivity to respond to changes in the file between calls to loadFromFile and loadLibrary

/**
    The DDLLibrary class provides the wrapper support for the embedded library stored in the
    matching .ddl file.
*/
class DDLLibrary : DynamicLibrary
{
    FilePath filename;
    DDLBinary binary;
    DynamicLibrary actualLibrary;
    LoaderRegistry homeRegistry;

    public this(LoaderRegistry homeRegistry,FileBuffer file)
	{
        filename = file.getPath;
        this.homeRegistry = homeRegistry;
        binary = new DDLBinary();
        binary.load(file);
    }

    public override char[] getType()
	{
        return "DDL";
    }

    public override char[][char[]] getAttributes()
	{
        return binary.attributes;
    }

    public override ExportSymbolPtr getSymbol(char[] name)
	{
        if(!actualLibrary) loadLibrary();
        return actualLibrary.getSymbol(name);
    }

    public override DynamicModule[] getModules()
	{
        if(!actualLibrary) loadLibrary();
        return actualLibrary.getModules();
    }

    public override DynamicModule getModuleForSymbol(char[] name)
	{
        if(!actualLibrary) loadLibrary();
        return actualLibrary.getModuleForSymbol(name);
    }

    public override ubyte[] getResource(char[] name)
	{
        if(!actualLibrary) loadLibrary();
        return actualLibrary.getResource(name);
    }

    protected void loadLibrary()
	{
        DynamicLibraryLoader loader = homeRegistry.getLoader(binary.binaryType);
        if(loader){
            debug debugLog("loading nested binary");
            FileBuffer fileBuffer = FileBuffer(filename,binary.getBinaryData());
            actualLibrary = loader.load(homeRegistry,fileBuffer);
        }
        else throw new Exception("Could not locate loader for extension '" ~ binary.binaryType ~ "'");
    }
}
