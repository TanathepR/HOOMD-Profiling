#!/bin/bash

#SBATCH -p compute                 #specify partition
#SBATCH --nodes=2                     # Number of nodes
#SBATCH --ntasks-per-node=128           # Number of tasks per node
#SBATCH --cpus-per-task=1             # Number of CPU cores per task
#SBATCH -t 0:01:00                 #job time limit <hr:min:sec>
#SBATCH -J hoomd-profiling                #job name
#SBATCH -A lt200291                #specify your account ID

module restore
module load OpenMPI

source /home/trochana/local/env/hoomd-venv/bin/activate

export PYTHONPATH=/home/trochana/app/bsc-tools/extrae/libexec:$PYTHONPATH
export EXTRAE_HOME=/home/trochana/app/bsc-tools/extrae
export EXTRAE_ON=1
export EXTRAE_CONFIG_FILE=/home/trochana/hoomd-benchmarks/run/profiling/extrae.xml

cd /home/trochana/hoomd-benchmarks

mpirun -n 256 python3 -m hoomd_benchmarks.md_pair_wca --device CPU -N 2000 -v --benchmark_steps 100
