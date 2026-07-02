process ALIGN {

    tag "$sample"

    input:
    tuple val(sample), path(reads)

    output:
    tuple val(sample), path("${sample}.bam"), emit: bam

    script:
    """
    bwa mem ${params.genome} ${reads[0]} ${reads[1]} \
    | samtools view -Sb - \
    > ${sample}.bam
    """
}
