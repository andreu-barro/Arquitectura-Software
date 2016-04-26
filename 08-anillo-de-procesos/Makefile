all: compile

compile: ring.erl ring_props.erl
	erlc ring.erl
	erlc ring_props.erl

clean:
	rm -f *.beam
	rm -f *~

mrproper: clean
	rm -rf doc
