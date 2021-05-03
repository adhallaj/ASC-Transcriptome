# ASC-Transcriptome
Pipeline for assembly and annotation of a de-novo transcriptome using the Alabama SuperComputer.

# Removing Adapters
Adapters are removed using the program Cutadapt. The adapter sequences should be available in the data provided by the sequencing provider.
There are two adapters because this transcriptome was sequenced using Illumina Paired-end sequencing.

5' Adapter:

5'-AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCT-3'

3' Adapter:

5'-GATCGGAAGAGCACACGTCTGAACTCCAGTCACATCACGATCTCGTATGCCGTCTTCTGCTTG-3'
