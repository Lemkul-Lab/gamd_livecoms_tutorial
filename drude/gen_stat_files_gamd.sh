#!/bin/bash
# script to generate all statistical time series for GaMD equilibration
# Usage: bash gen_statistics.sh 

for boost in [ "DIHED" "TOTAL" ];
do
	if [[ ${boost} == "DIHED" ]]; then
		suffix="dihe"
	# awk command pulls the line number and divides by 1000 to get ns 
	# and prints the corresponding statistic for that timepoint	
	
	# Vmax
	grep "GAUSSIAN ACCELERATED MD: ${boost}" gamd_equil.out | awk '{print NR/1000, $8}' > vmax_${suffix}.dat

	# Vmin
	grep "GAUSSIAN ACCELERATED MD: ${boost}" gamd_equil.out | awk '{print NR/1000, $10}' > vmin_${suffix}.dat

	# Vavg
	grep "GAUSSIAN ACCELERATED MD: ${boost}" gamd_equil.out | awk '{print NR/1000, $12}' > vavg_${suffix}.dat

	# sigma
	grep "GAUSSIAN ACCELERATED MD: ${boost}" gamd_equil.out | awk '{print NR/1000, $14}' > sigma_${suffix}.dat

	# E-threshold energy
	grep "GAUSSIAN ACCELERATED MD: ${boost}" gamd_equil.out | awk '{print NR/1000, $16}' > E_${suffix}.dat

	# k0
	grep "GAUSSIAN ACCELERATED MD: ${boost}" gamd_equil.out | awk '{print NR/1000, $18}' > k0_${suffix}.dat

	#k
	grep "GAUSSIAN ACCELERATED MD: ${boost}" gamd_equil.out | awk '{print NR/1000, $20}' > k_${suffix}.dat

	fi

	if [[ ${boost} == "TOTAL" ]]; then
                suffix="tot"

        # Vmax
        grep "GAUSSIAN ACCELERATED MD: ${boost}" gamd_equil.out | awk '{print NR/1000, $8}' > vmax_${suffix}.dat

        # Vmin
        grep "GAUSSIAN ACCELERATED MD: ${boost}" gamd_equil.out | awk '{print NR/1000, $10}' > vmin_${suffix}.dat

        # Vavg
        grep "GAUSSIAN ACCELERATED MD: ${boost}" gamd_equil.out | awk '{print NR/1000, $12}' > vavg_${suffix}.dat

        # sigma
        grep "GAUSSIAN ACCELERATED MD: ${boost}" gamd_equil.out | awk '{print NR/1000, $14}' > sigma_${suffix}.dat

        # E-threshold energy
        grep "GAUSSIAN ACCELERATED MD: ${boost}" gamd_equil.out | awk '{print NR/1000, $16}' > E_${suffix}.dat

        # k0
        grep "GAUSSIAN ACCELERATED MD: ${boost}" gamd_equil.out | awk '{print NR/1000, $18}' > k0_${suffix}.dat

        #k
        grep "GAUSSIAN ACCELERATED MD: ${boost}" gamd_equil.out | awk '{print NR/1000, $20}' > k_${suffix}.dat

        fi

done

mkdir stats
mv *tot.dat stats/
mv *dihe.dat stats/
