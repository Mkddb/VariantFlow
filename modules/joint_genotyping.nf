process JOINT_GENOTYPING {

    tag "cohort"

    input:
    path gvcfs

    output:
    path "cohort.vcf.gz", emit: vcf
    path "cohort.vcf.gz.tbi", emit: index

    script:
    def vcf_args = gvcfs.collect { "-V ${it}" }.join(' ')

    """
    gatk CombineGVCFs \
        -R ${params.genome} \
        ${vcf_args} \
        -O cohort.g.vcf.gz

    gatk GenotypeGVCFs \
        -R ${params.genome} \
        -V cohort.g.vcf.gz \
        -O cohort.vcf.gz
    """
}
