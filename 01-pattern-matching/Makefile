all: compile

compile: boolean.erl boolean_eqc.erl
	erlc boolean.erl
	erlc boolean_eqc.erl

edoc: 
	erl -noshell -run edoc_run files '["boolean.erl"]' '[{dir,"doc"}]'

dialyzer:
	erlc +debug_info boolean.erl
	dialyzer -Wunmatched_returns \
		 -Werror_handling    \
		 -Wrace_conditions   \
		 -Wunderspecs boolean.erl

clean:
	rm -f *.beam
	rm -f *~

mrproper: clean
	rm -rf doc
