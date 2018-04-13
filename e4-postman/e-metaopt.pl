:-[experiment].

pos_cost(Goal,C):-
    Goal=..[P,A,B],
    world_check(energy(E1),A),
    world_check(energy(E2),B),
    C is E2-E1.
neg_cost(_Goal,0).

learn:-
  examples(Pos,Neg),
  max_time(MaxTime),
  %% YAP
  time_out(metagol:metagolo(Pos,Neg),MaxTime,Result),((Result = time_out) -> (!,writeln('% timeout'),metagol:get_best_program(G),metagol:pprint(G)); true).