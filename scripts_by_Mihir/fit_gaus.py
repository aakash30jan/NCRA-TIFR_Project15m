import numpy as N, pylab as pl, scipy.optimize as so
pl.ion()

def poly(par,x,n):
    poly=0
    for i in range(n+1):
        poly+=par[i]*(x**i)
    return poly

def gaus(p,x,n=1):
    return p[0]*N.exp(-((x-p[1])**2)/(2*p[2]**2))+poly(p[3:],x,n)

def errfunc(p,x,y,n):
    return gaus(p,x,n)-y

def remnan(x,y):
    """Removes all Nan from y and corresponding x elements as well. x and y should have same size."""
    nonans=N.where(~N.isnan(y))
    y1=N.array(y[nonans])
    x1=N.array(x[nonans])
    return x1,y1

pointings=N.sum(data.pointing)
n=3
totarr=N.zeros((pointings,2,1023,n+4))
onbyoff=N.zeros((pointings,2,1023,))
nscan=-1
for scan in range(data.nscans):
    if data.pointing[scan]==True:
        nscan+=1
        print scan
        for pol in range(2):
            for chan in range(1023):
                y=data.scans[scan].data[pol,chan]
                flag=data.scans[scan].iniflag_mask[pol,chan]*data.scans[scan].inipiece_mask[pol,chan]
                y=y*flag
                x=N.arange(float(len(y)))
                x,y=remnan(x,y)
                if len(y)>0:
#                    print chan
                    p0=[N.max(y),N.argmax(y),10.,N.min(y)]+[0]*n
                    pnew=so.leastsq(errfunc,p0,args=(x,y,n))[0]
                    onval=pnew[0]
                    offval=poly(pnew[3:],pnew[1],n)
                    ratio=onval/offval
                else:
                    pnew=[N.nan]*(n+4)
                    ratio=N.nan
                totarr[nscan,pol,chan]=pnew
                onbyoff[nscan,pol,chan]=ratio
