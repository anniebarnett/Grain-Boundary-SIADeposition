#!/bin/bash -l

#SBATCH --job-name=depo800-cocrni
#SBATCH --time=72:00:00
#SBATCH --partition=parallel
#SBATCH --nodes=3
#SBATCH --ntasks-per-node=48
#SBATCH -o "output/pointDefects.%j.o" # file for job output
#SBATCH -e "output/pointDefects.%j.e" # file for job error messages
#SBATCH --mail-type=end

echo "working directory = "$SLURM_SUBMIT_DIR # directory you submitted from

NPROCS="$SLURM_NTASKS"
NNODES="$SLURM_JOB_NUM_NODES"

echo Running on host `hostname`
echo Time is `date`
echo Directory is `pwd`
echo Using ${NPROCS} processors across ${NNODES} nodes

START=`date +%s`

outDir=dump/

workingDir=/home/abarne65/scratch16-mfalk1/annie/GB-loading/depo/cocrni/800a/$outDir
dataDir=/home/abarne65/scratch16-mfalk1/annie/GB-loading/depo/cocrni/800a/$outDir

mkdir -p $workingDir
mkdir -p $dataDir

rm $workingDir/ptDefects*
rm $dataDir/ptDefects*

vars="-var workingDir $workingDir -var dataDir $dataDir"
echo $vars

cp NiCoCr.lammps.eam  $workingDir/NiCoCr.lammps.eam 
cp pointDefects.in $workingDir/pointDefects.in
cp pointDefectsCont.in $workingDir/pointDefectsCont.in
cd $workingDir

source /data/apps/go.sh
mpirun  -np 48 /home/abarne65/scratch16-mfalk1/annie/x_mpi_aug23 $vars -in pointDefectsCont.in
cp -p $workingDir/* $dataDir/ || :

for i in {1..40}
do 		
  mpirun -np 48 /home/abarne65/scratch16-mfalk1/annie/x_mpi_aug23 $vars -in pointDefectsCont.in
  cp -p $workingDir/* $dataDir/ || :
done


END=`date +%s`
ELAPSED=$(( $END - $START ))
echo "Finished with $ELAPSED elapsed"
