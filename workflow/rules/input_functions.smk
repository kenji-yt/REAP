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
                f"{OUTPUT_DIR}/qualimap/{{sample}}/aligned_1",
                sample=samples.name.values.tolist(),
            )
        )

        input.extend(
            expand(
                f"{OUTPUT_DIR}/qualimap/{{sample}}/aligned_2",
                sample=samples.name.values.tolist(),
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
