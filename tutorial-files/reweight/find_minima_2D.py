# Script to pull minima from GAMD pmf file
# 01/23 HMM

import re
# re allows you to split lines by multiple criteria rather
# than just one with str.split()
import sys, os

# load input file and specify output name and zcutoff
file_input = sys.argv[1]
file_out   = sys.argv[2]
max_pmf    = float(sys.argv[3]) # pmf threshold

inf = open(file_input, "r")
outf = open(file_out, "w")

outf.write("# phi  \t  psi  \t  pmf \n")

# iterate over file lines 
for line in inf.readlines()[5:]:
    line = re.split(",  | \t|  ", line) # GAMD specific formatting
    cv1 = line[0]
    cv2 = line[1]
    pmf = line[2].strip("\n")
    if 0 <= float(pmf) <= max_pmf:    
        #print(cv1, cv2, pmf)
        outf.write(cv1.ljust(10," ") + cv2.ljust(10," ") + pmf + "\n")

