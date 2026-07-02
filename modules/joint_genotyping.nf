process JOINT_GENOTYPING {

    tag "cohort"

    input:
    path gvcfs

    output:
    path "cohort.vcf.gz", emit: vcf

    script:
    """
    gatk CombineGVCFs \
        -R ${params.genome} \
        ${gvcfs.collect { "-V " + it }.join(" ")} \
        -O cohort.g.vcf.gz

    gatk GenotypeGVCFs \
        -R ${params.genome} \
        -V cohort.g.vcf.gz \
        -O cohort.vcf.gz
    """
}
