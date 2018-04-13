world_check(X,A):-
  nonvar(A),
  member(X,A).

world_replace(X,Y,A,B):-
  nonvar(A),
  append(Prefix,[X|Suffix],A),
  append(Prefix,[Y|Suffix],B).

value_at(A,Index,Value):-
  world_check(values(L),A),
  nth1(Index,L,Value).

value_replace_at(A,B,I,X) :-
  world_check(values(L),A),
  Dummy =.. [dummy|L],
  J is I,
  setarg(J,Dummy,X),
  Dummy =..[dummy|R],
  world_replace(values(L),values(R),A,B).

move_all_bag([],S1,S1,_):- !.

move_all_bag([Id/_|T],S1,S2,Pos) :-
  world_replace(pos(Id,_),pos(Id,Pos),S1,S3),
  move_all_bag(T,S3,S2,Pos).

pman_move_right(S1,S2) :-
  world_check(pos(postman,Pos1),S1),
  world_check(end_pos(EndPos),S1),
  Pos2 is Pos1+1,
  Pos2 =< EndPos,
  world_replace(pos(postman,_),pos(postman,Pos2),S1,S3),
  world_check(postman_bag(Bag1),S1),
  move_all_bag(Bag1,S3,S4,Pos2),
  increment_energy(S4,S2,1).

pman_move_left(S1,S2) :-
  world_check(pos(postman,Pos1),S1),
  world_check(start_pos(StartPos),S1),
  Pos2 is Pos1-1,
  Pos2 >= StartPos,
  world_replace(pos(postman,_),pos(postman,Pos2),S1,S3),
  world_check(postman_bag(Bag1),S1),
  move_all_bag(Bag1,S3,S4,Pos2),
  increment_energy(S4,S2,1).

pman_go_to_start(S1,S2) :-
  world_check(pos(postman,OldPos),S1),
  world_check(start_pos(NewPos),S1),
  OldPos \= NewPos,
  world_replace(pos(postman,OldPos),pos(postman,NewPos),S1,S3),
  world_check(postman_bag(Bag1),S1),
  move_all_bag(Bag1,S3,S4,NewPos),
  EnergyUsed is OldPos-NewPos,
  %% EnergyUsed > 0,
  increment_energy(S4,S2,EnergyUsed).

pman_go_to_end(S1,S2) :-
  world_check(pos(postman,OldPos),S1),
  world_check(end_pos(NewPos),S1),
  OldPos \= NewPos,
  world_replace(pos(postman,OldPos),pos(postman,NewPos),S1,S3),
  world_check(postman_bag(Bag1),S1),
  move_all_bag(Bag1,S3,S4,NewPos),
  EnergyUsed is NewPos-OldPos,
  %% EnergyUsed > 0,
  increment_energy(S4,S2,EnergyUsed).

bag_letter(S1,S2):-
  world_check(pos(postman,Pos),S1),

  %% check for letter in this position
  world_check(pos(Id,Pos),S1),
  %% check that it is not already in the bag
  world_check(postman_bag(Bag1),S1),
  not(member(Id/_,Bag1)),
  %% get destination
  world_check(letter(Id,_,Destination),S1),

  %% check that it is not already delivered
  Pos \= Destination,

  append(Bag1,[Id/Destination],Bag2),

  %% trace,
  world_replace(postman_bag(Bag1),postman_bag(Bag2),S1,S3),
  increment_energy(S3,S2,1).

give_letter(S1,S2):-
  world_check(pos(postman,Pos),S1),
  world_check(postman_bag(Bag1),S1),
  %% for letter is in this position
  world_check(pos(Id,Pos),S1),
  %% find letter in the bag to deliver to this position
  append(Prefix,[Id/Pos|Suffix],Bag1),
  %% remove letter from bag
  append(Prefix,Suffix,Bag2),
  world_replace(postman_bag(Bag1),postman_bag(Bag2),S1,S3),

  %% updated delivered_count
  world_check(delivered_count(DeliveredCount1),S1),
  DeliveredCount2 is DeliveredCount1+1,

  %% updated delivered_count
  world_replace(delivered_count(DeliveredCount1),delivered_count(DeliveredCount2),S3,S4),
  increment_energy(S4,S2,1).

find_next_sender(S1,S1):- bag_letter(S1,_),!.
find_next_sender(S1,S2):- pman_move_right(S1,S3), find_next_sender(S3,S2).

find_next_recipient(S1,S1):- give_letter(S1,_),!.
find_next_recipient(S1,S2):- pman_move_right(S1,S3), find_next_recipient(S3,S2).

take_letter(A,B):-
  world_check(postman_bag([]),A),
  bag_letter(A,B).

increment_energy(A,B,Amount):-
  world_check(energy(E1),A),
  E2 is E1+Amount,
  world_replace(energy(E1),energy(E2),A,B).