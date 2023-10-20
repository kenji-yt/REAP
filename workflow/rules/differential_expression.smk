
rule edgeR:
    output:
        # see STAR manual for additional output files
        aln=f"{OUTPUT_DIR}/star/{{sample}}/1_pe_aligned.bam",
        log=f"{OUTPUT_DIR}/star/{{sample}}/1_Log.out",
        sj=f"{OUTPUT_DIR}/star/{{sample}}/1_SJ.out.tab",
    log:
        "logs/pe/{sample}.log",
    params:
        metadata=f"{METADATA}",
        count_dir=f"{OUTPUT_DIR}/featureCounts/"
        min_count=f"{MIN_COUNT}"

    threads: workflow.cores
    shell:
        "Rscript workflow/scripts/edgeR.R {params.metadata} {params.count_dir} {params.min_count}"
        

