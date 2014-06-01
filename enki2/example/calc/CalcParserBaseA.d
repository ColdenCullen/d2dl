module example.calc.CalcParserBase;

import enkilib.d.Parser;

import Math = tango.math.Math;
import Float = tango.text.convert.Float;

public class CalcParserBaseA: Parser!(char){
	void neg(ref double result){
		result = result * -1;
	}
	
	double fac(ref double result){
		if(result < 0){
			result = double.nan;
		}
		else{
			uint value = cast(int)result;
			result = 1;
			for(int i=1; i<value; i++){
				result *= i;
			}
		}
        return result;
	}
	
	void add(ref double result,double value){
		result += value;
	}
	
	void sub(ref double result,double value){
		result -= value;
	}
	
	void mul(ref double result,double value){
		result *= value;
	}
	
	void div(ref double result,double value){
		result /= value;
	}
	
	void mod(ref double result,double value){
		result %= value;
	}
	
	void pow(ref double result,double value){
		result = Math.pow(result,value);
	}
	
	void abs(ref double result){
		result = Math.abs(result);
	}
	
	void sin(ref double result){
		result = Math.sin(result);
	}
	
	void cos(ref double result){
		result = Math.cos(result);
	}
	
	void tan(ref double result){
		result = Math.tan(result);
	}
	
	void pi2(ref double result){
		result = Math.PI_2;
	}
	
	void pi(ref double result){
		result = Math.PI;
	}
	
	double pi2(){
		return Math.PI_2;
	}
	
	double pi(){
		return Math.PI;
	}
	
	
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