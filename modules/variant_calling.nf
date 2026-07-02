process VARIANT_CALLING {

    tag "$sample"

    input:
    tuple val(sample), path(bam), path(bai)

    output:
    tuple val(sample), path("${sample}.g.vcf.gz"), emit: gvcf
    tuple val(sample), path("${sample}.g.vcf.gz.tbi"), emit: index

    script:
    """
    gatk HaplotypeCaller \
        -R ref.fa \
        -I ${bam} \
        -O ${sample}.g.vcf.gz \
        -ERC GVCF
    """
}
