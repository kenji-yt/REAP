rule edgeR:
    input:
        count_dir=f"{OUTPUT_DIR}/featureCounts",
    output: 
        mds_1=f"{OUTPUT_DIR}/edgeR/subgenome_1/MDS.png",
        fc_cpm_1=f"{OUTPUT_DIR}/edgeR/subgenome_1/fc_cpm.png",
        res_1=f"{OUTPUT_DIR}/edgeR/subgenome_1/results_table.txt",
        mds_2=f"{OUTPUT_DIR}/edgeR/subgenome_2/MDS.png",
        fc_cpm_2=f"{OUTPUT_DIR}/edgeR/subgenome_2/fc_cpm.png",
        res_2=f"{OUTPUT_DIR}/edgeR/subgenome_2/results_table.txt",
    log:
        "logs/edgeR/edgeR.log",
    params:
        out_dir=f"{OUTPUT_DIR}/edgeR",
    conda:
        "../../envs/edgeR.yaml"
    threads: workflow.cores
    shell:
        "Rscript workflow/scripts/edgeR.R {config[METADATA]} {input.count_dir} {config[MIN_COUNT]} {params.out_dir}"
        