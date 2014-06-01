module example.calc.CalcParserBase;

import enkilib.d.Parser;

import Float = tango.text.convert.Float;

public class CalcParserBase: Parser!(char){
	/**
		Enki hook for parsing a number.  Uses Tango's Float parser to do the real work.
	*/
    double value_Number;
	bool parse_Number(){
		uint ate = 0;		
		value_Number = cast(double)Float.parse(data[pos..$],&ate);
		if(ate > 0){
			pos+=ate;
			return true;
		}
		return false;
	}
}