:- module(cli_args, [parse_cli_args/2,
                     print_cli_options/0]).

:- ['iteration.prolog'].
:- dynamic options/1.

parse_cli_args(Argv, Options) :-
        ( foreach((_, _, _), Options) do true ),
        assert(options(Options)),
        (   foreach((O, Goal, _), Options)
        do  (   member(O, Argv) ->
                Goal
            ;   true
            )
        ).

print_cli_options :-
        options(Options),
        (   foreach((O, _, Desc), Options)
        do  format('~p\t~p', [O, Desc])
        ).
