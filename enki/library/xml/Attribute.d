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
module xml.Attribute;

private import xml.QName;
private import enki.types;

struct Attribute{
	QName name;
	String value;	
	
	static Attribute create(QName name,String value){
		Attribute _this;
		_this.name = name;
		_this.value = value;
		return _this;
	}
	
	static Attribute empty;
}

Attribute find(Attribute[] attribs, String name){
	foreach(attr; attribs){	
		if(name == attr.name.value) return attr;
	}
	return Attribute.empty;
}


Attribute find(Attribute[] attribs, QName thisName){
	foreach(attr; attribs){
		if(thisName.value == attr.name.value) return attr;
	}
	return Attribute.empty;
}