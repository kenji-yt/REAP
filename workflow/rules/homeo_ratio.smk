rule homeo_ratio:
    input:
        count_dir=f"{OUTPUT_DIR}/featureCounts",
        anno1=f"{ANNOTATION_PARENT_1}",
        ref1=f"{GENOME_DIR_1}/{GENOME_PARENT_1}.fa",
        anno2=f"{ANNOTATION_PARENT_2}",
        ref2=f"{GENOME_DIR_2}/{GENOME_PARENT_2}.fa",
        
    output: 
        
    log:
        "logs/homeo_ratio/homeo_ratio.log",
    params:
        out_dir=f"{OUTPUT_DIR}/homeo_ratio",
    conda:
        "../../envs/analyses.yaml"
    threads: workflow.cores
    shell:
        "bash workflow/scripts/homeo_ratio/homeo_ratio.sh -r {input.ref1} -r {input.ref2} -a {input.anno1} -a {input.anno2} -c {threads}"