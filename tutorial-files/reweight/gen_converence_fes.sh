#!/bin/bash
# script to automate generate of FES from multiple timepoints in GaMD tutorials
# steps can be done individually if desired
# 11/25 HMM

# create directories for each time point that you wish to analyze
# we chose 50, 100, 200, 300, 400 and 500 ns
for i in "50" "100" "200" "300" "400" "500"; do
    if [[ -d ${i} ]]; then
        echo "Directory exists"
    else
        mkdir ${i}
    fi
done

# activate conda environment that is configured for reweighting 
conda activate reweight

# for each time point, generate data files with appropriate number
# of data points from the full 500 ns data files
for i in "50" "100" "200" "300" "400" "500"; do
    cd "${i}"
    nlines=$(( 1000*${i} ))
    head -n${nlines} "../weights.dat" > "./weights_${i}.dat"
    head -n${nlines} "../cv.dat" > "./cv_${i}.dat"
    
    # copy the PyReweighting script and update variables for each timepoint
    # execute the reweighting 
    cp "../reweight-2d.sh" "."
    sed -i 's/cv.dat/cv_${i}.dat/g' reweight-2d.sh
    sed -i 's/weights.dat/weights_${i}.dat/g' reweight-2d.sh
    source "reweight-2d.sh"
    
    # call the python script to wrap the phi and psi values and generate
    # a new PMF file
    #cp "../fix_phipsi.py" "."
    python "../fix_phipsi.py" pmf-2D-c2-cv_${i}.dat-reweight-discx15-discy15.xvg fix_pmf_c2.xvg
    
    # plot the new PMF file
    #cp "../plot_csv.py" "."
    python "../plot_csv.py" fix_pmf_c2.xvg fes_${i}.png 15

    # seek out PMF minimia under specified threshold (2) and print to file
    python "../find_minima_2D.py" pmf-2D-c2-cv_${i}.dat-reweight-discx15-discy15.xvg minima_${i}.dat 2

    # return to base directory and move on to next time point
    cd ../
done
    
