#!/bin/bash

filename="${1%.*}"
filename="${filename%.*}"
filename=${filename::-2}
echo $filename

ariba run --verbose --threads 8 ~/Programs/ariba/refs/Cdip_MLST/ref_db $1 $filename'_2.fastq.gz' 'ariba/'$filename'.mlst' >> 'ariba/'$filename'.samlog'

ariba run --verbose --threads 8 ~/Programs/ariba/refs/argannot.out $1 $filename'_2.fastq.gz' 'ariba/'$filename'.argannot' >> 'ariba/'$filename'.samlog'

ariba run --verbose --threads 8 ~/Programs/ariba/refs/card.out $1 $filename'_2.fastq.gz' 'ariba/'$filename'.card' >> 'ariba/'$filename'.samlog'

ariba run --verbose --threads 8 ~/Programs/ariba/refs/megares.out $1 $filename'_2.fastq.gz' 'ariba/'$filename'.megares' >> 'ariba/'$filename'.samlog'

ariba run --verbose --threads 8 ~/Programs/ariba/refs/plasmidfinder.out $1 $filename'_2.fastq.gz' 'ariba/'$filename'.plasmidfinder'  >> 'ariba/'$filename'.samlog'

ariba run --verbose --threads 8 ~/Programs/ariba/refs/resfinder.out $1 $filename'_2.fastq.gz' 'ariba/'$filename'.resfinder' >> 'ariba/'$filename'.samlog'

ariba run --verbose --threads 8 ~/Programs/ariba/refs/srst2_argannot.out $1 $filename'_2.fastq.gz' 'ariba/'$filename'.srst2_arannot' >> 'ariba/'$filename'.samlog'

ariba run --verbose --threads 8 ~/Programs/ariba/refs/vfdb_full.out $1 $filename'_2.fastq.gz' 'ariba/'$filename'.vfdb_full' >> 'ariba/'$filename'.samlog'

ariba run --verbose --threads 8 ~/Programs/ariba/refs/virulencefinder.out $1 $filename'_2.fastq.gz' 'ariba/'$filename'.virulencefinder' >> 'ariba/'$filename'.samlog'

