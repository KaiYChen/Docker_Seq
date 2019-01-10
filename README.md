# Docker_Seq
Dockerfile to create images for Bioinformatics Analysis

This Docker image includes

## Libraires: 
### General
* htslib
* samtools
* fastqc
* bcl2fastq
* bedtools

### Genomic Seq
* bowtie2
* GATK: https://hub.docker.com/r/broadinstitute/gatk/
* BWA

### Transcriptomic Seq
* hisat2
* STAR

## Dependencies:
* gcc g++
* make
* git
* wget
* libcurl3-gnutls
* zlib1g-dev
* libncurses5-dev
* libbz2-dev
* liblzma-dev
* autoconf
* libssl-dev
* libtbb-dev
* unzip
* python3-pip
* python3-dev
* default-jdk
* alien