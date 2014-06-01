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

// using a token type of 'Token'
class ParserBackend{
	struct ErrorData{
		uint pos;
		String text;
	}
	
	private Token[] data;
	private uint position;
	alias pos position;
	private ErrorData[] errors;
	
	public this(){		
	}
	
	public void initialize(String input){
		data = input;
		pos = 0;
	}
		
	protected uint nextToken(){
		return (this.pos++);
	}
		
	/** error handling **/
	protected void setError(String text){
		debug writefln("[%d] Error: %s",pos,text);
		ErrorData data;
		data.pos = pos;
		data.text = text;	
		errors ~= data;
	}
	
	protected void setError(String text,int pos){
		ErrorData data;
		data.pos = pos;
		data.text = text;
		errors ~= data;
	}
	
	protected void clearErrors(){
		errors = (ErrorData[]).init;
	}
	
	public String getErrorReport(){
		return "";
		//TODO: finish me
/*		String result = "";
		foreach(ErrorData err; errors){
			uint line=1;
			uint startOfLine = 0;
			for(uint i=0; i<err.pos; i++){
				if(data[i] == '\n'){
					startOfLine = i;
					line++;
				}
			}
			result ~= transcodeToString(std.string.format("(%d,%d) %s\n",line,err.pos-startOfLine+1,err.text));
		}
		return result; */
	}
	
	public bool hasErrors(){
		return errors.length > 0;
	}
		
	protected String sliceData(uint start,uint end){
		String result;
		for(uint i=start; i<end; i++){
			result ~= data[i].render();
		}
		return result;
	}
	
	public ResultT!(Token) terminal(Tok token){
		Token thisToken = data[pos];
		if((thisToken.type == Token.Keyword || thisToken.type == Token.Operator) && thisToken.value.token == token){
			nextToken();
			ResultT!(Token)(thisToken);
		}
		ResultT!(Token)();
	}
	
	public ResultT!(Token) terminal(uint tokenType){
		Token thisToken = data[pos];
		if(thisToken.type == tokenType){
			nextToken();
			ResultT!(Token)(thisToken);
		}
		ResultT!(Token)();
	}
	
	// strings are mapped to identifiers and keywords	
	public ResultString terminal(String str){
		Token thisToken = data[pos];
		if(thisToken.type == Token.Identifier && thisToken.strValue == str){
			nextToken();
			ResultString(str);
		}
		else if(thisToken.type == Token.Keyword && keywordXref[thisToken.token] == str){
			nextToken();
			ResultString(str);
		}
		else if(thisToken.type == Token.Operator && operatorXref[thisToken.token] == str){
			nextToken();
			ResultString(str);
		}
		ResultString();
	}
		
	// overrides left unused:
	public ResultString terminal(uint ch){
		assert(false,"char terminals not supported.");
	}
	
	public ResultString range(uint start,uint end){
		assert(false,"ranges are not supported.");
	}
	
	protected ResultString regexp(String str){
		assert(false,"regexp is not supported.");
	}
}