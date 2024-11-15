#!/bin/bash
#SBATCH --nodes=4
#SBATCH --ntasks=512
#SBATCH --ntasks-per-node=128
#SBATCH -t 144:00:00
#SBATCH -p normal_q
#SBATCH -A lemkulgroup
#SBATCH --mail-type=ALL
#SBATCH --mail-user=hmichel@vt.edu
#SBATCH --job-name=mpi.alad

# load in your modules
#module avail
module reset
module load openmpi/gcc/64/1.10.7

# export path to NAMD executable
# here we are using MPI enabled NAMD
export NAMDIR=/projects/lemkul_lab/software/infer/namd/2.14_verbs

# Change to the directory from which the job was submitted
cd $SLURM_SUBMIT_DIR

# Run command
# adjust number of cores and input/output names
$NAMDIR/charmrun +p512 ++mpiexec ++remote-shell srun $NAMDIR/namd2 gamd_equil_c36.in > gamd_equil.out
