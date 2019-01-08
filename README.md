# Docker_Seq
Dockerfile to create images for Bioinformatics Analysis

This Docker image includes

Libraires: 
* Bowtie2
* samtools
* htslib
* FasQC

Dependencies:
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


USAGE:
docker build -t <imagename>:<tag> .
