#!/bin/bash
filename="${1%.*}"
filename=${filename%.*}
filename=${filename::-7}
echo $filename


pigz -dc $1 > working_1.fastq
pigz -dc $filename'_R2_001.fastq.gz' > working_2.fastq
ls working_*.fastq > files.txt


##Remove PCR Duplicates

fastuniq -i files.txt -t q -o tmp/fastuniq_1.fastq -p tmp/fastuniq_2.fastq

## Trim, merge paired ends, error correct, remove low complexity sequences


fastp -5 -3 -y -q 3 -c -m -i tmp/fastuniq_1.fastq -I tmp/fastuniq_2.fastq -o tmp/fastp_1.fastq -O tmp/fastp_2.fastq --merged_out tmp/fastp_merged.fastq -M 3 -l 31 -R $filename -j ../fastp/$filename'.fastp.json' --adapter_sequence=AGATCGGAAGAGCACACGTCTGAACTCCAGTCA --adapter_sequence_r2=AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT

rm fastp.html
rm tmp/fastuniq_1.fastq
rm tmp/fastuniq_2.fastq


## Filter Phi


bowtie2 -x ~/Data/References/PhiX -1 tmp/fastp_1.fastq -2 tmp/fastp_2.fastq -p 2 --un-conc 'tmp/NoPhi_%.fastq' 1>/dev/null 2>'../NoPhi/'$filename'_bowtie.log'

bowtie2 -x ~/Data/References/PhiX -U tmp/fastp_merged.fastq -p 2 --un 'tmp/NoPhi_merged.fastq' 1>/dev/null 2>'../NoPhi/'$filename'_merged_bowtie.log'

rm tmp/fastp_*.fastq

## Remove Contaminating Arcano sequences


seal.sh in=tmp/NoPhi_1.fastq in2=tmp/NoPhi_2.fastq refnames=t pattern='tmp/'$filename'_%_#.fastq.gz' ref=/home/sam/Data/References/CdipDedupe.fa,/home/sam/Data/References/ArcanoDedupe.fa outu='tmp/'$filename'_unseal'_1.fastq.gz outu2='tmp/'$filename'_unseal_2.fastq.gz' ambig=all

cat 'tmp/'$filename'_CdipDedupe_1.fastq.gz' 'tmp/'$filename'_unseal_1.fastq.gz' > '../NoContam/'$filename'_keep_1.fastq.gz'
cat 'tmp/'$filename'_CdipDedupe_2.fastq.gz' 'tmp/'$filename'_unseal_2.fastq.gz' > '../NoContam/'$filename'_keep_2.fastq.gz'

seal.sh in=tmp/NoPhi_merged.fastq refnames=t pattern='tmp/'$filename'_%.fastq.gz' ref=/home/sam/Data/References/CdipDedupe.fa,/home/sam/Data/References/ArcanoDedupe.fa outu='tmp/'$filename'_unseal'.fastq.gz ambig=all

cat 'tmp/'$filename'_CdipDedupe.fastq.gz' 'tmp/'$filename'_unseal.fastq.gz' > '../NoContam/'$filename'_keep_merged.fastq.gz'

rm tmp/NoPhi_*.fastq

## Assemble genome and plasmids


spades.py -o '~/Data/Assembled/'$filename --careful --pe1-1 '../NoContam/'$filename'_keep_1.fastq.gz' --pe1-2 '../NoContam/'$filename'_keep_2.fastq.gz' --pe1-m '../NoContam/'$filename'_keep_merged.fastq.gz' -t 8 -m 48 --cov-cutoff auto
#spades.py --plasmid -o '~/Data/Plasmids/'$filename --pe1-1 '../NoContam/'$filename'_keep_1.fastq.gz' --pe1-2 '../NoContam/'$filename'_keep_2.fastq.gz' --pe1-m '../NoContam/'$filename'_keep_merged.fastq.gz' -t 8 -m 48
spades.py --dataset '../Assembled/'$filename'/corrected/corrected.yaml' --plasmid -o '~/Data/Plasmids/'$filename -t 8 -m 48 --only-assembler

#Used for RGI with RGI v5
#Low quality assemblies and plasmids
#for i in *.fasta; do rgi main -i $i -o $i'_noNudgeLowQual' -n 8 --low_quality --exclude_nudge --clean; done

#High qual assemblies:
#for i in *.fasta; do rgi main -i $i -o $i'_noNudgeLowQual' -n 8 --exclude_nudge --clean; done
