true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% is better: 67
% is better: 57
% clauses: 4
% is better: 55
% clauses: 5
% is better: 53
% is better: 51
% is better: 49
% is better: 46
% clauses: 6
% is better: 41
% is better: 36
% is better: 31
f(A,B):-tail(A,C),f_1(C,B).
f_1(A,B):-f_2(A,C),dropLast(C,B).
f_2(A,B):-f_3(A,C),f_3(C,B).
f_3(A,B):-tail(A,C),f_4(C,B).
f_4(A,B):-f_5(A,C),f_5(C,B).
f_5(A,B):-tail(A,C),tail(C,B).
true.


