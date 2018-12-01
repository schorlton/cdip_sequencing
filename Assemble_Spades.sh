#!/bin/bash
filename="${1%.*}"
filename=${filename%.*}
filename=${filename::-2}
echo $filename
~/Programs/SPAdes-3.13.0-Linux/bin/spades.py -o '~/Data/Assembled/'$filename -1 $1 -2 $filename'_2.fastq.gz' -t 8 -m 27 --cov-cutoff auto
