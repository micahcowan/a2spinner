all: SPINNER.DSK

SPINNER.DSK: SPINNER EMPTY.DSK HELLO.BAS NAME.BAS
	cp -f EMPTY.DSK $@
	dos33 -y $@ SAVE A HELLO.BAS HELLO || { rm -f $@; false; }
	dos33 -y $@ SAVE A NAME.BAS NAME || { rm -f $@; false; }
	dos33 $@ BSAVE -a 768 SPINNER || { rm -f $@; false; }
	@echo Done.

SPINNER: spinner.s spinner.cfg
	ca65 -o spinner.o spinner.s
	ld65 -o $@ -t none spinner.o

HELLO.BAS: hello-bas.txt
NAME.BAS: name-bas.txt

HELLO.BAS NAME.BAS:
	tokenize_asoft < $< > $@ || { rm -f $@; false; }

.PHONY: clean
clean:
	rm *.o SPINNER SPINNER.DSK HELLO.BAS NAME.BAS
