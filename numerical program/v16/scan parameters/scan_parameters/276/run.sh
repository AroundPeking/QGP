#!/bin/bash
#SBATCH -o job.%j.out
#SBATCH -p long
#SBATCH -J QGP
#SBATCH --nodes=1
##SBATCH -x cpu01
##SBATCH --ntasks=16
#SBATCH --cpus-per-task=24
#SBATCH --ntasks-per-node=1

#module load gcc10.2
#module load intel20u4

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
echo Working directory is $PWD
echo This job has allocated $SLURM_JOB_CPUS_PER_NODE cpu cores.

echo Begin Time: `date`
workdir=$(basename `pwd`)
### * * * Running the tasks * * * ###

python3 ./optimize_parameters.py > opt.$SLURM_JOB_ID.log 2>&1

echo End Time: `date`
