process VARIANT_CALLING {

    tag "$sample"

    input:
    tuple val(sample), path(bam)

    output:
    tuple val(sample), path("${sample}.g.vcf.gz"), emit: gvcf

   script:
"""
mkdir -p ${params.outdir}/variants

gatk HaplotypeCaller \
    -R ${params.genome} \
    -I ${bam} \
    -O ${params.outdir}/variants/${sample}.g.vcf.gz \
    -ERC GVCF
"""
