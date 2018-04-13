:-['../metaopt'].
:-['mergesort'].

%% :-dynamic(num_train_examples/1).
max_time(600). % 10 mins in SWI

%% num_train_examples(10).
%% num_test_examples(50).

metagol:functional.
metagol:limit_recursion.

metarule(dident,[P,Q,R],([P,A,B]:-[[Q,A,B],[R,A,B]])):-freeze(Q,freeze(R,Q\=R)).
metarule(chain,[P,Q,R],([P,A,B]:-[[Q,A,C],[R,C,B]])).
metarule(tailrec,[P,Q],([P,A,B]:-[[Q,A,C],[P,C,B]])).

prim(mergesort/2).
prim(tail/2).
prim(head/2).
prim(element/2).

mergesort(A,B):-
  merge_sort(A,B),
  A\=B.

head([H|_],H).
tail([_|T],T).
element([X|_T],X).
element([_|T],X):-element(T,X).

%% GEN TRAIN DATA

gen_train_data(NumExamples):-
  gen_pos_examples(NumExamples,Pos1),
  sort_gen_examples(Pos1,Pos2),
  maplist(print_pos_example,Pos2),
  gen_neg_examples(NumExamples,Neg1),
  sort_gen_examples(Neg1,Neg2),
  maplist(print_neg_example,Neg2).

gen_test_data(NumExamples,N):-
  gen_pos_examples_with_size(NumExamples,N,Pos1),
  sort_gen_examples(Pos1,Pos2),
  maplist(print_pos_example,Pos2),
  gen_neg_examples_with_size(NumExamples,N,Neg1),
  sort_gen_examples(Neg1,Neg2),
  maplist(print_neg_example,Neg2).

gen_pos_examples(NumExamples,Xs):-
  findall(G, (
    between(1,NumExamples,_),
    random_between(5,100,NumElements),
    gen_pos_example(NumElements,A,B),
    G =..[f,A,B]),Xs).

gen_neg_examples(NumExamples,Xs):-
  findall(G, (
    between(1,NumExamples,_),
    random_between(5,100,NumElements),
    gen_neg_example(NumElements,A,B),
    G =..[f,A,B]),Xs).

gen_pos_examples_with_size(NumExamples,NumElements,Xs):-
findall(G, (
    between(1,NumExamples,_),
    gen_pos_example(NumElements,A,B),
    G =..[f,A,B]),Xs).

gen_neg_examples_with_size(NumExamples,NumElements,Xs):-
findall(G, (
    between(1,NumExamples,_),
    gen_neg_example(NumElements,A,B),
    G =..[f,A,B]),Xs).

gen_pos_example(N,L,X):-
  numlist(1,N,L1),
  random_between(1,N,X),!,
  L2=[X|L1],
  random_permutation(L2,L).

gen_neg_example(N,L,X):-
  numlist(1,N,L1),
  random_between(1,N,X),!,
  random_permutation(L1,L).



add_count(f(A,B),N-f(A,B)):-length(A,N).
remove_k(_-V,V).

print_pos_example(f(A,B)):-
  format('pos_ex(~w,~w).\n',[A,B]).

print_neg_example(f(A,B)):-
  format('neg_ex(~w,~w).\n',[A,B]).

sort_gen_examples(L1,L2):-
  maplist(add_count,L1,L3),
  keysort(L3,L4),
  maplist(remove_k,L4,L2).

examples(Pos,Neg):-
  pos_examples(Pos),
  neg_examples(Neg).

pos_examples(Pos):-
  findall(f(A,B),pos_ex(A,B),Pos).
neg_examples(Neg):-
  current_predicate(neg_ex/2),!,
  findall(f(A,B),neg_ex(A,B),Neg).
neg_examples([]).

do_test:-
  current_predicate(f/2),!,
  foreach(pos_ex(A,B),test_ex(f(A,B))),
  foreach(neg_ex(A,B),test_ex(f(A,B))).
do_test.

test_ex(G):-
  G=..[P,A,B],
  NewG=..[P,A,C],
  get_time(T1),
  statistics(inferences,I1),!,
  ((call(NewG),B=C) -> true; true),
  statistics(inferences,I2),
  get_time(T2),
  Cost is I2-I1,
  Time is T2-T1,
  format('~d,~w\n',[Cost,Time]).

func_test(Atom,PS,G):-
  Atom = [P,A,B],
  Actual = [P,A,Z],
  \+ (metagol :prove_deduce([Actual],PS,G,_),Z \= B).