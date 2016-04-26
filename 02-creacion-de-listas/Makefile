all: compile

compile: create.erl create_eqc.erl
	erlc create.erl
	erlc create_eqc.erl

edoc: 
	erl -noshell -run edoc_run files '["create.erl"]' '[{dir,"doc"}]'

dialyzer:
	erlc +debug_info create.erl
	dialyzer -Wunmatched_returns \
		 -Werror_handling    \
		 -Wrace_conditions   \
		 -Wunderspecs create.erl

clean:
	rm -f *.beam
	rm -f *~

mrproper: clean
	rm -rf doc
