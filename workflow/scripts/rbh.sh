######################
#### RBH Analysis ####
######################

# Guide to trailing arguments
# $1 fasta file containing all genes for species 1 
# $2 fasta file containing all genes for species 2
# $3 desired output file listing all RBH (inferred homologues). Don't include suffix. 
# $4 number of threads per process 

###########
### Run ###
###########

# Make hidden directories for the databases
mkdir .temp_db1
mkdir .temp_db2

# Make hidden directories for the hits lists
mkdir .temp_hits12
mkdir .temp_hits21

# First we create two databases of genes
makeblastdb -in $1 -dbtype nucl -out .temp_db1/temp_1
makeblastdb -in $2 -dbtype nucl -out .temp_db2/temp_2

# Perform the blast 
blastn -query $1 -db .temp_db2/temp_2 -num_threads $4 -max_hsps 1 -max_target_seqs 1 -outfmt "7 qseqid sseqid evalue" -out .temp_hits12/hits_12 
blastn -query $2 -db .temp_db1/temp_1 -num_threads $4 -max_hsps 1 -max_target_seqs 1 -outfmt "7 qseqid sseqid evalue" -out .temp_hits21/hits_21

# Find the best hits 
awk 'FNR==NR{a[$1"\t"$2];next} ($2"\t"$1 in a)' .temp_hits12/hits_12 .temp_hits21/hits_21 > $3.txt


# remove temporary working files
rm -r .temp* 


##################
### Making Log ###
##################

## Ortholog numbers ## 
# Count the number of genes in input & RBH:
n_genes_1=$(grep -c "^>" $1)
n_genes_2=$(grep -c "^>" $2)
n_rbh=$(grep -c "." $3.txt)

# Calculate proportion
frac_1_ortho=$(echo "scale=2; $n_rbh / $n_genes_1" | bc)
frac_1_ortho=$(echo "$frac_1_ortho * 100" | bc)
frac_2_ortho=$(echo "scale=2; $n_rbh / $n_genes_2" | bc)
frac_2_ortho=$(echo "$frac_2_ortho * 100" | bc)

## Alignment stats ## 
# Calculate mean and max e-values
mean_e=$(awk '{ sum += $3 }  END { avg = sum / NR; print avg }' $3.txt)
max=$(awk 'max < $3 {max = $3}  END { print max }' $3.txt)


## writing log ## 
log="Percentage of genes that have RBH from $1: $frac_1_ortho
Percentage of genes that have RBH from $2: $frac_2_ortho
Mean e-value: $mean_e
Max: $max" 
echo "$log" > $3.log