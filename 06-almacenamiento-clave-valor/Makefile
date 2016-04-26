all: compile

compile: db.erl db_eqc.erl db_test.erl
	erlc db.erl
	erlc db_eqc.erl
	erlc db_test.erl

clean:
	rm -f *.beam
	rm -f *~

mrproper: clean
	rm -rf doc
