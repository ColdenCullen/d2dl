/+
    Copyright (c) 2005-2007 Lars Ivar Igesund, Eric Anderton

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
/**
    Authors: Lars Ivar Igesund
    License: BSD Derivative (see source for details)
    Copyright: 2005-2006 Lars Ivar Igesund
*/
module ddl.elf.ELFLibrary;

import ddl.DynamicLibrary;
import ddl.DynamicModule;
import ddl.ExportSymbol;
import ddl.Attributes;
import ddl.Utils;
import ddl.FileBuffer;

import ddl.elf.ELFHeaders;
import ddl.elf.ELFModule;
import ddl.elf.ELFPrinter;

/**
    An implementation of the abstract class DynamicLibrary for use
    with libraries of ELF (Executable and Linkable Format) object
    files.
*/
class ELFLibrary : DynamicLibrary
{
    DynamicModule[] modules;
    DynamicModule[char[]] crossReference; // modules by symbol name
    ExportSymbolPtr[char[]] dictionary; // symbols by symbol name
    Attributes attributes;

    public this()
    {
        attributes["elf.filename"] = "<unknown>";
    }

    public this(FileBuffer file)
    {
        attributes["elf.filename"] = file.getPath.toString();
        load(file);
    }

    public override char[] getType()
    {
        return "ELFLIB";
    }

    public override Attributes getAttributes()
    {
        return attributes;
    }

    package void setAttributes(Attributes other)
    {
        other.copyInto(this.attributes);
    }

    package void setAttribute(char[] key,char[] value)
    {
        this.attributes[key] = value;
    }

    public override ExportSymbolPtr getSymbol(char[] name)
    {
        ExportSymbolPtr* sym = name in dictionary;
        if(sym) return *sym;
        else return &ExportSymbol.NONE;
    }

    public override DynamicModule[] getModules()
    {
        return this.modules;
    }

    public override DynamicModule getModuleForSymbol(char[] name)
    {
        debug debugLog("[ELFLIB] looking for " ~ name);
        DynamicModule* mod = name in crossReference;
        debug debugLog("[ELFLIB] Result: %0.8X",mod);
        if(mod) return *mod;
        return null;
    }

    public override ubyte[] getResource(char[] name)
    {
        return (ubyte[]).init;
    }

    package void addModule(ELFModule mod)
    {
        this.modules ~= mod;
        auto symbols = mod.getSymbols();
        for(uint i=0; i<symbols.length; i++)
        {
            ExportSymbolPtr exp = &(symbols[i]);
            if(exp.name in crossReference)
            {
                switch(exp.type)
                {
                case SymbolType.Weak: // replace extern only
                    if(dictionary[exp.name].type == SymbolType.Unresolved)
                    {
                        crossReference[exp.name] = mod;
                        dictionary[exp.name] = exp;
                    }
                    break;
                case SymbolType.Strong: // always overwrite
                    crossReference[exp.name] = mod;
                    dictionary[exp.name] = exp;
                    break;
                default:
                    // do nothing
                }
            }
            else{
                crossReference[exp.name] = mod;
                dictionary[exp.name] = exp;
            }
        }
    }

    protected void load(FileBuffer data)
    {
        //TODO
    }

    public char[] toString()
    {
        char[] result;

        foreach(mod; modules)
        {
            result ~= mod.toString();
        }
        return result;
    }
}
