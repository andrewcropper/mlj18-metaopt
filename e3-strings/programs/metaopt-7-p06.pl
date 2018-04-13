true.

% learning f/2
% clauses: 1
% is better: 90
% clauses: 2
% is better: 88
% clauses: 3
% is better: 86
% is better: 85
% clauses: 4
% is better: 84
% is better: 82
% clauses: 5
% is better: 80
% is better: 78
% is better: 74
% clauses: 6
% is better: 72
% is better: 70
% is better: 66
% is better: 58
f(A,B):-f_1(A,C),f_5(C,B).
f_1(A,B):-f_2(A,C),f_2(C,B).
f_2(A,B):-f_3(A,C),f_3(C,B).
f_3(A,B):-f_4(A,C),f_4(C,B).
f_4(A,B):-tail(A,C),tail(C,B).
f_5(A,B):-dropWhile(A,B,not_number).
true.


