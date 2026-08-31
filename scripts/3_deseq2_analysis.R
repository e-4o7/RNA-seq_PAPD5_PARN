#!/usr/bin/env Rscript

### Written by e-4o7

# Load libraries

library(tximport)
library(DESeq2)
library(pheatmap)
library(ggplot2)

# Paths to quant.sf files

files <- c(
    "SRR17129535_quant/quant.sf",
    "SRR17129536_quant/quant.sf",
    "SRR17129547_quant/quant.sf",
    "SRR17129548_quant/quant.sf"
)

# Sample names

names(files) <- c("BCH001", "RG7834", "Untreated", "DMSO")

# Import transcript-level counts

txi <- tximport(files, type = "salmon", txOut = TRUE)

dim(txi$counts)

# Metadata

coldata <- data.frame(
    row.names = colnames(txi$counts),
    condition = factor(c("Treatment", "Treatment", "Control", "Control"))
)

# DESeq2

dds <- DESeqDataSetFromTximport(txi, colData = coldata, design = ~ condition)
dds <- DESeq(dds)
res <- results(dds)
res_sorted <- res[order(res$padj), ]
summary(res)

# Save results

dir.create("results", showWarnings = FALSE)
write.csv(as.data.frame(res_sorted), "results/all_genes.csv")

# Significant genes (padj < 0.05)

res_sig <- res_sorted[which(res_sorted$padj < 0.05), ]
write.csv(as.data.frame(res_sig), "results/significant_genes.csv")

# Heatmap

vsd <- vst(dds, blind = FALSE)
sig_genes <- rownames(res[which(res$padj < 0.05), ]) 
pheatmap(assay(vsd)[sig_genes, ],
         scale = "row",
         main = "Все значимые гены",
         show_rownames = FALSE,
         fontsize_col = 14,
         filename = "results/heatmap_all_significant.png")
