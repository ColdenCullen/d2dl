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

enum Register{
	AL,
	AH,
	AX,
	EAX,
	BL,
	BH,
	BX,
	EBX,
	CL,
	CH,
	CX,
	ECX,
	DL,
	DH,
	DX,
	EDX,
	BP,
	EBP,
	SP,
	ESP,
	DI,
	EDI,
	SI,
	ESI,
	ES,
	CS,
	SS,
	DS,
	GS,
	FS,
	CR0,
	CR2,
	CR3,
	CR4,
	DR0,
	DR1,
	DR2,
	DR3,
	DR6,
	DR7,
	TR3,
	TR4,
	TR5,
	TR6,
	TR7,
	MM0,
	MM1,
	MM2,
	MM3,
	MM4,
	MM5,
	MM6,
	MM7,
	XMM0,
	XMM1,
	XMM2,
	XMM3,
	XMM4,
	XMM5,
	XMM6,
	XMM7,
	ST,
	ST0,
	ST1,
	ST2,
	ST3,
	ST4,
	ST5,
	ST6,
	ST7,	
}

String registerXref[Register];

static this(){	
	registerXref["AL"]	 = Register.AL;
	registerXref["AH"]	 = Register.AH;
	registerXref["AX"]	 = Register.AX;
	registerXref["EAX"]	 = Register.EAX;
	registerXref["BL"]	 = Register.BL;
	registerXref["BH"]	 = Register.BH;
	registerXref["BX"]	 = Register.BX;
	registerXref["EBX"]	 = Register.EBX;
	registerXref["CL"]	 = Register.CL;
	registerXref["CH"]	 = Register.CH;
	registerXref["CX"]	 = Register.CX;
	registerXref["ECX"]	 = Register.ECX;
	registerXref["DL"]	 = Register.DL;
	registerXref["DH"]	 = Register.DH;
	registerXref["DX"]	 = Register.DX;
	registerXref["EDX"]	 = Register.EDX;
	registerXref["BP"]	 = Register.BP;
	registerXref["EBP"]	 = Register.EBP;
	registerXref["SP"]	 = Register.SP;
	registerXref["ESP"]	 = Register.ESP;
	registerXref["DI"]	 = Register.DI;
	registerXref["EDI"]	 = Register.EDI;
	registerXref["SI"]	 = Register.SI;
	registerXref["ESI"]	 = Register.ESI;
	registerXref["ES"]	 = Register.ES;
	registerXref["CS"]	 = Register.CS;
	registerXref["SS"]	 = Register.SS;
	registerXref["DS"]	 = Register.DS;
	registerXref["GS"]	 = Register.GS;
	registerXref["FS"]	 = Register.FS;
	registerXref["CR0"]	 = Register.CR0;
	registerXref["CR2"]	 = Register.CR2;
	registerXref["CR3"]	 = Register.CR3;
	registerXref["CR4"]	 = Register.CR4;
	registerXref["DR0"]	 = Register.DR0;
	registerXref["DR1"]	 = Register.DR1;
	registerXref["DR2"]	 = Register.DR2;
	registerXref["DR3"]	 = Register.DR3;
	registerXref["DR6"]	 = Register.DR6;
	registerXref["DR7"]	 = Register.DR7;
	registerXref["TR3"]	 = Register.TR3;
	registerXref["TR4"]	 = Register.TR4;
	registerXref["TR5"]	 = Register.TR5;
	registerXref["TR6"]	 = Register.TR6;
	registerXref["TR7"]	 = Register.TR7;
	registerXref["MM0"]	 = Register.MM0;
	registerXref["MM1"]	 = Register.MM1;
	registerXref["MM2"]	 = Register.MM2;
	registerXref["MM3"]	 = Register.MM3;
	registerXref["MM4"]	 = Register.MM4;
	registerXref["MM5"]	 = Register.MM5;
	registerXref["MM6"]	 = Register.MM6;
	registerXref["MM7"]	 = Register.MM7;
	registerXref["XMM0"] = Register.XMM0;
	registerXref["XMM1"] = Register.XMM1;
	registerXref["XMM2"] = Register.XMM2;
	registerXref["XMM3"] = Register.XMM3;
	registerXref["XMM4"] = Register.XMM4;
	registerXref["XMM5"] = Register.XMM5;
	registerXref["XMM6"] = Register.XMM6;
	registerXref["XMM7"] = Register.XMM7;
	registerXref["ST"]	 = Register.ST;
	registerXref["ST0"]	 = Register.ST0;
	registerXref["ST1"]	 = Register.ST1;
	registerXref["ST2"]	 = Register.ST2;
	registerXref["ST3"]	 = Register.ST3;
	registerXref["ST4"]	 = Register.ST4;
	registerXref["ST5"]	 = Register.ST5;
	registerXref["ST6"]	 = Register.ST6;
	registerXref["ST7"]	 = Register.ST7;	
}