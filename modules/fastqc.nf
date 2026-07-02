process FASTQC {

    tag "$sample"

    input:
    tuple val(sample), path(reads)

    output:
    path "*_fastqc.zip", emit: fastqc_zip
    path "*_fastqc.html", emit: fastqc_html

    script:
    """
    mkdir -p fastqc
    fastqc ${reads[0]} ${reads[1]} --outdir fastqc
    """
}
