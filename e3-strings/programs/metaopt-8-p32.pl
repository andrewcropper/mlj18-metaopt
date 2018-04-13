true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% clauses: 4
% is better: 138
% is better: 130
% clauses: 5
% is better: 129
% is better: 93
% clauses: 6
% is better: 91
% is better: 85
% is better: 84
% is better: 80
f(A,B):-myreverse(A,C),f_1(C,B).
f_1(A,B):-f_2(A,C),myreverse(C,B).
f_2(A,B):-f_3(A,C),f_5(C,B).
f_3(A,B):-f_4(A,C),tail(C,B).
f_4(A,B):-dropWhile(A,B,is_number).
f_5(A,B):-takeWhile(A,B,is_letter).
true.


