true.

true.

% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% is better: 486
% clauses: 4
% is better: 457
% is better: 212
% is better: 211
% clauses: 5
% is better: 206
% is better: 205
% timeout
f(A,B):-tail(A,C),f_1(C,B).
f_1(A,B):-f_2(A,B),head(A,B).
f_1(A,B):-tail(A,C),f_1(C,B).
f_2(A,B):-tail(A,C),f_3(C,B).
f_3(A,B):-tail(A,C),head(C,B).
true.


