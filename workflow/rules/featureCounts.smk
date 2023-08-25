########################
## featureCounts rule ##
########################

# PARENT 1
rule feature_counts_p1:
    input:
        # list of sam or bam files
        samples=f"{OUTPUT_DIR}/read_sorting/{{sample}}/{{sample}}_classified1.ref.bam",
        annotation=f"{ANNOTATION_PARENT_2}",
    output:
        multiext(f"{OUTPUT_DIR}/featureCounts/{{sample}}/{{sample}}_subgenome_1",
            ".featureCounts",
            ".featureCounts.summary",
            ".featureCounts.jcounts",
        ),
    threads: 1
    params:
        extra=feature_count_params,
    log:
        "logs/read_sorting_{{sample}}_subgenome_2.log",
    wrapper:
        "v2.6.0/bio/subread/featurecounts"


# PARENT 2
rule feature_counts_p2:
    input:
        # list of sam or bam files
        samples=f"{OUTPUT_DIR}/read_sorting/{{sample}}/{{sample}}_classified2.ref.bam",
        annotation=f"{ANNOTATION_PARENT_2}",
    output:
        multiext(f"{OUTPUT_DIR}/featureCounts/{{sample}}/{{sample}}_subgenome_2",
            ".featureCounts",
            ".featureCounts.summary",
            ".featureCounts.jcounts",
        ),
    threads: 1
    params:
        extra=feature_count_params,
    log:
        "logs/read_sorting_{{sample}}_subgenome_2.log",
    wrapper:
        "v2.6.0/bio/subread/featurecounts"