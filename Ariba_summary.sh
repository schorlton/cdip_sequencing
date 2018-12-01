mkdir Summaries
cat Batch*.mlst/mlst_report.tsv > Summaries/MLST.txt

ariba summary Summaries/argannot Batch*.argannot/report.tsv
ariba summary Summaries/card Batch*.card/report.tsv
ariba summary Summaries/megares Batch*.megares/report.tsv
ariba summary Summaries/plasmidfinder Batch*.plasmidfinder/report.tsv
ariba summary Summaries/resfinder Batch*.resfinder/report.tsv
ariba summary Summaries/srst2_argannot Batch*.srst2_arannot/report.tsv
ariba summary Summaries/vfdb_full Batch*.vfdb_full/report.tsv
ariba summary Summaries/virulencefinder Batch*.virulencefinder/report.tsv
