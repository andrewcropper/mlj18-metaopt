rm -rf results
mkdir results

function metagol {
  k=$1
  m=$2
  swipl << % >> "results/metagol-$m-$k.txt"
  ['programs/metagol-$k'].
  ['data/test-$m-$k'].
  ['e-metaopt'].
  do_test.
%
}

function metagolo {
  k=$1
  m=$2
  swipl << % >> "results/metagolo-$m-$k.txt"
  ['programs/metagolo-$k'].
  ['data/test-$m-$k'].
  ['e-metaopt'].
  do_test.
%
}

function metaopt {
  k=$1
  m=$2
  swipl << % >> "results/metaopt-$m-$k.txt"
  ['programs/metaopt-$k'].
  ['data/test-$m-$k'].
  ['e-metaopt'].
  do_test.
%
}

function optimal {
  k=$1
  m=$2
  swipl << % >> "results/optimal-$m-$k.txt"
  ['optimal'].
  ['data/test-$m-$k'].
  ['e-metaopt'].
  do_test.
%
}

function f {
  k=$1
  for m in 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000
  do
    metagol $k $m
    metagolo $k $m
    metaopt $k $m
    optimal $k $m
  done
}

for k in `seq 1 20`
do
    f $k
done