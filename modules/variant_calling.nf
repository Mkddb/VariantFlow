process VARIANT_CALLING {

    tag "$sample"

    input:
    tuple val(sample), path(bam)

    output:
    tuple val(sample), path("${sample}.g.vcf.gz"), emit: gvcf

    script:
    """
    gatk HaplotypeCaller \
        -R ${params.genome} \
        -I ${bam} \
        -O ${sample}.g.vcf.gz \
        -ERC GVCF
    """
}
