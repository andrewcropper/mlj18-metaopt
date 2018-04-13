trials=20

rm -rf 'programs'
mkdir 'programs'

function metagol {
  k=$1
  yap << % >> "programs/metagol-$k.pl"
  ['data/train-$k'].
  ['e-metagol'].
  learn.
%
}

function metaopt {
  k=$1
  yap << % >> "programs/metaopt-$k.pl"
  ['data/train-$k'].
  ['e-metaopt'].
  learn.
%
}

for k in `seq $trials`
do
  metagol $k
  metaopt $k
done