
import sys, config, libs, os

def converttime(time):

  h = int(time)
  x = time -h
  m = int(x*60.)
  s = int(round((x*60-m)*60.))

  return h, m, s


filename = sys.argv[1]
srcname = sys.argv[2]
ddir = config.fdir

os.system("grep -A 1 -B 1 OBJECT "+ddir+filename+" | awk '{print $1}' > dummy1")
os.system("grep -v OBJECT dummy1 | grep -v '\-' | grep -v End > dummy2")

d = libs.readinfile("dummy2")[0]
nscans = len(d)/2

f = open(config.logdir+filename[:-4]+"log", "w")

nds = ['off', 'ehi', 'hi', 'med', 'low']
st = ['start', 'stop']
for i in range(nscans):
  h1, m1, s1 = converttime(d[i*2])
  h2, m2, s2 = converttime(d[i*2+1])
  f.write(str(h1)+' '+str(m1)+' '+str(s1)+' '+srcname+' on contm '+nds[i%5]+' '+st[0]+' 1330\n')
  f.write(str(h2)+' '+str(m2)+' '+str(s2)+' '+srcname+' on contm '+nds[i%5]+' '+st[1]+' 1330\n')

f.close()
