#!/bin/bash -l

#SBATCH --job-name=initGB
#SBATCH --time=48:00:00
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH -o "output/initGB.%j.o" # file for job output
#SBATCH -e "output/initGB.%j.e" # file for job error messages
#SBATCH --mail-type=end

echo "working directory = "$SLURM_SUBMIT_DIR # directory you submitted from

NPROCS="$SLURM_NTASKS"
NNODES="$SLURM_JOB_NUM_NODES"

echo Running on host `hostname`
echo Time is `date`
echo Directory is `pwd`
echo Using ${NPROCS} processors across ${NNODES} nodes

START=`date +%s`

switchFlag=varFlag

if [ "$switchFlag" -eq "1" ]
then
  v1x=(1 0 0)
  v1y=(0 2 -1)
  v1z=(0 1 2)
  v2x=(1 0 0)
  v2y=(0 2 1)
  v2z=(0 -1 2)
  latticeName="012.0n12"

  #make sure these correspond to CSL lengths for continuity across PBC; round last decimal place up
  inX=128.2
  inY=127.6
  inZ=192.3

  temp=550
  outDir=dump/

elif [ "$switchFlag" -eq "2" ]
then
  v1x=(1 0 0)
  v1y=(0 3 -1)
  v1z=(0 1 3)
  v2x=(1 0 0)
  v2y=(0 3 -1)
  v2z=(0 -1 3)
  latticeName="013.0n13"

  #make sure these correspond to CSL lengths for continuity across PBC; round last decimal place up
  inX=128.2
  inY=127.6
  inZ=192.3

  temp=550
  outDir=dump/

fi
workingDir=/home/abarne65/scratch16-mfalk1/annie/GB-loading/scripts-gb/$outDir
mkdir -p $workingDir
dataDir=/home/abarne65/scratch16-mfalk1/annie/GB-loading/scripts-gb/$outDir

rm $dataDir/*.restart
rm $dataDir/*.cfg
rm $workingDir/*.restart
rm $workingDir/*.cfg

vars="-var v1x1 ${v1x[0]} -var v1x2 ${v1x[1]} -var v1x3 ${v1x[2]}
-var v1y1 ${v1y[0]} -var v1y2 ${v1y[1]} -var v1y3 ${v1y[2]}
-var v1z1 ${v1z[0]} -var v1z2 ${v1z[1]} -var v1z3 ${v1z[2]}
-var v2x1 ${v2x[0]} -var v2x2 ${v2x[1]} -var v2x3 ${v2x[2]}
-var v2y1 ${v2y[0]} -var v2y2 ${v2y[1]} -var v2y3 ${v2y[2]}
-var v2z1 ${v2z[0]} -var v2z2 ${v2z[1]} -var v2z3 ${v2z[2]}
-var workingDir $workingDir -var dataDir $dataDir
-var inX ${inX} -var inY ${inY} -var inZ ${inZ}
-var inputTemp ${temp}"
echo $vars

mkdir -p $dataDir

cp Fe_Fe.CS3_33.alloy $workingDir/Fe_Fe.CS3_33.alloy
cp initgb.lammps $workingDir/initgb.lammps
cd $workingDir

source /data/apps/go.sh
mpirun  -np 24 /home/abarne65/scratch16-mfalk1/annie/x_mpi $vars -in initgb.lammps
cp -p $workingDir/* $dataDir/ || :

#for i in {1..20}
#do
  #mpirun lmp_mpi $vars -in [continue script]
  #cp -p $workingDir/* $dataDir/ || :
#done

END=`date +%s`
ELAPSED=$(( $END - $START ))
echo "Finished with $ELAPSED elapsed"

echo "Finished Job $SLURM-JOBID"

