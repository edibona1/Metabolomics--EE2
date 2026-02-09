#!/bin/bash

#SBATCH -J enrichment          # Name of the job
#SBATCH -t 24:00:00            # Time limit
#SBATCH -p normal              # Use the correct partition name


# Load R module
module load R


# Run the R script
Rscript EE2_C_3_L.R
