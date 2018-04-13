:- use_module(library(random)).
:- use_module(library(lists)).
:- use_module(library(apply)).
:- use_module(library(pairs)).
:- use_module(library(timeout)).
:- use_module(library(system)).
:- use_module(library(aggregate)).

:-['../metaopt'].
%% :-['../robot-costs'].
:-[postman].

max_time(600000). % 10 mins

num_train_examples(5).
num_test_examples(100).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TRAINING DATA GENERATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rand_select(X,L1,L2):-
  length(L1,N),
  random(1,N,I),
  nth1(I,L1,X),
  select(X,L1,L2).

rand_pair(X/Y,L1,L2):-
  rand_select(X,L1,L3),
  rand_select(Y,L3,L2).

remove_one(L1,L2):-
  select(1,L1,L2), !.
remove_one(L1,L1).

tmp_(0,_,[]) :- !.
tmp_(NumLetters1,L1,[letter(NumLetters1,StartPos,EndPos)|Letters]):-
  rand_pair(StartPos/EndPos,L1,L3),
  NumLetters2 is NumLetters1 - 1,
  tmp_(NumLetters2,L3,Letters).

tmp(NumLetters,MaxSpace,Letters):-
  Limit is MaxSpace-1,
  numlist(2,Limit,L1),
  remove_one(L1,L2),
  tmp_(NumLetters,L2,Letters).

letters_start_pos(Letters,LettersStartPositions):-
  findall(pos(I,StartPos), member(letter(I,StartPos,_),Letters),LettersStartPositions).

letters_end_pos(Letters,LettersEndPositions):-
  findall(pos(I,EndPos), member(letter(I,_,EndPos),Letters),LettersEndPositions).

gen_example(SpaceSize,NumLetters,A,B):-
  tmp(NumLetters,SpaceSize,Letters),
  letters_start_pos(Letters,LettersStartPositions),
  letters_end_pos(Letters,LettersEndPositions),
  append(LettersStartPositions,Letters,T1),
  append(LettersEndPositions,Letters,T2),!,
  A = [pos(postman,0),energy(0),postman_bag([]),start_pos(0),end_pos(SpaceSize),delivered_count(0)|T1],
  B = [pos(postman,0),energy(_),postman_bag([]),start_pos(0),end_pos(SpaceSize),delivered_count(NumLetters)|T2].

gen_examples(NumExamples,Xs):-
  findall(G, (
    between(1,NumExamples,_),
    random(10,25,SpaceSize),
    random(2,5,NumLetters),
    gen_example(SpaceSize,NumLetters,A,B),
    G =..[f,A,B]),Xs).

gen_examples(NumExamples,NumLetters,Xs):-
  SpaceSize=50,
  findall(G, (
    between(1,NumExamples,_),
    gen_example(SpaceSize,NumLetters,A,B),
    G =..[f,A,B]),Xs).

add_count(f(A,B),SpaceSize-f(A,B)):-
  world_check(end_pos(SpaceSize),A).
remove_k(_-V,V).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% LEARNING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prim(take_letter/2).
prim(give_letter/2).
prim(pman_go_to_start/2).
prim(find_next_sender/2).
prim(find_next_recipient/2).
prim(bag_letter/2).

metarule(pab_qac_pcb,[P,Q],([P,A,B]:-[[Q,A,C], @obj_gt(A,C),[P,C,B],@obj_gt(C,B)])).
metarule(pab_qac_rcb,[P,Q,R],([P,X,Y]:-[[Q,X,Z],[R,Z,Y]])).

obj_gt(A,B):-
  world_check(delivered_count(Ca),A),
  world_check(delivered_count(Cb),B),
  Cb > Ca,!.

obj_gt(A,B):-
  world_check(postman_bag(BagA),A),
  world_check(postman_bag(BagB),B),
  length(BagA,La),
  length(BagB,Lb),
  Lb > La,!.

set_rand:-
  datime(datime(_,_Month,_Day,_H,Minute,Second)),
  X is Minute * Second,Y=X,Z=X,
  setrand(rand(X,Y,Z)).

gen_train_data:-
  set_rand,
  num_train_examples(NumExamples),
  gen_examples(NumExamples,Pos1),
  sort_gen_examples(Pos1,Pos2),
  maplist(print_gen_example,Pos2).

gen_test_data(N):-
  set_rand,
  num_test_examples(NumExamples),
  gen_examples(NumExamples,N,Pos1),
  maplist(print_gen_example,Pos1).

print_gen_example(f(A,B)):-
  format('pos_ex(~w,~w).\n',[A,B]).

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
  foreach(pos_ex(A,B),test_ex(f(A,B))).

test_ex(G):-
  get_time(T1),
  test_ex_aux(G,Cost),
  get_time(T2),
  Time is T2-T1,
  format('~w,~w\n',[Cost,Time]).

test_ex_aux(G,Cost):-
  G=..[P,A,B],
  NewG=..[P,A,C],
  (call(NewG),B=C),!,
  world_check(energy(E1),A),
  world_check(energy(E2),B),
  Cost is E2-E1.

test_ex_aux(G,inf).


%% func_test(Atom,PS,G):-
%%   Atom = [P,A,B],
%%   Actual = [P,A,Z],
%%   \+ (metagol :prove_deduce([Actual],PS,G,_),Z \= B).