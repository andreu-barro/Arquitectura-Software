all: compile

compile: manipulating.erl manipulating_eqc.erl
	erlc manipulating.erl
	erlc manipulating_eqc.erl

clean:
	rm -f *.beam
	rm -f *~

mrproper: clean
	rm -rf doc
