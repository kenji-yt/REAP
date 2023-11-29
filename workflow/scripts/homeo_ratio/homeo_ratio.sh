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
anno_1=""
anno_2=""
ref_1=""
ref_2=""
outdir=""



# Usage example
function print_usage() {
    echo "Usage: $0 -r <reference> -a <annotation> -c <cores> -o <outdir>" 
}

# Parse command line options using getopts 
while getopts "g:p:c:m:x:t:" flag; do
    case "$flag" in
        g)
            generation="$OPTARG" ;;
        p)
            parent="$OPTARG" ;;
        c)
            cores="$OPTARG" ;;
        m)
            min_cov="$OPTARG" ;;
        x) 
            context="$OPTARG" ;;
        t)
            type="$OPTARG" ;;
        *) 
            print_usage 
            exit 1 ;;
    
    esac
done


# Check if required flags are provided
if test -z "$generation"; then
    echo "-g flags is required."
    print_usage
    exit 1
fi
if test -z "$cores"; then
    echo "-c flags is required."
    print_usage
    exit 1
fi
if test -z "$min_cov"; then
    echo "-m flags is required."
    print_usage
    exit 1
fi
if test -z "$type"; then
    echo "-t flags is required."
    print_usage
    exit 1
fi


# GET THE LIST OF HOMEOLOGS USING USING RBH
###########################################

bash workflow/scripts/rbh.sh 