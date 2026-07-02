nextflow.enable.dsl = 2

include { FASTQC } from './modules/fastqc.nf'
include { ALIGN } from './modules/alignment.nf'
include { BAM_PROCESS } from './modules/bam_process.nf'
include { VARIANT_CALLING } from './modules/variant_calling.nf'
include { JOINT_GENOTYPING } from './modules/joint_genotyping.nf'
include { ANNOTATION } from './modules/annotation.nf'

params.reads = "data/*_{1,2}.fastq.gz"

workflow {

    read_pairs = Channel.fromFilePairs(params.reads, checkIfExists: true)

    FASTQC(read_pairs)

    aligned_ch = ALIGN(read_pairs)

    bam_ch = BAM_PROCESS(aligned_ch.out.bam)

    variants_ch = VARIANT_CALLING(bam_ch.out.sorted_bam)

    gvcf_ch = variants_ch.out.gvcf

    joint_ch = JOINT_GENOTYPING(gvcf_ch.collect())

    annotated_ch = ANNOTATION(joint_ch.out.vcf)

    annotated_ch.view()
}
