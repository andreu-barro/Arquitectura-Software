all: compile

compile: crossring.erl crossring_props.erl
	erlc crossring.erl
	erlc crossring_props.erl

clean:
	rm -f *.beam
	rm -f *~

mrproper: clean
	rm -rf doc
