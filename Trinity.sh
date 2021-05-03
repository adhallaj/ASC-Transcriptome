#!/bin/bash
export OMP_NUM_THREADS=10 #OMP_NUM_THREADS should be set to same number as --CPU parameter
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load trinity/2.9.1
# --seqType type of read (fa for .fasta, or fq for .fq.gz), --left and --right are the file inputs so --left would be the fileinpair_1.ext and --right would be fileinpair_2.ext, --SS_lib_type read orientation FR is Reads_1 5'-->3' and Reads 2 3'<--5' , --CPU number of CPUs to use (default is 2), --min_contig_length is the min segment lengths that trinity will keep after assembly, output will be a .fasta file
Trinity --seqType fq --max_memory 50G --left /scratch/trinity/A1_clean_1.fq.gz --right /scratch/trinity/A1_clean_2.fq.gz --SS_lib_type FR --CPU 10 --min_contig_length 200 --full_cleanup --verbose --output /scratch/trinity/A1_trinity
# ran on dmc, 100:00:00, large queue, 100gb, 32 cores
