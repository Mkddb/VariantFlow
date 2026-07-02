process ANNOTATION {

    tag "cohort"

    input:
    path vcf

    output:
    path "annotated.vcf", emit: annotated_vcf
    path "annotated.vcf.idx", emit: index

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
