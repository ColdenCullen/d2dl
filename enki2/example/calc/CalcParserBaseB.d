module example.calc.CalcParserBase;

import enkilib.d.Parser;

import Math = tango.math.Math;
import Float = tango.text.convert.Float;

public class CalcParserBaseB: Parser!(char){
	double neg(double result){
		return result * -1;
	}
	
	double fac(double result){
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
	
	double add(double result,double value){
		return result + value;
	}
	
	double sub(double result,double value){
		return result - value;
	}
	
	double mul(double result,double value){
		return  result * value;
	}
	
	double div(double result,double value){
		return result / value;
	}
	
	double mod(ref double result,double value){
		return result % value;
	}
	
	double pow(double result,double value){
		return Math.pow(result,value);
	}
	
	double abs(double result){
		return Math.abs(result);
	}
	
	double sin(double result){
		return Math.sin(result);
	}
	
	double cos(double result){
		return Math.cos(result);
	}
	
	double tan(double result){
		return Math.tan(result);
	}
	
	double pi2(double result){
		return Math.PI_2;
	}
	
	double pi(double result){
		return Math.PI;
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