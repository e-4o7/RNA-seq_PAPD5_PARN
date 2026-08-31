#!bin/bash

###Written by e-4o7

### Fastp: clean reads (single-end)

mkdir trimmed
fastp --html trimmed/SRR17129535.fastp.html --json trimmed/SRR17129535.fastp.json -i raw_fastq/SRR17129535_1.fastq.gz -o trimmed/SRR17129535_1.fastq.gz
fastp --html trimmed/SRR17129536.fastp.html --json trimmed/SRR17129536.fastp.json -i raw_fastq/SRR17129536_1.fastq.gz -o trimmed/SRR17129536_1.fastq.gz
fastp --html trimmed/SRR17129547.fastp.html --json trimmed/SRR17129547.fastp.json -i raw_fastq/SRR17129547_1.fastq.gz -o trimmed/SRR17129547_1.fastq.gz
fastp --html trimmed/SRR17129548.fastp.html --json trimmed/SRR17129548.fastp.json -i raw_fastq/SRR17129548_1.fastq.gz -o trimmed/SRR17129548_1.fastq.gz

### FastQC on trimmed reads

mkdir qc_trimmed
fastqc trimmed/*.fastq.gz -o qc_trimmed

### Download pre-built human transcriptome (GENCODE v44)
wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_44/gencode.v44.transcripts.fa.gz

### Build Salmon index

salmon index -t gencode.v44.transcripts.fa.gz -i salmon_human_index -k 31 --gencode

### Quantify

salmon quant -i salmon_human_index -l A -r trimmed/SRR17129535_1.fastq.gz -p 2 -o salmon_out/SRR17129535_quant
salmon quant -i salmon_human_index -l A -r trimmed/SRR17129536_1.fastq.gz -p 2 -o salmon_out/SRR17129536_quant
salmon quant -i salmon_human_index -l A -r trimmed/SRR17129547_1.fastq.gz -p 2 -o salmon_out/SRR17129547_quant
salmon quant -i salmon_human_index -l A -r trimmed/SRR17129548_1.fastq.gz -p 2 -o salmon_out/SRR17129548_quant

### MultiQC report

multiqc salmon_out/ -o multiqc_salmon
