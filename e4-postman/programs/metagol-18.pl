% learning f/2
% clauses: 1
% clauses: 2
% clauses: 3
% clauses: 4
% clauses: 5
f(A,B):-f_1(A,C),pman_go_to_start(C,B).
f(A,B):-f_1(A,C),f(C,B).
f_1(A,B):-pman_go_to_start(A,C),f_2(C,B).
f_1(A,B):-find_next_sender(A,C),bag_letter(C,B).
f_2(A,B):-find_next_recipient(A,C),give_letter(C,B).
