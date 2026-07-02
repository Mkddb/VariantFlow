nextflow.enable.dsl = 2

include { FASTQC } from './modules/fastqc.nf'
include { ALIGN } from './modules/alignment.nf'
include { BAM_PROCESS } from './modules/bam_process.nf'
include { VARIANT_CALLING } from './modules/variant_calling.nf'
include { JOINT_GENOTYPING } from './modules/joint_genotyping.nf'
include { ANNOTATION } from './modules/annotation.nf'

params.reads = "data/*_{1,2}.fastq.gz"

workflow {

    // Input
    Channel
        .fromFilePairs(params.reads, checkIfExists: true)
        .map { sample, reads -> tuple(sample, reads) }
        .set { read_pairs }

    // QC
    FASTQC(read_pairs)

    // Alignment
    aligned = ALIGN(read_pairs)

    // BAM processing
    bam = BAM_PROCESS(aligned.bam)

    // Variant calling (per sample)
    variants = VARIANT_CALLING(bam.sorted_bam)

    // IMPORTANT FIX: flatten GVCF channel
    gvcfs = variants.gvcf.map { it[1] }

    // Joint genotyping
    joint = JOINT_GENOTYPING(gvcfs.collect())

    // Annotation
    annotated = ANNOTATION(joint.vcf)

    annotated.view()
}
