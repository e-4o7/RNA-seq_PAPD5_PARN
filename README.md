# RNA-seq analysis of PAPD5 inhibitors in PARN-mutant iPSCs

## Project goal
Identify differentially expressed genes in iPSC cells with PARN mutation treated with PAPD5 inhibitors (BCH001, RG7834).

## Data
- **GEO:** GSE190173
- **SRA:** PRJNA786214
- 4 samples: Untreated, DMSO, BCH001, RG7834 (patient 1)

## Pipeline
- **QC:** FastQC, MultiQC
- **Trimming:** fastp
- **Quantification:** Salmon
- **DE analysis:** DESeq2 (R)
- **Visualization:** pheatmap, ggplot2

## Results
- 512 differentially expressed genes (padj < 0.05)
- Clear separation between control and treatment groups
- Heatmap confirm experimental validity
  ![Тепловая карта всех значимых генов](heatmap_all_significant.png)

## Technologies
- R (DESeq2, pheatmap, ggplot2)
- Bash (fastp, Salmon, FastQC)
- Conda environment

## Files
- `heatmap_all_significant.pdf` — main heatmap
- `significant_genes_padj0.05.csv` — full list of DE genes

## Author
e-4o7

## References

1. Nagpal N, Wang J, Zeng J, et al. **Small-Molecule PAPD5 Inhibitors Restore Telomerase Activity in Patient Stem Cells.** *Cell Stem Cell*. 2020;26(6):896-909.e8. doi: [10.1016/j.stem.2020.03.016](https://doi.org/10.1016/j.stem.2020.03.016). PMID: 32320679.

2. Nagpal N, et al. **Domain specific mutations in dyskerin disrupt 3' end processing of scaRNA13.** *Nucleic Acids Research*. 2022;50(18):10573-10589. doi: [10.1093/nar/gkac706](https://doi.org/10.1093/nar/gkac706). PMID: 36018809. GEO: [GSE190173](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE190173).
