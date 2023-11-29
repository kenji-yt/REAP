rule homeo_ratio:
    input:
        count_dir=f"{OUTPUT_DIR}/featureCounts",
    output: 
        mds_1=f"{OUTPUT_DIR}/edgeR/subgenome_1/MDS.png",
        fc_cpm_1=f"{OUTPUT_DIR}/edgeR/subgenome_1/fc_cpm.png",
        res_1=f"{OUTPUT_DIR}/edgeR/subgenome_1/result_table.txt",
        mds_2=f"{OUTPUT_DIR}/edgeR/subgenome_2/MDS.png",
        fc_cpm_2=f"{OUTPUT_DIR}/edgeR/subgenome_2/fc_cpm.png",
        res_2=f"{OUTPUT_DIR}/edgeR/subgenome_2/result_table.txt",
    log:
        "logs/homeo_ratio/homeo_ratio.log",
    params:
        out_dir=f"{OUTPUT_DIR}/homeo_ratio",
    conda:
        "../../envs/homeo_ratio.yaml"
    threads: workflow.cores
    shell:
        "Rscript workflow/scripts/edgeR.R {config[METADATA]} {input.count_dir} {config[MIN_COUNT]} {params.out_dir}"
        