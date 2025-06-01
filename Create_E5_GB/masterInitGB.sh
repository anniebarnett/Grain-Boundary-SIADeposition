# creates a copy of the master slurm script initgb.slurm
# called initgb$1.slurm, replacing the string "varFlag" with
# $1. e.g, if you submit:
# ./masterInitGB.sh 1, this will replace varFlag with 1.
mkdir -p output
cat initgb.slurm | sed -e 's/varFlag/'"$1"'/' > initgb$1.slurm

# submit the new script
sbatch initgb$1.slurm
