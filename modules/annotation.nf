process ANNOTATION {

    tag "cohort"

    input:
    path vcf

    output:
    path "annotated.vcf", emit: annotated_vcf

    script:
    """
    vep \
        -i ${vcf} \
        -o annotated.vcf \
        --vcf \
        --species homo_sapiens \
        --cache \
        --offline \
        --everything
    """
}
