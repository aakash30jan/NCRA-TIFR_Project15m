import numpy as N
from scipy.optimize import leastsq
import pylab as pl
pl.ion()

def gauss(c,x):
    yy = c[0]*N.exp(-0.5*(x-c[1])*(x-c[1])/(c[2]*c[2]))+c[3]+c[4]*x
    return yy
def res(c,x,y):
    return gauss(c,x)-y

def fit(p0,x,y,res):
    p1=leastsq(res, c, args=(x, y))[0]
    return p1

def  
for scan in range(data.nscans):
    if data.pointing[scan]==True:
        for pol in range(2):
             
