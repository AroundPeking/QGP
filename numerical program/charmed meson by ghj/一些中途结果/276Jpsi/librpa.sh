#!/bin/bash
#SBATCH -o job.%j.out
#SBATCH -p 640
#SBATCH -J test_LibRPA
##SBATCH -x cpu01
#SBATCH --nodes=1
##SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --ntasks-per-node=1
##SBATCH -w cpu07

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
echo Working directory is $PWD
echo This job has allocated $SLURM_JOB_CPUS_PER_NODE cpu cores.

echo Begin Time: `date`
workdir=$(basename `pwd`)
### * * * Running the tasks * * * ###

mpirun /home/rongshi/new_abacus_LibRPA/LibRPA/chi0_main.exe 14 0 > LibRPA_$workdir.$SLURM_JOB_ID.out
#mpirun /home/rongshi/abacus_LibRPA/LibRPA/chi0_main.exe 0 > LibRPA_$workdir.$SLURM_JOB_ID.out

echo End Time: `date`
