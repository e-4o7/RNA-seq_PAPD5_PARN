#!/bin/bash

### Writtern by e-4o7

### Activate conda environment

source ~/miniconda3/etc/profile.d/conda.sh
conda activate pad5

### Create project directory

mkdir -p rna_seq_papd5
cd rna_seq_papd5

### Download SRA files using prefetch

prefetch --option-file SRR_Acc_List.txt

### Move .sra files to raw_fastq directory

mkdir -p raw_fastq
mv SRR*/*.sra raw_fastq/
rmdir SRR*/

### Convert .sra to .fastq.gz

cd raw_fastq
for file in *.sra; do
    run=$(basename $file .sra)
    fastq-dump --split-files --gzip --outdir . $run
done
cd ..

### Run FastQC

mkdir -p qc_raw
fastqc -o qc_raw raw_fastq/*.fastq.gz

### Run MultiQC

multiqc qc_raw/ -o multiqc_raw/

