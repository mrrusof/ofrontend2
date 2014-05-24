:- module(cli_args, [parse_cli_args/3,
                     print_cli_options/1]).

:- ['iteration.prolog'].

/*
parse_cli_args(+Argv, +Options, -Files)
*/
parse_cli_args(Argv, Options, Files) :-
        (   foreach((O, Goal, _), Options),
            fromto(Argv, InA, OutA, Files)
        do  (   member(O, InA) ->
                Goal,
                delete(InA, O, OutA)
            ;   OutA = InA
            )
        ).

print_cli_options(Options) :-
        (   foreach((O, _, Desc), Options)
        do  format('~p\t~p', [O, Desc])
        ).
