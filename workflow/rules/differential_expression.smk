rule get_counts_1:
    output:
        gene_count1=f"{OUTPUT_DIR}/edgeR/{{sample}}/{{sample}}_subgenome_1.input_edgeR"
    input:
        count_table1=f"{OUTPUT_DIR}/featureCounts/{{sample}}/{{sample}}_subgenome_1.featureCounts",
    shell:
        """
        cat {input.count_table1} | awk '{if (NR>2) {print{$1 "\t" $7}}' > {output.gene_count1}
        """
rule get_counts_2:
    output:
        gene_count2=f"{OUTPUT_DIR}/edgeR/{{sample}}/{{sample}}_subgenome_2.input_edgeR"
    input:
        count_table2=f"{OUTPUT_DIR}/featureCounts/{{sample}}/{{sample}}_subgenome_2.featureCounts",
    shell:
        """
        cat {input.count_table2} | awk '{if (NR>2) {print $1 "\t" $7}}' > {output.gene_count2}
        """



rule edgeR:
    output:
    log:
        "logs/edgeR/edgeR.log",
    params:
        metadata=f"{METADATA}",
        count_dir=f"{OUTPUT_DIR}/featureCounts"
        min_count=f"{MIN_COUNT}"

    threads: workflow.cores
    shell:
        "Rscript workflow/scripts/edgeR.R {params.metadata} {params.count_dir} {params.min_count}"
        

