module XMLParser;
import enkilib.d.AST;
import enkilib.d.CharParser;	

debug import tango.io.Stdout;

class XMLParserT(CharT):ASTParserT!(CharParserT!(CharT)){

	/*
	any = String;
	*/

	/*
	S
		::= (#20-#20 | #0A-#0A | #0D-#0D | #09-#09 | #3000-#3000)+;
	*/
	bool parse_S(){
		debug Stdout("parse_S").newline;
		auto __astNode = createASTNode("S");
		// Iterator
		size_t counter5 = 0;
		start2:
			// (terminator)
			if(!hasMore()){
				goto end3;
			}
			// (expression)
			expr4:
				// OrGroup increment6
					// CharRange
					if(match(0x20)){
						goto increment6;
					}
				term7:
					// CharRange
					if(match(0x0A)){
						goto increment6;
					}
				term8:
					// CharRange
					if(match(0x0D)){
						goto increment6;
					}
				term9:
					// CharRange
					if(match(0x09)){
						goto increment6;
					}
				term10:
					// CharRange
					if(!match(0x3000)){
						goto end3;
					}
			increment6:
			// (increment expr count)
				counter5 ++;
			goto start2;
		end3:
			// (range test)
				if(!((counter5 >= 1))){
					goto fail1;
					goto pass0;
				}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_S failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	Character
		::= #09-#09 | #0A-#0A | #0D-#0D | #20-#FFFD | #00010000-#7FFFFFFF;
	*/
	bool parse_Character(){
		debug Stdout("parse_Character").newline;
		auto __astNode = createASTNode("Character");
		// OrGroup pass0
			// CharRange
			if(match(0x09)){
				goto pass0;
			}
		term2:
			// CharRange
			if(match(0x0A)){
				goto pass0;
			}
		term3:
			// CharRange
			if(match(0x0D)){
				goto pass0;
			}
		term4:
			// CharRange
			if(match(0x20,0xFFFD)){
				goto pass0;
			}
		term5:
			// CharRange
			if(!match(0x00010000,0x7FFFFFFF)){
				goto fail1;
			}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_Character failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	BaseChar
		::= #41-#5A | #61-#7A | #AA-#AA | #B5-#B5 | #BA-#BA | #C0-#D6 | #D8-#F6 | #F8-#FF | #0100-#017F | #0180-#01F5 | #01FA-#0217 | #0250-#02A8 | #02B0-#02B8 | #02BB-#02C1 | #02E0-#02E4 | #037A-#037A | #0386-#0386 | #0388-#038A | #038C-#038C | #038E-#03A1 | #03A3-#03CE | #03D0-#03D6 | #03DA-#03DA | #03DC-#03DC | #03DE-#03DE | #03E0-#03E0 | #03E2-#03F3 | #0401-#040C | #040E-#044F | #0451-#045C | #045E-#0481 | #0490-#04C4 | #04C7-#04C8 | #04CB-#04CC | #04D0-#04EB | #04EE-#04F5 | #04F8-#04F9 | #0531-#0556 | #0559-#055A | #0561-#0587 | #05D0-#05EA | #05F0-#05F2 | #0621-#063A | #0641-#064A | #0671-#06B7 | #06BA-#06BE | #06C0-#06CE | #06D0-#06D3 | #06D5-#06D6 | #06E5-#06E6 | #0905-#0939 | #093D-#093D | #0958-#0961 | #0981-#0981 | #0985-#098C | #098F-#0990 | #0993-#09A8 | #09AA-#09B0 | #09B2-#09B2 | #09B6-#09B9 | #09DC-#09DD | #09DF-#09E1 | #09F0-#09F1 | #0A05-#0A0A | #0A0F-#0A10 | #0A13-#0A28 | #0A2A-#0A30 | #0A32-#0A33 | #0A35-#0A36 | #0A38-#0A39 | #0A8F-#0A91 | #0A93-#0AA8 | #0AAA-#0AB0 | #0AB2-#0AB3 | #0AB5-#0AB9 | #0AE0-#0AE0 | #0B05-#0B0C | #0B0F-#0B10 | #0B13-#0B28 | #0B2A-#0B30 | #0B32-#0B33 | #0B36-#0B39 | #0B3D-#0B3D | #0B5C-#0B5D | #0B5F-#0B61 | #0B85-#0B8A | #0B8E-#0B90 | #0B92-#0B95 | #0B99-#0B9A | #0B9C-#0B9C | #0B9E-#0B9F | #0BA3-#0BA4 | #0BA8-#0BAA | #0BAE-#0BB5 | #0BB7-#0BB9 | #0C05-#0C0C | #0C0E-#0C10 | #0C12-#0C28 | #0C2A-#0C33 | #0C35-#0C39 | #0C60-#0C61 | #0C85-#0C8C | #0C8E-#0C90 | #0C92-#0CA8 | #0CAA-#0CB3 | #0CB5-#0CB9 | #0CDE-#0CDE | #0CE0-#0CE1 | #0D05-#0D0C | #0D0E-#0D10 | #0D12-#0D28 | #0D2A-#0D39 | #0D60-#0D61 | #0E01-#0E2E | #0E30-#0E30 | #0E32-#0E33 | #0E40-#0E45 | #0E81-#0E82 | #0E84-#0E84 | #0E87-#0E88 | #0E8A-#0E8A | #0E8D-#0E8D | #0E94-#0E97 | #0E99-#0E9F | #0EA1-#0EA3 | #0EA5-#0EA5 | #0EA7-#0EA7 | #0EAA-#0EAB | #0EAD-#0EAE | #0EB0-#0EB0 | #0EB2-#0EB3 | #0EBD-#0EBD | #0EC0-#0EC4 | #0EDC-#0EDD | #0F40-#0F47 | #0F49-#0F69 | #10A0-#10C5 | #10D0-#10F6 | #1100-#1159 | #115F-#11A2 | #11A8-#11F9 | #1E00-#1E9B | #1EA0-#1EF9 | #1F00-#1F15 | #1F18-#1F1D | #1F20-#1F45 | #1F48-#1F4D | #1F50-#1F57 | #1F59-#1F59 | #1F5B-#1F5B | #1F5D-#1F5D | #1F5F-#1F7D | #1F80-#1FB4 | #1FB6-#1FBC | #1FBE-#1FBE | #1FC2-#1FC4 | #1FC6-#1FCC | #1FD0-#1FD3 | #1FD6-#1FDB | #1FE0-#1FEC | #1FF2-#1FF4 | #1FF6-#1FFC | #207F-#207F | #2102-#2102 | #2107-#2107 | #210A-#2113 | #2115-#2115 | #2118-#211D | #2124-#2124 | #2126-#2126 | #2128-#2128 | #212A-#212D | #212F-#2131 | #2133-#2138 | #2160-#2182 | #3041-#3094 | #30A1-#30FA | #3105-#312C | #3131-#318E | #AC00-#D7A3 | #FB00-#FB06 | #FB13-#FB17 | #FB1F-#FB28 | #FB2A-#FB36 | #FB38-#FB3C | #FB3E-#FB3E | #FB40-#FB41 | #FB43-#FB44 | #FB46-#FB4F | #FB50-#FBB1 | #FBD3-#FD3D | #FD50-#FD8F | #FD92-#FDC7 | #FDF0-#FDF8 | #FE70-#FE72 | #FE74-#FE74 | #FE76-#FEFC | #FF21-#FF3A | #FF41-#FF5A | #FF66-#FF6F | #FE71-#FF9D | #FFA0-#FFBE | #FFC2-#FFC7 | #FFCA-#FFCF | #FFD2-#FFD7 | #FFDA-#FFDC;
	*/
	bool parse_BaseChar(){
		debug Stdout("parse_BaseChar").newline;
		auto __astNode = createASTNode("BaseChar");
		// OrGroup pass0
			// CharRange
			if(match(0x41,0x5A)){
				goto pass0;
			}
		term2:
			// CharRange
			if(match(0x61,0x7A)){
				goto pass0;
			}
		term3:
			// CharRange
			if(match(0xAA)){
				goto pass0;
			}
		term4:
			// CharRange
			if(match(0xB5)){
				goto pass0;
			}
		term5:
			// CharRange
			if(match(0xBA)){
				goto pass0;
			}
		term6:
			// CharRange
			if(match(0xC0,0xD6)){
				goto pass0;
			}
		term7:
			// CharRange
			if(match(0xD8,0xF6)){
				goto pass0;
			}
		term8:
			// CharRange
			if(match(0xF8,0xFF)){
				goto pass0;
			}
		term9:
			// CharRange
			if(match(0x0100,0x017F)){
				goto pass0;
			}
		term10:
			// CharRange
			if(match(0x0180,0x01F5)){
				goto pass0;
			}
		term11:
			// CharRange
			if(match(0x01FA,0x0217)){
				goto pass0;
			}
		term12:
			// CharRange
			if(match(0x0250,0x02A8)){
				goto pass0;
			}
		term13:
			// CharRange
			if(match(0x02B0,0x02B8)){
				goto pass0;
			}
		term14:
			// CharRange
			if(match(0x02BB,0x02C1)){
				goto pass0;
			}
		term15:
			// CharRange
			if(match(0x02E0,0x02E4)){
				goto pass0;
			}
		term16:
			// CharRange
			if(match(0x037A)){
				goto pass0;
			}
		term17:
			// CharRange
			if(match(0x0386)){
				goto pass0;
			}
		term18:
			// CharRange
			if(match(0x0388,0x038A)){
				goto pass0;
			}
		term19:
			// CharRange
			if(match(0x038C)){
				goto pass0;
			}
		term20:
			// CharRange
			if(match(0x038E,0x03A1)){
				goto pass0;
			}
		term21:
			// CharRange
			if(match(0x03A3,0x03CE)){
				goto pass0;
			}
		term22:
			// CharRange
			if(match(0x03D0,0x03D6)){
				goto pass0;
			}
		term23:
			// CharRange
			if(match(0x03DA)){
				goto pass0;
			}
		term24:
			// CharRange
			if(match(0x03DC)){
				goto pass0;
			}
		term25:
			// CharRange
			if(match(0x03DE)){
				goto pass0;
			}
		term26:
			// CharRange
			if(match(0x03E0)){
				goto pass0;
			}
		term27:
			// CharRange
			if(match(0x03E2,0x03F3)){
				goto pass0;
			}
		term28:
			// CharRange
			if(match(0x0401,0x040C)){
				goto pass0;
			}
		term29:
			// CharRange
			if(match(0x040E,0x044F)){
				goto pass0;
			}
		term30:
			// CharRange
			if(match(0x0451,0x045C)){
				goto pass0;
			}
		term31:
			// CharRange
			if(match(0x045E,0x0481)){
				goto pass0;
			}
		term32:
			// CharRange
			if(match(0x0490,0x04C4)){
				goto pass0;
			}
		term33:
			// CharRange
			if(match(0x04C7,0x04C8)){
				goto pass0;
			}
		term34:
			// CharRange
			if(match(0x04CB,0x04CC)){
				goto pass0;
			}
		term35:
			// CharRange
			if(match(0x04D0,0x04EB)){
				goto pass0;
			}
		term36:
			// CharRange
			if(match(0x04EE,0x04F5)){
				goto pass0;
			}
		term37:
			// CharRange
			if(match(0x04F8,0x04F9)){
				goto pass0;
			}
		term38:
			// CharRange
			if(match(0x0531,0x0556)){
				goto pass0;
			}
		term39:
			// CharRange
			if(match(0x0559,0x055A)){
				goto pass0;
			}
		term40:
			// CharRange
			if(match(0x0561,0x0587)){
				goto pass0;
			}
		term41:
			// CharRange
			if(match(0x05D0,0x05EA)){
				goto pass0;
			}
		term42:
			// CharRange
			if(match(0x05F0,0x05F2)){
				goto pass0;
			}
		term43:
			// CharRange
			if(match(0x0621,0x063A)){
				goto pass0;
			}
		term44:
			// CharRange
			if(match(0x0641,0x064A)){
				goto pass0;
			}
		term45:
			// CharRange
			if(match(0x0671,0x06B7)){
				goto pass0;
			}
		term46:
			// CharRange
			if(match(0x06BA,0x06BE)){
				goto pass0;
			}
		term47:
			// CharRange
			if(match(0x06C0,0x06CE)){
				goto pass0;
			}
		term48:
			// CharRange
			if(match(0x06D0,0x06D3)){
				goto pass0;
			}
		term49:
			// CharRange
			if(match(0x06D5,0x06D6)){
				goto pass0;
			}
		term50:
			// CharRange
			if(match(0x06E5,0x06E6)){
				goto pass0;
			}
		term51:
			// CharRange
			if(match(0x0905,0x0939)){
				goto pass0;
			}
		term52:
			// CharRange
			if(match(0x093D)){
				goto pass0;
			}
		term53:
			// CharRange
			if(match(0x0958,0x0961)){
				goto pass0;
			}
		term54:
			// CharRange
			if(match(0x0981)){
				goto pass0;
			}
		term55:
			// CharRange
			if(match(0x0985,0x098C)){
				goto pass0;
			}
		term56:
			// CharRange
			if(match(0x098F,0x0990)){
				goto pass0;
			}
		term57:
			// CharRange
			if(match(0x0993,0x09A8)){
				goto pass0;
			}
		term58:
			// CharRange
			if(match(0x09AA,0x09B0)){
				goto pass0;
			}
		term59:
			// CharRange
			if(match(0x09B2)){
				goto pass0;
			}
		term60:
			// CharRange
			if(match(0x09B6,0x09B9)){
				goto pass0;
			}
		term61:
			// CharRange
			if(match(0x09DC,0x09DD)){
				goto pass0;
			}
		term62:
			// CharRange
			if(match(0x09DF,0x09E1)){
				goto pass0;
			}
		term63:
			// CharRange
			if(match(0x09F0,0x09F1)){
				goto pass0;
			}
		term64:
			// CharRange
			if(match(0x0A05,0x0A0A)){
				goto pass0;
			}
		term65:
			// CharRange
			if(match(0x0A0F,0x0A10)){
				goto pass0;
			}
		term66:
			// CharRange
			if(match(0x0A13,0x0A28)){
				goto pass0;
			}
		term67:
			// CharRange
			if(match(0x0A2A,0x0A30)){
				goto pass0;
			}
		term68:
			// CharRange
			if(match(0x0A32,0x0A33)){
				goto pass0;
			}
		term69:
			// CharRange
			if(match(0x0A35,0x0A36)){
				goto pass0;
			}
		term70:
			// CharRange
			if(match(0x0A38,0x0A39)){
				goto pass0;
			}
		term71:
			// CharRange
			if(match(0x0A8F,0x0A91)){
				goto pass0;
			}
		term72:
			// CharRange
			if(match(0x0A93,0x0AA8)){
				goto pass0;
			}
		term73:
			// CharRange
			if(match(0x0AAA,0x0AB0)){
				goto pass0;
			}
		term74:
			// CharRange
			if(match(0x0AB2,0x0AB3)){
				goto pass0;
			}
		term75:
			// CharRange
			if(match(0x0AB5,0x0AB9)){
				goto pass0;
			}
		term76:
			// CharRange
			if(match(0x0AE0)){
				goto pass0;
			}
		term77:
			// CharRange
			if(match(0x0B05,0x0B0C)){
				goto pass0;
			}
		term78:
			// CharRange
			if(match(0x0B0F,0x0B10)){
				goto pass0;
			}
		term79:
			// CharRange
			if(match(0x0B13,0x0B28)){
				goto pass0;
			}
		term80:
			// CharRange
			if(match(0x0B2A,0x0B30)){
				goto pass0;
			}
		term81:
			// CharRange
			if(match(0x0B32,0x0B33)){
				goto pass0;
			}
		term82:
			// CharRange
			if(match(0x0B36,0x0B39)){
				goto pass0;
			}
		term83:
			// CharRange
			if(match(0x0B3D)){
				goto pass0;
			}
		term84:
			// CharRange
			if(match(0x0B5C,0x0B5D)){
				goto pass0;
			}
		term85:
			// CharRange
			if(match(0x0B5F,0x0B61)){
				goto pass0;
			}
		term86:
			// CharRange
			if(match(0x0B85,0x0B8A)){
				goto pass0;
			}
		term87:
			// CharRange
			if(match(0x0B8E,0x0B90)){
				goto pass0;
			}
		term88:
			// CharRange
			if(match(0x0B92,0x0B95)){
				goto pass0;
			}
		term89:
			// CharRange
			if(match(0x0B99,0x0B9A)){
				goto pass0;
			}
		term90:
			// CharRange
			if(match(0x0B9C)){
				goto pass0;
			}
		term91:
			// CharRange
			if(match(0x0B9E,0x0B9F)){
				goto pass0;
			}
		term92:
			// CharRange
			if(match(0x0BA3,0x0BA4)){
				goto pass0;
			}
		term93:
			// CharRange
			if(match(0x0BA8,0x0BAA)){
				goto pass0;
			}
		term94:
			// CharRange
			if(match(0x0BAE,0x0BB5)){
				goto pass0;
			}
		term95:
			// CharRange
			if(match(0x0BB7,0x0BB9)){
				goto pass0;
			}
		term96:
			// CharRange
			if(match(0x0C05,0x0C0C)){
				goto pass0;
			}
		term97:
			// CharRange
			if(match(0x0C0E,0x0C10)){
				goto pass0;
			}
		term98:
			// CharRange
			if(match(0x0C12,0x0C28)){
				goto pass0;
			}
		term99:
			// CharRange
			if(match(0x0C2A,0x0C33)){
				goto pass0;
			}
		term100:
			// CharRange
			if(match(0x0C35,0x0C39)){
				goto pass0;
			}
		term101:
			// CharRange
			if(match(0x0C60,0x0C61)){
				goto pass0;
			}
		term102:
			// CharRange
			if(match(0x0C85,0x0C8C)){
				goto pass0;
			}
		term103:
			// CharRange
			if(match(0x0C8E,0x0C90)){
				goto pass0;
			}
		term104:
			// CharRange
			if(match(0x0C92,0x0CA8)){
				goto pass0;
			}
		term105:
			// CharRange
			if(match(0x0CAA,0x0CB3)){
				goto pass0;
			}
		term106:
			// CharRange
			if(match(0x0CB5,0x0CB9)){
				goto pass0;
			}
		term107:
			// CharRange
			if(match(0x0CDE)){
				goto pass0;
			}
		term108:
			// CharRange
			if(match(0x0CE0,0x0CE1)){
				goto pass0;
			}
		term109:
			// CharRange
			if(match(0x0D05,0x0D0C)){
				goto pass0;
			}
		term110:
			// CharRange
			if(match(0x0D0E,0x0D10)){
				goto pass0;
			}
		term111:
			// CharRange
			if(match(0x0D12,0x0D28)){
				goto pass0;
			}
		term112:
			// CharRange
			if(match(0x0D2A,0x0D39)){
				goto pass0;
			}
		term113:
			// CharRange
			if(match(0x0D60,0x0D61)){
				goto pass0;
			}
		term114:
			// CharRange
			if(match(0x0E01,0x0E2E)){
				goto pass0;
			}
		term115:
			// CharRange
			if(match(0x0E30)){
				goto pass0;
			}
		term116:
			// CharRange
			if(match(0x0E32,0x0E33)){
				goto pass0;
			}
		term117:
			// CharRange
			if(match(0x0E40,0x0E45)){
				goto pass0;
			}
		term118:
			// CharRange
			if(match(0x0E81,0x0E82)){
				goto pass0;
			}
		term119:
			// CharRange
			if(match(0x0E84)){
				goto pass0;
			}
		term120:
			// CharRange
			if(match(0x0E87,0x0E88)){
				goto pass0;
			}
		term121:
			// CharRange
			if(match(0x0E8A)){
				goto pass0;
			}
		term122:
			// CharRange
			if(match(0x0E8D)){
				goto pass0;
			}
		term123:
			// CharRange
			if(match(0x0E94,0x0E97)){
				goto pass0;
			}
		term124:
			// CharRange
			if(match(0x0E99,0x0E9F)){
				goto pass0;
			}
		term125:
			// CharRange
			if(match(0x0EA1,0x0EA3)){
				goto pass0;
			}
		term126:
			// CharRange
			if(match(0x0EA5)){
				goto pass0;
			}
		term127:
			// CharRange
			if(match(0x0EA7)){
				goto pass0;
			}
		term128:
			// CharRange
			if(match(0x0EAA,0x0EAB)){
				goto pass0;
			}
		term129:
			// CharRange
			if(match(0x0EAD,0x0EAE)){
				goto pass0;
			}
		term130:
			// CharRange
			if(match(0x0EB0)){
				goto pass0;
			}
		term131:
			// CharRange
			if(match(0x0EB2,0x0EB3)){
				goto pass0;
			}
		term132:
			// CharRange
			if(match(0x0EBD)){
				goto pass0;
			}
		term133:
			// CharRange
			if(match(0x0EC0,0x0EC4)){
				goto pass0;
			}
		term134:
			// CharRange
			if(match(0x0EDC,0x0EDD)){
				goto pass0;
			}
		term135:
			// CharRange
			if(match(0x0F40,0x0F47)){
				goto pass0;
			}
		term136:
			// CharRange
			if(match(0x0F49,0x0F69)){
				goto pass0;
			}
		term137:
			// CharRange
			if(match(0x10A0,0x10C5)){
				goto pass0;
			}
		term138:
			// CharRange
			if(match(0x10D0,0x10F6)){
				goto pass0;
			}
		term139:
			// CharRange
			if(match(0x1100,0x1159)){
				goto pass0;
			}
		term140:
			// CharRange
			if(match(0x115F,0x11A2)){
				goto pass0;
			}
		term141:
			// CharRange
			if(match(0x11A8,0x11F9)){
				goto pass0;
			}
		term142:
			// CharRange
			if(match(0x1E00,0x1E9B)){
				goto pass0;
			}
		term143:
			// CharRange
			if(match(0x1EA0,0x1EF9)){
				goto pass0;
			}
		term144:
			// CharRange
			if(match(0x1F00,0x1F15)){
				goto pass0;
			}
		term145:
			// CharRange
			if(match(0x1F18,0x1F1D)){
				goto pass0;
			}
		term146:
			// CharRange
			if(match(0x1F20,0x1F45)){
				goto pass0;
			}
		term147:
			// CharRange
			if(match(0x1F48,0x1F4D)){
				goto pass0;
			}
		term148:
			// CharRange
			if(match(0x1F50,0x1F57)){
				goto pass0;
			}
		term149:
			// CharRange
			if(match(0x1F59)){
				goto pass0;
			}
		term150:
			// CharRange
			if(match(0x1F5B)){
				goto pass0;
			}
		term151:
			// CharRange
			if(match(0x1F5D)){
				goto pass0;
			}
		term152:
			// CharRange
			if(match(0x1F5F,0x1F7D)){
				goto pass0;
			}
		term153:
			// CharRange
			if(match(0x1F80,0x1FB4)){
				goto pass0;
			}
		term154:
			// CharRange
			if(match(0x1FB6,0x1FBC)){
				goto pass0;
			}
		term155:
			// CharRange
			if(match(0x1FBE)){
				goto pass0;
			}
		term156:
			// CharRange
			if(match(0x1FC2,0x1FC4)){
				goto pass0;
			}
		term157:
			// CharRange
			if(match(0x1FC6,0x1FCC)){
				goto pass0;
			}
		term158:
			// CharRange
			if(match(0x1FD0,0x1FD3)){
				goto pass0;
			}
		term159:
			// CharRange
			if(match(0x1FD6,0x1FDB)){
				goto pass0;
			}
		term160:
			// CharRange
			if(match(0x1FE0,0x1FEC)){
				goto pass0;
			}
		term161:
			// CharRange
			if(match(0x1FF2,0x1FF4)){
				goto pass0;
			}
		term162:
			// CharRange
			if(match(0x1FF6,0x1FFC)){
				goto pass0;
			}
		term163:
			// CharRange
			if(match(0x207F)){
				goto pass0;
			}
		term164:
			// CharRange
			if(match(0x2102)){
				goto pass0;
			}
		term165:
			// CharRange
			if(match(0x2107)){
				goto pass0;
			}
		term166:
			// CharRange
			if(match(0x210A,0x2113)){
				goto pass0;
			}
		term167:
			// CharRange
			if(match(0x2115)){
				goto pass0;
			}
		term168:
			// CharRange
			if(match(0x2118,0x211D)){
				goto pass0;
			}
		term169:
			// CharRange
			if(match(0x2124)){
				goto pass0;
			}
		term170:
			// CharRange
			if(match(0x2126)){
				goto pass0;
			}
		term171:
			// CharRange
			if(match(0x2128)){
				goto pass0;
			}
		term172:
			// CharRange
			if(match(0x212A,0x212D)){
				goto pass0;
			}
		term173:
			// CharRange
			if(match(0x212F,0x2131)){
				goto pass0;
			}
		term174:
			// CharRange
			if(match(0x2133,0x2138)){
				goto pass0;
			}
		term175:
			// CharRange
			if(match(0x2160,0x2182)){
				goto pass0;
			}
		term176:
			// CharRange
			if(match(0x3041,0x3094)){
				goto pass0;
			}
		term177:
			// CharRange
			if(match(0x30A1,0x30FA)){
				goto pass0;
			}
		term178:
			// CharRange
			if(match(0x3105,0x312C)){
				goto pass0;
			}
		term179:
			// CharRange
			if(match(0x3131,0x318E)){
				goto pass0;
			}
		term180:
			// CharRange
			if(match(0xAC00,0xD7A3)){
				goto pass0;
			}
		term181:
			// CharRange
			if(match(0xFB00,0xFB06)){
				goto pass0;
			}
		term182:
			// CharRange
			if(match(0xFB13,0xFB17)){
				goto pass0;
			}
		term183:
			// CharRange
			if(match(0xFB1F,0xFB28)){
				goto pass0;
			}
		term184:
			// CharRange
			if(match(0xFB2A,0xFB36)){
				goto pass0;
			}
		term185:
			// CharRange
			if(match(0xFB38,0xFB3C)){
				goto pass0;
			}
		term186:
			// CharRange
			if(match(0xFB3E)){
				goto pass0;
			}
		term187:
			// CharRange
			if(match(0xFB40,0xFB41)){
				goto pass0;
			}
		term188:
			// CharRange
			if(match(0xFB43,0xFB44)){
				goto pass0;
			}
		term189:
			// CharRange
			if(match(0xFB46,0xFB4F)){
				goto pass0;
			}
		term190:
			// CharRange
			if(match(0xFB50,0xFBB1)){
				goto pass0;
			}
		term191:
			// CharRange
			if(match(0xFBD3,0xFD3D)){
				goto pass0;
			}
		term192:
			// CharRange
			if(match(0xFD50,0xFD8F)){
				goto pass0;
			}
		term193:
			// CharRange
			if(match(0xFD92,0xFDC7)){
				goto pass0;
			}
		term194:
			// CharRange
			if(match(0xFDF0,0xFDF8)){
				goto pass0;
			}
		term195:
			// CharRange
			if(match(0xFE70,0xFE72)){
				goto pass0;
			}
		term196:
			// CharRange
			if(match(0xFE74)){
				goto pass0;
			}
		term197:
			// CharRange
			if(match(0xFE76,0xFEFC)){
				goto pass0;
			}
		term198:
			// CharRange
			if(match(0xFF21,0xFF3A)){
				goto pass0;
			}
		term199:
			// CharRange
			if(match(0xFF41,0xFF5A)){
				goto pass0;
			}
		term200:
			// CharRange
			if(match(0xFF66,0xFF6F)){
				goto pass0;
			}
		term201:
			// CharRange
			if(match(0xFE71,0xFF9D)){
				goto pass0;
			}
		term202:
			// CharRange
			if(match(0xFFA0,0xFFBE)){
				goto pass0;
			}
		term203:
			// CharRange
			if(match(0xFFC2,0xFFC7)){
				goto pass0;
			}
		term204:
			// CharRange
			if(match(0xFFCA,0xFFCF)){
				goto pass0;
			}
		term205:
			// CharRange
			if(match(0xFFD2,0xFFD7)){
				goto pass0;
			}
		term206:
			// CharRange
			if(!match(0xFFDA,0xFFDC)){
				goto fail1;
			}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_BaseChar failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	Ideographic
		::= #4E00-#9FA5 | #F900-#FA2D | #3007-#3007 | #3021-#3029;
	*/
	bool parse_Ideographic(){
		debug Stdout("parse_Ideographic").newline;
		auto __astNode = createASTNode("Ideographic");
		// OrGroup pass0
			// CharRange
			if(match(0x4E00,0x9FA5)){
				goto pass0;
			}
		term2:
			// CharRange
			if(match(0xF900,0xFA2D)){
				goto pass0;
			}
		term3:
			// CharRange
			if(match(0x3007)){
				goto pass0;
			}
		term4:
			// CharRange
			if(!match(0x3021,0x3029)){
				goto fail1;
			}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_Ideographic failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	CombiningChar
		::= #0300-#0361 | #0483-#0486 | #0591-#05C4 | #064B-#0652 | #0670-#0670 | #06D7-#06DC | #06DD-#06DF | #06E0-#06E4 | #06E7-#06E8 | #06EA-#06ED | #0901-#0903 | #093E-#094C | #094D-#094D | #0951-#0954 | #0962-#0963 | #0981-#0983 | #09BC-#09BC | #09BE-#09BE | #09BF-#09BF | #09C0-#09C4 | #09C7-#09C8 | #09CB-#09CD | #09D7-#09D7 | #09E2-#09E3 | #0A02-#0A02 | #0A3C-#0A3C | #0A3E-#0A3E | #0A3F-#0A3F | #0A40-#0A42 | #0A47-#0A48 | #0A4B-#0A4D | #0A70-#0A71 | #0A81-#0A83 | #0ABC-#0ABC | #0ABE-#0AC5 | #0AC7-#0AC9 | #0ACB-#0ACB | #0ACC-#0ACC | #0B01-#0B03 | #0B3C-#0B3C | #0B3E-#0B43 | #0B47-#0B48 | #0B4B-#0B4C | #0B56-#0B57 | #0B82-#0B83 | #0BBE-#0BC2 | #0BC6-#0BC8 | #0BCA-#0BCC | #0BD7-#0BD7 | #0C01-#0C03 | #0C3E-#0C44 | #0C46-#0C48 | #0C4A-#0C4D | #0C55-#0C56 | #0C82-#0C83 | #0CBE-#0CC4 | #0CC6-#0CC8 | #0CCA-#0CCC | #0CD5-#0CD6 | #0D02-#0D03 | #0D3E-#0D43 | #0D46-#0D48 | #0D4A-#0D4C | #0D57-#0D57 | #0E31-#0E31 | #0E34-#0E3A | #0E47-#0E4E | #0EB1-#0EB1 | #0EB4-#0EB9 | #0EBB-#0EBC | #0EC8-#0ECD | #0F18-#0F19 | #0F35-#0F35 | #0F37-#0F37 | #0F39-#0F39 | #0F3E-#0F3E | #0F3F-#0F3F | #0F71-#0F84 | #0F86-#0F8B | #0F90-#0F95 | #0F97-#0F97 | #0F99-#0FAD | #0FB1-#0FB7 | #0FB9-#0FB9 | #20D0-#20DC | #20E1-#20E1 | #302A-#302F | #3099-#3099 | #309A-#309A | #FB1E-#FB1E | #FE20-#FE23;
	*/
	bool parse_CombiningChar(){
		debug Stdout("parse_CombiningChar").newline;
		auto __astNode = createASTNode("CombiningChar");
		// OrGroup pass0
			// CharRange
			if(match(0x0300,0x0361)){
				goto pass0;
			}
		term2:
			// CharRange
			if(match(0x0483,0x0486)){
				goto pass0;
			}
		term3:
			// CharRange
			if(match(0x0591,0x05C4)){
				goto pass0;
			}
		term4:
			// CharRange
			if(match(0x064B,0x0652)){
				goto pass0;
			}
		term5:
			// CharRange
			if(match(0x0670)){
				goto pass0;
			}
		term6:
			// CharRange
			if(match(0x06D7,0x06DC)){
				goto pass0;
			}
		term7:
			// CharRange
			if(match(0x06DD,0x06DF)){
				goto pass0;
			}
		term8:
			// CharRange
			if(match(0x06E0,0x06E4)){
				goto pass0;
			}
		term9:
			// CharRange
			if(match(0x06E7,0x06E8)){
				goto pass0;
			}
		term10:
			// CharRange
			if(match(0x06EA,0x06ED)){
				goto pass0;
			}
		term11:
			// CharRange
			if(match(0x0901,0x0903)){
				goto pass0;
			}
		term12:
			// CharRange
			if(match(0x093E,0x094C)){
				goto pass0;
			}
		term13:
			// CharRange
			if(match(0x094D)){
				goto pass0;
			}
		term14:
			// CharRange
			if(match(0x0951,0x0954)){
				goto pass0;
			}
		term15:
			// CharRange
			if(match(0x0962,0x0963)){
				goto pass0;
			}
		term16:
			// CharRange
			if(match(0x0981,0x0983)){
				goto pass0;
			}
		term17:
			// CharRange
			if(match(0x09BC)){
				goto pass0;
			}
		term18:
			// CharRange
			if(match(0x09BE)){
				goto pass0;
			}
		term19:
			// CharRange
			if(match(0x09BF)){
				goto pass0;
			}
		term20:
			// CharRange
			if(match(0x09C0,0x09C4)){
				goto pass0;
			}
		term21:
			// CharRange
			if(match(0x09C7,0x09C8)){
				goto pass0;
			}
		term22:
			// CharRange
			if(match(0x09CB,0x09CD)){
				goto pass0;
			}
		term23:
			// CharRange
			if(match(0x09D7)){
				goto pass0;
			}
		term24:
			// CharRange
			if(match(0x09E2,0x09E3)){
				goto pass0;
			}
		term25:
			// CharRange
			if(match(0x0A02)){
				goto pass0;
			}
		term26:
			// CharRange
			if(match(0x0A3C)){
				goto pass0;
			}
		term27:
			// CharRange
			if(match(0x0A3E)){
				goto pass0;
			}
		term28:
			// CharRange
			if(match(0x0A3F)){
				goto pass0;
			}
		term29:
			// CharRange
			if(match(0x0A40,0x0A42)){
				goto pass0;
			}
		term30:
			// CharRange
			if(match(0x0A47,0x0A48)){
				goto pass0;
			}
		term31:
			// CharRange
			if(match(0x0A4B,0x0A4D)){
				goto pass0;
			}
		term32:
			// CharRange
			if(match(0x0A70,0x0A71)){
				goto pass0;
			}
		term33:
			// CharRange
			if(match(0x0A81,0x0A83)){
				goto pass0;
			}
		term34:
			// CharRange
			if(match(0x0ABC)){
				goto pass0;
			}
		term35:
			// CharRange
			if(match(0x0ABE,0x0AC5)){
				goto pass0;
			}
		term36:
			// CharRange
			if(match(0x0AC7,0x0AC9)){
				goto pass0;
			}
		term37:
			// CharRange
			if(match(0x0ACB)){
				goto pass0;
			}
		term38:
			// CharRange
			if(match(0x0ACC)){
				goto pass0;
			}
		term39:
			// CharRange
			if(match(0x0B01,0x0B03)){
				goto pass0;
			}
		term40:
			// CharRange
			if(match(0x0B3C)){
				goto pass0;
			}
		term41:
			// CharRange
			if(match(0x0B3E,0x0B43)){
				goto pass0;
			}
		term42:
			// CharRange
			if(match(0x0B47,0x0B48)){
				goto pass0;
			}
		term43:
			// CharRange
			if(match(0x0B4B,0x0B4C)){
				goto pass0;
			}
		term44:
			// CharRange
			if(match(0x0B56,0x0B57)){
				goto pass0;
			}
		term45:
			// CharRange
			if(match(0x0B82,0x0B83)){
				goto pass0;
			}
		term46:
			// CharRange
			if(match(0x0BBE,0x0BC2)){
				goto pass0;
			}
		term47:
			// CharRange
			if(match(0x0BC6,0x0BC8)){
				goto pass0;
			}
		term48:
			// CharRange
			if(match(0x0BCA,0x0BCC)){
				goto pass0;
			}
		term49:
			// CharRange
			if(match(0x0BD7)){
				goto pass0;
			}
		term50:
			// CharRange
			if(match(0x0C01,0x0C03)){
				goto pass0;
			}
		term51:
			// CharRange
			if(match(0x0C3E,0x0C44)){
				goto pass0;
			}
		term52:
			// CharRange
			if(match(0x0C46,0x0C48)){
				goto pass0;
			}
		term53:
			// CharRange
			if(match(0x0C4A,0x0C4D)){
				goto pass0;
			}
		term54:
			// CharRange
			if(match(0x0C55,0x0C56)){
				goto pass0;
			}
		term55:
			// CharRange
			if(match(0x0C82,0x0C83)){
				goto pass0;
			}
		term56:
			// CharRange
			if(match(0x0CBE,0x0CC4)){
				goto pass0;
			}
		term57:
			// CharRange
			if(match(0x0CC6,0x0CC8)){
				goto pass0;
			}
		term58:
			// CharRange
			if(match(0x0CCA,0x0CCC)){
				goto pass0;
			}
		term59:
			// CharRange
			if(match(0x0CD5,0x0CD6)){
				goto pass0;
			}
		term60:
			// CharRange
			if(match(0x0D02,0x0D03)){
				goto pass0;
			}
		term61:
			// CharRange
			if(match(0x0D3E,0x0D43)){
				goto pass0;
			}
		term62:
			// CharRange
			if(match(0x0D46,0x0D48)){
				goto pass0;
			}
		term63:
			// CharRange
			if(match(0x0D4A,0x0D4C)){
				goto pass0;
			}
		term64:
			// CharRange
			if(match(0x0D57)){
				goto pass0;
			}
		term65:
			// CharRange
			if(match(0x0E31)){
				goto pass0;
			}
		term66:
			// CharRange
			if(match(0x0E34,0x0E3A)){
				goto pass0;
			}
		term67:
			// CharRange
			if(match(0x0E47,0x0E4E)){
				goto pass0;
			}
		term68:
			// CharRange
			if(match(0x0EB1)){
				goto pass0;
			}
		term69:
			// CharRange
			if(match(0x0EB4,0x0EB9)){
				goto pass0;
			}
		term70:
			// CharRange
			if(match(0x0EBB,0x0EBC)){
				goto pass0;
			}
		term71:
			// CharRange
			if(match(0x0EC8,0x0ECD)){
				goto pass0;
			}
		term72:
			// CharRange
			if(match(0x0F18,0x0F19)){
				goto pass0;
			}
		term73:
			// CharRange
			if(match(0x0F35)){
				goto pass0;
			}
		term74:
			// CharRange
			if(match(0x0F37)){
				goto pass0;
			}
		term75:
			// CharRange
			if(match(0x0F39)){
				goto pass0;
			}
		term76:
			// CharRange
			if(match(0x0F3E)){
				goto pass0;
			}
		term77:
			// CharRange
			if(match(0x0F3F)){
				goto pass0;
			}
		term78:
			// CharRange
			if(match(0x0F71,0x0F84)){
				goto pass0;
			}
		term79:
			// CharRange
			if(match(0x0F86,0x0F8B)){
				goto pass0;
			}
		term80:
			// CharRange
			if(match(0x0F90,0x0F95)){
				goto pass0;
			}
		term81:
			// CharRange
			if(match(0x0F97)){
				goto pass0;
			}
		term82:
			// CharRange
			if(match(0x0F99,0x0FAD)){
				goto pass0;
			}
		term83:
			// CharRange
			if(match(0x0FB1,0x0FB7)){
				goto pass0;
			}
		term84:
			// CharRange
			if(match(0x0FB9)){
				goto pass0;
			}
		term85:
			// CharRange
			if(match(0x20D0,0x20DC)){
				goto pass0;
			}
		term86:
			// CharRange
			if(match(0x20E1)){
				goto pass0;
			}
		term87:
			// CharRange
			if(match(0x302A,0x302F)){
				goto pass0;
			}
		term88:
			// CharRange
			if(match(0x3099)){
				goto pass0;
			}
		term89:
			// CharRange
			if(match(0x309A)){
				goto pass0;
			}
		term90:
			// CharRange
			if(match(0xFB1E)){
				goto pass0;
			}
		term91:
			// CharRange
			if(!match(0xFE20,0xFE23)){
				goto fail1;
			}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_CombiningChar failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	Letter
		::= (BaseChar CombiningChar*) | Ideographic;
	*/
	bool parse_Letter(){
		debug Stdout("parse_Letter").newline;
		auto __astNode = createASTNode("Letter");
		// OrGroup pass0
			// AndGroup
				auto position4 = getPos();
					// Production
					if(!parse_BaseChar()){
						goto fail5;
					}
					addASTChild(__astNode,"BaseChar",getASTResult());
				term6:
					// Iterator
					start7:
						// (terminator)
						if(!hasMore()){
							goto end8;
						}
						// (expression)
						expr9:
							// Production
							if(!parse_CombiningChar()){
								goto end8;
							}
							addASTChild(__astNode,"CombiningChar",getASTResult());
						goto start7;
					end8:
						goto pass0;
				fail5:
				setPos(position4);
		term2:
			// Production
			if(!parse_Ideographic()){
				goto fail1;
			}
			addASTChild(__astNode,"Ideographic",getASTResult());
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_Letter failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	Digit
		::= #30-#39 | #0660-#0669 | #06F0-#06F9 | #0966-#096F | #09E6-#09EF | #0A66-#0A6F | #0AE6-#0AEF | #0B66-#0B6F | #0BE7-#0BEF | #0C66-#0C6F | #0CE6-#0CEF | #0D66-#0D6F | #0E50-#0E59 | #0ED0-#0ED9 | #0F20-#0F29 | #FF10-#FF19;
	*/
	bool parse_Digit(){
		debug Stdout("parse_Digit").newline;
		auto __astNode = createASTNode("Digit");
		// OrGroup pass0
			// CharRange
			if(match(0x30,0x39)){
				goto pass0;
			}
		term2:
			// CharRange
			if(match(0x0660,0x0669)){
				goto pass0;
			}
		term3:
			// CharRange
			if(match(0x06F0,0x06F9)){
				goto pass0;
			}
		term4:
			// CharRange
			if(match(0x0966,0x096F)){
				goto pass0;
			}
		term5:
			// CharRange
			if(match(0x09E6,0x09EF)){
				goto pass0;
			}
		term6:
			// CharRange
			if(match(0x0A66,0x0A6F)){
				goto pass0;
			}
		term7:
			// CharRange
			if(match(0x0AE6,0x0AEF)){
				goto pass0;
			}
		term8:
			// CharRange
			if(match(0x0B66,0x0B6F)){
				goto pass0;
			}
		term9:
			// CharRange
			if(match(0x0BE7,0x0BEF)){
				goto pass0;
			}
		term10:
			// CharRange
			if(match(0x0C66,0x0C6F)){
				goto pass0;
			}
		term11:
			// CharRange
			if(match(0x0CE6,0x0CEF)){
				goto pass0;
			}
		term12:
			// CharRange
			if(match(0x0D66,0x0D6F)){
				goto pass0;
			}
		term13:
			// CharRange
			if(match(0x0E50,0x0E59)){
				goto pass0;
			}
		term14:
			// CharRange
			if(match(0x0ED0,0x0ED9)){
				goto pass0;
			}
		term15:
			// CharRange
			if(match(0x0F20,0x0F29)){
				goto pass0;
			}
		term16:
			// CharRange
			if(!match(0xFF10,0xFF19)){
				goto fail1;
			}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_Digit failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	Ignorable
		::= #200C-#200F | #202A-#202E | #206A-#206F | #FEFF-#FEFF;
	*/
	bool parse_Ignorable(){
		debug Stdout("parse_Ignorable").newline;
		auto __astNode = createASTNode("Ignorable");
		// OrGroup pass0
			// CharRange
			if(match(0x200C,0x200F)){
				goto pass0;
			}
		term2:
			// CharRange
			if(match(0x202A,0x202E)){
				goto pass0;
			}
		term3:
			// CharRange
			if(match(0x206A,0x206F)){
				goto pass0;
			}
		term4:
			// CharRange
			if(!match(0xFEFF)){
				goto fail1;
			}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_Ignorable failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	Extender
		::= #B7-#B7 | #02D0-#02D0 | #02D1-#02D1 | #0387-#0387 | #0640-#0640 | #0E46-#0E46 | #0EC6-#0EC6 | #3005-#3005 | #3031-#3035 | #309B-#309E | #30FC-#30FE | #FF70-#FF70 | #FF9E-#FF9E | #FF9F-#FF9F;
	*/
	bool parse_Extender(){
		debug Stdout("parse_Extender").newline;
		auto __astNode = createASTNode("Extender");
		// OrGroup pass0
			// CharRange
			if(match(0xB7)){
				goto pass0;
			}
		term2:
			// CharRange
			if(match(0x02D0)){
				goto pass0;
			}
		term3:
			// CharRange
			if(match(0x02D1)){
				goto pass0;
			}
		term4:
			// CharRange
			if(match(0x0387)){
				goto pass0;
			}
		term5:
			// CharRange
			if(match(0x0640)){
				goto pass0;
			}
		term6:
			// CharRange
			if(match(0x0E46)){
				goto pass0;
			}
		term7:
			// CharRange
			if(match(0x0EC6)){
				goto pass0;
			}
		term8:
			// CharRange
			if(match(0x3005)){
				goto pass0;
			}
		term9:
			// CharRange
			if(match(0x3031,0x3035)){
				goto pass0;
			}
		term10:
			// CharRange
			if(match(0x309B,0x309E)){
				goto pass0;
			}
		term11:
			// CharRange
			if(match(0x30FC,0x30FE)){
				goto pass0;
			}
		term12:
			// CharRange
			if(match(0xFF70)){
				goto pass0;
			}
		term13:
			// CharRange
			if(match(0xFF9E)){
				goto pass0;
			}
		term14:
			// CharRange
			if(!match(0xFF9F)){
				goto fail1;
			}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_Extender failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	MiscName
		::= "." | Ignorable | Extender;
	*/
	bool parse_MiscName(){
		debug Stdout("parse_MiscName").newline;
		auto __astNode = createASTNode("MiscName");
		// OrGroup pass0
			// Terminal
			if(match(".")){
				goto pass0;
			}
		term2:
			// Production
			if(parse_Ignorable()){
				addASTChild(__astNode,"Ignorable",getASTResult());
				goto pass0;
			}
		term3:
			// Production
			if(!parse_Extender()){
				goto fail1;
			}
			addASTChild(__astNode,"Extender",getASTResult());
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_MiscName failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	NameChar
		::= Letter | Digit | MiscName;
	*/
	bool parse_NameChar(){
		debug Stdout("parse_NameChar").newline;
		auto __astNode = createASTNode("NameChar");
		// OrGroup pass0
			// Production
			if(parse_Letter()){
				addASTChild(__astNode,"Letter",getASTResult());
				goto pass0;
			}
		term2:
			// Production
			if(parse_Digit()){
				addASTChild(__astNode,"Digit",getASTResult());
				goto pass0;
			}
		term3:
			// Production
			if(!parse_MiscName()){
				goto fail1;
			}
			addASTChild(__astNode,"MiscName",getASTResult());
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_NameChar failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	Name
		::= (Letter | "-") (NameChar)*;
	*/
	bool parse_Name(){
		debug Stdout("parse_Name").newline;
		auto __astNode = createASTNode("Name");
		// AndGroup
			auto position3 = getPos();
				// OrGroup term5
					// Production
					if(parse_Letter()){
						addASTChild(__astNode,"Letter",getASTResult());
						goto term5;
					}
				term6:
					// Terminal
					if(!match("-")){
						goto fail4;
					}
			term5:
				// Iterator
				start7:
					// (terminator)
					if(!hasMore()){
						goto end8;
					}
					// (expression)
					expr9:
						// Production
						if(!parse_NameChar()){
							goto end8;
						}
						addASTChild(__astNode,"NameChar",getASTResult());
					goto start7;
				end8:
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_Name failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	Nmtoken
		::= (NameChar)+;
	*/
	bool parse_Nmtoken(){
		debug Stdout("parse_Nmtoken").newline;
		auto __astNode = createASTNode("Nmtoken");
		// Iterator
		size_t counter5 = 0;
		start2:
			// (terminator)
			if(!hasMore()){
				goto end3;
			}
			// (expression)
			expr4:
				// Production
				if(!parse_NameChar()){
					goto end3;
				}
				addASTChild(__astNode,"NameChar",getASTResult());
			increment6:
			// (increment expr count)
				counter5 ++;
			goto start2;
		end3:
			// (range test)
				if(!((counter5 >= 1))){
					goto fail1;
					goto pass0;
				}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_Nmtoken failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	Nmtokens
		::= Nmtoken (S Nmtoken)*;
	*/
	bool parse_Nmtokens(){
		debug Stdout("parse_Nmtokens").newline;
		auto __astNode = createASTNode("Nmtokens");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_Nmtoken()){
					goto fail4;
				}
				addASTChild(__astNode,"Nmtoken",getASTResult());
			term5:
				// Iterator
				start6:
					// (terminator)
					if(!hasMore()){
						goto end7;
					}
					// (expression)
					expr8:
						// AndGroup
							auto position10 = getPos();
								// Production
								if(!parse_S()){
									goto fail11;
								}
								addASTChild(__astNode,"S",getASTResult());
							term12:
								// Production
								if(parse_Nmtoken()){
									addASTChild(__astNode,"Nmtoken",getASTResult());
									goto start6;
								}
							fail11:
							setPos(position10);
							goto end7;
					goto start6;
				end7:
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_Nmtokens failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	Literal
		::= "\"" (PEReference | CharRef)* "\"" | "\'" (PEReference | CharRef)* "\'";
	*/
	bool parse_Literal(){
		debug Stdout("parse_Literal").newline;
		auto __astNode = createASTNode("Literal");
		// OrGroup pass0
			// AndGroup
				auto position4 = getPos();
					// Terminal
					if(!match("\"")){
						goto fail5;
					}
				term6:
					// Iterator
					start7:
						// (terminator)
							// Terminal
							if(match("\"")){
								goto end8;
							}
						// (expression)
						expr9:
							// OrGroup start7
								// Production
								if(parse_PEReference()){
									addASTChild(__astNode,"PEReference",getASTResult());
									goto start7;
								}
							term10:
								// Production
								if(!parse_CharRef()){
									goto fail5;
								}
								addASTChild(__astNode,"CharRef",getASTResult());
						goto start7;
					end8:
						goto pass0;
				fail5:
				setPos(position4);
		term2:
			// AndGroup
				auto position12 = getPos();
					// Terminal
					if(!match("\'")){
						goto fail13;
					}
				term14:
					// Iterator
					start15:
						// (terminator)
							// Terminal
							if(match("\'")){
								goto end16;
							}
						// (expression)
						expr17:
							// OrGroup start15
								// Production
								if(parse_PEReference()){
									addASTChild(__astNode,"PEReference",getASTResult());
									goto start15;
								}
							term18:
								// Production
								if(!parse_CharRef()){
									goto fail13;
								}
								addASTChild(__astNode,"CharRef",getASTResult());
						goto start15;
					end16:
						goto pass0;
				fail13:
				setPos(position12);
				goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_Literal failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	QuotedCData
		::= "\"" (Reference | any)* "\"" | "\'" (Reference | any)* "\'";
	*/
	bool parse_QuotedCData(){
		debug Stdout("parse_QuotedCData").newline;
		auto __astNode = createASTNode("QuotedCData");
		// OrGroup pass0
			// AndGroup
				auto position4 = getPos();
					// Terminal
					if(!match("\"")){
						goto fail5;
					}
				term6:
					// Iterator
					start7:
						// (terminator)
							// Terminal
							if(match("\"")){
								goto end8;
							}
						// (expression)
						expr9:
							// OrGroup start7
								// Production
								if(parse_Reference()){
									addASTChild(__astNode,"Reference",getASTResult());
									goto start7;
								}
							term10:
								// Production
								if(!parse_any()){
									goto fail5;
								}
								addASTChild(__astNode,"any",getASTResult());
						goto start7;
					end8:
						goto pass0;
				fail5:
				setPos(position4);
		term2:
			// AndGroup
				auto position12 = getPos();
					// Terminal
					if(!match("\'")){
						goto fail13;
					}
				term14:
					// Iterator
					start15:
						// (terminator)
							// Terminal
							if(match("\'")){
								goto end16;
							}
						// (expression)
						expr17:
							// OrGroup start15
								// Production
								if(parse_Reference()){
									addASTChild(__astNode,"Reference",getASTResult());
									goto start15;
								}
							term18:
								// Production
								if(!parse_any()){
									goto fail13;
								}
								addASTChild(__astNode,"any",getASTResult());
						goto start15;
					end16:
						goto pass0;
				fail13:
				setPos(position12);
				goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_QuotedCData failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	Eq
		::= S? "=" S?;
	*/
	bool parse_Eq(){
		debug Stdout("parse_Eq").newline;
		auto __astNode = createASTNode("Eq");
		// AndGroup
			auto position3 = getPos();
				// Iterator (optional alias special case)
					// (expression)
					// Production
					if(!parse_S()){
						goto term6;
					}
					addASTChild(__astNode,"S",getASTResult());
					// (terminator)
					term6:
					// Terminal
					if(!match("=")){
						goto fail4;
					}
			term5:
				// Iterator (optional alias special case)
					// (expression)
					// Production
					if(parse_S()){
						addASTChild(__astNode,"S",getASTResult());
						goto pass0;
					}
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_Eq failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	PCData
		::= (!("<" | "&"))+;
	*/
	bool parse_PCData(){
		debug Stdout("parse_PCData").newline;
		auto __astNode = createASTNode("PCData");
		// Iterator
		size_t counter5 = 0;
		start2:
			// (terminator)
			if(!hasMore()){
				goto end3;
			}
			// (expression)
			expr4:
				// Negate
					// (test expr)
					auto position9 = getPos();
					// OrGroup fail8
						// Terminal
						if(match("<")){
							goto fail8;
						}
					term10:
						// Terminal
						if(!match("&")){
							goto term7;
						}
					fail8:
					setPos(position9);
					goto end3;
					term7:
					parse_any();
			increment6:
			// (increment expr count)
				counter5 ++;
			goto start2;
		end3:
			// (range test)
				if(!((counter5 >= 1))){
					goto fail1;
					goto pass0;
				}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_PCData failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	Comment
		::= "<!--" (!"-")* "-->";
	*/
	bool parse_Comment(){
		debug Stdout("parse_Comment").newline;
		auto __astNode = createASTNode("Comment");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("<!--")){
					goto fail4;
				}
			term5:
				// Iterator
				start6:
					// (terminator)
						// Terminal
						if(match("-->")){
							goto end7;
						}
					// (expression)
					expr8:
						// Negate
							// (test expr)
							auto position11 = getPos();
							// Terminal
							if(!match("-")){
								goto term9;
							}
							fail10:
							setPos(position11);
							goto fail4;
							term9:
							parse_any();
					goto start6;
				end7:
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_Comment failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	PI
		::= "<?" Name S (!"?")* "?>";
	*/
	bool parse_PI(){
		debug Stdout("parse_PI").newline;
		auto __astNode = createASTNode("PI");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("<?")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_Name()){
					goto fail4;
				}
				addASTChild(__astNode,"Name",getASTResult());
			term6:
				// Production
				if(!parse_S()){
					goto fail4;
				}
				addASTChild(__astNode,"S",getASTResult());
			term7:
				// Iterator
				start8:
					// (terminator)
						// Terminal
						if(match("?>")){
							goto end9;
						}
					// (expression)
					expr10:
						// Negate
							// (test expr)
							auto position13 = getPos();
							// Terminal
							if(!match("?")){
								goto term11;
							}
							fail12:
							setPos(position13);
							goto fail4;
							term11:
							parse_any();
					goto start8;
				end9:
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_PI failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	CDSect
		::= CDStart CData CDEnd;
	*/
	bool parse_CDSect(){
		debug Stdout("parse_CDSect").newline;
		auto __astNode = createASTNode("CDSect");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_CDStart()){
					goto fail4;
				}
				addASTChild(__astNode,"CDStart",getASTResult());
			term5:
				// Production
				if(!parse_CData()){
					goto fail4;
				}
				addASTChild(__astNode,"CData",getASTResult());
			term6:
				// Production
				if(parse_CDEnd()){
					addASTChild(__astNode,"CDEnd",getASTResult());
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_CDSect failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	CDStart
		::= "<![CDATA[";
	*/
	bool parse_CDStart(){
		debug Stdout("parse_CDStart").newline;
		auto __astNode = createASTNode("CDStart");
		// Terminal
		if(!match("<![CDATA[")){
			goto fail1;
		}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_CDStart failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	CData
		::= (!"]]")*;
	*/
	bool parse_CData(){
		debug Stdout("parse_CData").newline;
		auto __astNode = createASTNode("CData");
		// Iterator
		start2:
			// (terminator)
			if(!hasMore()){
				goto end3;
			}
			// (expression)
			expr4:
				// Negate
					// (test expr)
					auto position7 = getPos();
					// Terminal
					if(!match("]]")){
						goto term5;
					}
					fail6:
					setPos(position7);
					goto end3;
					term5:
					parse_any();
			goto start2;
		end3:
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_CData failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	CDEnd
		::= "]]>";
	*/
	bool parse_CDEnd(){
		debug Stdout("parse_CDEnd").newline;
		auto __astNode = createASTNode("CDEnd");
		// Terminal
		if(!match("]]>")){
			goto fail1;
		}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_CDEnd failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	document
		::= Prolog element Misc*;
	*/
	bool parse_document(){
		debug Stdout("parse_document").newline;
		auto __astNode = createASTNode("document");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_Prolog()){
					goto fail4;
				}
				addASTChild(__astNode,"Prolog",getASTResult());
			term5:
				// Production
				if(!parse_element()){
					goto fail4;
				}
				addASTChild(__astNode,"element",getASTResult());
			term6:
				// Iterator
				start7:
					// (terminator)
					if(!hasMore()){
						goto end8;
					}
					// (expression)
					expr9:
						// Production
						if(!parse_Misc()){
							goto end8;
						}
						addASTChild(__astNode,"Misc",getASTResult());
					goto start7;
				end8:
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_document failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	Prolog
		::= XMLDecl Misc* doctypedecl? Misc*;
	*/
	bool parse_Prolog(){
		debug Stdout("parse_Prolog").newline;
		auto __astNode = createASTNode("Prolog");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_XMLDecl()){
					goto fail4;
				}
				addASTChild(__astNode,"XMLDecl",getASTResult());
			term5:
				// Iterator
				start6:
					// (terminator)
					if(!hasMore()){
						goto end7;
					}
					// (expression)
					expr8:
						// Production
						if(!parse_Misc()){
							goto end7;
						}
						addASTChild(__astNode,"Misc",getASTResult());
					goto start6;
				end7:
					// Iterator (optional alias special case)
						// (expression)
						// Production
						if(!parse_doctypedecl()){
							goto term9;
						}
						addASTChild(__astNode,"doctypedecl",getASTResult());
						// (terminator)
						term9:
						// Iterator
						start10:
							// (terminator)
							if(!hasMore()){
								goto end11;
							}
							// (expression)
							expr12:
								// Production
								if(!parse_Misc()){
									goto end11;
								}
								addASTChild(__astNode,"Misc",getASTResult());
							goto start10;
						end11:
							goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_Prolog failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	XMLDecl
		::= "<?XML" VersionInfo EncodingDecl? RMDecl? S? "?>";
	*/
	bool parse_XMLDecl(){
		debug Stdout("parse_XMLDecl").newline;
		auto __astNode = createASTNode("XMLDecl");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("<?XML")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_VersionInfo()){
					goto fail4;
				}
				addASTChild(__astNode,"VersionInfo",getASTResult());
			term6:
				// Iterator (optional alias special case)
					// (expression)
					// Production
					if(!parse_EncodingDecl()){
						goto term7;
					}
					addASTChild(__astNode,"EncodingDecl",getASTResult());
					// (terminator)
					term7:
					// Iterator (optional alias special case)
						// (expression)
						// Production
						if(!parse_RMDecl()){
							goto term8;
						}
						addASTChild(__astNode,"RMDecl",getASTResult());
						// (terminator)
						term8:
						// Iterator (optional alias special case)
							// (expression)
							// Production
							if(!parse_S()){
								goto term9;
							}
							addASTChild(__astNode,"S",getASTResult());
							// (terminator)
							term9:
							// Terminal
							if(match("?>")){
								goto pass0;
							}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_XMLDecl failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	VersionInfo
		::= S "version" Eq ("\"1.0\"" | "\'1.0\'");
	*/
	bool parse_VersionInfo(){
		debug Stdout("parse_VersionInfo").newline;
		auto __astNode = createASTNode("VersionInfo");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_S()){
					goto fail4;
				}
				addASTChild(__astNode,"S",getASTResult());
			term5:
				// Terminal
				if(!match("version")){
					goto fail4;
				}
			term6:
				// Production
				if(!parse_Eq()){
					goto fail4;
				}
				addASTChild(__astNode,"Eq",getASTResult());
			term7:
				// OrGroup pass0
					// Terminal
					if(match("\"1.0\"")){
						goto pass0;
					}
				term8:
					// Terminal
					if(match("\'1.0\'")){
						goto pass0;
					}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_VersionInfo failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	Misc
		::= Comment | PI | S;
	*/
	bool parse_Misc(){
		debug Stdout("parse_Misc").newline;
		auto __astNode = createASTNode("Misc");
		// OrGroup pass0
			// Production
			if(parse_Comment()){
				addASTChild(__astNode,"Comment",getASTResult());
				goto pass0;
			}
		term2:
			// Production
			if(parse_PI()){
				addASTChild(__astNode,"PI",getASTResult());
				goto pass0;
			}
		term3:
			// Production
			if(!parse_S()){
				goto fail1;
			}
			addASTChild(__astNode,"S",getASTResult());
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_Misc failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	doctypedecl
		::= "<!DOCTYPE" S Name (S ExternalID)? S? ("[" internalsubset* "]" S?)? ">";
	*/
	bool parse_doctypedecl(){
		debug Stdout("parse_doctypedecl").newline;
		auto __astNode = createASTNode("doctypedecl");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("<!DOCTYPE")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_S()){
					goto fail4;
				}
				addASTChild(__astNode,"S",getASTResult());
			term6:
				// Production
				if(!parse_Name()){
					goto fail4;
				}
				addASTChild(__astNode,"Name",getASTResult());
			term7:
				// Iterator (optional alias special case)
					// (expression)
					// AndGroup
						auto position10 = getPos();
							// Production
							if(!parse_S()){
								goto fail11;
							}
							addASTChild(__astNode,"S",getASTResult());
						term12:
							// Production
							if(parse_ExternalID()){
								addASTChild(__astNode,"ExternalID",getASTResult());
								goto term8;
							}
						fail11:
						setPos(position10);
						goto term8;
					// (terminator)
					term8:
					// Iterator (optional alias special case)
						// (expression)
						// Production
						if(!parse_S()){
							goto term13;
						}
						addASTChild(__astNode,"S",getASTResult());
						// (terminator)
						term13:
						// Iterator (optional alias special case)
							// (expression)
							// AndGroup
								auto position16 = getPos();
									// Terminal
									if(!match("[")){
										goto fail17;
									}
								term18:
									// Iterator
									start20:
										// (terminator)
											// Terminal
											if(match("]")){
												goto end21;
											}
										// (expression)
										expr22:
											// Production
											if(!parse_internalsubset()){
												goto fail17;
											}
											addASTChild(__astNode,"internalsubset",getASTResult());
										goto start20;
									end21:
								term19:
									// Iterator (optional alias special case)
										// (expression)
										// Production
										if(parse_S()){
											addASTChild(__astNode,"S",getASTResult());
											goto term14;
										}
										goto term14;
								fail17:
								setPos(position16);
								goto term14;
							// (terminator)
							term14:
							// Terminal
							if(match(">")){
								goto pass0;
							}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_doctypedecl failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	internalsubset
		::= elementdecl | AttlistDecl | EntityDecl | NotationDecl | PEReference | conditionalSect | PI | S | Comment;
	*/
	bool parse_internalsubset(){
		debug Stdout("parse_internalsubset").newline;
		auto __astNode = createASTNode("internalsubset");
		// OrGroup pass0
			// Production
			if(parse_elementdecl()){
				addASTChild(__astNode,"elementdecl",getASTResult());
				goto pass0;
			}
		term2:
			// Production
			if(parse_AttlistDecl()){
				addASTChild(__astNode,"AttlistDecl",getASTResult());
				goto pass0;
			}
		term3:
			// Production
			if(parse_EntityDecl()){
				addASTChild(__astNode,"EntityDecl",getASTResult());
				goto pass0;
			}
		term4:
			// Production
			if(parse_NotationDecl()){
				addASTChild(__astNode,"NotationDecl",getASTResult());
				goto pass0;
			}
		term5:
			// Production
			if(parse_PEReference()){
				addASTChild(__astNode,"PEReference",getASTResult());
				goto pass0;
			}
		term6:
			// Production
			if(parse_conditionalSect()){
				addASTChild(__astNode,"conditionalSect",getASTResult());
				goto pass0;
			}
		term7:
			// Production
			if(parse_PI()){
				addASTChild(__astNode,"PI",getASTResult());
				goto pass0;
			}
		term8:
			// Production
			if(parse_S()){
				addASTChild(__astNode,"S",getASTResult());
				goto pass0;
			}
		term9:
			// Production
			if(!parse_Comment()){
				goto fail1;
			}
			addASTChild(__astNode,"Comment",getASTResult());
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_internalsubset failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	RMDecl
		::= "RMD" Eq ("NONE" | "INTERNAL" | "ALL");
	*/
	bool parse_RMDecl(){
		debug Stdout("parse_RMDecl").newline;
		auto __astNode = createASTNode("RMDecl");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("RMD")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_Eq()){
					goto fail4;
				}
				addASTChild(__astNode,"Eq",getASTResult());
			term6:
				// OrGroup pass0
					// Terminal
					if(match("NONE")){
						goto pass0;
					}
				term7:
					// Terminal
					if(match("INTERNAL")){
						goto pass0;
					}
				term8:
					// Terminal
					if(match("ALL")){
						goto pass0;
					}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_RMDecl failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	STag
		::= "<" Name (S Attribute)* S? ">";
	*/
	bool parse_STag(){
		debug Stdout("parse_STag").newline;
		auto __astNode = createASTNode("STag");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("<")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_Name()){
					goto fail4;
				}
				addASTChild(__astNode,"Name",getASTResult());
			term6:
				// Iterator
				start7:
					// (terminator)
					if(!hasMore()){
						goto end8;
					}
					// (expression)
					expr9:
						// AndGroup
							auto position11 = getPos();
								// Production
								if(!parse_S()){
									goto fail12;
								}
								addASTChild(__astNode,"S",getASTResult());
							term13:
								// Production
								if(parse_Attribute()){
									addASTChild(__astNode,"Attribute",getASTResult());
									goto start7;
								}
							fail12:
							setPos(position11);
							goto end8;
					goto start7;
				end8:
					// Iterator (optional alias special case)
						// (expression)
						// Production
						if(!parse_S()){
							goto term14;
						}
						addASTChild(__astNode,"S",getASTResult());
						// (terminator)
						term14:
						// Terminal
						if(match(">")){
							goto pass0;
						}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_STag failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	Attribute
		::= Name Eq QuotedCData;
	*/
	bool parse_Attribute(){
		debug Stdout("parse_Attribute").newline;
		auto __astNode = createASTNode("Attribute");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_Name()){
					goto fail4;
				}
				addASTChild(__astNode,"Name",getASTResult());
			term5:
				// Production
				if(!parse_Eq()){
					goto fail4;
				}
				addASTChild(__astNode,"Eq",getASTResult());
			term6:
				// Production
				if(parse_QuotedCData()){
					addASTChild(__astNode,"QuotedCData",getASTResult());
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_Attribute failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	ETag
		::= "</" Name S? ">";
	*/
	bool parse_ETag(){
		debug Stdout("parse_ETag").newline;
		auto __astNode = createASTNode("ETag");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("</")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_Name()){
					goto fail4;
				}
				addASTChild(__astNode,"Name",getASTResult());
			term6:
				// Iterator (optional alias special case)
					// (expression)
					// Production
					if(!parse_S()){
						goto term7;
					}
					addASTChild(__astNode,"S",getASTResult());
					// (terminator)
					term7:
					// Terminal
					if(match(">")){
						goto pass0;
					}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_ETag failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	EmptyElement
		::= "<" Name (S Attribute)* S? "/>";
	*/
	bool parse_EmptyElement(){
		debug Stdout("parse_EmptyElement").newline;
		auto __astNode = createASTNode("EmptyElement");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("<")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_Name()){
					goto fail4;
				}
				addASTChild(__astNode,"Name",getASTResult());
			term6:
				// Iterator
				start7:
					// (terminator)
					if(!hasMore()){
						goto end8;
					}
					// (expression)
					expr9:
						// AndGroup
							auto position11 = getPos();
								// Production
								if(!parse_S()){
									goto fail12;
								}
								addASTChild(__astNode,"S",getASTResult());
							term13:
								// Production
								if(parse_Attribute()){
									addASTChild(__astNode,"Attribute",getASTResult());
									goto start7;
								}
							fail12:
							setPos(position11);
							goto end8;
					goto start7;
				end8:
					// Iterator (optional alias special case)
						// (expression)
						// Production
						if(!parse_S()){
							goto term14;
						}
						addASTChild(__astNode,"S",getASTResult());
						// (terminator)
						term14:
						// Terminal
						if(match("/>")){
							goto pass0;
						}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_EmptyElement failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	content
		::= (element | PCData | Reference | CDSect | PI | Comment)*;
	*/
	bool parse_content(){
		debug Stdout("parse_content").newline;
		auto __astNode = createASTNode("content");
		// Iterator
		start2:
			// (terminator)
			if(!hasMore()){
				goto end3;
			}
			// (expression)
			expr4:
				// OrGroup start2
					// Production
					if(parse_element()){
						addASTChild(__astNode,"element",getASTResult());
						goto start2;
					}
				term5:
					// Production
					if(parse_PCData()){
						addASTChild(__astNode,"PCData",getASTResult());
						goto start2;
					}
				term6:
					// Production
					if(parse_Reference()){
						addASTChild(__astNode,"Reference",getASTResult());
						goto start2;
					}
				term7:
					// Production
					if(parse_CDSect()){
						addASTChild(__astNode,"CDSect",getASTResult());
						goto start2;
					}
				term8:
					// Production
					if(parse_PI()){
						addASTChild(__astNode,"PI",getASTResult());
						goto start2;
					}
				term9:
					// Production
					if(!parse_Comment()){
						goto end3;
					}
					addASTChild(__astNode,"Comment",getASTResult());
			goto start2;
		end3:
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_content failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	element
		::= EmptyElement | STag content ETag;
	*/
	bool parse_element(){
		debug Stdout("parse_element").newline;
		auto __astNode = createASTNode("element");
		// OrGroup pass0
			// Production
			if(parse_EmptyElement()){
				addASTChild(__astNode,"EmptyElement",getASTResult());
				goto pass0;
			}
		term2:
			// AndGroup
				auto position4 = getPos();
					// Production
					if(!parse_STag()){
						goto fail5;
					}
					addASTChild(__astNode,"STag",getASTResult());
				term6:
					// Production
					if(!parse_content()){
						goto fail5;
					}
					addASTChild(__astNode,"content",getASTResult());
				term7:
					// Production
					if(parse_ETag()){
						addASTChild(__astNode,"ETag",getASTResult());
						goto pass0;
					}
				fail5:
				setPos(position4);
				goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_element failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	elementdecl
		::= "<!ELEMENT" S Name S ("EMPTY" | "ANY" | Mixed | elements) S? ">";
	*/
	bool parse_elementdecl(){
		debug Stdout("parse_elementdecl").newline;
		auto __astNode = createASTNode("elementdecl");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("<!ELEMENT")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_S()){
					goto fail4;
				}
				addASTChild(__astNode,"S",getASTResult());
			term6:
				// Production
				if(!parse_Name()){
					goto fail4;
				}
				addASTChild(__astNode,"Name",getASTResult());
			term7:
				// Production
				if(!parse_S()){
					goto fail4;
				}
				addASTChild(__astNode,"S",getASTResult());
			term8:
				// OrGroup term9
					// Terminal
					if(match("EMPTY")){
						goto term9;
					}
				term10:
					// Terminal
					if(match("ANY")){
						goto term9;
					}
				term11:
					// Production
					if(parse_Mixed()){
						addASTChild(__astNode,"Mixed",getASTResult());
						goto term9;
					}
				term12:
					// Production
					if(!parse_elements()){
						goto fail4;
					}
					addASTChild(__astNode,"elements",getASTResult());
			term9:
				// Iterator (optional alias special case)
					// (expression)
					// Production
					if(!parse_S()){
						goto term13;
					}
					addASTChild(__astNode,"S",getASTResult());
					// (terminator)
					term13:
					// Terminal
					if(match(">")){
						goto pass0;
					}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_elementdecl failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	Mixed
		::= "(" S? "#PCDATA" (S? "|" S? Name)* S? ")*" | "(" S? "#PCDATA" S? ")";
	*/
	bool parse_Mixed(){
		debug Stdout("parse_Mixed").newline;
		auto __astNode = createASTNode("Mixed");
		// OrGroup pass0
			// AndGroup
				auto position4 = getPos();
					// Terminal
					if(!match("(")){
						goto fail5;
					}
				term6:
					// Iterator (optional alias special case)
						// (expression)
						// Production
						if(!parse_S()){
							goto term8;
						}
						addASTChild(__astNode,"S",getASTResult());
						// (terminator)
						term8:
						// Terminal
						if(!match("#PCDATA")){
							goto fail5;
						}
				term7:
					// Iterator
					start9:
						// (terminator)
						if(!hasMore()){
							goto end10;
						}
						// (expression)
						expr11:
							// AndGroup
								auto position13 = getPos();
									// Iterator (optional alias special case)
										// (expression)
										// Production
										if(!parse_S()){
											goto term16;
										}
										addASTChild(__astNode,"S",getASTResult());
										// (terminator)
										term16:
										// Terminal
										if(!match("|")){
											goto fail14;
										}
								term15:
									// Iterator (optional alias special case)
										// (expression)
										// Production
										if(!parse_S()){
											goto term17;
										}
										addASTChild(__astNode,"S",getASTResult());
										// (terminator)
										term17:
										// Production
										if(parse_Name()){
											addASTChild(__astNode,"Name",getASTResult());
											goto start9;
										}
								fail14:
								setPos(position13);
								goto end10;
						goto start9;
					end10:
						// Iterator (optional alias special case)
							// (expression)
							// Production
							if(!parse_S()){
								goto term18;
							}
							addASTChild(__astNode,"S",getASTResult());
							// (terminator)
							term18:
							// Terminal
							if(match(")*")){
								goto pass0;
							}
				fail5:
				setPos(position4);
		term2:
			// AndGroup
				auto position20 = getPos();
					// Terminal
					if(!match("(")){
						goto fail21;
					}
				term22:
					// Iterator (optional alias special case)
						// (expression)
						// Production
						if(!parse_S()){
							goto term24;
						}
						addASTChild(__astNode,"S",getASTResult());
						// (terminator)
						term24:
						// Terminal
						if(!match("#PCDATA")){
							goto fail21;
						}
				term23:
					// Iterator (optional alias special case)
						// (expression)
						// Production
						if(!parse_S()){
							goto term25;
						}
						addASTChild(__astNode,"S",getASTResult());
						// (terminator)
						term25:
						// Terminal
						if(match(")")){
							goto pass0;
						}
				fail21:
				setPos(position20);
				goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_Mixed failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	elements
		::= (choice | seq) ("?" | "*" | "+")?;
	*/
	bool parse_elements(){
		debug Stdout("parse_elements").newline;
		auto __astNode = createASTNode("elements");
		// AndGroup
			auto position3 = getPos();
				// OrGroup term5
					// Production
					if(parse_choice()){
						addASTChild(__astNode,"choice",getASTResult());
						goto term5;
					}
				term6:
					// Production
					if(!parse_seq()){
						goto fail4;
					}
					addASTChild(__astNode,"seq",getASTResult());
			term5:
				// Iterator (optional alias special case)
					// (expression)
					// OrGroup pass0
						// Terminal
						if(match("?")){
							goto pass0;
						}
					term7:
						// Terminal
						if(match("*")){
							goto pass0;
						}
					term8:
						// Terminal
						if(match("+")){
							goto pass0;
						}
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_elements failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	cp
		::= (Name | choice | seq) ("?" | "*" | "+")?;
	*/
	bool parse_cp(){
		debug Stdout("parse_cp").newline;
		auto __astNode = createASTNode("cp");
		// AndGroup
			auto position3 = getPos();
				// OrGroup term5
					// Production
					if(parse_Name()){
						addASTChild(__astNode,"Name",getASTResult());
						goto term5;
					}
				term6:
					// Production
					if(parse_choice()){
						addASTChild(__astNode,"choice",getASTResult());
						goto term5;
					}
				term7:
					// Production
					if(!parse_seq()){
						goto fail4;
					}
					addASTChild(__astNode,"seq",getASTResult());
			term5:
				// Iterator (optional alias special case)
					// (expression)
					// OrGroup pass0
						// Terminal
						if(match("?")){
							goto pass0;
						}
					term8:
						// Terminal
						if(match("*")){
							goto pass0;
						}
					term9:
						// Terminal
						if(match("+")){
							goto pass0;
						}
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_cp failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	cps
		::= S? cp S?;
	*/
	bool parse_cps(){
		debug Stdout("parse_cps").newline;
		auto __astNode = createASTNode("cps");
		// AndGroup
			auto position3 = getPos();
				// Iterator (optional alias special case)
					// (expression)
					// Production
					if(!parse_S()){
						goto term6;
					}
					addASTChild(__astNode,"S",getASTResult());
					// (terminator)
					term6:
					// Production
					if(!parse_cp()){
						goto fail4;
					}
					addASTChild(__astNode,"cp",getASTResult());
			term5:
				// Iterator (optional alias special case)
					// (expression)
					// Production
					if(parse_S()){
						addASTChild(__astNode,"S",getASTResult());
						goto pass0;
					}
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_cps failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	choice
		::= "(" cps ("|" cps)+ ")";
	*/
	bool parse_choice(){
		debug Stdout("parse_choice").newline;
		auto __astNode = createASTNode("choice");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("(")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_cps()){
					goto fail4;
				}
				addASTChild(__astNode,"cps",getASTResult());
			term6:
				// Iterator
				size_t counter10 = 0;
				start7:
					// (terminator)
						// Terminal
						if(match(")")){
							goto end8;
						}
					// (expression)
					expr9:
						// AndGroup
							auto position13 = getPos();
								// Terminal
								if(!match("|")){
									goto fail14;
								}
							term15:
								// Production
								if(parse_cps()){
									addASTChild(__astNode,"cps",getASTResult());
									goto increment11;
								}
							fail14:
							setPos(position13);
							goto fail4;
					increment11:
					// (increment expr count)
						counter10 ++;
					goto start7;
				end8:
					// (range test)
						if(((counter10 >= 1))){
							goto pass0;
						}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_choice failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	seq
		::= "(" cps ("," cps)* ")";
	*/
	bool parse_seq(){
		debug Stdout("parse_seq").newline;
		auto __astNode = createASTNode("seq");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("(")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_cps()){
					goto fail4;
				}
				addASTChild(__astNode,"cps",getASTResult());
			term6:
				// Iterator
				start7:
					// (terminator)
						// Terminal
						if(match(")")){
							goto end8;
						}
					// (expression)
					expr9:
						// AndGroup
							auto position11 = getPos();
								// Terminal
								if(!match(",")){
									goto fail12;
								}
							term13:
								// Production
								if(parse_cps()){
									addASTChild(__astNode,"cps",getASTResult());
									goto start7;
								}
							fail12:
							setPos(position11);
							goto fail4;
					goto start7;
				end8:
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_seq failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	AttlistDecl
		::= "<!ATTLIST" S Name AttDef+ S? ">";
	*/
	bool parse_AttlistDecl(){
		debug Stdout("parse_AttlistDecl").newline;
		auto __astNode = createASTNode("AttlistDecl");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("<!ATTLIST")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_S()){
					goto fail4;
				}
				addASTChild(__astNode,"S",getASTResult());
			term6:
				// Production
				if(!parse_Name()){
					goto fail4;
				}
				addASTChild(__astNode,"Name",getASTResult());
			term7:
				// Iterator
				size_t counter11 = 0;
				start8:
					// (terminator)
					if(!hasMore()){
						goto end9;
					}
					// (expression)
					expr10:
						// Production
						if(!parse_AttDef()){
							goto end9;
						}
						addASTChild(__astNode,"AttDef",getASTResult());
					increment12:
					// (increment expr count)
						counter11 ++;
					goto start8;
				end9:
					// (range test)
						if(((counter11 >= 1))){
							// Iterator (optional alias special case)
								// (expression)
								// Production
								if(!parse_S()){
									goto term13;
								}
								addASTChild(__astNode,"S",getASTResult());
								// (terminator)
								term13:
								// Terminal
								if(match(">")){
									goto pass0;
								}
						}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_AttlistDecl failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	AttDef
		::= S Name S AttType S Default;
	*/
	bool parse_AttDef(){
		debug Stdout("parse_AttDef").newline;
		auto __astNode = createASTNode("AttDef");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_S()){
					goto fail4;
				}
				addASTChild(__astNode,"S",getASTResult());
			term5:
				// Production
				if(!parse_Name()){
					goto fail4;
				}
				addASTChild(__astNode,"Name",getASTResult());
			term6:
				// Production
				if(!parse_S()){
					goto fail4;
				}
				addASTChild(__astNode,"S",getASTResult());
			term7:
				// Production
				if(!parse_AttType()){
					goto fail4;
				}
				addASTChild(__astNode,"AttType",getASTResult());
			term8:
				// Production
				if(!parse_S()){
					goto fail4;
				}
				addASTChild(__astNode,"S",getASTResult());
			term9:
				// Production
				if(parse_Default()){
					addASTChild(__astNode,"Default",getASTResult());
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_AttDef failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	AttType
		::= StringType | TokenizedType | EnumeratedType;
	*/
	bool parse_AttType(){
		debug Stdout("parse_AttType").newline;
		auto __astNode = createASTNode("AttType");
		// OrGroup pass0
			// Production
			if(parse_StringType()){
				addASTChild(__astNode,"StringType",getASTResult());
				goto pass0;
			}
		term2:
			// Production
			if(parse_TokenizedType()){
				addASTChild(__astNode,"TokenizedType",getASTResult());
				goto pass0;
			}
		term3:
			// Production
			if(!parse_EnumeratedType()){
				goto fail1;
			}
			addASTChild(__astNode,"EnumeratedType",getASTResult());
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_AttType failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	StringType
		::= "CDATA";
	*/
	bool parse_StringType(){
		debug Stdout("parse_StringType").newline;
		auto __astNode = createASTNode("StringType");
		// Terminal
		if(!match("CDATA")){
			goto fail1;
		}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_StringType failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	TokenizedType
		::= "ID";
	*/
	bool parse_TokenizedType(){
		debug Stdout("parse_TokenizedType").newline;
		auto __astNode = createASTNode("TokenizedType");
		// Terminal
		if(!match("ID")){
			goto fail1;
		}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_TokenizedType failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	EnumeratedType
		::= NotationType | Enumeration;
	*/
	bool parse_EnumeratedType(){
		debug Stdout("parse_EnumeratedType").newline;
		auto __astNode = createASTNode("EnumeratedType");
		// OrGroup pass0
			// Production
			if(parse_NotationType()){
				addASTChild(__astNode,"NotationType",getASTResult());
				goto pass0;
			}
		term2:
			// Production
			if(!parse_Enumeration()){
				goto fail1;
			}
			addASTChild(__astNode,"Enumeration",getASTResult());
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_EnumeratedType failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	NotationType
		::= "NOTATION" S "(" S? Name (S? "|" S? Name)* S? ")";
	*/
	bool parse_NotationType(){
		debug Stdout("parse_NotationType").newline;
		auto __astNode = createASTNode("NotationType");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("NOTATION")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_S()){
					goto fail4;
				}
				addASTChild(__astNode,"S",getASTResult());
			term6:
				// Terminal
				if(!match("(")){
					goto fail4;
				}
			term7:
				// Iterator (optional alias special case)
					// (expression)
					// Production
					if(!parse_S()){
						goto term9;
					}
					addASTChild(__astNode,"S",getASTResult());
					// (terminator)
					term9:
					// Production
					if(!parse_Name()){
						goto fail4;
					}
					addASTChild(__astNode,"Name",getASTResult());
			term8:
				// Iterator
				start10:
					// (terminator)
					if(!hasMore()){
						goto end11;
					}
					// (expression)
					expr12:
						// AndGroup
							auto position14 = getPos();
								// Iterator (optional alias special case)
									// (expression)
									// Production
									if(!parse_S()){
										goto term17;
									}
									addASTChild(__astNode,"S",getASTResult());
									// (terminator)
									term17:
									// Terminal
									if(!match("|")){
										goto fail15;
									}
							term16:
								// Iterator (optional alias special case)
									// (expression)
									// Production
									if(!parse_S()){
										goto term18;
									}
									addASTChild(__astNode,"S",getASTResult());
									// (terminator)
									term18:
									// Production
									if(parse_Name()){
										addASTChild(__astNode,"Name",getASTResult());
										goto start10;
									}
							fail15:
							setPos(position14);
							goto end11;
					goto start10;
				end11:
					// Iterator (optional alias special case)
						// (expression)
						// Production
						if(!parse_S()){
							goto term19;
						}
						addASTChild(__astNode,"S",getASTResult());
						// (terminator)
						term19:
						// Terminal
						if(match(")")){
							goto pass0;
						}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_NotationType failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	Enumeration
		::= "(" S? Nmtoken (S? "|" S? Nmtoken)* S? ")";
	*/
	bool parse_Enumeration(){
		debug Stdout("parse_Enumeration").newline;
		auto __astNode = createASTNode("Enumeration");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("(")){
					goto fail4;
				}
			term5:
				// Iterator (optional alias special case)
					// (expression)
					// Production
					if(!parse_S()){
						goto term7;
					}
					addASTChild(__astNode,"S",getASTResult());
					// (terminator)
					term7:
					// Production
					if(!parse_Nmtoken()){
						goto fail4;
					}
					addASTChild(__astNode,"Nmtoken",getASTResult());
			term6:
				// Iterator
				start8:
					// (terminator)
					if(!hasMore()){
						goto end9;
					}
					// (expression)
					expr10:
						// AndGroup
							auto position12 = getPos();
								// Iterator (optional alias special case)
									// (expression)
									// Production
									if(!parse_S()){
										goto term15;
									}
									addASTChild(__astNode,"S",getASTResult());
									// (terminator)
									term15:
									// Terminal
									if(!match("|")){
										goto fail13;
									}
							term14:
								// Iterator (optional alias special case)
									// (expression)
									// Production
									if(!parse_S()){
										goto term16;
									}
									addASTChild(__astNode,"S",getASTResult());
									// (terminator)
									term16:
									// Production
									if(parse_Nmtoken()){
										addASTChild(__astNode,"Nmtoken",getASTResult());
										goto start8;
									}
							fail13:
							setPos(position12);
							goto end9;
					goto start8;
				end9:
					// Iterator (optional alias special case)
						// (expression)
						// Production
						if(!parse_S()){
							goto term17;
						}
						addASTChild(__astNode,"S",getASTResult());
						// (terminator)
						term17:
						// Terminal
						if(match(")")){
							goto pass0;
						}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_Enumeration failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	Default
		::= "#REQUIRED" | "#IMPLIED" | ("#FIXED"? QuotedCData);
	*/
	bool parse_Default(){
		debug Stdout("parse_Default").newline;
		auto __astNode = createASTNode("Default");
		// OrGroup pass0
			// Terminal
			if(match("#REQUIRED")){
				goto pass0;
			}
		term2:
			// Terminal
			if(match("#IMPLIED")){
				goto pass0;
			}
		term3:
			// Iterator (optional alias special case)
				// (expression)
				// Terminal
				if(!match("#FIXED")){
					goto term4;
				}
				// (terminator)
				term4:
				// Production
				if(!parse_QuotedCData()){
					goto fail1;
				}
				addASTChild(__astNode,"QuotedCData",getASTResult());
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_Default failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	conditionalSect
		::= "<![" CSKey "[" csdata "]]>";
	*/
	bool parse_conditionalSect(){
		debug Stdout("parse_conditionalSect").newline;
		auto __astNode = createASTNode("conditionalSect");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("<![")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_CSKey()){
					goto fail4;
				}
				addASTChild(__astNode,"CSKey",getASTResult());
			term6:
				// Terminal
				if(!match("[")){
					goto fail4;
				}
			term7:
				// Production
				if(!parse_csdata()){
					goto fail4;
				}
				addASTChild(__astNode,"csdata",getASTResult());
			term8:
				// Terminal
				if(match("]]>")){
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_conditionalSect failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	CSKey
		::= PEReference | "INCLUDE" | "IGNORE";
	*/
	bool parse_CSKey(){
		debug Stdout("parse_CSKey").newline;
		auto __astNode = createASTNode("CSKey");
		// OrGroup pass0
			// Production
			if(parse_PEReference()){
				addASTChild(__astNode,"PEReference",getASTResult());
				goto pass0;
			}
		term2:
			// Terminal
			if(match("INCLUDE")){
				goto pass0;
			}
		term3:
			// Terminal
			if(!match("IGNORE")){
				goto fail1;
			}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_CSKey failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	csdata ::= internalsubset;
	*/
	alias parse_internalsubset parse_csdata;

	/*
	Hex
		::= #30-#39 | #41-#46 | #61-#66;
	*/
	bool parse_Hex(){
		debug Stdout("parse_Hex").newline;
		auto __astNode = createASTNode("Hex");
		// OrGroup pass0
			// CharRange
			if(match(0x30,0x39)){
				goto pass0;
			}
		term2:
			// CharRange
			if(match(0x41,0x46)){
				goto pass0;
			}
		term3:
			// CharRange
			if(!match(0x61,0x66)){
				goto fail1;
			}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_Hex failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	Hex4
		::= Hex<4>;
	*/
	bool parse_Hex4(){
		debug Stdout("parse_Hex4").newline;
		auto __astNode = createASTNode("Hex4");
		// Iterator
		size_t counter5 = 0;
		start2:
			// (terminator)
			if(counter5 == 4){
				goto end3;
			}
			// (expression)
			expr4:
				// Production
				if(!parse_Hex()){
					goto end3;
				}
				addASTChild(__astNode,"Hex",getASTResult());
			increment6:
			// (increment expr count)
				counter5 ++;
			goto start2;
		end3:
			// (range test)
				if(!((counter5 == 4))){
					goto fail1;
					goto pass0;
				}
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_Hex4 failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	CharRef
		::= "&#" (#30-#39)+ ";" | "&u-" Hex4 ";";
	*/
	bool parse_CharRef(){
		debug Stdout("parse_CharRef").newline;
		auto __astNode = createASTNode("CharRef");
		// OrGroup pass0
			// AndGroup
				auto position4 = getPos();
					// Terminal
					if(!match("&#")){
						goto fail5;
					}
				term6:
					// Iterator
					size_t counter10 = 0;
					start7:
						// (terminator)
							// Terminal
							if(match(";")){
								goto end8;
							}
						// (expression)
						expr9:
							// CharRange
							if(!match(0x30,0x39)){
								goto fail5;
							}
						increment11:
						// (increment expr count)
							counter10 ++;
						goto start7;
					end8:
						// (range test)
							if(((counter10 >= 1))){
								goto pass0;
							}
				fail5:
				setPos(position4);
		term2:
			// AndGroup
				auto position13 = getPos();
					// Terminal
					if(!match("&u-")){
						goto fail14;
					}
				term15:
					// Production
					if(!parse_Hex4()){
						goto fail14;
					}
					addASTChild(__astNode,"Hex4",getASTResult());
				term16:
					// Terminal
					if(match(";")){
						goto pass0;
					}
				fail14:
				setPos(position13);
				goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_CharRef failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	Reference
		::= EntityRef | CharRef;
	*/
	bool parse_Reference(){
		debug Stdout("parse_Reference").newline;
		auto __astNode = createASTNode("Reference");
		// OrGroup pass0
			// Production
			if(parse_EntityRef()){
				addASTChild(__astNode,"EntityRef",getASTResult());
				goto pass0;
			}
		term2:
			// Production
			if(!parse_CharRef()){
				goto fail1;
			}
			addASTChild(__astNode,"CharRef",getASTResult());
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_Reference failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	EntityRef
		::= "&" Name ";";
	*/
	bool parse_EntityRef(){
		debug Stdout("parse_EntityRef").newline;
		auto __astNode = createASTNode("EntityRef");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("&")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_Name()){
					goto fail4;
				}
				addASTChild(__astNode,"Name",getASTResult());
			term6:
				// Terminal
				if(match(";")){
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_EntityRef failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	PEReference
		::= "%" Name ";";
	*/
	bool parse_PEReference(){
		debug Stdout("parse_PEReference").newline;
		auto __astNode = createASTNode("PEReference");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("%")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_Name()){
					goto fail4;
				}
				addASTChild(__astNode,"Name",getASTResult());
			term6:
				// Terminal
				if(match(";")){
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_PEReference failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	EntityDecl
		::= "<!ENTITY" S Name S EntityDef S? ">" | "<!ENTITY" S "%" S Name S EntityDef S? ">";
	*/
	bool parse_EntityDecl(){
		debug Stdout("parse_EntityDecl").newline;
		auto __astNode = createASTNode("EntityDecl");
		// OrGroup pass0
			// AndGroup
				auto position4 = getPos();
					// Terminal
					if(!match("<!ENTITY")){
						goto fail5;
					}
				term6:
					// Production
					if(!parse_S()){
						goto fail5;
					}
					addASTChild(__astNode,"S",getASTResult());
				term7:
					// Production
					if(!parse_Name()){
						goto fail5;
					}
					addASTChild(__astNode,"Name",getASTResult());
				term8:
					// Production
					if(!parse_S()){
						goto fail5;
					}
					addASTChild(__astNode,"S",getASTResult());
				term9:
					// Production
					if(!parse_EntityDef()){
						goto fail5;
					}
					addASTChild(__astNode,"EntityDef",getASTResult());
				term10:
					// Iterator (optional alias special case)
						// (expression)
						// Production
						if(!parse_S()){
							goto term11;
						}
						addASTChild(__astNode,"S",getASTResult());
						// (terminator)
						term11:
						// Terminal
						if(match(">")){
							goto pass0;
						}
				fail5:
				setPos(position4);
		term2:
			// AndGroup
				auto position13 = getPos();
					// Terminal
					if(!match("<!ENTITY")){
						goto fail14;
					}
				term15:
					// Production
					if(!parse_S()){
						goto fail14;
					}
					addASTChild(__astNode,"S",getASTResult());
				term16:
					// Terminal
					if(!match("%")){
						goto fail14;
					}
				term17:
					// Production
					if(!parse_S()){
						goto fail14;
					}
					addASTChild(__astNode,"S",getASTResult());
				term18:
					// Production
					if(!parse_Name()){
						goto fail14;
					}
					addASTChild(__astNode,"Name",getASTResult());
				term19:
					// Production
					if(!parse_S()){
						goto fail14;
					}
					addASTChild(__astNode,"S",getASTResult());
				term20:
					// Production
					if(!parse_EntityDef()){
						goto fail14;
					}
					addASTChild(__astNode,"EntityDef",getASTResult());
				term21:
					// Iterator (optional alias special case)
						// (expression)
						// Production
						if(!parse_S()){
							goto term22;
						}
						addASTChild(__astNode,"S",getASTResult());
						// (terminator)
						term22:
						// Terminal
						if(match(">")){
							goto pass0;
						}
				fail14:
				setPos(position13);
				goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_EntityDecl failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	EntityDef
		::= Literal | ExternalDef;
	*/
	bool parse_EntityDef(){
		debug Stdout("parse_EntityDef").newline;
		auto __astNode = createASTNode("EntityDef");
		// OrGroup pass0
			// Production
			if(parse_Literal()){
				addASTChild(__astNode,"Literal",getASTResult());
				goto pass0;
			}
		term2:
			// Production
			if(!parse_ExternalDef()){
				goto fail1;
			}
			addASTChild(__astNode,"ExternalDef",getASTResult());
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_EntityDef failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	ExternalDef
		::= ExternalID NDataDecl?;
	*/
	bool parse_ExternalDef(){
		debug Stdout("parse_ExternalDef").newline;
		auto __astNode = createASTNode("ExternalDef");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_ExternalID()){
					goto fail4;
				}
				addASTChild(__astNode,"ExternalID",getASTResult());
			term5:
				// Iterator (optional alias special case)
					// (expression)
					// Production
					if(parse_NDataDecl()){
						addASTChild(__astNode,"NDataDecl",getASTResult());
						goto pass0;
					}
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_ExternalDef failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	ExternalID
		::= "SYSTEM" S SystemLiteral;
	*/
	bool parse_ExternalID(){
		debug Stdout("parse_ExternalID").newline;
		auto __astNode = createASTNode("ExternalID");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("SYSTEM")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_S()){
					goto fail4;
				}
				addASTChild(__astNode,"S",getASTResult());
			term6:
				// Production
				if(parse_SystemLiteral()){
					addASTChild(__astNode,"SystemLiteral",getASTResult());
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_ExternalID failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	SystemLiteral
		::= "\"" any* "\"" | "\'" any* "\'";
	*/
	bool parse_SystemLiteral(){
		debug Stdout("parse_SystemLiteral").newline;
		auto __astNode = createASTNode("SystemLiteral");
		// OrGroup pass0
			// AndGroup
				auto position4 = getPos();
					// Terminal
					if(!match("\"")){
						goto fail5;
					}
				term6:
					// Iterator
					start7:
						// (terminator)
							// Terminal
							if(match("\"")){
								goto end8;
							}
						// (expression)
						expr9:
							// Production
							if(!parse_any()){
								goto fail5;
							}
							addASTChild(__astNode,"any",getASTResult());
						goto start7;
					end8:
						goto pass0;
				fail5:
				setPos(position4);
		term2:
			// AndGroup
				auto position11 = getPos();
					// Terminal
					if(!match("\'")){
						goto fail12;
					}
				term13:
					// Iterator
					start14:
						// (terminator)
							// Terminal
							if(match("\'")){
								goto end15;
							}
						// (expression)
						expr16:
							// Production
							if(!parse_any()){
								goto fail12;
							}
							addASTChild(__astNode,"any",getASTResult());
						goto start14;
					end15:
						goto pass0;
				fail12:
				setPos(position11);
				goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_SystemLiteral failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	NDataDecl
		::= S "NDATA" S Name;
	*/
	bool parse_NDataDecl(){
		debug Stdout("parse_NDataDecl").newline;
		auto __astNode = createASTNode("NDataDecl");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_S()){
					goto fail4;
				}
				addASTChild(__astNode,"S",getASTResult());
			term5:
				// Terminal
				if(!match("NDATA")){
					goto fail4;
				}
			term6:
				// Production
				if(!parse_S()){
					goto fail4;
				}
				addASTChild(__astNode,"S",getASTResult());
			term7:
				// Production
				if(parse_Name()){
					addASTChild(__astNode,"Name",getASTResult());
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_NDataDecl failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	EncodingDecl
		::= S "encoding" Eq QEncoding;
	*/
	bool parse_EncodingDecl(){
		debug Stdout("parse_EncodingDecl").newline;
		auto __astNode = createASTNode("EncodingDecl");
		// AndGroup
			auto position3 = getPos();
				// Production
				if(!parse_S()){
					goto fail4;
				}
				addASTChild(__astNode,"S",getASTResult());
			term5:
				// Terminal
				if(!match("encoding")){
					goto fail4;
				}
			term6:
				// Production
				if(!parse_Eq()){
					goto fail4;
				}
				addASTChild(__astNode,"Eq",getASTResult());
			term7:
				// Production
				if(parse_QEncoding()){
					addASTChild(__astNode,"QEncoding",getASTResult());
					goto pass0;
				}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_EncodingDecl failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	EncodingPI
		::= "<?XML" S "encoding" Eq QEncoding S? "?>";
	*/
	bool parse_EncodingPI(){
		debug Stdout("parse_EncodingPI").newline;
		auto __astNode = createASTNode("EncodingPI");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("<?XML")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_S()){
					goto fail4;
				}
				addASTChild(__astNode,"S",getASTResult());
			term6:
				// Terminal
				if(!match("encoding")){
					goto fail4;
				}
			term7:
				// Production
				if(!parse_Eq()){
					goto fail4;
				}
				addASTChild(__astNode,"Eq",getASTResult());
			term8:
				// Production
				if(!parse_QEncoding()){
					goto fail4;
				}
				addASTChild(__astNode,"QEncoding",getASTResult());
			term9:
				// Iterator (optional alias special case)
					// (expression)
					// Production
					if(!parse_S()){
						goto term10;
					}
					addASTChild(__astNode,"S",getASTResult());
					// (terminator)
					term10:
					// Terminal
					if(match("?>")){
						goto pass0;
					}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_EncodingPI failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	QEncoding
		::= "\"" Encoding "\"" | "\'" Encoding "\'";
	*/
	bool parse_QEncoding(){
		debug Stdout("parse_QEncoding").newline;
		auto __astNode = createASTNode("QEncoding");
		// OrGroup pass0
			// AndGroup
				auto position4 = getPos();
					// Terminal
					if(!match("\"")){
						goto fail5;
					}
				term6:
					// Production
					if(!parse_Encoding()){
						goto fail5;
					}
					addASTChild(__astNode,"Encoding",getASTResult());
				term7:
					// Terminal
					if(match("\"")){
						goto pass0;
					}
				fail5:
				setPos(position4);
		term2:
			// AndGroup
				auto position9 = getPos();
					// Terminal
					if(!match("\'")){
						goto fail10;
					}
				term11:
					// Production
					if(!parse_Encoding()){
						goto fail10;
					}
					addASTChild(__astNode,"Encoding",getASTResult());
				term12:
					// Terminal
					if(match("\'")){
						goto pass0;
					}
				fail10:
				setPos(position9);
				goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_QEncoding failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	Encoding ::= LatinName;
	*/
	alias parse_LatinName parse_Encoding;

	/*
	LatinName
		::= (#41-#5A | #61-#7A) (#30-#39 | #41-#5A | #61-#7A | "-" | ".")*;
	*/
	bool parse_LatinName(){
		debug Stdout("parse_LatinName").newline;
		auto __astNode = createASTNode("LatinName");
		// AndGroup
			auto position3 = getPos();
				// OrGroup term5
					// CharRange
					if(match(0x41,0x5A)){
						goto term5;
					}
				term6:
					// CharRange
					if(!match(0x61,0x7A)){
						goto fail4;
					}
			term5:
				// Iterator
				start7:
					// (terminator)
					if(!hasMore()){
						goto end8;
					}
					// (expression)
					expr9:
						// OrGroup start7
							// CharRange
							if(match(0x30,0x39)){
								goto start7;
							}
						term10:
							// CharRange
							if(match(0x41,0x5A)){
								goto start7;
							}
						term11:
							// CharRange
							if(match(0x61,0x7A)){
								goto start7;
							}
						term12:
							// Terminal
							if(match("-")){
								goto start7;
							}
						term13:
							// Terminal
							if(!match(".")){
								goto end8;
							}
					goto start7;
				end8:
					goto pass0;
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_LatinName failed").newline;
			clearASTResult(__astNode);
			return false;
	}

	/*
	NotationDecl
		::= "<!NOTATION" S Name S ExternalID S? ">";
	*/
	bool parse_NotationDecl(){
		debug Stdout("parse_NotationDecl").newline;
		auto __astNode = createASTNode("NotationDecl");
		// AndGroup
			auto position3 = getPos();
				// Terminal
				if(!match("<!NOTATION")){
					goto fail4;
				}
			term5:
				// Production
				if(!parse_S()){
					goto fail4;
				}
				addASTChild(__astNode,"S",getASTResult());
			term6:
				// Production
				if(!parse_Name()){
					goto fail4;
				}
				addASTChild(__astNode,"Name",getASTResult());
			term7:
				// Production
				if(!parse_S()){
					goto fail4;
				}
				addASTChild(__astNode,"S",getASTResult());
			term8:
				// Production
				if(!parse_ExternalID()){
					goto fail4;
				}
				addASTChild(__astNode,"ExternalID",getASTResult());
			term9:
				// Iterator (optional alias special case)
					// (expression)
					// Production
					if(!parse_S()){
						goto term10;
					}
					addASTChild(__astNode,"S",getASTResult());
					// (terminator)
					term10:
					// Terminal
					if(match(">")){
						goto pass0;
					}
			fail4:
			setPos(position3);
			goto fail1;
		// Rule
		pass0:
			debug Stdout("passed").newline;
			setASTResult(__astNode);
			return true;
		fail1:
			debug Stdout.format("\tparse_NotationDecl failed").newline;
			clearASTResult(__astNode);
			return false;
	}
}
