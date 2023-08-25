# This file includes all functions to define inputs to other rules


def multiqc_input(wildcards):
    input = []
    if config["RUN_FASTQC"]:
        input.extend(
            expand(
                f"{OUTPUT_DIR}/fastqc/{{sample}}_{{extension}}_fastqc.zip",
                sample=samples.name.values.tolist(),
                extension=["R1", "R2"],
            )
        )
    if config["RUN_STAR"]:
        input.extend(
            expand(
                f"{OUTPUT_DIR}/qualimap/{{sample}}/aligned_{{one_or_two}}",
                sample=samples.name.values.tolist(),
                one_or_two=["1", "2"],
            )
        )
    if config["RUN_EAGLE"]:
        input.extend(
            expand(
                f"{OUTPUT_DIR}/read_sorting/{{sample}}/{{sample}}_classified{{one_or_two}}.ref.bam",
                sample=samples.name.values.tolist(),
                one_or_two=["1", "2"],
            )
        )

    return input


# Special parameters for Feature Count
def feature_count_params(wildcards):
    input = []
    if config["PAIRED_END"]:
        input.extend("--primary -p")
    else:
        input.extend("--primary")
    return input
