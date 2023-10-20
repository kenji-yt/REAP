########################################################
##### Differential Expression Analysis using EdgeR #####
########################################################

#-----------------------#
### Required packages ###
#-----------------------#
library(edgeR)

#-----------------------#
### Get the arguments ###
#-----------------------#

comm_args <- commandArgs(trailingOnly = TRUE)

# First argument: read count filenames
metadata <- read.table(comm_args[1])
# Second argument: read count file directory 
count_dir <- comm_args[2]
# Third argument: minimum count per million base pair
min_cpm <- comm_args[3]
# All other arguments
Others <- comm_args[4:]

#-------------------#
### Load the data ### 
#-------------------#

# create paths 
filenames_1 <- c() 
filenames_2 <- c()
groups <-c()
for(i in 1:nrow(metadata)){
    sample <- metadata$name[i]
    filenames_1 <- c(filenames_1,paste0(sample,"/",sample,"_subgenome_",1,".featureCounts"))
    filenames_2 <- c(filenames_2,paste0(sample,"/",sample,"_subgenome_",2,".featureCounts"))
}

# read data into DGEList ojects
sub_genome_1 <- readDGE(filenames_1, path=count_dir, columns=c(1,7), group=metadata$group, labels=metadata$name)
sub_genome_2 <- readDGE(filenames_2, path=count_dir, columns=c(1,7), group=metadata$group, labels=metadata$name)

#-----------------------------#
### Filter out genes by cpm ### 
#-----------------------------#

# Requiring minimum cpm in all individuals.
keep_1 <- rowSums(cpm(sub_genome_1)>min_cpm) == length(groups) 
sub_genome_1 <- sub_genome_1[keep_1,]
# Reset library size
sub_genome_1$samples$lib.size <- colSums(sub_genome_1$counts)

# Requiring minimum cpm in all individuals.
keep_2 <- rowSums(cpm(sub_genome_2)>min_cpm) == length(groups) 
sub_genome_2 <- sub_genome_2[keep_2,]
# Reset library size
sub_genome_2$samples$lib.size <- colSums(sub_genome_2$counts)


#------------------#
### DEG analysis ### 
#------------------#

# Compare expression between groups for subgenome 1 

# Compare expression between groups for subgenome 2 

# Compare expression of homeologs
#   With:  -1 reference:
#                       -ref/alt
#          -2 reference:
#                        -ref/alt genome 1
#                        -ref/alt genome 2
#                        -if also 2 annotations: RBH list
#                        Three ways to have homeologs, choose manually or default to one getting most genes.

# How to compare homeologs? 
# Within a group between subgenomes. 
# Between all combinations? So each group is group+subgenome. Does this make sense?
# Between a group: Homeolog ratio test.

