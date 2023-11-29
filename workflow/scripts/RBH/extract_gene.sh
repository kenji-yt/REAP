# Guide to trailing arguments
# $1: assembly
# $2: annotation
# $3: output bed
# $4: output fasta

# Get start, stop and ID of each gene & produce bed:
awk -F '\t|_' '$1 ~ /chr[0-9]/ && $3 ~ /gene/ { print $1"\t"($4-1)"\t"$5"\t"$10 }' $2 > $3

# Use bed to extract gene sequence and ID into fasta:
bedtools getfasta -fi $1 -bed $3 -name -fo $4

# Note: Ran this manually for Lyrata because the annotation and assembly dont have the same chromosome names. 
# **A note on formating:** The script works only if the 9th column has information in the format "X_geneID" with X being some information. 
# works for gff, what about gtf?