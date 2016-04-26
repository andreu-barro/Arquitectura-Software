all: compile

compile: sorting.erl sorting_eqc.erl
	erlc sorting.erl
	erlc sorting_eqc.erl

clean:
	rm -f *.beam
	rm -f *~

mrproper: clean
	rm -rf doc
