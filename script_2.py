s0n=(s0.data)*(s0.iniflag_mask)*(s0.inibpflag_mask)
pl.subplot(1,2,1)
pl.plot(np.nansum(s0n[0,:,:],0)/np.nansum(((s0.iniflag_mask)*(s0.inibpflag_mask))[0,:,:],0))
pl.xlabel('time')
pl.ylabel('intensity avg over freq')
pl.subplot(1,2,2)
pl.plot(np.nansum(s0n[0,:,:],1)/np.nansum(((s0.iniflag_mask)*(s0.inibpflag_mask))[0,:,:],1))
pl.xlabel('frequency')
pl.ylabel('intensity avg over time')
pl.savefig('t_f_i_gen.png')




WITH ONLY INIflag_MASK PLOTTING OF INTENSITY VS TIME
pl.plot(np.mean(s0.data[0,:,:],0))


WITH ONLY INIflag_MASK PLOTTING OF INTENSITY VS FREQUENCY
pl.plot(np.mean(s0.data[0,:,:],1))


TIME VS FREQUENCY DISTRIBUTION WITHOUT flag_ING
pl.imshow(s0.data[0,:,:])

TIME VS FREQUENCY DISTRIBUTION WITH flag_ING
pl.imshow(s0n.data[0,:,:])


PLOTTING OF TSOURCE/TSYS WRT TIME BY USING BOTH flag_S
k1=np.nansum(s0n[0,:,:],0)/np.nansum(((s0.iniflag_mask)*(s0.inibpflag_mask)
k2=np.nansum(s1n[0,:,:],0)/np.nansum(((s1.iniflag_mask)*(s1.inibpflag_mask)
pl.plot((k2-k1)/k1), label's0s1')
pl.xlabel('time')
pl.ylabel('Tsrc/Tsys)



PLOTTING OF TSOURCE/TSYS WRT TIME BY WITHOUT USING flag_S
k1=np.mean(s0.data[0,:,:],0)
k2=np.mean(s1.data[0,:,:],0)
pl.plot((k2-k1)/k1), label's0s1')
pl.xlabel('time')
pl.ylabel('Tx/Tsys)
