filename="${1%.*}"
#filename=${filename::-2}

#~/Programs/bwa-0.7.17/bwa mem ~/Data/Genomics/Refs/C7.fasta -t 2 $1 $filename'_2.fastq' | samtools sort -@2 > 'Mapped/C7/'$filename'.bam'

#/Programs/bwa-0.7.17/bwa mem ../Refs/NCTC13129.fasta $1 $filename'_R2_001.fastq.gz' | samtools sort > '../Mapped/NCTC13129/'$filename'.sam'


#~/Programs/timeout -s 7000000 ~/Programs/SPAdes-3.12.0-Linux/bin/spades.py -o '~/Data/Genomics/Original/NoArcano/Contamd/'$filename -1 $1 -2 $filename'_2.fastq' -t 2 -m 7

#~/prokka/bin/prokka --prefix $filename --cpus 8 $1

python3 ~/Programs/busco/scripts/run_BUSCO.py -m genome -i $1 -o $filename -l ~/Programs/busco/actinobacteria_odb9 -c 8
