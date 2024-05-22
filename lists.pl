search2(E, [E, E | _]) :- !.
search2(E, [_ | T]) :- search2(E, T).

search_two(E, [E, _, E | _]) :- !.
search_two(E, [_ | T]) :- search_two(E, T).

size([], 0).
size([_ | T], N) :- size(T, N1), N is N1 + 1.

sum([], 0).
sum([H | T], N) :- sum(T, N1), N is N1 + H.

max([], E, E).
max([H | T], E, M) :- H >= E, !, max(T, H, M).
max([H | T], E, M) :- max(T, E, M).
max([H | T], M) :- max(T, H, M).

min([], E, E).
min([H | T], E, M) :- H >= E, !, min(T, E, M).
min([H | T], E, M) :- min(T, H, M).
min([H | T], M) :- min(T, H, M).

min-max(L, Max, Min) :- max(L, Max), min(L, Min).

% split(L, E, L1, L2)
% no if the position is out of bound
split(L, 0, [], L) :- !.
split([H | T], E, [H | L1], L2) :- N is E - 1, split(T, N, L1, L2).

append_last([], E, [E]) :- !.
append_last([H | T], E, [H | L]) :- append_last(T, E, L).

rotate([], []).
rotate([H | T], L) :- append_last(T, H, L).

dice(6, 6) :- !.
dice(X, X).
dice(X, N) :- N2 is N + 1, dice(X, N2).
dice(X) :- dice(X, 1).

three_dice(N, [H1, H2, H3]) :- dice(H1), dice(H2), dice(H3), N is H1 + H2 + H3.

dropAny(X, [X | T], T).
dropAny(X, [H | Xs], [H | L]) :- dropAny(X, Xs, L).

dropFirst(X, L, L1) :- dropAny(X, L, L1), !.

dropLast(X, [X | T], [X | L]) :- dropLast(X, T, L), !.
dropLast(X, [X | T], T) :- !.
dropLast(X, [H | Xs], [H | L]) :- dropLast(X, Xs, L).

dropAll(E, L, L1) :- copy_term(E, X), dropFirst(X, L, Temp), dropAll(E, Temp, L1), !.
dropAll(X, L, L) :- !.

fromList([_], []).
fromList([H1, H2 | T], [e(H1, H2) | L]) :- fromList([H2 | T], L).

fromCircList([H | T], L1) :- append_last(T, H, L), fromList([H | L], L1).

outDegree([], N, 0).
outDegree([e(N, _) | T], N, D) :- outDegree(T, N, S), D is S + 1, !.
outDegree([e(E, _) | T], N, D) :- outDegree(T, N, D).

dropNode(G, N, OG) :- dropAll(e(N, _), G, G2), dropAll(e(_, N), G2, OG).