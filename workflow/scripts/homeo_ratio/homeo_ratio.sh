#############################
#### Homeolog ratio test ####
#############################


#----------------------------------------------#
#----------------------------------------------#
#---------------- Parse the flags -------------#
#----------------------------------------------#
#----------------------------------------------#

# Default values
cores=""
annotations=""
references=""
outdir=""



# Usage example
function print_usage() {
    echo "Usage: $0 -r <reference> -a <annotation> -c <cores> -o <outdir>" 
}

# Parse command line options using getopts 
while getopts "r:a:c:o:" flag; do
    case "$flag" in
        r)
            references+=("$OPTARG");;
        a)
            annotations+=("$OPTARG");;
        c)
            cores="$OPTARG" ;;
        o)
            outdir="$OPTARG" ;;
        *) 
            print_usage 
            exit 1 ;;
    
    esac
done
#shift $((OPTIND -1))
#https://stackoverflow.com/questions/7529856/retrieving-multiple-arguments-for-a-single-option-using-getopts-in-bash


# Check if required flags are provided
if [ ${#references[@]} -lt 2 ]; then
    echo "Please provide at least two reference genomes."
    print_usage
    exit 1
fi
if [ ${#annotations[@]} -lt 2 ]; then
    echo "Please provide at least two annotations."
    print_usage
    exit 1
fi 
if [ ${#annotations[@]} -ne ${#references[@]}  ]; then
    echo "Please provide the same number of reference and annotations."
    print_usage
    exit 1
    
if test -z "$cores"; then
    echo "-c flags is required."
    print_usage
    exit 1
fi
if test -z "$outdir"; then
    echo "-o flags is required."
    print_usage
    exit 1
fi

n_subgenomes=${#annotations[@]}
index=$(($n_subgenomes-1))
# Get each annotation and reference
for i in $(seq 0 1 $n_subgenomes); do
    # name the variables
    anno_var_name="anno_${i}" 
    ref_var_name="ref_${i}"
    # assign values to variables
    eval ${anno_var_name} ${annotations[${i}]}
    eval ${ref_var_name} ${references[${i}]}
done


#############################################
# GET THE LIST OF HOMEOLOGS USING USING RBH #
#############################################

bash workflow/scripts/extract_gene.sh

bash workflow/scripts/rbh.sh 