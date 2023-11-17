rule edgeR:
    input:
        feature_counts_output=edgeR_input,
    output:
        mds_1=f"{OUTPUT_DIR}/edgeR/subgenome_1/MDS.png",
        fc_cpm_1=f"{OUTPUT_DIR}/edgeR/subgenome_1/fc_cpm.png",
        res_1=f"{OUTPUT_DIR}/edgeR/subgenome_1/result_table.txt",
        mds_2=f"{OUTPUT_DIR}/edgeR/subgenome_2/MDS.png",
        fc_cpm_2=f"{OUTPUT_DIR}/edgeR/subgenome_2/fc_cpm.png",
        res_2=f"{OUTPUT_DIR}/edgeR/subgenome_2/result_table.txt",
    log:
        "logs/edgeR/edgeR.log",
    params:
        count_dir=lambda w, input: os.path.split(
            os.path.split(input.feature_counts_output[0])[0]
        )[0],
        out_dir=lambda w, output: os.path.split(os.path.split(output.mds_1)[0])[0],
        metadata=config["METADATA"],
        min_count=MIN_COUNT,
    conda:
        "../../envs/edgeR.yaml"
    threads: workflow.cores
    shell:
        "Rscript workflow/scripts/edgeR.R {params.metadata} {params.count_dir} {params.min_count} {params.out_dir} 2> {log}"
