process BAM_PROCESS {

    tag "$sample"

    input:
    tuple val(sample), path(bam)

    output:
    tuple val(sample), path("${sample}.sorted.bam"), emit: sorted_bam
    tuple val(sample), path("${sample}.sorted.bam.bai"), emit: index

    script:
    """
    samtools sort -o ${sample}.sorted.bam ${bam}
    samtools index ${sample}.sorted.bam
    """
}
