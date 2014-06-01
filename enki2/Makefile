build = rebuild

ifeq ($(OS),Windows_NT)
  EXE = .exe
else
  EXE = .a
endif

test:
	dmd -c enki/bootstrap/bootstrap.d | sed -ne "/enki/p" | sed -e "s/.*(\(.*\)).*/\1/"

bootstrap$(EXE):
	@echo "Building bootstrap";
	$(build) -ofbootstrap$(EXE) enki/bootstrap/bootstrap.d -release -inline;
	./bootstrap$(EXE);
bootstrap: bootstrap$(EXE)
    
enki$(EXE): bootstrap
	@echo "Building enki (release)";
	$(build) -ofenki$(EXE) enki/enki.d -release -inline -clean;	
release: enki$(EXE)
    
enki-dbg$(EXE): bootstrap
	@echo "Building enki (debug)";
	$(build) -ofenki-dbg$(EXE) enki/enki.d -debug;	
debug: enki-dbg$(EXE)
    
examples: release
	#calculator examples
	enki example/calc/calc1.bnf
	$(build) -ofcalcdemo$(EXE) example/calc/calcdemo.d -release -inline -clean;
	enki example/calc/calc2.bnf
	$(build) -ofcalcdemo2$(EXE) example/calc/calcdemo2.d -release -inline -clean;
	enki example/calc/calc3.bnf
	$(build) -ofcalcdemo3$(EXE) example/calc/calcdemo3.d -release -inline -clean;
    
clean:
	@echo "Cleaning workspace"
	-rm bootstrap$(EXE)
	-rm -r *.obj
	-rm -r *.o
	-rm -r *.map
	-rm -r *.def
	-rm -r *.rsp
	-rm -r *.exe

all: clean release debug