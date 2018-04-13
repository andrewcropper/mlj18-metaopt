% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% clauses: 4
% clauses: 5
% is better: 102
% is better: 82
% is better: 78
% is better: 66
% clauses: 6
% is better: 64
f(A,B):-f_1(A,C),pman_go_to_start(C,B).
f(A,B):-f_1(A,C),f(C,B).
f_1(A,B):-pman_go_to_start(A,C),f_2(C,B).
f_1(A,B):-f_2(A,C),f_1(C,B).
f_2(A,B):-find_next_recipient(A,C),give_letter(C,B).
f_2(A,B):-find_next_sender(A,C),bag_letter(C,B).
