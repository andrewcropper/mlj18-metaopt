rm -rf 'data'
mkdir 'data'

function f {
  k=$1
  yap -q << % >> "data/train-$k.pl"
  ['experiment'].
  gen_train_data.
%
  for n in 2 4 6 8 10 12 14
  do
    echo $n $k
    yap << % >> "data/test-$n-$k.pl"
    ['experiment'].
    gen_test_data($n).
%
  done
}

for k in `seq 20`
do
  f $k
done