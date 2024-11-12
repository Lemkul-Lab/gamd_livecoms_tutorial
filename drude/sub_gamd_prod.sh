#!/bin/bash
#SBATCH --output alad.out
#SBATCH --job-name alad
#SBATCH --ntasks=384
#SBATCH --ntasks-per-node=128
#SBATCH --nodes=3
#SBATCH -t 48:00:00
#SBATCH -p compute
#SBATCH -A vpt121
#SBATCH --mail-type=ALL
#SBATCH --mail-user=hmichel@vt.edu

# load in modules
#module avail
module reset
module load cpu/0.17.3b
module load gcc/10.2.0/npcyll4
module load openmpi/4.1.3/oq3qvsv
 
# export path the MPI enabled NAMD
export NAMDDIR=/expanse/lustre/projects/vpt121/jalemkul/software/namd/2.14_verbs

# change directory to submission directory
cd $SLURM_SUBMIT_DIR

#echo "Date              = $(date)"
#echo "Hostname          = $(hostname -s)"
#echo "Working Directory = $(pwd)"
#echo ""
#echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
#echo "Number of Tasks Allocated      = $SLURM_NTASKS"
#echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"

# Populate header with queue stuff, modules, etc.

base="ala"     # replace this with your PDB code or however you want to name it
ff="drude"

for (( i=1; i<51; i++ ))
do
    j="$(($i-1))"

    # set base file name for inputs to be read (previous state)
    if [[ $i -eq 1 ]];
    then
        basename="gamd_equil"
    else		
	basename="${base}.${ff}.${j}"
    fi
    
    # generate input file from template
    # replace the placeholders with current interval file names
    sed "s/<BASENAME>/${basename}/g" md.template > md.${i}.in
    sed -i "s/<BASE>/${base}/g" md.${i}.in
    sed -i "s/<CURR>/${i}/g" md.${i}.in

    # random number of processors chosen, update
    #/cm/shared/apps/slurm/current/bin/srun -n 48 $NAMDIR/namd2 md.${i}.in > md.${i}.out   
    $NAMDDIR/charmrun +p384 ++mpiexec ++remote-shell srun $NAMDDIR/namd2 md.${i}.in > md.${i}.out
done

exit;
