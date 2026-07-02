process JOINT_GENOTYPING {

    tag "cohort"

    input:
    path gvcfs

    output:
    path "cohort.vcf.gz", emit: vcf

    script:
    """
    gatk CombineGVCFs \
        -R ref.fa \
        ${gvcfs.collect { "-V " + it }.join(" ")} \
        -O cohort.vcf.gz

    gatk GenotypeGVCFs \
        -R ref.fa \
        -V cohort.vcf.gz \
        -O cohort_final.vcf.gz
    """
}
