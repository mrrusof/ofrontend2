#!/usr/bin/env swipl -q -t main -f --

:- use_module('cli_args.prolog', [parse_cli_args/2,
                                  print_cli_options/0]).

print_help_halt :-
        print('\nUsage: ofrontend [ option params ] input_file\n'),
        print_cli_options,
        print('\n'),
	halt.

ofrontend_start(Argv) :-
        Options =
        [
         ( '-h', print_help_halt, 'Print this help.')
        ],
        parse_cli_args(Argv, Options).

main :- runtime_entry(start).
user:runtime_entry(start) :-
        print('OFRONTEND: The OCaml frontend for OSUMMARIZER\n'),
        prolog_flag(argv, Argv),
        print(Argv), nl,
        ofrontend_start(Argv).
