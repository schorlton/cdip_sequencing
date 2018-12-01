#!/bin/bash

ls *_1.fastq.gz | xargs -n 1 -P 1 ~/Programs/Scripts/BBSplit.sh
cd ../NoContam/
ls *_keep_1.fastq.gz | xargs -n 1 -P 1 ~/Programs/Scripts/Ariba.sh
ls *_keep_1.fastq.gz | xargs -n 1 -P 1 ~/Programs/Scripts/Assemble_Spades.sh
cd ../Assembled/
mkdir Contigs
for i in Batch*; do cp $i'/contigs.fasta' 'Contigs/'$i'.fasta'; done
mkdir Scaffolds
for i in Batch*; do cp $i'/scaffolds.fasta' 'Scaffolds/'$i'.fasta'; done
cd Scaffolds
ls *.fasta | xargs -n 1 -P 1 ~/Programs/Scripts/Busco.sh
mkdir ../busco
mv run_Batch* ../busco/
ls *.fasta | xargs -n 1 -P 1 ~/Programs/Scripts/Prokka.sh
mkdir ../Prokka
mv Batch*_keep/ ../Prokka/
cd ../Contigs/
~/Programs/Scripts/Shutdown.sh
