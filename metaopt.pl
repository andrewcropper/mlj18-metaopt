%% This is a copyrighted file under the BSD 3-clause licence, details of which can be found in the root directory.

:- module(metagol,[metagol/2,metaopt/2,metagolo/2,pprint/1,op(950,fx,'@')]).

:- user:use_module(library(lists)).

:- use_module(library(lists)).
:- use_module(library(apply)).
:- use_module(library(pairs)).

:- dynamic
    functional/0,
    print_ordering/0,
    min_clauses/1,
    max_clauses/1,
    max_inv_preds/1,
    metarule_next_id/1,
    interpreted_bk/2,
    user:prim/1,
    user:primcall/2.

:- discontiguous
    user:metarule/7,
    user:metarule_init/6,
    user:prim/1,
    user:primcall/2.

default(min_clauses(1)).
default(max_clauses(6)).
default(metarule_next_id(1)).
default(max_inv_preds(10)).

learn(Pos1,Neg1,Prog,AllCosts):-
    maplist(atom_to_list,Pos1,Pos2),
    maplist(atom_to_list,Neg1,Neg2),
    proveall(Pos2,Sig,Prog,AllCosts),
    nproveall(Neg2,Sig,Prog),
    is_functional(Pos2,Sig,Prog).

learn_seq(Seq,Prog):-
    maplist(learn_task,Seq,Progs),
    flatten(Progs,Prog).

learn_task(Pos/Neg,Prog):-
    learn(Pos,Neg,Prog),!,
    maplist(assert_clause,Prog),
    assert_prims(Prog).

proveall(Atoms,Sig,Prog,AllCosts):-
    target_predicate(Atoms,P/A),
    format('% learning ~w\n',[P/A]),
    iterator(MaxN),
    format('% clauses: ~d\n',[MaxN]),
    invented_symbols(MaxN,P/A,Sig),
    prove_examples(Atoms,Sig,_Sig,MaxN,0,_N,[],Prog,AllCosts).

prove_examples([],_FullSig,_Sig,_MaxN,N,N,Prog,Prog,[]).
prove_examples([Atom|Atoms],FullSig,Sig,MaxN,N1,N2,Prog1,Prog2,[C|AllCosts]):-
    prove_deduce([Atom],FullSig,Prog1,C),!,
    is_functional([Atom],Sig,Prog1),
    prove_examples(Atoms,FullSig,Sig,MaxN,N1,N2,Prog1,Prog2,AllCosts).
prove_examples([Atom1|Atoms],FullSig,Sig,MaxN,N1,N2,Prog1,Prog2,[C|AllCosts]):-
    add_empty_path(Atom1,Atom2),
    prove([Atom2],FullSig,Sig,MaxN,N1,N3,Prog1,Prog3,0,C),
    prove_examples(Atoms,FullSig,Sig,MaxN,N3,N2,Prog3,Prog2,AllCosts).

prove_deduce(Atoms1,Sig,Prog,C):-
    maplist(add_empty_path,Atoms1,Atoms2),
    length(Prog,N),
    prove(Atoms2,Sig,_,N,N,N,Prog,Prog,0,C).

prove([],_FullSig,_Sig,_MaxN,N,N,Prog,Prog,C,C).
prove([Atom|Atoms],FullSig,Sig,MaxN,N1,N2,Prog1,Prog2,C1,C2):-
    prove_aux(Atom,FullSig,Sig,MaxN,N1,N3,Prog1,Prog3,C1,C3),
    prove(Atoms,FullSig,Sig,MaxN,N3,N2,Prog3,Prog2,C3,C2).


%% %% prove order constraint
prove_aux('@'(Atom),_FullSig,_Sig,_MaxN,N,N,Prog,Prog,C,C):-!,
    user:call(Atom).

%% prove primitive atom
prove_aux(p(prim,P,_A,Args,_,_Path),_FullSig,_Sig,_MaxN,N,N,Prog,Prog,C1,C2):-
    prim_cost_call(P,Args,C),
    C2 is C1+C,
    is_better(C2).

%% use existing abduction
prove_aux(p(inv,P,A,_Args,Atom,Path),FullSig,Sig1,MaxN,N1,N2,Prog1,Prog2,C1,C2):-
    select_lower(P,A,FullSig,Sig1,Sig2),
    member(sub(Name,P,A,MetaSub,PredTypes),Prog1),
    user:metarule_init(Name,MetaSub,PredTypes,(Atom:-Body1),Recursive,[Atom|Path]),
    (Recursive==true -> \+memberchk(Atom,Path); true),
    prove(Body1,FullSig,Sig2,MaxN,N1,N2,Prog1,Prog2,C1,C2).

%% new abduction
prove_aux(p(inv,P,A,_Args,Atom,Path),FullSig,Sig1,MaxN,N1,N2,Prog1,Prog2,C1,C2):-
    (N1 == MaxN -> fail; true),
    bind_lower(P,A,FullSig,Sig1,Sig2),
    user:metarule(Name,MetaSub,PredTypes,(Atom:-Body1),FullSig,Recursive,[Atom|Path]),
    (Recursive==true -> \+memberchk(Atom,Path); true),
    check_new_metasub(Name,P,A,MetaSub,Prog1),
    succ(N1,N3),
    prove(Body1,FullSig,Sig2,MaxN,N3,N2,[sub(Name,P,A,MetaSub,PredTypes)|Prog1],Prog2,C1,C2).

add_empty_path([P|Args],p(inv,P,A,Args,[P|Args],[])):-
    size(Args,A).

select_lower(P,A,FullSig,_Sig1,Sig2):-
    nonvar(P),!,
    append(_,[sym(P,A,_)|Sig2],FullSig),!.

select_lower(P,A,_FullSig,Sig1,Sig2):-
    append(_,[sym(P,A,U)|Sig2],Sig1),
    (var(U)-> !,fail;true ).

bind_lower(P,A,FullSig,_Sig1,Sig2):-
    nonvar(P),!,
    append(_,[sym(P,A,_)|Sig2],FullSig),!.

bind_lower(P,A,_FullSig,Sig1,Sig2):-
    append(_,[sym(P,A,U)|Sig2],Sig1),
    (var(U)-> U = 1,!;true).

check_new_metasub(Name,P,A,MetaSub,Prog):-
    memberchk(sub(Name,P,A,_,_),Prog),!,
    last(MetaSub,X),
    when(nonvar(X),\+memberchk(sub(Name,P,A,MetaSub,_),Prog)).
check_new_metasub(_Name,_P,_A,_MetaSub,_Prog).

size([],0) :-!.
size([_],1) :-!.
size([_,_],2) :-!.
size([_,_,_],3) :-!.
size(L,N):- !,
  length(L,N).

nproveall([],_PS,_Prog):- !.
nproveall([Atom|Atoms],PS,Prog):-
    \+ prove_deduce([Atom],PS,Prog,_),
    nproveall(Atoms,PS,Prog).

iterator(N):-
    get_option(min_clauses(MinN)),
    get_option(max_clauses(MaxN)),
    between(MinN,MaxN,N).

target_predicate([[P|Args]|_],P/A):-
    length(Args,A).

invented_symbols(MaxClauses,P/A,[sym(P,A,_U)|Sig]):-
    NumSymbols is MaxClauses-1,
    get_option(max_inv_preds(MaxInvPreds)),
    M is min(NumSymbols,MaxInvPreds),
    findall(sym(InvSym,_Artiy,_Used),(between(1,M,I),atomic_list_concat([P,'_',I],InvSym)),Sig).

pprint(Prog1):-
    map_list_to_pairs(arg(2),Prog1,Pairs),
    keysort(Pairs,Sorted),
    pairs_values(Sorted,Prog2),
    maplist(pprint_clause,Prog2).

pprint_clause(Sub):-
    construct_clause(Sub,Clause),
    numbervars(Clause,0,_),
    format('~q.~n',[Clause]).

%% construct clause is horrible and needs refactoring
construct_clause(sub(Name,_,_,MetaSub,_),Clause):-
    user:metarule_init(Name,MetaSub,_,(HeadList:-BodyAsList1),_,_),
    add_path_to_body(BodyAsList2,_,BodyAsList1,_),
    atom_to_list(Head,HeadList),
    (BodyAsList2 == [] ->Clause=Head;(pprint_list_to_clause(BodyAsList2,Body),Clause = (Head:-Body))).

pprint_list_to_clause(List1,Clause):-
    atomsaslists_to_atoms(List1,List2),
    list_to_clause(List2,Clause).

atomsaslists_to_atoms([],[]).
atomsaslists_to_atoms(['@'(Atom)|T1],Out):- !,
    (get_option(print_ordering) -> Out=[Atom|T2]; Out=T2),
    atomsaslists_to_atoms(T1,T2).
atomsaslists_to_atoms([AtomAsList|T1],[Atom|T2]):-
    atom_to_list(Atom,AtomAsList),
    atomsaslists_to_atoms(T1,T2).

list_to_clause([Atom],Atom):-!.
list_to_clause([Atom|T1],(Atom,T2)):-!,
    list_to_clause(T1,T2).

list_to_atom(AtomList,Atom):-
    Atom =..AtomList.
atom_to_list(Atom,AtomList):-
    Atom =..AtomList.

is_functional(Atoms,Sig,Prog):-
    (get_option(functional) -> is_functional_aux(Atoms,Sig,Prog); true).
is_functional_aux([],_Sig,_Prog).
is_functional_aux([Atom|Atoms],Sig,Prog):-
    func_test(Atom,Sig,Prog),
    is_functional_aux(Atoms,Sig,Prog).

get_option(Option):-call(Option), !.
get_option(Option):-default(Option).

set_option(Option):-
    functor(Option,Name,Arity),
    functor(Retract,Name,Arity),
    retractall(Retract),
    assert(Option).

gen_metarule_id(Id):-
    get_option(metarule_next_id(Id)),
    succ(Id,IdNext),
    set_option(metarule_next_id(IdNext)).

user:term_expansion(interpreted(P/A),L2):-
    functor(Head,P,A),
    findall((Head:-Body),user:clause(Head,Body),L1),
    maplist(convert_to_interpreted,L1,L2).

convert_to_interpreted((Head:-true),metagol:(interpreted_bk(HeadAsList,[]))):-!,
    ho_atom_to_list(Head,HeadAsList).
convert_to_interpreted((Head:-Body),metagol:(interpreted_bk(HeadAsList,BodyList2))):-
    ho_atom_to_list(Head,HeadAsList),
    clause_to_list(Body,BodyList1),
    maplist(ho_atom_to_list,BodyList1,BodyList2).

user:term_expansion(prim(P/A),[user:prim(P/A),user:(primcall(P,Args):-user:Call)]):-
    functor(Call,P,A),
    Call =.. [P|Args].

user:term_expansion(metarule(MetaSub,Clause),Asserts):-
    get_asserts(_Name,MetaSub,Clause,_,_PS,Asserts).
user:term_expansion(metarule(Name,MetaSub,Clause),Asserts):-
    get_asserts(Name,MetaSub,Clause,_,_PS,Asserts).
user:term_expansion((metarule(MetaSub,Clause):-Body),Asserts):-
    get_asserts(_Name,MetaSub,Clause,Body,_PS,Asserts).
user:term_expansion((metarule(Name,MetaSub,Clause):-Body),Asserts):-
    get_asserts(Name,MetaSub,Clause,Body,_PS,Asserts).
user:term_expansion((metarule(Name,MetaSub,Clause,PS):-Body),Asserts):-
    get_asserts(Name,MetaSub,Clause,Body,PS,Asserts).

get_asserts(Name,MetaSub,Clause1,MetaBody,PS,[MRule,metarule_init(AssertName,MetaSub,PredTypes,Clause2,Recursive,Path)]):-
    Clause1 = (Head:-Body1),
    Head = [P|_],
    is_recursive(Body1,P,Recursive),
    add_path_to_body(Body1,Path,Body3,PredTypes),
    Clause2 = (Head:-Body3),
    (var(Name)->gen_metarule_id(AssertName);AssertName=Name),
    (var(MetaBody) ->
        MRule = metarule(AssertName,MetaSub,PredTypes,Clause2,PS,Recursive,Path);
        MRule = (metarule(AssertName,MetaSub,PredTypes,Clause2,PS,Recursive,Path):-MetaBody)).

is_recursive([],_,false).
is_recursive([[Q|_]|_],P,true):-
    Q==P,!.
is_recursive([_|T],P,Res):-
    is_recursive(T,P,Res).

add_path_to_body([],_Path,[],[]).
add_path_to_body(['@'(Atom)|Atoms],Path,['@'(Atom)|Rest],Out):-
    add_path_to_body(Atoms,Path,Rest,Out).
add_path_to_body([[P|Args]|Atoms],Path,[p(PType,P,A,Args,[P|Args],Path)|Rest],[PType|Out]):-
    size(Args,A),
    add_path_to_body(Atoms,Path,Rest,Out).

assert_program(Prog):-
    maplist(assert_clause,Prog).

assert_clause(Sub):-
    construct_clause(Sub,Clause),
    assert(user:Clause).

assert_prims(Prog):-
    findall(P/A,(member(sub(_Name,P,A,_MetaSub),Prog)),Prims),!,
    list_to_set(Prims,PrimSet),
    maplist(assert_prim,PrimSet).

assert_prim(Prim):-
    prim_asserts(Prim,Asserts),
    maplist(assertz,Asserts).

prim_asserts(P/A,[user:prim(P/A), user:(primcall(P,Args):-user:Call)]):-
    functor(Call,P,A),
    Call =.. [P|Args].

clause_to_list((Atom,T1),[Atom|T2]):-
    clause_to_list(T1,T2).
clause_to_list(Atom,[Atom]):- !.

ho_atom_to_list(Atom,T):-
    Atom=..AtomList,
    AtomList = [call|T],!.
ho_atom_to_list(Atom,AtomList):-
    Atom=..AtomList.


%% ==================================================
%% REPLICATING METAGOL
%% ==================================================
metagol(Pos,Neg):-
    set_best_cost(inf),
    set_best_program(false),
    learn(Pos,Neg,Prog,_AllCosts),
    pprint(Prog).

%% ==================================================
%% REPLICATING METAGOLO
%% ==================================================
metagolo(Pos,Neg):-
    set_best_cost(inf),
    set_best_program(false),
    learn(Pos,Neg,Prog,AllCosts),
    max_list(AllCosts,Cost),
    is_better(Cost),
    format('% is better: ~d\n',[Cost]),
    set_best_cost(Cost),
    set_best_program(Prog),
    false.
metagolo(_,_):-
    get_best_program(Prog),
    pprint(Prog).

%% ==================================================
%% METAOPT
%% ==================================================

metaopt(Pos,Neg):-
    set_best_cost(inf),
    set_best_program(false),
    learn(Pos,Neg,Prog,_),
    program_cost(Pos,Neg,Prog,Cost),
    is_better(Cost),
    format('% is better: ~d\n',[Cost]),
    set_best_cost(Cost),
    set_best_program(Prog),
    false.
metaopt(_,_):-
    get_best_program(Prog),
    pprint(Prog).

%% ==================================================
%% GENERAL METAOPT UTILITY FUNCTIONS
%% ==================================================
prim_cost_call(P,Args,C):-
    user:primcall(P,Args),
    Goal=..[P|Args],
    user:pos_cost(Goal,C).

set_best_cost(C):-
  nb_setval(best_cost,C).
get_best_cost(C):-
  nb_getval(best_cost,C).
is_better(C):-
  get_best_cost(Best),
  C< Best.

set_best_program(G):-
  nb_setval(best_program,G).
get_best_program(G):-
  nb_getval(best_program,G).

func_test(Atom,PS,G):-
    Atom = [P,A,B],
    Actual = [P,A,Z],
    \+ (prove_deduce([Actual],PS,G,_),Z \= B).

program_cost(Pos,Neg,Prog,NewBound):-
  retract_old,
  metagol:assert_program(Prog),
  maplist(pos_cost,Pos,PosCosts),
  maplist(neg_cost,Neg,NegCosts),
  retract_old,
  append(PosCosts,NegCosts,Costs),
  max_list(Costs,NewBound).

% TODO: fix this hack
retract_old:-
  retractall(user:f(_,_)),
  retractall(user:f_1(_,_)),
  retractall(user:f_2(_,_)),
  retractall(user:f_3(_,_)),
  retractall(user:f_4(_,_)),
  retractall(user:f_5(_,_)),
  retractall(user:f_6(_,_)),
  retractall(user:f_7(_,_)).