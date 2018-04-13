true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
f(A,B):-tail(A,C),f_1(C,B).
f_1(A,B):-dropLast(A,C),f_2(C,B).
f_2(A,B):-dropWhile(A,B,not_uppercase).
true.


