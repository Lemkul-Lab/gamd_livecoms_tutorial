#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --gres=gpu:1
#SBATCH -t 4:00:00
#SBATCH -p t4_dev_q
#SBATCH -A lemkulgroup
#SBATCH --mail-type=ALL
#SBATCH --mail-user=hmichel@vt.edu
#SBATCH --job-name=alad

# load modules
module reset
module load gcc/9.2.0                                                                                          
# export path to CHARMM executable
export SW="/projects/lemkul_lab/software/infer"
CHARMM=$SW/charmm/charmm

# Change to the directory from which the job was submitted
cd $SLURM_SUBMIT_DIR

# if log and weights file already exist, delete them
if [[ -f "gamd_namd.log" ]]; then 
	rm gamd_namd.log
fi

if [[ -f "raw_weights.dat" ]]; then
	rm raw_weights.dat
fi

if [[ -f "names.txt" ]]; then
        rm names.txt
fi

echo `pwd`
# loop over all strides and combine all output files
for (( i=1; i<51; i++ ))
do
   cat "md.${i}.out" >> gamd_namd.log
   echo "ala.c36.${i}.dcd" >> names.txt   
done

$SW/bin/catdcd -o full.dcd `cat names.txt`

# prepare input file "raw_weights.dat" for NAMD
grep "ACCELERATED MD" gamd_namd.log | grep -v "GAUSSIAN" | grep -v "ACTIVE" | awk '{print $6/(0.001987*298)" " $4 " " $6 " "$8}' > raw_weights.dat

# fix time in weights file
python fix_time_gamd.py raw_weights.dat weights.dat

# orient system using CHARMM
$CHARMM -i orient.inp -o o.out

# generate dihedrals using CHARMM
$CHARMM -i dihedral_calc_drude.inp -o dihe.out

# combine phi and psi angles into one file
awk 'NR==FNR{a[NR]=$0;next}{print a[FNR],$0}' phi.1.dat psi.1.dat > cv.dat
