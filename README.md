# Grain Boundary SIA Deposition using LAMMPS
DOI: 10.5281/zenodo.15549457
Molecular dynamics simulation of preferential interstitial absorption at grain boundaries.  

## 📝 Description  
This workflow allows users to probe grain boundary structural transitions in LAMMPS by depositing atoms at the grain boundary and monitoring the bicrystal evolution. The project aims at providing insights into materials evolution under high-defect producing conditions, such as radition. The repository contains simulation data and scripts to deposition self-interstitial atoms (SIAs) at grain boundaries in a variety of material systems and dose rates. The provided code is for a ternary FCC alloy, however files for a 100% Nickel and 95% Nickel/5% Chromium alloy are also provided. 

## 📁 Repository Structure

    Grain-Boundary-SIADeposition/
    ├── Create_E5_GB/           # Scripts to create a bicrystal with E5 grain boundary
    ├── example_dump_files/     # Sample LAMMPS dump files from the initial and final frame of each stoichiometry simulation
    ├── potential_files/        # EAM potential files used in simulations
    ├── startfiles/             # Initial configuration files for SIA deposition simulations
    ├── LICENSE                 # CC-BY-4.0 License
    └── README.md               # Project documentation


## 🚀 Getting Started
To utilize the scripts and data in this repository:
1. Clone the repository:  
   'git clone https://github.com/anniebarnett/Grain-Boundary-SIADeposition.git'
   'cd Grain-Boundary-SIADeposition' 
  
2. Set up your environment:  
Ensure you have LAMMPS installed. The bicrystal created using this set-up generates a simulation cell of >2M atoms. The provided bash scripts are set up for running on HPC, which is suggested due to the system size and runtime required to see GB evolution.   

3. Run simulations:  
Use the scripts in the Create_E5_GB/ directory to generate bicrystals with speicfic grain boundary structures.  
Use the scripts in the startfiles/ directory to begin the deposition simulation. This will run a specified number of loops, or until your HPC time has run out. To specfiy the number of loops for the simulation, manipulate line 47 in startfiles/depo.slurm.  
Submit both GB creation and SIA deposition slurm jobs using ./masterInitGB.sh 1 and ./masterPDs.sh 1, respectively. This enables you to submit multiple variations of the script, which will appended the slurm file with the number (i.e., initgb$1.slurm).   

## 📊 Data and Examples
example_dump_files/: Contains sample output files from the LAMMPS simulations in 3 different stoichiometries. Each stoichiometry folder (Nickel/Ni95Cr5/CoCrNi) contains the first and last dump files from a 20 ns simulation. The intermediate files have not been uploaded due to size limitations. For the intermediate files, please contact the maintainer. 

potential_files/: Includes the EAM potential files required for running the simulations in the CoCrNi system. Information about the potential can be found at: Q.-J. Li, H. Sheng, and E. Ma, ‘Strengthening in multi-principal element alloys with local-chemical-order roughened dislocation pathways’, Nat Commun, vol. 10, no. 1, p. 3563, Aug. 2019, doi: 10.1038/s41467-019-11464-7.

startfiles/: Files to perform SIA deposition at the GB. 

Create_E5_GB/: Files to create the bicrystal configuration. The GB character can be altered in the initgb.slurm file. The current files create a bicrystal configuration by constructing two adjoining FCC Ni grains with distinct crystallographic orientations. The top grain is created with orientation vectors [100],[021 ̅ ],[012]. Then, the bottom grain replaces the bottom half of the domain orientation with orientation [100],[021],[01 ̅2], forming a Σ5(012) symmetric tilt grain boundary about the [100] tilt axis.

## 🙋‍♀️ Contact  
For questions or collaborations, please contact the repository maintainer.  

Maintainer: Annie K. Barnett  
Email: abarne65@jhu.edu  
GitHub: [@anniebarnett](https://github.com/anniebarnett)  

## 📄 License
This project is licensed under the Creative Commons Attribution 4.0 International License (CC-BY-4.0). You are free to share and adapt the material for any purpose, even commercially, with appropriate credit.
