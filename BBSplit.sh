#!/bin/bash

filename="${1%.*}"
filename="${filename%.*}"
filename=${filename::-2}

~/Programs/bbmap/bbsplit.sh -Xmx25g in=$1 in2=$filename'_2.fastq.gz' basename='../NoContam/'$filename'_%_#.fastq.gz' ambiguous2=all qtrim=f scafstats='../NoContam/'$filename'.scaf' refstats='../NoContam/'$filename'.refstats' outu1='../NoContam/'$filename'_unmapped_1.fastq.gz' outu2='../NoContam/'$filename'_unmapped_2.fastq.gz' ref=Contam.fa,Cdip.fa

cat '../NoContam/'$filename'_Cdip_1.fastq.gz' '../NoContam/'$filename'_unmapped_1.fastq.gz' > '../NoContam/'$filename'_keep_1.fastq.gz'

cat '../NoContam/'$filename'_Cdip_2.fastq.gz' '../NoContam/'$filename'_unmapped_2.fastq.gz' > '../NoContam/'$filename'_keep_2.fastq.gz'

