#simple plot
import numpy as np
import pylab as pl
s=data.data
#signal over time
mean=np.mean(s,axis=1)
pl.figure()
pl.plot(mean[0],label='zeroth pol')
pl.plot(mean[1],label='first pol')
pl.xlabel('time')
pl.ylabel('intensity')
pl.title('mean signal over time')
pl.legend()
#calculating bandshape
band=np.mean(s,axis=2)
pl.figure()
pl.plot(band[0],label='zeroth pol')
pl.plot(band[1],label='first pol')
pl.xlabel('frequency')
pl.ylabel('intensity')
pl.title('mean banshape')
pl.legend()

