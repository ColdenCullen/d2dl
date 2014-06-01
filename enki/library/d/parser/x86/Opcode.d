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

enum Opcode{	
	AAA,
	AAD,
	AAM,
	AAS,
	AAS,
	ADC,
	                                          
	ADD,
	ADDPD,
	ADDPS,
	ADDSD,
	ADDSD,
	ADDSS,
	                                          
	AND,
	ANDNPD,
	ANDNPS,
	ANDPD,
	ANDPD,
	ANDPS,
	                                          
	ARPL,
	BOUND,
	BSF,
	BSR,
	BSR,
	BSWAP,
	                                          
	BT,
	BTC,
	BTR,
	BTS,
	BTS,
	CALL,
	                                          
	CBW,
	CDQ,
	CLC,
	CLD,
	CLD,
	CLFLUSH,
	                                          
	CLI,
	CLTS,
	CMC,
	CMOVA,
	CMOVA,
	CMOVAE,
	                                          
	CMOVB,
	CMOVBE,
	CMOVC,
	CMOVE,
	CMOVE,
	CMOVG,
	                                          
	CMOVGE,
	CMOVL,
	CMOVLE,
	CMOVNA,
	CMOVNA,
	CMOVNAE,
	                                          
	CMOVNB,
	CMOVNBE,
	CMOVNC,
	CMOVNE,
	CMOVNE,
	CMOVNG,
	                                          
	CMOVNGE,
	CMOVNL,
	CMOVNLE,
	CMOVNO,
	CMOVNO,
	CMOVNP,
	                                          
	CMOVNS,
	CMOVNZ,
	CMOVO,
	CMOVP,
	CMOVP,
	CMOVPE,
	                                          
	CMOVPO,
	CMOVS,
	CMOVZ,
	CMP,
	CMP,
	CMPPD,
	                                          
	CMPPS,
	CMPS,
	CMPSB,
	CMPSD,
	CMPSD,
	CMPSS,
	                                          
	CMPSW,
	CMPXCH8B,
	CMPXCHG,
	COMISD,
	COMISD,
	COMISS,
	                                          
	CPUID,
	CVTDQ2PD,
	CVTDQ2PS,
	CVTPD2DQ,
	                                          
	CVTPD2PI,
	                                          
	CVTPD2PS,
	CVTPI2PD,
	CVTPI2PS,
	CVTPS2DQ,
	                                          
	CVTPS2PD,
	                                          
	CVTPS2PI,
	CVTSD2SI,
	CVTSD2SS,
	CVTSI2SD,
	                                          
	CVTSI2SS,
	                                          
	CVTSS2SD,
	CVTSS2SI,
	CVTTPD2DQ,
	CVTTPD2PI,
	                                          
	CVTTPS2DQ,
	                                          
	CVTTPS2PI,
	CVTTSD2SI,
	CVTTSS2SI,
	CWD,
	CWD,
	CWDE,
	                	                      
	DA,
	DAA,
	DAS,
	DB,
	DB,
	DD,
	                	                      
	DE,
	DEC,
	DF,
	DI,
	DI,
	DIV,
	                                          
	DIVPD,
	DIVPS,
	DIVSD,
	DIVSS,
	                	                      
	DL,
	                	                      
	DQ,
	DS,
	DT,
	DW,
	DW,
	EMMS,
	                	                      
	ENTER,
	F2XM1,
	FABS,
	FADD,
	FADD,
	FADDP,
	                	                      
	FBLD,
	FBSTP,
	FCHS,
	FCLEX,
	FCLEX,
	FCMOVB,
	                                          
	FCMOVBE,
	FCMOVE,
	FCMOVNB,
	FCMOVNBE,
	FCMOVNBE,
	FCMOVNE,
	                                          
	FCMOVNU,
	FCMOVU,
	FCOM,
	FCOMI,
	FCOMI,
	FCOMIP,
	                                          
	FCOMP,
	FCOMPP,
	FCOS,
	FDECSTP,
	FDECSTP,
	FDISI,
	                                          
	FDIV,
	FDIVP,
	FDIVR,
	FDIVRP,
	FDIVRP,
	FENI,
	                                          
	FFREE,
	FIADD,
	FICOM,
	FICOMP,
	FICOMP,
	FIDIV,
	                                          
	FIDIVR,
	FILD,
	FIMUL,
	FINCSTP,
	FINCSTP,
	FINIT,
	                                          
	FIST,
	FISTP,
	FISUB,
	FISUBR,
	FISUBR,
	FLD,
	                                          
	FLD1,
	FLDCW,
	FLDENV,
	FLDL2E,
	FLDL2E,
	FLDL2T,
	                                          
	FLDLG2,
	FLDLN2,
	FLDPI,
	FLDZ,
	FLDZ,
	FMUL,
	                                          
	FMULP,
	FNCLEX,
	FNDISI,
	FNENI,
	FNENI,
	FNINIT,
	                                          
	FNOP,
	FNSAVE,
	FNSTCW,
	FNSTENV,
	FNSTENV,
	FNSTSW,
	                                          
	FPATAN,
	FPREM,
	FPREM1,
	FPTAN,
	FPTAN,
	FRNDINT,
	                                          
	FRSTOR,
	FSAVE,
	FSCALE,
	FSETPM,
	FSETPM,
	FSIN,
	                                          
	FSINCOS,
	FSQRT,
	FST,
	FSTCW,
	FSTCW,
	FSTENV,
	                                          
	FSTP,
	FSTSW,
	FSUB,
	FSUBP,
	FSUBP,
	FSUBR,
	                                          
	FSUBRP,
	FTST,
	FUCOM,
	FUCOMI,
	FUCOMI,
	FUCOMIP,
	                                          
	FUCOMP,
	FUCOMPP,
	FWAIT,
	FXAM,
	FXAM,
	FXCH,
	                                          
	FXRSTOR,
	FXSAVE,
	FXTRACT,
	FYL2X,
	FYL2X,
	FYL2XP1,
	                                          
	HLT,
	IDIV,
	IMUL,
	IN,
	IN,
	INC,
	                                          
	INS,
	INSB,
	INSD,
	INSW,
	INSW,
	INT,
	                	                      
	INTO,
	INVD,
	INVLPG,
	IRET,
	IRET,
	IRETD,
	                	                      
	JA,
	JAE,
	JB,
	JBE,
	JBE,
	JC,
	                	                      
	JCXZ,
	JE,
	JECXZ,
	JG,
	JG,
	JGE,
	                	                      
	JL,
	JLE,
	JMP,
	JNA,
	JNA,
	JNAE,
	                	                      
	JNB,
	JNBE,
	JNC,
	JNE,
	JNE,
	JNG,
	                                          
	JNGE,
	JNL,
	JNLE,
	JNO,
	JNO,
	JNP,
	                                          
	JNS,
	JNZ,
	JO,
	JP,
	JP,
	JPE,
	                                          
	JPO,
	JS,
	JZ,
	LAHF,
	LAHF,
	LAR,
	                                          
	LDMXCSR,
	LDS,
	LEA,
	LEAVE,
	LEAVE,
	LES,
	                                          
	LFENCE,
	LFS,
	LGDT,
	LGS,
	LGS,
	LIDT,
	                                          
	LLDT,
	LMSW,
	LOCK,
	LODS,
	LODS,
	LODSB,
	                                          
	LODSD,
	LODSW,
	LOOP,
	LOOPE,
	LOOPE,
	LOOPNE,
	                                          
	LOOPNZ,
	LOOPZ,
	LSL,
	LSS,
	LSS,
	LTR,
	                                          
	MASKMOVDQU,
	MASKMOVQ,
	MAXPD,
	MAXPS,
	                                          
	MAXSD,
		                                      
	MAXSS,
	MFENCE,
	MINPD,
	MINPS,
	                                          
	MINSD,
	                                          
	MINSS,
	MOV,
	MOVAPD,
	MOVAPS,
	                                          
	MOVD,
	                                          
	MOVDQ2Q,
	MOVDQA,
	MOVDQU,
	MOVHLPS,
	                                          
	MOVHPD,
	                                          
	MOVHPS,
	MOVLHPS,
	MOVLPD,
	MOVLPS,
	                                          
	MOVMSKPD,
	                                          
	MOVMSKPS,
	MOVNTDQ,
	MOVNTI,
	MOVNTPD,
	                                          
	MOVNTPS,
	                                          
	MOVNTQ,
	MOVQ,
	MOVQ2DQ,
	MOVS,
	MOVS,
	MOVSB,
	                                          
	MOVSD,
	MOVSS,
	MOVSW,
	MOVSX,
	MOVSX,
	MOVUPD,
	                                          
	MOVUPS,
	MOVZX,
	MUL,
	MULPD,
	                                          
	MULPS,
	                                          
	MULSD,
	MULSS,
	NEG,
	NOP,
	NOP,
	NOT,
	                                          
	OR,
	ORPD,
	ORPS,
	OUT,
	OUT,
	OUTS,
	                                          
	OUTSB,
	OUTSD,
	OUTSW,
	PACKSSDW,
	                                          
	PACKSSWB,
	                                          
	PACKUSWB,
	PADDB,
	PADDD,
	PADDQ,
	                                          
	PADDSB,
	                                          
	PADDSW,
	PADDUSB,
	PADDUSW,
	PADDW,
	                                          
	PAND,
	                                          
	PANDN,
	PAVGB,
	PAVGW,
	PCMPEQB,
	                                          
	PCMPEQD,
	                                          
	PCMPEQW,
	PCMPGTB,
	PCMPGTD,
	PCMPGTW,
	                                          
	PEXTRW,
	                                          
	PINSRW,
	PMADDWD,
	PMAXSW,
	PMAXUB,
	                                          
	PMINSW,
	                                          
	PMINUB,
	PMOVMSKB,
	PMULHUW,
	PMULHW,
	                                          
	PMULLW,
	                                          
	PMULUDQ,
	POP,
	POPA,
	POPAD,
	POPAD,
	POPF,
	                                          
	POPFD,
	POR,
	PREFETCHNTA,
	PREFETCHT0,
	                                          
	PREFETCHT1,
	                                          
	PREFETCHT2,
	PSADBW,
	PSHUFD,
	PSHUFHW,
	                                          
	PSHUFLW,
	                                          
	PSHUFW,
	PSLLD,
	PSLLDQ,
	PSLLQ,
	                                          
	PSLLW,
	                                          
	PSRAD,
	PSRAW,
	PSRLD,
	PSRLDQ,
	                                          
	PSRLQ,
	                                          
	PSRLW,
	PSUBB,
	PSUBD,
	PSUBQ,
	                                          
	PSUBSB,
	                                          
	PSUBSW,
	PSUBUSB,
	PSUBUSW,
	PSUBW,
	                                          
	PUNPCKHBW,
	                                          
	PUNPCKHDQ,
	PUNPCKHQDQ,
	PUNPCKHWD,
	PUNPCKLBW,
	                                          
	PUNPCKLDQ,
	                                          
	PUNPCKLQDQ,
	PUNPCKLWD,
	PUSH,
	PUSHA,
	PUSHA,
	PUSHAD,
	                                          
	PUSHF,
	PUSHFD,
	PXOR,
	RCL,
	RCL,
	RCPPS,
	                                          
	RCPSS,
	RCR,
	RDMSR,
	RDPMC,
	                                          
	RDTSC,
	                                          
	REP,
	REPE,
	REPNE,
	REPNZ,
	REPNZ,
	REPZ,
	                                          
	RET,
	RETF,
	ROL,
	ROR,
	ROR,
	RSM,
	                                          
	RSQRTPS,
	RSQRTSS,
	SAHF,
	SAL,
	SAL,
	SAR,
	                                          
	SBB,
	SCAS,
	SCASB,
	SCASD,
	SCASD,
	SCASW,
	                                          
	SETA,
	SETAE,
	SETB,
	SETBE,
	SETBE,
	SETC,
	                                          
	SETE,
	SETG,
	SETGE,
	SETL,
	SETL,
	SETLE,
	                                          
	SETNA,
	SETNAE,
	SETNB,
	SETNBE,
	SETNBE,
	SETNC,
	                                          
	SETNE,
	SETNG,
	SETNGE,
	SETNL,
	SETNL,
	SETNLE,
	                                          
	SETNO,
	SETNP,
	SETNS,
	SETNZ,
	SETNZ,
	SETO,
	                                          
	SETP,
	SETPE,
	SETPO,
	SETS,
	SETS,
	SETZ,
	                                          
	SFENCE,
	SGDT,
	SHL,
	SHLD,
	SHLD,
	SHR,
	                                          
	SHRD,
	SHUFPD,
	SHUFPS,
	SIDT,
	SIDT,
	SLDT,
	                                          
	SMSW,
	SQRTPD,
	SQRTPS,
	SQRTSD,
	                                          
	SQRTSS,
	                                          
	STC,
	STD,
	STI,
	STMXCSR,
	                                          
	STOS,
	                                          
	STOSB,
	STOSD,
	STOSW,
	STR,
	STR,
	SUB,
	                                          
	SUBPD,
	SUBPS,
	SUBSD,
	SUBSS,
	                                          
	SYSENTER,
	SYSEXIT,
	TEST,
	UCOMISD,
	UCOMISS,
	UD2,
	UNPCKHPD,
	UNPCKHPS,
	UNPCKLPD,
	UNPCKLPS,
	VERR,
	VERW,
	WAIT,
	WBINVD,
	WRMSR,
	WRMSR,
	XADD,
	                                          
	XCHG,
	XLAT,
	XLATB,
	XOR,
	XOR,
	XORPD,
	                                          
	XORPS,
	ADDSUBPD,
	                                          
	ADDSUBPS,
	FISTTP,
	HADDPD,
	HADDPS,
	                                          
	HSUBPD,
	                                          
	HSUBPS,
	LDDQU,
	MONITOR,
	MOVDDUP,
	                                          
	MOVSHDUP,
	                                          
	MOVSLDUP,
	MWAIT,
	PAVGUSB,
	PF2ID,
	PFACC,
	PFADD,
	                                          
	PFCMPEQ,
	                                          
	PFCMPGE,
	PFCMPGT,
	PFMAX,
	PFMIN,
	                                          
	PFMUL,
	                                          
	PFNACC,
	PFPNACC,
	PFRCP,
	PFRCPIT1,
	                                          
	PFRCPIT2,
	                                          
	PFRSQIT1,
	PFRSQRT,
	PFSUB,
	PFSUBR,
	                                          
	PI2FD,
	                                          
	PMULHRW,
	PSWAPD,
}

Opcode opcodeXref[String];

static this(){
	opcodeXref["aaa"]			= Opcode.AAA;        
  	opcodeXref["aad"]			= Opcode.AAD;        
  	opcodeXref["aam"]			= Opcode.AAM;        
  	opcodeXref["aas"]			= Opcode.AAS;        
	opcodeXref["aas"]			= Opcode.AAS;        
  	opcodeXref["adc"]			= Opcode.ADC;        
                                          
  	opcodeXref["add"]			= Opcode.ADD;        
  	opcodeXref["addpd"]			= Opcode.ADDPD;      
  	opcodeXref["addps"]			= Opcode.ADDPS;      
  	opcodeXref["addsd"]			= Opcode.ADDSD;      
	opcodeXref["addsd"]			= Opcode.ADDSD;      
  	opcodeXref["addss"]			= Opcode.ADDSS;      
                                          
  	opcodeXref["and"]			= Opcode.AND;        
  	opcodeXref["andnpd"]		= Opcode.ANDNPD;     
  	opcodeXref["andnps"]		= Opcode.ANDNPS;     
  	opcodeXref["andpd"]			= Opcode.ANDPD;      
	opcodeXref["andpd"]			= Opcode.ANDPD;      
  	opcodeXref["andps"]			= Opcode.ANDPS;      
                                          
  	opcodeXref["arpl"]			= Opcode.ARPL;       
  	opcodeXref["bound"]			= Opcode.BOUND;      
  	opcodeXref["bsf"]			= Opcode.BSF;        
  	opcodeXref["bsr"]			= Opcode.BSR;        
	opcodeXref["bsr"]			= Opcode.BSR;        
  	opcodeXref["bswap"]			= Opcode.BSWAP;      
                                          
  	opcodeXref["bt"]			= Opcode.BT;         
  	opcodeXref["btc"]			= Opcode.BTC;        
  	opcodeXref["btr"]			= Opcode.BTR;        
  	opcodeXref["bts"]			= Opcode.BTS;        
	opcodeXref["bts"]			= Opcode.BTS;        
  	opcodeXref["call"]			= Opcode.CALL;       
                                          
  	opcodeXref["cbw"]			= Opcode.CBW;        
  	opcodeXref["cdq"]			= Opcode.CDQ;        
  	opcodeXref["clc"]			= Opcode.CLC;        
  	opcodeXref["cld"]			= Opcode.CLD;        
	opcodeXref["cld"]			= Opcode.CLD;        
	opcodeXref["clflush"]		= Opcode.CLFLUSH;    
                                          
  	opcodeXref["cli"]			= Opcode.CLI;        
  	opcodeXref["clts"]			= Opcode.CLTS;       
  	opcodeXref["cmc"]			= Opcode.CMC;        
  	opcodeXref["cmova"]			= Opcode.CMOVA;      
	opcodeXref["cmova"]			= Opcode.CMOVA;      
  	opcodeXref["cmovae"]		= Opcode.CMOVAE;     
                                          
  	opcodeXref["cmovb"]			= Opcode.CMOVB;      
  	opcodeXref["cmovbe"]		= Opcode.CMOVBE;     
  	opcodeXref["cmovc"]			= Opcode.CMOVC;      
  	opcodeXref["cmove"]			= Opcode.CMOVE;      
	opcodeXref["cmove"]			= Opcode.CMOVE;      
  	opcodeXref["cmovg"]			= Opcode.CMOVG;      
                                          
  	opcodeXref["cmovge"]		= Opcode.CMOVGE;     
  	opcodeXref["cmovl"]			= Opcode.CMOVL;      
  	opcodeXref["cmovle"]		= Opcode.CMOVLE;     
  	opcodeXref["cmovna"]		= Opcode.CMOVNA;     
	opcodeXref["cmovna"]		= Opcode.CMOVNA;     
  	opcodeXref["cmovnae"]		= Opcode.CMOVNAE;    
                                          
  	opcodeXref["cmovnb"]		= Opcode.CMOVNB;     
  	opcodeXref["cmovnbe"]		= Opcode.CMOVNBE;    
  	opcodeXref["cmovnc"]		= Opcode.CMOVNC;     
  	opcodeXref["cmovne"]		= Opcode.CMOVNE;     
	opcodeXref["cmovne"]		= Opcode.CMOVNE;     
  	opcodeXref["cmovng"]		= Opcode.CMOVNG;     
                                          
  	opcodeXref["cmovnge"]		= Opcode.CMOVNGE;    
  	opcodeXref["cmovnl"]		= Opcode.CMOVNL;     
  	opcodeXref["cmovnle"]		= Opcode.CMOVNLE;    
  	opcodeXref["cmovno"]		= Opcode.CMOVNO;     
	opcodeXref["cmovno"]		= Opcode.CMOVNO;     
  	opcodeXref["cmovnp"]		= Opcode.CMOVNP;     
                                          
  	opcodeXref["cmovns"]		= Opcode.CMOVNS;     
  	opcodeXref["cmovnz"]		= Opcode.CMOVNZ;     
  	opcodeXref["cmovo"]			= Opcode.CMOVO;      
  	opcodeXref["cmovp"]			= Opcode.CMOVP;      
	opcodeXref["cmovp"]			= Opcode.CMOVP;      
  	opcodeXref["cmovpe"]		= Opcode.CMOVPE;     
                                          
  	opcodeXref["cmovpo"]		= Opcode.CMOVPO;     
  	opcodeXref["cmovs"]			= Opcode.CMOVS;      
  	opcodeXref["cmovz"]			= Opcode.CMOVZ;      
  	opcodeXref["cmp"]			= Opcode.CMP;        
	opcodeXref["cmp"]			= Opcode.CMP;        
  	opcodeXref["cmppd"]			= Opcode.CMPPD;      
                                          
  	opcodeXref["cmpps"]			= Opcode.CMPPS;      
  	opcodeXref["cmps"]			= Opcode.CMPS;       
  	opcodeXref["cmpsb"]			= Opcode.CMPSB;      
  	opcodeXref["cmpsd"]			= Opcode.CMPSD;      
	opcodeXref["cmpsd"]			= Opcode.CMPSD;      
  	opcodeXref["cmpss"]			= Opcode.CMPSS;      
                                          
  	opcodeXref["cmpsw"]			= Opcode.CMPSW;      
  	opcodeXref["cmpxch8b"]		= Opcode.CMPXCH8B;   
  	opcodeXref["cmpxchg"]		= Opcode.CMPXCHG;    
  	opcodeXref["comisd"]		= Opcode.COMISD;     
	opcodeXref["comisd"]		= Opcode.COMISD;     
  	opcodeXref["comiss"]		= Opcode.COMISS;     
                                          
  	opcodeXref["cpuid"]			= Opcode.CPUID;      
	opcodeXref["cvtdq2pd"]		= Opcode.CVTDQ2PD;   
	opcodeXref["cvtdq2ps"]		= Opcode.CVTDQ2PS;   
	opcodeXref["cvtpd2dq"]		= Opcode.CVTPD2DQ;   
                                          
	opcodeXref["cvtpd2pi"]		= Opcode.CVTPD2PI;   
                                          
	opcodeXref["cvtpd2ps"]		= Opcode.CVTPD2PS;   
	opcodeXref["cvtpi2pd"]		= Opcode.CVTPI2PD;   
	opcodeXref["cvtpi2ps"]		= Opcode.CVTPI2PS;   
	opcodeXref["cvtps2dq"]		= Opcode.CVTPS2DQ;   
                                          
	opcodeXref["cvtps2pd"]		= Opcode.CVTPS2PD;   
                                          
	opcodeXref["cvtps2pi"]		= Opcode.CVTPS2PI;   
	opcodeXref["cvtsd2si"]		= Opcode.CVTSD2SI;   
	opcodeXref["cvtsd2ss"]		= Opcode.CVTSD2SS;   
	opcodeXref["cvtsi2sd"]		= Opcode.CVTSI2SD;   
                                          
	opcodeXref["cvtsi2ss"]		= Opcode.CVTSI2SS;   
                                          
	opcodeXref["cvtss2sd"]		= Opcode.CVTSS2SD;   
	opcodeXref["cvtss2si"]		= Opcode.CVTSS2SI;   
	opcodeXref["cvttpd2dq"]		= Opcode.CVTTPD2DQ;  
	opcodeXref["cvttpd2pi"]		= Opcode.CVTTPD2PI;  
                                          
	opcodeXref["cvttps2dq"]		= Opcode.CVTTPS2DQ;  
                                          
	opcodeXref["cvttps2pi"]		= Opcode.CVTTPS2PI;  
	opcodeXref["cvttsd2si"]		= Opcode.CVTTSD2SI;  
	opcodeXref["cvttss2si"]		= Opcode.CVTTSS2SI;  
  	opcodeXref["cwd"]			= Opcode.CWD;        
	opcodeXref["cwd"]			= Opcode.CWD;        
  	opcodeXref["cwde"]			= Opcode.CWDE;       
                	                      
  	opcodeXref["da"]			= Opcode.DA;         
  	opcodeXref["daa"]			= Opcode.DAA;        
  	opcodeXref["das"]			= Opcode.DAS;        
  	opcodeXref["db"]			= Opcode.DB;         
	opcodeXref["db"]			= Opcode.DB;         
  	opcodeXref["dd"]			= Opcode.DD;         
                	                      
  	opcodeXref["de"]			= Opcode.DE;         
  	opcodeXref["dec"]			= Opcode.DEC;        
  	opcodeXref["df"]			= Opcode.DF;         
  	opcodeXref["di"]			= Opcode.DI;         
	opcodeXref["di"]			= Opcode.DI;         
  	opcodeXref["div"]			= Opcode.DIV;        
                                          
	opcodeXref["divpd"]			= Opcode.DIVPD;      
	opcodeXref["divps"]			= Opcode.DIVPS;      
	opcodeXref["divsd"]			= Opcode.DIVSD;      
	opcodeXref["divss"]			= Opcode.DIVSS;      
                	                      
  	opcodeXref["dl"]			= Opcode.DL;         
                	                      
  	opcodeXref["dq"]			= Opcode.DQ;         
  	opcodeXref["ds"]			= Opcode.DS;         
  	opcodeXref["dt"]			= Opcode.DT;         
  	opcodeXref["dw"]			= Opcode.DW;         
	opcodeXref["dw"]			= Opcode.DW;         
	opcodeXref["emms"]			= Opcode.EMMS;       
                	                      
  	opcodeXref["enter"]			= Opcode.ENTER;      
  	opcodeXref["f2xm1"]			= Opcode.F2XM1;      
  	opcodeXref["fabs"]			= Opcode.FABS;       
  	opcodeXref["fadd"]			= Opcode.FADD;       
	opcodeXref["fadd"]			= Opcode.FADD;       
  	opcodeXref["faddp"]			= Opcode.FADDP;      
                	                      
  	opcodeXref["fbld"]			= Opcode.FBLD;       
  	opcodeXref["fbstp"]			= Opcode.FBSTP;      
  	opcodeXref["fchs"]			= Opcode.FCHS;       
  	opcodeXref["fclex"]			= Opcode.FCLEX;      
	opcodeXref["fclex"]			= Opcode.FCLEX;      
  	opcodeXref["fcmovb"]		= Opcode.FCMOVB;     
                                          
  	opcodeXref["fcmovbe"]		= Opcode.FCMOVBE;    
  	opcodeXref["fcmove"]		= Opcode.FCMOVE;     
  	opcodeXref["fcmovnb"]		= Opcode.FCMOVNB;    
  	opcodeXref["fcmovnbe"]		= Opcode.FCMOVNBE;   
	opcodeXref["fcmovnbe"]		= Opcode.FCMOVNBE;   
  	opcodeXref["fcmovne"]		= Opcode.FCMOVNE;    
                                          
  	opcodeXref["fcmovnu"]		= Opcode.FCMOVNU;    
  	opcodeXref["fcmovu"]		= Opcode.FCMOVU;     
  	opcodeXref["fcom"]			= Opcode.FCOM;       
  	opcodeXref["fcomi"]			= Opcode.FCOMI;      
	opcodeXref["fcomi"]			= Opcode.FCOMI;      
  	opcodeXref["fcomip"]		= Opcode.FCOMIP;     
                                          
  	opcodeXref["fcomp"]			= Opcode.FCOMP;      
  	opcodeXref["fcompp"]		= Opcode.FCOMPP;     
  	opcodeXref["fcos"]			= Opcode.FCOS;       
  	opcodeXref["fdecstp"]		= Opcode.FDECSTP;    
	opcodeXref["fdecstp"]		= Opcode.FDECSTP;    
  	opcodeXref["fdisi"]			= Opcode.FDISI;      
                                          
  	opcodeXref["fdiv"]			= Opcode.FDIV;       
  	opcodeXref["fdivp"]			= Opcode.FDIVP;      
  	opcodeXref["fdivr"]			= Opcode.FDIVR;      
  	opcodeXref["fdivrp"]		= Opcode.FDIVRP;     
	opcodeXref["fdivrp"]		= Opcode.FDIVRP;     
  	opcodeXref["feni"]			= Opcode.FENI;       
                                          
  	opcodeXref["ffree"]			= Opcode.FFREE;      
  	opcodeXref["fiadd"]			= Opcode.FIADD;      
  	opcodeXref["ficom"]			= Opcode.FICOM;      
  	opcodeXref["ficomp"]		= Opcode.FICOMP;     
	opcodeXref["ficomp"]		= Opcode.FICOMP;     
  	opcodeXref["fidiv"]			= Opcode.FIDIV;      
                                          
  	opcodeXref["fidivr"]		= Opcode.FIDIVR;     
  	opcodeXref["fild"]			= Opcode.FILD;       
  	opcodeXref["fimul"]			= Opcode.FIMUL;      
  	opcodeXref["fincstp"]		= Opcode.FINCSTP;    
	opcodeXref["fincstp"]		= Opcode.FINCSTP;    
  	opcodeXref["finit"]			= Opcode.FINIT;      
                                          
  	opcodeXref["fist"]			= Opcode.FIST;       
  	opcodeXref["fistp"]			= Opcode.FISTP;      
  	opcodeXref["fisub"]			= Opcode.FISUB;      
  	opcodeXref["fisubr"]		= Opcode.FISUBR;     
	opcodeXref["fisubr"]		= Opcode.FISUBR;     
  	opcodeXref["fld"]			= Opcode.FLD;        
                                          
  	opcodeXref["fld1"]			= Opcode.FLD1;       
  	opcodeXref["fldcw"]			= Opcode.FLDCW;      
  	opcodeXref["fldenv"]		= Opcode.FLDENV;     
  	opcodeXref["fldl2e"]		= Opcode.FLDL2E;     
	opcodeXref["fldl2e"]		= Opcode.FLDL2E;     
  	opcodeXref["fldl2t"]		= Opcode.FLDL2T;     
                                          
  	opcodeXref["fldlg2"]		= Opcode.FLDLG2;     
  	opcodeXref["fldln2"]		= Opcode.FLDLN2;     
  	opcodeXref["fldpi"]			= Opcode.FLDPI;      
  	opcodeXref["fldz"]			= Opcode.FLDZ;       
	opcodeXref["fldz"]			= Opcode.FLDZ;       
  	opcodeXref["fmul"]			= Opcode.FMUL;       
                                          
  	opcodeXref["fmulp"]			= Opcode.FMULP;      
  	opcodeXref["fnclex"]		= Opcode.FNCLEX;     
  	opcodeXref["fndisi"]		= Opcode.FNDISI;     
  	opcodeXref["fneni"]			= Opcode.FNENI;      
	opcodeXref["fneni"]			= Opcode.FNENI;      
  	opcodeXref["fninit"]		= Opcode.FNINIT;     
                                          
  	opcodeXref["fnop"]			= Opcode.FNOP;       
  	opcodeXref["fnsave"]		= Opcode.FNSAVE;     
  	opcodeXref["fnstcw"]		= Opcode.FNSTCW;     
  	opcodeXref["fnstenv"]		= Opcode.FNSTENV;    
	opcodeXref["fnstenv"]		= Opcode.FNSTENV;    
  	opcodeXref["fnstsw"]		= Opcode.FNSTSW;     
                                          
  	opcodeXref["fpatan"]		= Opcode.FPATAN;     
  	opcodeXref["fprem"]			= Opcode.FPREM;      
  	opcodeXref["fprem1"]		= Opcode.FPREM1;     
  	opcodeXref["fptan"]			= Opcode.FPTAN;      
	opcodeXref["fptan"]			= Opcode.FPTAN;      
  	opcodeXref["frndint"]		= Opcode.FRNDINT;    
                                          
  	opcodeXref["frstor"]		= Opcode.FRSTOR;     
  	opcodeXref["fsave"]			= Opcode.FSAVE;      
  	opcodeXref["fscale"]		= Opcode.FSCALE;     
  	opcodeXref["fsetpm"]		= Opcode.FSETPM;     
	opcodeXref["fsetpm"]		= Opcode.FSETPM;     
  	opcodeXref["fsin"]			= Opcode.FSIN;       
                                          
  	opcodeXref["fsincos"]		= Opcode.FSINCOS;    
  	opcodeXref["fsqrt"]			= Opcode.FSQRT;      
  	opcodeXref["fst"]			= Opcode.FST;        
  	opcodeXref["fstcw"]			= Opcode.FSTCW;      
	opcodeXref["fstcw"]			= Opcode.FSTCW;      
  	opcodeXref["fstenv"]		= Opcode.FSTENV;     
                                          
  	opcodeXref["fstp"]			= Opcode.FSTP;       
  	opcodeXref["fstsw"]			= Opcode.FSTSW;      
  	opcodeXref["fsub"]			= Opcode.FSUB;       
  	opcodeXref["fsubp"]			= Opcode.FSUBP;      
	opcodeXref["fsubp"]			= Opcode.FSUBP;      
  	opcodeXref["fsubr"]			= Opcode.FSUBR;      
                                          
  	opcodeXref["fsubrp"]		= Opcode.FSUBRP;     
  	opcodeXref["ftst"]			= Opcode.FTST;       
  	opcodeXref["fucom"]			= Opcode.FUCOM;      
  	opcodeXref["fucomi"]		= Opcode.FUCOMI;     
	opcodeXref["fucomi"]		= Opcode.FUCOMI;     
  	opcodeXref["fucomip"]		= Opcode.FUCOMIP;    
                                          
  	opcodeXref["fucomp"]		= Opcode.FUCOMP;     
  	opcodeXref["fucompp"]		= Opcode.FUCOMPP;    
  	opcodeXref["fwait"]			= Opcode.FWAIT;      
  	opcodeXref["fxam"]			= Opcode.FXAM;       
	opcodeXref["fxam"]			= Opcode.FXAM;       
  	opcodeXref["fxch"]			= Opcode.FXCH;       
                                          
	opcodeXref["fxrstor"]		= Opcode.FXRSTOR;    
	opcodeXref["fxsave"]		= Opcode.FXSAVE;     
  	opcodeXref["fxtract"]		= Opcode.FXTRACT;    
  	opcodeXref["fyl2x"]			= Opcode.FYL2X;      
	opcodeXref["fyl2x"]			= Opcode.FYL2X;      
  	opcodeXref["fyl2xp1"]		= Opcode.FYL2XP1;    
                                          
  	opcodeXref["hlt"]			= Opcode.HLT;        
  	opcodeXref["idiv"]			= Opcode.IDIV;       
  	opcodeXref["imul"]			= Opcode.IMUL;       
  	opcodeXref["in"]			= Opcode.IN;         
	opcodeXref["in"]			= Opcode.IN;         
  	opcodeXref["inc"]			= Opcode.INC;        
                                          
  	opcodeXref["ins"]			= Opcode.INS;        
  	opcodeXref["insb"]			= Opcode.INSB;       
  	opcodeXref["insd"]			= Opcode.INSD;       
  	opcodeXref["insw"]			= Opcode.INSW;       
	opcodeXref["insw"]			= Opcode.INSW;       
  	opcodeXref["int"]			= Opcode.INT;        
                	                      
  	opcodeXref["into"]			= Opcode.INTO;       
  	opcodeXref["invd"]			= Opcode.INVD;       
  	opcodeXref["invlpg"]		= Opcode.INVLPG;     
  	opcodeXref["iret"]			= Opcode.IRET;       
	opcodeXref["iret"]			= Opcode.IRET;       
  	opcodeXref["iretd"]			= Opcode.IRETD;      
                	                      
  	opcodeXref["ja"]			= Opcode.JA;         
  	opcodeXref["jae"]			= Opcode.JAE;        
  	opcodeXref["jb"]			= Opcode.JB;         
  	opcodeXref["jbe"]			= Opcode.JBE;        
	opcodeXref["jbe"]			= Opcode.JBE;        
  	opcodeXref["jc"]			= Opcode.JC;         
                	                      
  	opcodeXref["jcxz"]			= Opcode.JCXZ;       
  	opcodeXref["je"]			= Opcode.JE;         
  	opcodeXref["jecxz"]			= Opcode.JECXZ;      
  	opcodeXref["jg"]			= Opcode.JG;         
	opcodeXref["jg"]			= Opcode.JG;         
  	opcodeXref["jge"]			= Opcode.JGE;        
                	                      
  	opcodeXref["jl"]			= Opcode.JL;         
  	opcodeXref["jle"]			= Opcode.JLE;        
  	opcodeXref["jmp"]			= Opcode.JMP;        
  	opcodeXref["jna"]			= Opcode.JNA;        
	opcodeXref["jna"]			= Opcode.JNA;        
  	opcodeXref["jnae"]			= Opcode.JNAE;       
                	                      
  	opcodeXref["jnb"]			= Opcode.JNB;        
  	opcodeXref["jnbe"]			= Opcode.JNBE;       
  	opcodeXref["jnc"]			= Opcode.JNC;        
  	opcodeXref["jne"]			= Opcode.JNE;        
	opcodeXref["jne"]			= Opcode.JNE;        
  	opcodeXref["jng"]			= Opcode.JNG;        
                                          
  	opcodeXref["jnge"]			= Opcode.JNGE;       
  	opcodeXref["jnl"]			= Opcode.JNL;        
  	opcodeXref["jnle"]			= Opcode.JNLE;       
  	opcodeXref["jno"]			= Opcode.JNO;        
	opcodeXref["jno"]			= Opcode.JNO;        
  	opcodeXref["jnp"]			= Opcode.JNP;        
                                          
  	opcodeXref["jns"]			= Opcode.JNS;        
  	opcodeXref["jnz"]			= Opcode.JNZ;        
  	opcodeXref["jo"]			= Opcode.JO;         
  	opcodeXref["jp"]			= Opcode.JP;         
	opcodeXref["jp"]			= Opcode.JP;         
  	opcodeXref["jpe"]			= Opcode.JPE;        
                                          
  	opcodeXref["jpo"]			= Opcode.JPO;        
  	opcodeXref["js"]			= Opcode.JS;         
  	opcodeXref["jz"]			= Opcode.JZ;         
  	opcodeXref["lahf"]			= Opcode.LAHF;       
	opcodeXref["lahf"]			= Opcode.LAHF;       
  	opcodeXref["lar"]			= Opcode.LAR;        
                                          
	opcodeXref["ldmxcsr"]		= Opcode.LDMXCSR;    
  	opcodeXref["lds"]			= Opcode.LDS;        
  	opcodeXref["lea"]			= Opcode.LEA;        
  	opcodeXref["leave"]			= Opcode.LEAVE;      
	opcodeXref["leave"]			= Opcode.LEAVE;      
  	opcodeXref["les"]			= Opcode.LES;        
                                          
	opcodeXref["lfence"]		= Opcode.LFENCE;     
  	opcodeXref["lfs"]			= Opcode.LFS;        
  	opcodeXref["lgdt"]			= Opcode.LGDT;       
  	opcodeXref["lgs"]			= Opcode.LGS;        
	opcodeXref["lgs"]			= Opcode.LGS;        
  	opcodeXref["lidt"]			= Opcode.LIDT;       
                                          
  	opcodeXref["lldt"]			= Opcode.LLDT;       
  	opcodeXref["lmsw"]			= Opcode.LMSW;       
	opcodeXref["lock"]			= Opcode.LOCK;       
  	opcodeXref["lods"]			= Opcode.LODS;       
	opcodeXref["lods"]			= Opcode.LODS;       
  	opcodeXref["lodsb"]			= Opcode.LODSB;      
                                          
  	opcodeXref["lodsd"]			= Opcode.LODSD;      
  	opcodeXref["lodsw"]			= Opcode.LODSW;      
  	opcodeXref["loop"]			= Opcode.LOOP;       
  	opcodeXref["loope"]			= Opcode.LOOPE;      
	opcodeXref["loope"]			= Opcode.LOOPE;      
  	opcodeXref["loopne"]		= Opcode.LOOPNE;     
                                          
  	opcodeXref["loopnz"]		= Opcode.LOOPNZ;     
  	opcodeXref["loopz"]			= Opcode.LOOPZ;      
  	opcodeXref["lsl"]			= Opcode.LSL;        
  	opcodeXref["lss"]			= Opcode.LSS;        
	opcodeXref["lss"]			= Opcode.LSS;        
  	opcodeXref["ltr"]			= Opcode.LTR;        
                                          
	opcodeXref["maskmovdqu"]	= Opcode.MASKMOVDQU; 
	opcodeXref["maskmovq"]		= Opcode.MASKMOVQ;   
	opcodeXref["maxpd"]			= Opcode.MAXPD;      
	opcodeXref["maxps"]			= Opcode.MAXPS;      
                                          
	opcodeXref["maxsd"]			= Opcode.MAXSD;      
	                                      
	opcodeXref["maxss"]			= Opcode.MAXSS;      
	opcodeXref["mfence"]		= Opcode.MFENCE;     
	opcodeXref["minpd"]			= Opcode.MINPD;      
	opcodeXref["minps"]			= Opcode.MINPS;      
                                          
	opcodeXref["minsd"]			= Opcode.MINSD;      
                                          
	opcodeXref["minss"]			= Opcode.MINSS;      
  	opcodeXref["mov"]			= Opcode.MOV;        
	opcodeXref["movapd"]		= Opcode.MOVAPD;     
	opcodeXref["movaps"]		= Opcode.MOVAPS;     
                                          
  	opcodeXref["movd"]			= Opcode.MOVD;       
                                          
	opcodeXref["movdq2q"]		= Opcode.MOVDQ2Q;    
	opcodeXref["movdqa"]		= Opcode.MOVDQA;     
	opcodeXref["movdqu"]		= Opcode.MOVDQU;     
	opcodeXref["movhlps"]		= Opcode.MOVHLPS;    
                                          
	opcodeXref["movhpd"]		= Opcode.MOVHPD;     
                                          
	opcodeXref["movhps"]		= Opcode.MOVHPS;     
	opcodeXref["movlhps"]		= Opcode.MOVLHPS;    
	opcodeXref["movlpd"]		= Opcode.MOVLPD;     
	opcodeXref["movlps"]		= Opcode.MOVLPS;     
                                          
	opcodeXref["movmskpd"]		= Opcode.MOVMSKPD;   
                                          
	opcodeXref["movmskps"]		= Opcode.MOVMSKPS;   
	opcodeXref["movntdq"]		= Opcode.MOVNTDQ;    
	opcodeXref["movnti"]		= Opcode.MOVNTI;     
	opcodeXref["movntpd"]		= Opcode.MOVNTPD;    
                                          
	opcodeXref["movntps"]		= Opcode.MOVNTPS;    
                                          
	opcodeXref["movntq"]		= Opcode.MOVNTQ;     
  	opcodeXref["movq"]			= Opcode.MOVQ;       
	opcodeXref["movq2dq"]		= Opcode.MOVQ2DQ;    
  	opcodeXref["movs"]			= Opcode.MOVS;       
	opcodeXref["movs"]			= Opcode.MOVS;       
  	opcodeXref["movsb"]			= Opcode.MOVSB;      
                                          
  	opcodeXref["movsd"]			= Opcode.MOVSD;      
	opcodeXref["movss"]			= Opcode.MOVSS;      
  	opcodeXref["movsw"]			= Opcode.MOVSW;      
  	opcodeXref["movsx"]			= Opcode.MOVSX;      
	opcodeXref["movsx"]			= Opcode.MOVSX;      
	opcodeXref["movupd"]		= Opcode.MOVUPD;     
                                          
	opcodeXref["movups"]		= Opcode.MOVUPS;     
  	opcodeXref["movzx"]			= Opcode.MOVZX;      
  	opcodeXref["mul"]			= Opcode.MUL;        
	opcodeXref["mulpd"]			= Opcode.MULPD;      
                                          
	opcodeXref["mulps"]			= Opcode.MULPS;      
                                          
	opcodeXref["mulsd"]			= Opcode.MULSD;      
	opcodeXref["mulss"]			= Opcode.MULSS;      
  	opcodeXref["neg"]			= Opcode.NEG;        
  	opcodeXref["nop"]			= Opcode.NOP;        
	opcodeXref["nop"]			= Opcode.NOP;        
  	opcodeXref["not"]			= Opcode.NOT;        
                                          
  	opcodeXref["or"]			= Opcode.OR;         
	opcodeXref["orpd"]			= Opcode.ORPD;       
	opcodeXref["orps"]			= Opcode.ORPS;       
  	opcodeXref["out"]			= Opcode.OUT;        
	opcodeXref["out"]			= Opcode.OUT;        
  	opcodeXref["outs"]			= Opcode.OUTS;       
                                          
  	opcodeXref["outsb"]			= Opcode.OUTSB;      
  	opcodeXref["outsd"]			= Opcode.OUTSD;      
  	opcodeXref["outsw"]			= Opcode.OUTSW;      
	opcodeXref["packssdw"]		= Opcode.PACKSSDW;   
                                          
	opcodeXref["packsswb"]		= Opcode.PACKSSWB;   
                                          
	opcodeXref["packuswb"]		= Opcode.PACKUSWB;   
	opcodeXref["paddb"]			= Opcode.PADDB;      
	opcodeXref["paddd"]			= Opcode.PADDD;      
	opcodeXref["paddq"]			= Opcode.PADDQ;      
                                          
	opcodeXref["paddsb"]		= Opcode.PADDSB;     
                                          
	opcodeXref["paddsw"]		= Opcode.PADDSW;     
	opcodeXref["paddusb"]		= Opcode.PADDUSB;    
	opcodeXref["paddusw"]		= Opcode.PADDUSW;    
	opcodeXref["paddw"]			= Opcode.PADDW;      
                                          
	opcodeXref["pand"]			= Opcode.PAND;       
                                          
	opcodeXref["pandn"]			= Opcode.PANDN;      
	opcodeXref["pavgb"]			= Opcode.PAVGB;      
	opcodeXref["pavgw"]			= Opcode.PAVGW;      
	opcodeXref["pcmpeqb"]		= Opcode.PCMPEQB;    
                                          
	opcodeXref["pcmpeqd"]		= Opcode.PCMPEQD;    
                                          
	opcodeXref["pcmpeqw"]		= Opcode.PCMPEQW;    
	opcodeXref["pcmpgtb"]		= Opcode.PCMPGTB;    
	opcodeXref["pcmpgtd"]		= Opcode.PCMPGTD;    
	opcodeXref["pcmpgtw"]		= Opcode.PCMPGTW;    
                                          
	opcodeXref["pextrw"]		= Opcode.PEXTRW;     
                                          
	opcodeXref["pinsrw"]		= Opcode.PINSRW;     
	opcodeXref["pmaddwd"]		= Opcode.PMADDWD;    
	opcodeXref["pmaxsw"]		= Opcode.PMAXSW;     
	opcodeXref["pmaxub"]		= Opcode.PMAXUB;     
                                          
	opcodeXref["pminsw"]		= Opcode.PMINSW;     
                                          
	opcodeXref["pminub"]		= Opcode.PMINUB;     
	opcodeXref["pmovmskb"]		= Opcode.PMOVMSKB;   
	opcodeXref["pmulhuw"]		= Opcode.PMULHUW;    
	opcodeXref["pmulhw"]		= Opcode.PMULHW;     
                                          
	opcodeXref["pmullw"]		= Opcode.PMULLW;     
                                          
	opcodeXref["pmuludq"]		= Opcode.PMULUDQ;    
  	opcodeXref["pop"]			= Opcode.POP;        
  	opcodeXref["popa"]			= Opcode.POPA;       
  	opcodeXref["popad"]			= Opcode.POPAD;      
	opcodeXref["popad"]			= Opcode.POPAD;      
  	opcodeXref["popf"]			= Opcode.POPF;       
                                          
  	opcodeXref["popfd"]			= Opcode.POPFD;      
	opcodeXref["por"]			= Opcode.POR;        
	opcodeXref["prefetchnta"]	= Opcode.PREFETCHNTA;
	opcodeXref["prefetcht0"]	= Opcode.PREFETCHT0; 
                                          
	opcodeXref["prefetcht1"]	= Opcode.PREFETCHT1; 
                                          
	opcodeXref["prefetcht2"]	= Opcode.PREFETCHT2; 
	opcodeXref["psadbw"]		= Opcode.PSADBW;     
	opcodeXref["pshufd"]		= Opcode.PSHUFD;     
	opcodeXref["pshufhw"]		= Opcode.PSHUFHW;    
                                          
	opcodeXref["pshuflw"]		= Opcode.PSHUFLW;    
                                          
	opcodeXref["pshufw"]		= Opcode.PSHUFW;     
	opcodeXref["pslld"]			= Opcode.PSLLD;      
	opcodeXref["pslldq"]		= Opcode.PSLLDQ;     
	opcodeXref["psllq"]			= Opcode.PSLLQ;      
                                          
	opcodeXref["psllw"]			= Opcode.PSLLW;      
                                          
	opcodeXref["psrad"]			= Opcode.PSRAD;      
	opcodeXref["psraw"]			= Opcode.PSRAW;      
	opcodeXref["psrld"]			= Opcode.PSRLD;      
	opcodeXref["psrldq"]		= Opcode.PSRLDQ;     
                                          
	opcodeXref["psrlq"]			= Opcode.PSRLQ;      
                                          
	opcodeXref["psrlw"]			= Opcode.PSRLW;      
	opcodeXref["psubb"]			= Opcode.PSUBB;      
	opcodeXref["psubd"]			= Opcode.PSUBD;      
	opcodeXref["psubq"]			= Opcode.PSUBQ;      
                                          
	opcodeXref["psubsb"]		= Opcode.PSUBSB;     
                                          
	opcodeXref["psubsw"]		= Opcode.PSUBSW;     
	opcodeXref["psubusb"]		= Opcode.PSUBUSB;    
	opcodeXref["psubusw"]		= Opcode.PSUBUSW;    
	opcodeXref["psubw"]			= Opcode.PSUBW;      
                                          
	opcodeXref["punpckhbw"]		= Opcode.PUNPCKHBW;  
                                          
	opcodeXref["punpckhdq"]		= Opcode.PUNPCKHDQ;  
	opcodeXref["punpckhqdq"]	= Opcode.PUNPCKHQDQ; 
	opcodeXref["punpckhwd"]		= Opcode.PUNPCKHWD;  
	opcodeXref["punpcklbw"]		= Opcode.PUNPCKLBW;  
                                          
	opcodeXref["punpckldq"]		= Opcode.PUNPCKLDQ;  
                                          
	opcodeXref["punpcklqdq"]	= Opcode.PUNPCKLQDQ; 
	opcodeXref["punpcklwd"]		= Opcode.PUNPCKLWD;  
  	opcodeXref["push"]			= Opcode.PUSH;       
  	opcodeXref["pusha"]			= Opcode.PUSHA;      
	opcodeXref["pusha"]			= Opcode.PUSHA;      
  	opcodeXref["pushad"]		= Opcode.PUSHAD;     
                                          
  	opcodeXref["pushf"]			= Opcode.PUSHF;      
  	opcodeXref["pushfd"]		= Opcode.PUSHFD;     
	opcodeXref["pxor"]			= Opcode.PXOR;       
  	opcodeXref["rcl"]			= Opcode.RCL;        
	opcodeXref["rcl"]			= Opcode.RCL;        
	opcodeXref["rcpps"]			= Opcode.RCPPS;      
                                          
	opcodeXref["rcpss"]			= Opcode.RCPSS;      
  	opcodeXref["rcr"]			= Opcode.RCR;        
  	opcodeXref["rdmsr"]			= Opcode.RDMSR;      
	opcodeXref["rdpmc"]			= Opcode.RDPMC;      
                                          
  	opcodeXref["rdtsc"]			= Opcode.RDTSC;      
                                          
  	opcodeXref["rep"]			= Opcode.REP;        
  	opcodeXref["repe"]			= Opcode.REPE;       
  	opcodeXref["repne"]			= Opcode.REPNE;      
  	opcodeXref["repnz"]			= Opcode.REPNZ;      
	opcodeXref["repnz"]			= Opcode.REPNZ;      
  	opcodeXref["repz"]			= Opcode.REPZ;       
                                          
  	opcodeXref["ret"]			= Opcode.RET;        
  	opcodeXref["retf"]			= Opcode.RETF;       
  	opcodeXref["rol"]			= Opcode.ROL;        
  	opcodeXref["ror"]			= Opcode.ROR;        
	opcodeXref["ror"]			= Opcode.ROR;        
  	opcodeXref["rsm"]			= Opcode.RSM;        
                                          
	opcodeXref["rsqrtps"]		= Opcode.RSQRTPS;    
	opcodeXref["rsqrtss"]		= Opcode.RSQRTSS;    
  	opcodeXref["sahf"]			= Opcode.SAHF;       
  	opcodeXref["sal"]			= Opcode.SAL;        
	opcodeXref["sal"]			= Opcode.SAL;        
  	opcodeXref["sar"]			= Opcode.SAR;        
                                          
  	opcodeXref["sbb"]			= Opcode.SBB;        
  	opcodeXref["scas"]			= Opcode.SCAS;       
  	opcodeXref["scasb"]			= Opcode.SCASB;      
  	opcodeXref["scasd"]			= Opcode.SCASD;      
	opcodeXref["scasd"]			= Opcode.SCASD;      
  	opcodeXref["scasw"]			= Opcode.SCASW;      
                                          
  	opcodeXref["seta"]			= Opcode.SETA;       
  	opcodeXref["setae"]			= Opcode.SETAE;      
  	opcodeXref["setb"]			= Opcode.SETB;       
  	opcodeXref["setbe"]			= Opcode.SETBE;      
	opcodeXref["setbe"]			= Opcode.SETBE;      
  	opcodeXref["setc"]			= Opcode.SETC;       
                                          
  	opcodeXref["sete"]			= Opcode.SETE;       
  	opcodeXref["setg"]			= Opcode.SETG;       
  	opcodeXref["setge"]			= Opcode.SETGE;      
  	opcodeXref["setl"]			= Opcode.SETL;       
	opcodeXref["setl"]			= Opcode.SETL;       
  	opcodeXref["setle"]			= Opcode.SETLE;      
                                          
  	opcodeXref["setna"]			= Opcode.SETNA;      
  	opcodeXref["setnae"]		= Opcode.SETNAE;     
  	opcodeXref["setnb"]			= Opcode.SETNB;      
  	opcodeXref["setnbe"]		= Opcode.SETNBE;     
	opcodeXref["setnbe"]		= Opcode.SETNBE;     
  	opcodeXref["setnc"]			= Opcode.SETNC;      
                                          
  	opcodeXref["setne"]			= Opcode.SETNE;      
  	opcodeXref["setng"]			= Opcode.SETNG;      
  	opcodeXref["setnge"]		= Opcode.SETNGE;     
  	opcodeXref["setnl"]			= Opcode.SETNL;      
	opcodeXref["setnl"]			= Opcode.SETNL;      
  	opcodeXref["setnle"]		= Opcode.SETNLE;     
                                          
  	opcodeXref["setno"]			= Opcode.SETNO;      
  	opcodeXref["setnp"]			= Opcode.SETNP;      
  	opcodeXref["setns"]			= Opcode.SETNS;      
  	opcodeXref["setnz"]			= Opcode.SETNZ;      
	opcodeXref["setnz"]			= Opcode.SETNZ;      
  	opcodeXref["seto"]			= Opcode.SETO;       
                                          
  	opcodeXref["setp"]			= Opcode.SETP;       
  	opcodeXref["setpe"]			= Opcode.SETPE;      
  	opcodeXref["setpo"]			= Opcode.SETPO;      
  	opcodeXref["sets"]			= Opcode.SETS;       
	opcodeXref["sets"]			= Opcode.SETS;       
  	opcodeXref["setz"]			= Opcode.SETZ;       
                                          
	opcodeXref["sfence"]		= Opcode.SFENCE;     
  	opcodeXref["sgdt"]			= Opcode.SGDT;       
  	opcodeXref["shl"]			= Opcode.SHL;        
  	opcodeXref["shld"]			= Opcode.SHLD;       
	opcodeXref["shld"]			= Opcode.SHLD;       
  	opcodeXref["shr"]			= Opcode.SHR;        
                                          
  	opcodeXref["shrd"]			= Opcode.SHRD;       
	opcodeXref["shufpd"]		= Opcode.SHUFPD;     
	opcodeXref["shufps"]		= Opcode.SHUFPS;     
  	opcodeXref["sidt"]			= Opcode.SIDT;       
	opcodeXref["sidt"]			= Opcode.SIDT;       
  	opcodeXref["sldt"]			= Opcode.SLDT;       
                                          
  	opcodeXref["smsw"]			= Opcode.SMSW;       
	opcodeXref["sqrtpd"]		= Opcode.SQRTPD;     
	opcodeXref["sqrtps"]		= Opcode.SQRTPS;     
	opcodeXref["sqrtsd"]		= Opcode.SQRTSD;     
                                          
	opcodeXref["sqrtss"]		= Opcode.SQRTSS;     
                                          
  	opcodeXref["stc"]			= Opcode.STC;        
  	opcodeXref["std"]			= Opcode.STD;        
  	opcodeXref["sti"]			= Opcode.STI;        
	opcodeXref["stmxcsr"]		= Opcode.STMXCSR;    
                                          
  	opcodeXref["stos"]			= Opcode.STOS;       
                                          
  	opcodeXref["stosb"]			= Opcode.STOSB;      
  	opcodeXref["stosd"]			= Opcode.STOSD;      
  	opcodeXref["stosw"]			= Opcode.STOSW;      
  	opcodeXref["str"]			= Opcode.STR;        
	opcodeXref["str"]			= Opcode.STR;        
  	opcodeXref["sub"]			= Opcode.SUB;        
                                          
	opcodeXref["subpd"]			= Opcode.SUBPD;      
	opcodeXref["subps"]			= Opcode.SUBPS;      
	opcodeXref["subsd"]			= Opcode.SUBSD;      
	opcodeXref["subss"]			= Opcode.SUBSS;      
                                          
	opcodeXref["sysenter"]		= Opcode.SYSENTER;   
	opcodeXref["sysexit"]		= Opcode.SYSEXIT;    
  	opcodeXref["test"]			= Opcode.TEST;       
	opcodeXref["ucomisd"]		= Opcode.UCOMISD;    
	opcodeXref["ucomiss"]		= Opcode.UCOMISS;    
	opcodeXref["ud2"]			= Opcode.UD2;        
	opcodeXref["unpckhpd"]		= Opcode.UNPCKHPD;   
	opcodeXref["unpckhps"]		= Opcode.UNPCKHPS;   
	opcodeXref["unpcklpd"]		= Opcode.UNPCKLPD;   
	opcodeXref["unpcklps"]		= Opcode.UNPCKLPS;   
  	opcodeXref["verr"]			= Opcode.VERR;       
  	opcodeXref["verw"]			= Opcode.VERW;       
  	opcodeXref["wait"]			= Opcode.WAIT;       
  	opcodeXref["wbinvd"]		= Opcode.WBINVD;     
  	opcodeXref["wrmsr"]			= Opcode.WRMSR;      
	opcodeXref["wrmsr"]			= Opcode.WRMSR;      
  	opcodeXref["xadd"]			= Opcode.XADD;       
                                          
  	opcodeXref["xchg"]			= Opcode.XCHG;       
  	opcodeXref["xlat"]			= Opcode.XLAT;       
  	opcodeXref["xlatb"]			= Opcode.XLATB;      
  	opcodeXref["xor"]			= Opcode.XOR;        
	opcodeXref["xor"]			= Opcode.XOR;        
	opcodeXref["xorpd"]			= Opcode.XORPD;      
                                          
	opcodeXref["xorps"]			= Opcode.XORPS;      
	opcodeXref["addsubpd"]		= Opcode.ADDSUBPD;   
                                          
	opcodeXref["addsubps"]		= Opcode.ADDSUBPS;   
  	opcodeXref["fisttp"]		= Opcode.FISTTP;     
	opcodeXref["haddpd"]		= Opcode.HADDPD;     
	opcodeXref["haddps"]		= Opcode.HADDPS;     
                                          
	opcodeXref["hsubpd"]		= Opcode.HSUBPD;     
                                          
	opcodeXref["hsubps"]		= Opcode.HSUBPS;     
	opcodeXref["lddqu"]			= Opcode.LDDQU;      
	opcodeXref["monitor"]		= Opcode.MONITOR;    
	opcodeXref["movddup"]		= Opcode.MOVDDUP;    
                                          
	opcodeXref["movshdup"]		= Opcode.MOVSHDUP;   
                                          
	opcodeXref["movsldup"]		= Opcode.MOVSLDUP;   
	opcodeXref["mwait"]			= Opcode.MWAIT;      
	opcodeXref["pavgusb"]		= Opcode.PAVGUSB;    
	opcodeXref["pf2id"]			= Opcode.PF2ID;      
	opcodeXref["pfacc"]			= Opcode.PFACC;      
	opcodeXref["pfadd"]			= Opcode.PFADD;      
                                          
	opcodeXref["pfcmpeq"]		= Opcode.PFCMPEQ;    
                                          
	opcodeXref["pfcmpge"]		= Opcode.PFCMPGE;    
	opcodeXref["pfcmpgt"]		= Opcode.PFCMPGT;    
	opcodeXref["pfmax"]			= Opcode.PFMAX;      
	opcodeXref["pfmin"]			= Opcode.PFMIN;      
                                          
	opcodeXref["pfmul"]			= Opcode.PFMUL;      
                                          
	opcodeXref["pfnacc"]		= Opcode.PFNACC;     
	opcodeXref["pfpnacc"]		= Opcode.PFPNACC;    
	opcodeXref["pfrcp"]			= Opcode.PFRCP;      
	opcodeXref["pfrcpit1"]		= Opcode.PFRCPIT1;   
                                          
	opcodeXref["pfrcpit2"]		= Opcode.PFRCPIT2;   
                                          
	opcodeXref["pfrsqit1"]		= Opcode.PFRSQIT1;   
	opcodeXref["pfrsqrt"]		= Opcode.PFRSQRT;    
	opcodeXref["pfsub"]			= Opcode.PFSUB;      
	opcodeXref["pfsubr"]		= Opcode.PFSUBR;     
                                          
	opcodeXref["pi2fd"]			= Opcode.PI2FD;      
                                          
	opcodeXref["pmulhrw"]		= Opcode.PMULHRW;    
	opcodeXref["pswapd"]		= Opcode.PSWAPD;
}
