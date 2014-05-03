:- op(1100, xfy, do).

(foreach(X, [H|T]) do Body) :-
        \+ \+ (X=H, Body),
        ( foreach(X, T) do Body ).
(foreach(_, []) do _).
        