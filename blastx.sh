#!/bin/bash
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load blast+/2.6.0
# place blast+ commands here
#-db blast database name (default nr)
#-query input file against nucleotide database
#-out output file
#insert expected threshold here (lower value=more strict, less likely to be random, biol. significant)
#expected threshld 0.05
#word size(expect to use 3-blastx default-leave out/ or set to 3)
#max target- 100 control number of matches reported??? Leave out to see what code does
#matrix-score for aligning possible pair of residues(amino acids)(blosum62 = >85 and (11,1))
#Gap cost raw score of alignment is sum of scores for aligning pairs of residues and score of the gap
#gapopen- cost to open or extend gap (11,1)
#Compositional adjustments
#low complexity region indices capture maksing information? repeats etc
#didnt work: update_blastdb.pl --decompress nr

makeblastdb -in /home/aubaxh001/blastx/databases/giltheadbiomart.fasta -dbtype prot -input_type fasta
blastx -db /home/aubaxh0s01/blastx/databases/giltheadbiomart.fasta -outfmt '6 std qcovhsp' -query /home/aubaxh001/cdhit/A1_rmdup -out /home/aubaxh001/blastx/A1_blastedgh -evalue 0.00001 -num_threads 16
