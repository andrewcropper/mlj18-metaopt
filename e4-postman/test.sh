# rm -rf results
# mkdir results

function metagol {
  k=$1
  m=$2
  # swipl -q << % >> "results/metagol-$m-$k.txt"
  yap << % >> "results/metagol-$m-$k.txt"
  ['programs/metagol-$k'].
  ['data/test-$m-$k'].
  ['e-metaopt'].
  do_test.
%
}

function metaopt {
  k=$1
  m=$2
  # swipl -q << % >> "results/metaopt-$m-$k.txt"
  yap << % >> "results/metaopt-$m-$k.txt"
  ['programs/metaopt-$k'].
  ['data/test-$m-$k'].
  ['e-metaopt'].
  do_test.
%
}

function f {
  k=$1
  for n in 2 4 6 8 10 12 14
  # for n in 14
  do
    echo $k $n
    metagol $k $n
    metaopt $k $n
  done
}

# for k in `seq 2`
# do
#     f $k
# done


f $1