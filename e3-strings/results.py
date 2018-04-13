import numpy as np
from scipy import stats
max_k=10

def mad(xs):
    med = np.median(xs)
    return 1.4826*np.median([abs(x - med) for x in xs])

def f(prob,mode):
    all_costs = []
    for k in range(1,max_k+1):
        costs=[]
        with open('results/{0}-{1}-{2}.pl'.format(mode,k,prob),'r') as f:
            for line in f:
                xs = line.strip().split(',')
                if len(xs) > 1:
                    costs.append(float(xs[0]))
        all_costs.append(np.median(costs))
    print '({0},{1}) +- (0,{2})'.format(prob,np.median(all_costs),mad(all_costs))

for name in ['metagol','metagolo','metaopt']:
    print '%',name
    print "\\addplot+[error bars/.cd,y dir=both,y explicit] coordinates {"
    for p in ['p01','p06','p08','p11','p22c','p25','p29','p30','p31','p32']:
        f(p,name)
    print "};"