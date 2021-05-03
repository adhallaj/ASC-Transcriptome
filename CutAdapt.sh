#!/bin/bash
	#load the module
	source /opt/asn/etc/asn-bash-profiles-special/modules.sh
	module load anaconda/3-2020.02
	# -g is for the 5' adapter for file _1 (the forward file), -a is for the 3' adapter for file _1 (the forward file), -G is for the 5' adapter for file_2, -A is for the 3' adapter for file_2 --trim-n is how many Nucleotides (n) to trim off the end, -m is the minimum length of sequences that cutadapt will consider, -q is used to trim low-quality ends (leave this at 25), -o is where to put the output and what to call it, -p  short for paired-output to trim both reads in a pair at the same time, -cores should be 0 which defaults to what im running on ASC, directories at the end are the input files (two in this case because they are paired-end sequenced)
	cutadapt -g AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCT -a GATCGGAAGAGCACACGTCTGAACTCCAGTCACATCACGATCTCGTATGCCGTCTTCTGCTTG -G AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCT -A GATCGGAAGAGCACACGTCTGAACTCCAGTCACATCACGATCTCGTATGCCGTCTTCTGCTTG --trim-n -m 50 -q 25 --pair-filter=any --cores=0 -o /home/aubaxh001/forfileinpair_1.fq.gz -p /home/aubaxh001/forfileinpair_2.fq.gz /home/aubaxh001/raw_data/A1/A1_1.fq.gz /home/aubaxh001/raw_data/A1/A1_2.fq.gz
	# give ~4 hours to run, dmc, try 16gb, medium queue, 16 cores
