:- op(1100, xfy, do).

/*
X1=N1, ..., Xn=Hn
*/
set_xs([X|Xs], [[H|_]|Ls]) :- X=H, set_xs(Xs, Ls).
set_xs([], []).

/*
consume_heads(+Ls, -LsWithoutHeads)
*/
consume_heads([[_|L]|Ls], [L|LswoH]) :- consume_heads(Ls, LswoH).
consume_heads([], []).

/*
empty_lists(+ListOfLists).
*/
empty_lists([[]|Ls]) :- empty_lists(Ls).
empty_lists([]).

/*
foreach_iterator(+[foreach(X1, L1), ..., foreach(Xn, Ln)], -foreach([X1...Xn], [L1...Ln]))
*/
foreach_iterator([foreach(X,L)|FEs], fe([X|Xs], [L|Ls])) :-
        foreach_iterator(FEs, fe(Xs, Ls)).
foreach_iterator([], fe([], [])).

/*
( foreach([X1...Xn], [[H1|T1]...[Hn|Tn]]) do Body ) :-
*/
( fe(_, Ls) do _ )     :-
        empty_lists(Ls),
        !.
( fe(Xs, Ls) do Body ) :-
        \+ \+ (set_xs(Xs, Ls), Body),
        consume_heads(Ls, LswoH),
        ( fe(Xs, LswoH) do Body ).
/*
( +Iterators do +Body )
*/
( Iterators do Body ) :-
        (   Iterators = foreach(Xs, Ls) ->
            ( fe([Xs], [Ls]) do Body )
        ;   Iterators =.. [,|Its] ->
            foreach_iterator(Its, ForEach),
            ( ForEach do Body )
        ).

        

        