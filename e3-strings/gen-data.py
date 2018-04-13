import itertools

def dif(A,B):
  bset = set(str(x) for x in B)
  for x in A:
    if str(x) not in bset:
      yield x

dic = {}

with open('problems.txt', 'r') as f:
  for line in f:
    xs=line.strip().split('=>')
    if len(xs)==1 and len(xs[0])>0:
      problem=xs[0]
    elif len(xs)>1:
      if problem not in dic:
        dic[problem] = []
      dic[problem].append(xs)
for problem,examples in dic.iteritems():
  for index,train in enumerate(itertools.combinations(examples,3)):
    test = list(dif(examples,train))
    for x in train:
      print 'train_ex({0},{1},{2},{3}).'.format(index+1,problem,list(x[0].strip()),list(x[1].strip()))
    for x in test:
      print 'test_ex({0},{1},{2},{3}).'.format(index+1,problem,list(x[0].strip()),list(x[1].strip()))