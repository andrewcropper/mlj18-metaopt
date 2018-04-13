# trials=20

# rm -rf 'data'
# mkdir 'data'

# for k in `seq $trials`
# do
#   sleep 1
#   # swipl -q << % >> "data/train-$k.pl"
#   yap << % >> "data/train-$k.pl"
#   ['experiment'].
#   gen_train_data.
# %
# done

# for k in `seq $trials`
# do
#   for n in 2 4 6 8 10 12 14 16 18 20
#   do
#     sleep 1
#     # swipl -q << % >> "data/test-$n-$k.pl"
#     yap << % >> "data/test-$n-$k.pl"
#     ['experiment'].
#     gen_test_data($n).
# %
#   done
# done

function f {
  k=$1
  yap -q << % >> "data/train-$k.pl"
  ['experiment'].
  gen_train_data.
%
  for n in 2 4 6 8 10 12 14
  # for n in 14
  do
    echo $n $k
    yap << % >> "data/test-$n-$k.pl"
    ['experiment'].
    gen_test_data($n).
%
  done
}

f $1