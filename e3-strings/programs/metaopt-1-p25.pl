true.

% learning f/2
% clauses: 1
% clauses: 2
% is better: 36
% is better: 29
% is better: 18
% is better: 17
% clauses: 3
% clauses: 4
% clauses: 5
% clauses: 6
f(A,B):-myreverse(A,C),f_1(C,B).
f_1(A,B):-dropWhile(A,B,is_uppercase).
true.


