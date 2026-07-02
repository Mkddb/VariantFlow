process FASTQC {

    tag "$sample"

    input:
    tuple val(sample), path(reads)

    output:
    tuple val(sample),
          path("${sample}_fastqc.zip"),
          path("${sample}_fastqc.html"),
          emit: results

    script:
    """
    fastqc ${reads[0]} ${reads[1]} --outdir .

    # rename outputs to sample-safe names
    mv *_1_fastqc.zip ${sample}_R1_fastqc.zip
    mv *_1_fastqc.html ${sample}_R1_fastqc.html

    mv *_2_fastqc.zip ${sample}_R2_fastqc.zip
    mv *_2_fastqc.html ${sample}_R2_fastqc.html
    """
}
