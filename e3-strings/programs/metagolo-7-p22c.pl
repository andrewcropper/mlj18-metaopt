true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% clauses: 4
% is better: 1
% clauses: 5
% clauses: 6
f(A,B):-f_1(A,C),dropLast(C,B).
f_1(A,B):-f_2(A,C),f_3(C,B).
f_2(A,B):-dropWhile(A,B,not_space).
f_3(A,B):-filter(A,B,is_letter).
true.


