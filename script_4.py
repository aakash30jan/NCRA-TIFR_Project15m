s=data.data
#calculating bandshape
band=np.mean(s,axis=2)
pl.figure()
pl.plot(band[0],label='zeroth pol')
pl.plot(band[1],label='first pol')
pl.xlabel('frequency')
pl.ylabel('intensity')
pl.title('mean banshape')
pl.legend()
#calculating mean signal
mean=np.mean(s,axis=1)
pl.figure()
pl.plot(mean[0],label='zeroth pol')
pl.plot(mean[1],label='first pol')
pl.xlabel('time')
pl.ylabel('intensity')
pl.title('mean signal over time')
pl.legend()
#considering data only from zeroth pol
pl.figure()
pl.plot(mean[0],label='zeroth pol')
pl.xlabel('time')
pl.ylabel('intensity')
pl.title('mean signal over time zeroth pol')
#18th june data... taking 0 to 90 as ON
#18th june data... taking 110 to 160 as OFF
t=data.times
t.shape
a1=data.times[0]
a2=data.times[89]
a3=data.times[109]
a4=data.times[159]
print a1,a2,a3,a4
# 15.6198 15.68617 15.70103 15.73834
#scan file will be created
x=[a1,a2,a3,a4]
time=np.zeros((4,3))
for i in range(4):
    time[i,0]=int(x[i])
    time[i,1]=int((x[i]-int(x[i]))*60)
    time[i,2]=int((x[i]-int(x[i]))*60)-int((x[i]-int(x[i]))*60)
#scan file created
#Tsrc_by_Tsys
sc=data.scans
on=sc[0]
off=sc[1]
on=np.nansum(on.iniflag_mask*on.data,axis=2)/np.nansum(on.iniflag_mask,axis=2)
off=np.nansum(off.iniflag_mask*off.data,axis=2)/np.nansum(off.iniflag_mask,axis=2)
on=on[0,:]
off=off[0,:]
T=(on-off)/off
pl.figure()
pl.plot(T)
pl.xlabel('frequency')
pl.ylabel('intensity')
pl.title('Tsrc_by_Tsys')
Tratio=T[150:800]
tratio=Tratio/Tratio
Tvalue=np.nansum(Tratio,axis=0)/np.nansum(tratio,axis=0)
pl.figure()
pl.plot(Tratio)
pl.xlabel('frequency')
pl.ylabel('intensity')
pl.title('Tsrc_by_Tsys[150:800]')
#Tvalue:0.05053
#finding stddev
dev=(Tratio-Tvalue)*(Tratio-Tvalue)
stdev=np.sqrt((np.nansum(dev,axis=0)/np.nansum((dev/dev),axis=0)))
#stdev:0.00129
print 'final value:'+str(Tvalue)+'+-'+str(stdev)+'with percent error:'+str((stdev/Tvalue)*100)






