all: compile

compile: echo.erl echo_eqc.erl echo_positive_eqc.erl
	erlc echo.erl
	erlc echo_eqc.erl
	erlc echo_positive_eqc.erl

clean:
	rm -f *.beam
	rm -f *~

mrproper: clean
	rm -rf doc
