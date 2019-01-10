#
# Computational Biology Dockerfile
#
#  created by Kai-Yuan Chen 

# Pull base image.

FROM ubuntu:18.04
MAINTAINER Kai-Yuan Chen <kaiyuan.kyle.chen@gmail.com>

# Install Dependencies in ubuntu
RUN \
    mkdir /src /download && \
    apt-get update && \
    apt-get -y upgrade && \ 
    apt-get install -y \
            gcc g++ \
            make \
            git \
            wget \
            libcurl3-gnutls \
            zlib1g-dev \
            libncurses5-dev \
            libbz2-dev \
            liblzma-dev \
            autoconf \
            libssl-dev \
            libtbb-dev \
            unzip \
            python3-pip \
            python3-dev \
            default-jdk \
            bedtools \
            alien
    
##### download source files
#### General
## 1. htslib
## 2. samtools
## 3. fastqc
## 4. bcl2fastq
## 5. bedtools

#### Genomic Seq
## 6. bowtie2
## 7. GATK: https://hub.docker.com/r/broadinstitute/gatk/
## 8. BWA

#### Transcriptomic Seq
## 9. hisat2
## 10. STAR

# Install htslib
WORKDIR /download
RUN wget https://github.com/samtools/htslib/releases/download/1.9/htslib-1.9.tar.bz2 && \
    tar -vxjf htslib-1.9.tar.bz2 && \
    cd /download/htslib-1.9 && \
    ./configure --prefix=/src/htslib && \
    make && make install && \ 
    cp /src/htslib/bin/* /usr/bin

# Install samtools
WORKDIR /download
RUN wget https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2 && \
    tar -vxjf samtools-1.9.tar.bz2 && \
    cd /download/samtools-1.9 && \
    ./configure --prefix=/src/samtools && \
    make && make install && \
    cp /src/samtools/bin/* /usr/bin
    
# Install Bowtie2
WORKDIR /download
RUN wget https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.3.4.3/bowtie2-2.3.4.3-linux-x86_64.zip/download && \
    unzip download && rm download && \
    cp /download/bowtie2-2.3.4.3-linux-x86_64/bowtie2* /usr/bin

# Install bcl2fastq
WORKDIR /download
RUN wget https://support.illumina.com/content/dam/illumina-support/documents/downloads/software/bcl2fastq/bcl2fastq2-v2-20-0-linux-x86-64.zip && \
    unzip bcl2fastq2-v2-20-0-linux-x86-64.zip && rm bcl2fastq2-v2-20-0-linux-x86-64.zip && \
    alien bcl2fastq2-v2.20.0.422-Linux-x86_64.rpm && \
    dpkg -i bcl2fastq2_0v2.20.0.422-2_amd64.deb

# Install bwa
WORKDIR /download
RUN git clone https://github.com/lh3/bwa.git && cd bwa && make && \
    cp bwa /usr/bin

# Install fastqc
WORKDIR /download
RUN wget http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.8.zip && \
    unzip fastqc_v0.11.8.zip && \
    chmod 755 /download/FastQC/fastqc && \
    cp /download/FastQC/fastqc /usr/bin

# Install hisat2 
WORKDIR /download
RUN wget http://ccb.jhu.edu/software/hisat2/dl/hisat2-2.1.0-Linux_x86_64.zip && \
    unzip hisat2-2.1.0-Linux_x86_64.zip && \ 
    cp -p hisat2-2.1.0/hisat2 hisat2-2.1.0/hisat2-* /usr/bin    

# Install STAR
WORKDIR /download
RUN wget https://github.com/alexdobin/STAR/archive/2.6.0a.tar.gz && \
    tar -xzf 2.6.0a.tar.gz && \
    cd STAR-2.6.0a/source && \
    make STAR && \
    cp STAR /usr/bin/STAR

# relink Python3
WORKDIR /usr/bin
RUN ln -s /usr/bin/python3 python && \
    pip3 install --upgrade pip    

# clear all downloads
WORKDIR /download
RUN rm -rf ./*