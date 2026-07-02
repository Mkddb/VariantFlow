process JOINT_GENOTYPING {

    tag "cohort"

    input:
    path gvcfs

    output:
    path "cohort.vcf.gz", emit: vcf

   script:
"""
mkdir -p ${params.outdir}/variants

gatk CombineGVCFs \
    -R ${params.genome} \
    ${gvcfs.collect { "-V " + it }.join(" ")} \
    -O ${params.outdir}/variants/cohort.g.vcf.gz

gatk GenotypeGVCFs \
    -R ${params.genome} \
    -V ${params.outdir}/variants/cohort.g.vcf.gz \
    -O ${params.outdir}/variants/cohort.vcf.gz
"""
