trials=10

rm -rf 'results'
mkdir 'results'

function metagol {
  k=$1
  name=$2
  swipl -q << % >> "results/metagol-$k-$name.pl"
  ['programs/metagol-$k-$name'].
  ['e-metaopt'].
  do_test($k,$name).
%
}

function metagolo {
  k=$1
  name=$2
  swipl -q << % >> "results/metagolo-$k-$name.pl"
  ['programs/metagolo-$k-$name'].
  ['e-metaopt'].
  do_test($k,$name).
%
}

function metaopt {
  k=$1
  name=$2
  swipl -q << % >> "results/metaopt-$k-$name.pl"
  ['programs/metaopt-$k-$name'].
  ['e-metaopt'].
  do_test($k,$name).
%
}

for k in `seq $trials`
do
  for p in p01 p06 p07 p08 p11 p22c p25 p29 p30 p31 p32
  do
    echo $k $p
    metagol $k $p
    metaopt $k $p
    metagolo $k $p
  done
done
