:-[experiment].

pos_cost(_Goal,1).
neg_cost(_Goal,1).


learn:-
  examples(Pos,Neg),
  max_time(MaxTime),

  %% YAP
  time_out(metagol:metagol(Pos,Neg),MaxTime,Result),((Result = time_out) -> (!,writeln('% timeout'),metagol:get_best_program(G),metagol:pprint(G)); true).