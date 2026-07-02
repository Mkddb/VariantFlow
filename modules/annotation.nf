process ANNOTATION {

    tag "cohort"

    input:
    path vcf

    output:
    path "annotated.vcf", emit: annotated_vcf

  script:
"""
mkdir -p ${params.outdir}/annotation

vep \
    -i ${vcf} \
    -o ${params.outdir}/annotation/annotated.vcf \
    --vcf \
    --species homo_sapiens \
    --cache \
    --offline \
    --everything
"""
