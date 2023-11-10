rule edgeR:
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
        "logs/edgeR/edgeR.log",
    params:
        out_dir=lambda w, output: os.path.split(
            os.path.split(os.path.split(output.mds_1)[0])[0]
        )[0],
        metadata=samples,
        min_count=MIN_COUNT,
    conda:
        "../../envs/edgeR.yaml"
    threads: workflow.cores
    shell:
        "Rscript workflow/scripts/edgeR.R {params.metadata} {input.count_dir} {params.min_count} {params.out_dir}"
