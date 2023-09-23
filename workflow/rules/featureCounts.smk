########################
## featureCounts rule ##
########################


# PARENT 1
rule feature_counts_p1:
    input:
        # list of sam or bam files
        samples=f"{OUTPUT_DIR}/read_sorting/{{sample}}/{{sample}}_classified1.ref.bam",
        annotation=f"{ANNOTATION_PARENT_1}",
    output:
        count_table=f"{OUTPUT_DIR}/featureCounts/{{sample}}/{{sample}}_subgenome_1.featureCounts",
        summary=f"{OUTPUT_DIR}/featureCounts/{{sample}}/{{sample}}_subgenome_1.featureCounts.summary",
    threads: workflow.cores
    params:
        extra="-t exon -g gene_id -p",
    log:
        "logs/featureCounts_{sample}_subgenome_1.log",
    wrapper:
        "v2.6.0/bio/subread/featurecounts"


# PARENT 2
rule feature_counts_p2:
    input:
        # list of sam or bam files
        samples=f"{OUTPUT_DIR}/read_sorting/{{sample}}/{{sample}}_classified2.ref.bam",
        annotation=f"{ANNOTATION_PARENT_2}",
    output:
        count_table=f"{OUTPUT_DIR}/featureCounts/{{sample}}/{{sample}}_subgenome_2.featureCounts",
        summary=f"{OUTPUT_DIR}/featureCounts/{{sample}}/{{sample}}_subgenome_2.featureCounts.summary",
    threads: workflow.cores
    params:
        extra="-t exon -g gene_id -p",
    log:
        "logs/featureCounts_{sample}_subgenome_2.log",
    wrapper:
        "v2.6.0/bio/subread/featurecounts"
