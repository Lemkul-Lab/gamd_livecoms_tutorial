# Script to create a single timeline from GaMD simulation strides
# 11/24 HMM

import sys

# Read in raw weights and specify fixed weights output file
raw_weights = open(sys.argv[1], "r")
weights = open(sys.argv[2], "w")


goodlines = [] 

# Create list of all non-0 timepoints
for line in raw_weights.readlines():
	if int(line.split()[1]) == 0:
		pass
	else:
		goodlines.append(line)

# Renumber time to be continuous
for i in range(len(goodlines)):
	line = goodlines[i]
	reweight_factor = line.split()[0]
	time = line.split()[1]
	boost = line.split()[2]
	davg = line.split()[3]

	dt = 10
	new_time = str(i * dt)
	string = reweight_factor + ' ' + new_time + ' ' + boost + ' ' + davg + '\n'
	#print(string)
	
	weights.write(string) 
