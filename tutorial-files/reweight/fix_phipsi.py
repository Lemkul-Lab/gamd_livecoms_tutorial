##################################################
# Script to ensure values wrap properly from 
# -180 to 180 in an .xvg file
#
# Note: .xvg files are expected to be tab-separated
#
#
# Last edited hmichel@vt.edu 9/04/2024 13:38 EST
##################################################
import sys

infile = sys.argv[1]
outfile = sys.argv[2]


f = open(infile, 'r')
o = open(outfile, 'w')

d_pmf = {}

#print("hi")
def get_key_from_value(d,val):
    keys = [k for k, v in d.items() if v==val]
    if keys:
        return keys[0]
    return None

lines = f.readlines()

# pull phi, psi, and pmf into variables
for line in lines[5:]:
    phi = line.split()[0]
    # print(phi)
    psi = line.split()[1]
    pmf = line.split()[2]
    
    # set up a dictionary to match pmf to phi and psi
    if -180 <= float(psi) <= 180 and -180 <= float(phi) <= 180:
        d_pmf[phi,psi] = pmf

# print(d_pmf)

# update pmf values for phi = 180 and psi = 180
for key in d_pmf:
    # fix values for phi = 180 first
    if key[0] == "180.0": 
        s_phi = -1 * float(key[0]) + 0 #add 0 to avoid strange -0.0 error when multiplying 0 by -1
        s_psi = float(key[1])
        #print(key[0], key[1], d_pmf[key[0],key[1]], "\t new:", d_pmf[str(s_phi),str(s_psi)])
        s_val = d_pmf[str(s_phi),str(s_psi)]
    # now fix values for psi = 180
    elif key[1] == "180.0":
        s_phi = float(key[0]) + 0 #add 0 to avoid strange -0.0 error when multiplying 0 by -1
        s_psi = -1 * float(key[1]) + 0
        s_val = d_pmf[str(s_phi),str(s_psi)]
    
    else:
        s_val = d_pmf[key[0], key[1]]

    # print updated pmf surface values to file
    newline=str(key[0]) + "\t" + str(key[1]) + "\t" + str(s_val) + "\n" 
    o.write(newline)
            
f.close()
o.close()
