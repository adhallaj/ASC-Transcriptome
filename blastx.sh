#!/bin/bash
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load blast+/2.6.0
# place blast+ commands here
#-db blast database name (default nr)
#-query input file against nucleotide database
#-out output file
# change the -in and -db depending on what database you are using

makeblastdb -in /home/aubaxh001/blastx/databases/giltheadbiomart.fasta -dbtype prot -input_type fasta
blastx -db /home/aubaxh0s01/blastx/databases/giltheadbiomart.fasta -outfmt '6 std qcovhsp' -query /home/aubaxh001/cdhit/A1_rmdup -out /home/aubaxh001/blastx/A1_blastedgh -evalue 0.00001 -num_threads 16
