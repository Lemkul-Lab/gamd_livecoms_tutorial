# Script to pull frames of minima from 2D CV file

import sys,os
import numpy as np

cv_file = sys.argv[1]
out_file = sys.argv[2]

f = open(cv_file, "r")
o = open(out_file, "w")

AT_minG = []
AT_minH = []
AT_minI = []
AT_minJ = []
AT_minK = []
tranD = []
tranE = []
tranF = []
GT_minA = []
GT_minB = []
GT_minC = []


for i, line in enumerate(f.readlines()):
    #print(line)
    line = line.split()
    ermsd = float(line[0])
    angle = float(line[1])
   
    if (1.14 < ermsd < 1.17) and (88 < angle < 92):
        tranF.append(i)
        print(i, ermsd, angle)
#        #print(str(i) + " "  + str(ermsd) + " " + str(angle))
#
#    elif (1.35 < ermsd < 1.5) and (60 < angle < 80):
#        tranE.append(i)
#
#    elif (1.4 < ermsd < 1.45) and (30 < angle < 42):
#        AT_minI.append(i)
#     
    elif (1.398 < ermsd < 1.402) and (59.8 < angle < 60.2):
        tranD.append(i) 
        print("D",i, ermsd, angle)
#    elif (1.52 < ermsd < 1.56) and (48 < angle < 52):
#        AT_minK.append(i)
#
#    elif (1.2 < ermsd < 1.25) and (100 < angle < 111):
#        GT_minA.append(i)
#
#    elif (1.35 < ermsd < 1.45) and (90 < angle < 101):
#        GT_minC.append(i)
#        print("C",i, ermsd, angle)
#    elif (1.25 < ermsd < 1.30) and (100 < angle < 111):
#        GT_minB.append(i)
#
#    elif (1.2 < ermsd < 1.25) and (30 < angle < 41):
#        AT_minG.append(i)
#
#    elif (1.28 < ermsd < 1.32) and (30 < angle < 41):
#        AT_minH.append(i)
#        print(i, ermsd, angle)
#    elif (1.38 < ermsd < 1.48) and (28 < angle < 42):
#        AT_minJ.append(i)

#o.write("G: " + str(AT_minG) + "\n"
#        "H: " + str(AT_minH) + "\n"
#        "I: " + str(AT_minI) + "\n" 
#        "J: " + str(AT_minJ) + "\n"
#        "K: " + str(AT_minK) + "\n"
#        "D: " + str(tranD) + "\n" 
#        "E: " + str(tranE) + "\n"
#        "F: " + str(tranF) + "\n"
#        "A: " + str(GT_minA) + "\n"
#        "B: " + str(GT_minB) + "\n"
#        "C: " + str(GT_minC) +  "\n")
#print("G: ", AT_minG)
#print()
#print("H: ", AT_minH)
#print()
#print("I: ", AT_minI)
#print()
#print("J: ", AT_minJ)
#print()
#print("K: ", AT_minK)
#print()
#print("D: ", tranD)
#print()
#print("E: ", tranE)
#print()
#print("F: ", tranF)
#print()
#print("A: ", GT_minA)
#print()
#print("B: ", GT_minB)
#print()
#print("C: ",GT_minC)
#print()

