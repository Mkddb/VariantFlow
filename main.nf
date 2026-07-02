nextflow.enable.dsl = 2

params.reads = "data/*_{1,2}.fastq.gz"

workflow {

    Channel
        .fromFilePairs(params.reads, checkIfExists: true)
        .set { read_pairs }

    read_pairs.view()
}
