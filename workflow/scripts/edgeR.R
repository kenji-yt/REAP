########################################################
##### Differential Expression Analysis using EdgeR #####
########################################################

#-----------------------#
#   Required packages   #
#-----------------------#
library(edgeR)

#-----------------------#
#   Get the arguments   #
#-----------------------#

comm_args <- commandArgs(trailingOnly = TRUE)

# First argument: read count filenames
metadata <- read.table(comm_args[1],header=T)
# Second argument: read count file directory 
count_dir <- comm_args[2]
# Third argument: minimum count per million base pair
min_cpm <- comm_args[3]
# All other arguments
Others <- comm_args[4:]

#-------------------#
#   Load the data   # 
#-------------------#

# create paths 
filenames_1 <- c() 
filenames_2 <- c()
groups <-c()
for(i in 1:nrow(metadata)){
    sample <- metadata$name[i]
    filenames_1 <- c(filenames_1,paste0(sample,"/",sample,"_subgenome_",1,".input_edgeR"))
    filenames_2 <- c(filenames_2,paste0(sample,"/",sample,"_subgenome_",2,".input_edgeR"))
}

# read data into DGEList ojects
sub_genome_1 <- readDGE(filenames_1, path=count_dir, columns=c(1,2), group=metadata$group, labels=metadata$name)
sub_genome_2 <- readDGE(filenames_2, path=count_dir, columns=c(1,2), group=metadata$group, labels=metadata$name)

#-----------------------------#
#   Filter out genes by cpm   # 
#-----------------------------#

# Requiring minimum cpm in all individuals.
keep_1 <- rowSums(cpm(sub_genome_1)>min_cpm) == length(metadata$group)
sub_genome_1 <- sub_genome_1[keep_1,]
# Reset library size
sub_genome_1$samples$lib.size <- colSums(sub_genome_1$counts)

# Requiring minimum cpm in all individuals.
keep_2 <- rowSums(cpm(sub_genome_2)>min_cpm) == length(metadata$group)
sub_genome_2 <- sub_genome_2[keep_2,]
# Reset library size
sub_genome_2$samples$lib.size <- colSums(sub_genome_2$counts)


#-----------------------------#
#         Normalizing         # 
#-----------------------------#

sub_genome_1 <- calcNormFactors(sub_genome_1)
sub_genome_2 <- calcNormFactors(sub_genome_2)

#-----------------------------#
#             MDS             # 
#-----------------------------#

plotMDS(sub_genome_1, col=as.numeric(sub_genome_1$samples$group))
legend("bottomleft", as.character(unique(sub_genome_1$samples$group)), col=1:3, pch=20)


plotMDS(sub_genome_2, col=as.numeric(sub_genome_2$samples$group))
legend("bottomleft", as.character(unique(sub_genome_2$samples$group)), col=1:3, pch=20)

#-----------------------------#
#    Estimating Dispersion    # 
#-----------------------------#

# GLM estimates of dispersion
design.mat1 <- model.matrix(~ 0 + sub_genome_1$samples$group)
colnames(design.mat1) <- levels(sub_genome_1$samples$group)
sub_genome_1 <- estimateGLMCommonDisp(sub_genome_1,design.mat1)
sub_genome_1 <- estimateGLMTrendedDisp(sub_genome_1,design.mat1)

design.mat2 <- model.matrix(~ 0 + sub_genome_2$samples$group)
colnames(design.mat2) <- levels(sub_genome_2$samples$group)
sub_genome_2 <- estimateGLMCommonDisp(sub_genome_2,design.mat2)
sub_genome_2 <- estimateGLMTrendedDisp(sub_genome_2,design.mat2)

#------------------#
#   DEG analysis   # 
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

