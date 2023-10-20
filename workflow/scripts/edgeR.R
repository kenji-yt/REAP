############ Differential Expression Analysis using EdgeR ############

### Required packages ###
library(edgeR)

### Get the arguments ###
comm_args <- commandArgs(trailingOnly = TRUE)

# First argument: read count filenames
metadata <- read.table(comm_args[1])
# Second argument: read count file directory 
count_dir <- comm_args[2]
# Third argument: minimum count per million base pair
min_cpm <- comm_args[3]
# All other arguments
Others <- comm_args[4:]
### Analysis ###

# Load the data
filenames_1 <- c() 
filenames_2 <- c()
groups <-c()
for(i in 1:nrow(metadata)){
    sample <- metadata$name[i]
    filenames_1 <- c(filenames_1,paste0(sample,"/",sample,"_subgenome_",1,".featureCounts"))
    filenames_2 <- c(filenames_2,paste0(sample,"/",sample,"_subgenome_",2,".featureCounts"))
}


sub_genome_1 <-readDGE(filenames_1, path=count_dir, columns=c(1,7), group=metadata$group, labels=metadata$name)

# Create DGElist object
d <- DGEList(counts=count_data,group=factor(groups))

# Filter out genes by cpm
keep <- rowSums(cpm(d)>min_cpm) == length(groups) # Requiring minimum cpm in all individuals.
d <- d[keep,]

# Reset library size
d$samples$lib.size <- colSums(d$counts)