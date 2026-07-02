process JOINT_GENOTYPING {

    tag "cohort"

    input:
    path gvcfs

    output:
    path "cohort.vcf.gz", emit: vcf
    path "cohort.vcf.gz.tbi", emit: index

    script:
    """
    mkdir -p ${params.outdir}/variants

    # Combine GVCFs properly (no Nextflow logic inside script)
    gatk CombineGVCFs \
        -R ${params.genome} \
        ${gvcfs.collect { "-V " + it }.join(" ")} \
        -O cohort.g.vcf.gz

    # Genotype
    gatk GenotypeGVCFs \
        -R ${params.genome} \
        -V cohort.g.vcf.gz \
        -O cohort.vcf.gz
    """
}
