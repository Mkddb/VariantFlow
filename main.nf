nextflow.enable.dsl = 2

include { FASTQC } from './modules/fastqc.nf'
include { ALIGN } from './modules/alignment.nf'
include { BAM_PROCESS } from './modules/bam_process.nf'
include { VARIANT_CALLING } from './modules/variant_calling.nf'
include { JOINT_GENOTYPING } from './modules/joint_genotyping.nf'
include { ANNOTATION } from './modules/annotation.nf'

params.reads = "data/*_{1,2}.fastq.gz"

workflow {

    Channel
        .fromFilePairs(params.reads, checkIfExists: true)
        .map { sample, reads -> tuple(sample, reads) }
        .set { read_pairs }

    FASTQC(read_pairs)

    aligned = ALIGN(read_pairs)

    bam = BAM_PROCESS(aligned.bam)

    variants = VARIANT_CALLING(bam.sorted_bam)

    joint = JOINT_GENOTYPING(variants.gvcf.collect())

    annotated = ANNOTATION(joint.vcf)

    annotated.view()
}
