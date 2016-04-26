all: compile

compile: effects.erl
	erlc effects.erl

clean:
	rm -f *.beam
	rm -f *~

mrproper: clean
	rm -rf doc
