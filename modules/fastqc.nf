process FASTQC {

    tag "$sample"

    input:
    tuple val(sample), path(reads)

    output:
    tuple val(sample), path("fastqc"), emit: results

    script:
    """
    mkdir -p fastqc
    fastqc ${reads[0]} ${reads[1]} --outdir fastqc
    """
}
