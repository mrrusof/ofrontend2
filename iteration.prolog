:- op(1100, xfy, do).

/*
( +Iterators do ?Body )
*/
( Iterators do Body ) :-
        (   Iterators = foreach(Xs, Vs) ->
            do(([Xs], [Vs]), ([], [], [], []), Body)
        ;   Iterators =.. [,|Its] ->
            iterators_to_drivers_accus(Its, Ds, As),
            do(Ds, As, Body)
        ).

iterators_to_drivers_accus([foreach(X, Vs)|Its], ([X|Xs], [Vs|Vss]), As) :-
        iterators_to_drivers_accus(Its, (Xs, Vss), As).
iterators_to_drivers_accus([fromto(I,In,Out,O)|Its], Ds, ([I|Is],[In|Ins],[Out|Outs],[O|Os])) :-
        iterators_to_drivers_accus(Its, Ds, (Is, Ins, Outs, Os)).
iterators_to_drivers_accus([], ([], []), ([], [], [], [])).

do((Xs, Vss), (Is, Ins, Outs, Os), Body) :-
        do1(Xs, Vss, Is, Ins, Outs, Body, Os).
do1(Xs, Vss, Ss, Ins, Outs, Body, Os) :-
        (   maplist(empty, Vss) ->
            Os = Ss
        ;   copy_term(Xs-Ins-Outs-Body, XsC-InsC-OutsC-BodyC),
            set_values(XsC, Vss),
            set_states(InsC, Ss),
            BodyC,
            consume_values(Vss, Vss1),
            do1(Xs, Vss1, OutsC, Ins, Outs, Body, Os)
        ).

empty([]).

set_values([Xn|Xs], [[Hn|_]|Vss]) :- Xn=Hn, set_values(Xs, Vss).
set_values([], []).

set_states([Xn|Xs], [Sn|Ss]) :- Xn=Sn, set_states(Xs, Ss).
set_states([], []).

consume_values([[_|Vs]|Vss], [Vs|Vss1]) :- consume_values(Vss, Vss1).
consume_values([], []).
