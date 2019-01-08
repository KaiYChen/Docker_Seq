#
# Computational Biology Dockerfile
#
# 
#

# Pull base image.
FROM ubuntu:18.04
MAINTAINER Kai-Yuan Chen <kaiyuan.kyle.chen@gmail.com>
# Install.
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
            default-jdk
    
## download samtools and htslib
WORKDIR /download 
RUN \
    wget https://github.com/samtools/htslib/releases/download/1.9/htslib-1.9.tar.bz2 && \
    wget https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2 && \
    wget https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.3.4.3/bowtie2-2.3.4.3-linux-x86_64.zip/download && \
    wget http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.8.zip && \
    tar -vxjf samtools-1.9.tar.bz2 && \
    tar -vxjf htslib-1.9.tar.bz2 && \
    unzip download && rm download && \
    unzip fastqc_v0.11.8.zip

# Install htslib
WORKDIR /download/htslib-1.9
RUN ./configure --prefix=/src/htslib && \
    make && make install && \ 
    cp /src/htslib/bin/* /bin

# Install samtools
WORKDIR /download/samtools-1.9
RUN ./configure --prefix=/src/samtools && \
    make && make install && \
    cp /src/samtools/bin/* /bin
    
# Transfer Bowtie2
WORKDIR /download/bowtie2-2.3.4.3-linux-x86_64
RUN cp bowtie2* /bin

# Transfer Python3
WORKDIR /bin
RUN ln -s /usr/bin/python3 python && \
    pip3 install --upgrade pip
    
# fastqc
RUN cp -r /download/FastQC /src && \
    chmod 755 /src/FastQC/fastqc && \
    ln -s /src/FastQC/fastqc fastqc

#ADD root/.gitconfig /root/.gitconfig
#ADD root/.scripts /root/.scripts

# Set environment variables.
#ENV HOME /root

# Define working directory.
#WORKDIR /root

# Define default command.
# CMD ["cat 'hello'"]