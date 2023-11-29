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
# Second argument: edgeR output directory 
count_dir <- comm_args[2]
# Third argument: minimum count per million base pair
min_cpm <- as.numeric(comm_args[3])
# Output directory
out_dir <- comm_args[4]
dir.create(out_dir)
dir.create(paste0(out_dir,"/subgenome_1"))
out_1 <- paste0(out_dir,"/subgenome_1")
dir.create(paste0(out_dir,"/subgenome_2"))
out_2 <- paste0(out_dir,"/subgenome_2")


#-------------------#
#   Load the data   # 
#-------------------#

# create edgeR formated data

filenames_1 <- c() 
filenames_2 <- c()

for(i in 1:nrow(metadata)){
  sample <- metadata$name[i]
  dir.create(paste0(out_dir,"/",sample))
  
  count_1 <- read.table(paste0(count_dir,"/",sample,"/",sample,"_subgenome_1.featureCounts"), skip = 2) 
  name_1 <- paste0(sample,"/",sample,"_subgenome_",1,".input_edgeR")
  write.table(count_1[,c(1,7)],paste0(out_dir,"/",name_1),quote=F,sep="\t",row.names = F,col.names = F)
  filenames_1 <- c(filenames_1,name_1)
  
  count_2 <- read.table(paste0(count_dir,"/",sample,"/",sample,"_subgenome_2.featureCounts"), skip = 2) 
  name_2 <- paste0(sample,"/",sample,"_subgenome_",2,".input_edgeR")
  write.table(count_2[,c(1,7)],paste0(out_dir,"/",name_2),quote=F,sep="\t",row.names = F,col.names = F)     
  filenames_2 <- c(filenames_2,name_2)
}

# read data into DGEList ojects
sub_genome_1 <- readDGE(filenames_1, path=out_dir, columns=c(1,2), group=metadata$group, labels=metadata$name)
sub_genome_2 <- readDGE(filenames_2, path=out_dir, columns=c(1,2), group=metadata$group, labels=metadata$name)

#-----------------------------#
#   Filter out genes by cpm   # 
#-----------------------------#