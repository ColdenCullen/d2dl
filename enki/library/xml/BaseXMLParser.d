/+
    Copyright (c) 2006 Eric Anderton

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
module xml.BaseXMLParser;

private import enki.BaseParser;
private import enki.types;

private import std.stdio;

private import xml.QName;
private import xml.Attribute;


abstract class BaseXMLParser : BaseParser{
	void onComment(String value){
	}
	
	void onPI(String target,String value,bool isXML){
	}
	
	void onStartDocument(){
	}
	
	void onEndDocument(){
	}
	
	void onStartDoctype(String name,String externalID){
	}
	
	void onEndDoctype(String name,String externalID){
	}
	
	void onStartTag(QName name,Attribute[] attributes){
	}
	
	void onEndTag(QName name,Attribute[] attributes){
	}
	 
	void onPCData(String value){
	}
	 	 
	String resolveEntityRef(String name){
		return "";
	}
	
	String resolvePEReference(String name){
		return "";
	}
	
	String resolveDecimalCharRef(String value){
		return "";
	}
	
	String resolveHexCharRef(String value){
		return "";
	}
}