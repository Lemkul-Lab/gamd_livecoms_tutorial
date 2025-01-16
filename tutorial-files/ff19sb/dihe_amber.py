# Sv
import pytraj as pt
import sys
import numpy as np

#
pdb_ref = sys.argv[1]
traj    = sys.argv[2]

outprefix = sys.argv[3]

# timestep
dt = 20

#define heavy sele (segid PROA .and. .not. type H*) .and. resid 45 : 289 end
#define bb sele heavy .and. (type N .or. type CA .or. type C .or. type O) end

# 1res in charmm = 29, so res45 in amber is actually res17 while res289 is actually res261

print("Loading trajectory...")
traj_load = pt.load(traj, pdb_ref)

print("Calculating...")
phi = pt.dihedral(traj_load, '@5 @7 @9 @15', top=pdb_ref)
psi = pt.dihedral(traj_load, '@7 @9 @15 @17', top=pdb_ref)

#print(phi)

time = len(phi)*int(dt)/1000
time_array = np.arange(0,time,int(dt)/1000)


print("Writing output...")
o1 = open(outprefix + "_dihe.dat", "w")
o1.write("#phi    psi\n")

for i in range(0,len(phi)):
    t = "{:.2f}".format(time_array[i])
   # rphi = round(phi[i], 6)
   # rpsi = round(psi[i], 6)
    
    line_dihe = str(phi[i]).ljust(25, " ") + str(psi[i]).ljust(25, " ") + "\n"

    o1.write(line_dihe)

o1.close()
