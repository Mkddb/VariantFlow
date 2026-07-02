process VARIANT_CALLING {

    tag "$sample"

    input:
    tuple val(sample), path(bam)

    output:
    tuple val(sample),
          path("${sample}.g.vcf.gz"),
          path("${sample}.g.vcf.gz.tbi"),
          emit: gvcf

    script:
    """
    gatk HaplotypeCaller \
        -R ${params.genome} \
        -I ${bam} \
        -O ${sample}.g.vcf.gz \
        -ERC GVCF

    tabix -p vcf ${sample}.g.vcf.gz
    """
}
