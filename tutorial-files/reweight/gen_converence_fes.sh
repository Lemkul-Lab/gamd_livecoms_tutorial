#!/bin/bash

for i in "50" "100" "200" "300" "400" "500"; do
    if [[ -d ${i} ]]; then
        echo "Directory exists"
    else
        mkdir ${i}
    fi
done

conda activate reweight

for i in "50" "100" "200" "300" "400" "500"; do
    cd "${i}"
    nlines=$(( 1000*${i} ))
    head -n${nlines} "../weights.dat" > "./weights_${i}.dat"
    head -n${nlines} "../cv.dat" > "./cv_${i}.dat"
    
    cp "../reweight-2d.sh" "."
    sed -i 's/cv.dat/cv_${i}.dat/g' reweight-2d.sh
    sed -i 's/weights.dat/weights_${i}.dat/g' reweight-2d.sh
    source "reweight-2d.sh"
    
    #cp "../fix_phipsi.py" "."
    python "../fix_phipsi.py" pmf-2D-c2-cv_${i}.dat-reweight-discx15-discy15.xvg fix_pmf_c2.xvg
    
    #cp "../plot_csv.py" "."
    python "../plot_csv.py" fix_pmf_c2.xvg fes_${i}.png 15

    python "../find_minima_2D.py" pmf-2D-c2-cv_${i}.dat-reweight-discx15-discy15.xvg minima_${i}.dat 2

    cd ../
done
    
