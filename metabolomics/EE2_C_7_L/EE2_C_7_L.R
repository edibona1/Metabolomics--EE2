# Load MetaboAnalystR
library(MetaboAnalystR)

# Clean global environment
rm(list = ls())

# Create objects for storing processed data
mSet <- InitDataObjects("mass_all", "mummichog", FALSE)

# Set parameters, ppm is 4.3 here
# Only positive mode (ESI+) included 

# inputs is 4 column 'mptr'
mSet <- SetPeakFormat(mSet, "mptr")


mSet <- UpdateInstrumentParameters(mSet, 15.0, "mixed", "yes", 0.02)

#       change input file 
mSet <- Read.PeakListData(mSet, "output_mixed_Log2_Fold_Change_7_dpf_EE2_7_dpf_Control_.txt");
#
mSet <- SetRTincluded(mSet, "seconds")

# Set parameters

# set algorithm as "mummichog" and version 2
# Here we use the top 10% peaks as the p value cutoff

mSet <- SanityCheckMummichogData(mSet)

mSet<-SetPeakEnrichMethod(mSet, "mum", "v2")

pval <- sort(mSet[["dataSet"]][["mummi.proc"]][["p.value"]])[ceiling(length(mSet[["dataSet"]][["mummi.proc"]][["p.value"]])*0.1)]

mSet<-SetMummichogPval(mSet, 0.2)

# Perform functional analysis using zebrafish kegg pathways
mSet<-PerformPSEA(mSet, "dre_mtf", "current", 3 , 100) 

mSet<-PlotPeaks2Paths(mSet, "peaks_to_paths_msms_", "png", 72, width=8)