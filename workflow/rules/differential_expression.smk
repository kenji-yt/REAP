rule edgeR:
    input:
        count_dir=f"{OUTPUT_DIR}/featureCounts",
    output: 
        results=f"{OUTPUT_DIR}/edgeR/subgenome_{{one_or_two}}/{{outfile}}",
    log:
        "logs/edgeR/edgeR.log",
    params:
        out_dir=f"{OUTPUT_DIR}/edgeR",

    threads: workflow.cores
    shell:
        "Rscript workflow/scripts/edgeR.R {config[METADATA]} {input.count_dir} {config[MIN_COUNT]} {params.out_dir}"
        