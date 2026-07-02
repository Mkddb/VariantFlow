nextflow.enable.dsl = 2

include { FASTQC } from './modules/fastqc.nf'
include { ALIGN } from './modules/alignment.nf'
include { BAM_PROCESS } from './modules/bam_process.nf'
include { VARIANT_CALLING } from './modules/variant_calling.nf'
include { JOINT_GENOTYPING } from './modules/joint_genotyping.nf'
include { ANNOTATION } from './modules/annotation.nf'

params.reads = "data/*_{1,2}.fastq.gz"

workflow {

    // INPUT (already paired correctly)
    read_pairs = Channel.fromFilePairs(params.reads, checkIfExists: true)

    // QC
    FASTQC(read_pairs)

    // ALIGNMENT
    aligned_ch = ALIGN(read_pairs)

    // BAM PROCESSING
    bam_ch = BAM_PROCESS(aligned_ch.bam)

    // VARIANT CALLING
    variants_ch = VARIANT_CALLING(bam_ch.sorted_bam)

    // EXTRACT GVCFs (depends on your module output structure)
    gvcf_ch = variants_ch.gvcf.flatten()

    // JOINT GENOTYPING
    joint_ch = JOINT_GENOTYPING(gvcf_ch.collect())

    // ANNOTATION
    annotated_ch = ANNOTATION(joint_ch.vcf)

    annotated_ch.view()
}
