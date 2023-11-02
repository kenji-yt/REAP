rule edgeR:
    input:
        count_dir=f"{OUTPUT_DIR}/featureCounts",
    output: 
        in_data=f"{OUTPUT_DIR}/edgeR/{{sample}}/{{sample}}_subgenome_{{one_or_two}}.input_edgeR",
    log:
        "logs/edgeR/edgeR.log",
    params:
        out_dir=f"{OUTPUT_DIR}/edgeR",

    threads: workflow.cores
    shell:
        "Rscript workflow/scripts/edgeR.R {config[METADATA]} {input.count_dir} {config[MIN_COUNT]} {params.out_dir}"
        