# ASC-Transcriptome
Pipeline for assembly and annotation of a de-novo transcriptome using the Alabama SuperComputer.

# Notes before starting:

All .sh scripts need to have the [chmod +x] command executed on them to be able to run via run_script on the ASC.

Scripts were run using the following command:

  run_script scriptname.sh

# 1. Removing Adapters from Raw Reads with CutAdapt
Adapters are removed using the program Cutadapt. The adapter sequences should be available in the data provided by the sequencing provider.
There are two adapters (and two raw data .fq.gz files) because this transcriptome was sequenced using Illumina paired-end sequencing.

5' Adapter:

5'-AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCT-3'

3' Adapter:

5'-GATCGGAAGAGCACACGTCTGAACTCCAGTCACATCACGATCTCGTATGCCGTCTTCTGCTTG-3'

Ran Cutadapt with the following parameters:
4:00:00 run time, medium queue, 16gb memory, 16 cores, dmc

# 2. Assembling Raw Reads into a Transcriptome with Trinity
Now there are two files of sequences, adapter free, that need to be assembled. This assembly is done via Trinity. Both files will be combined and assembled in an output .fasta file specified by the flag --output.

The sequences are now a proper assembled transcriptome, but will need to be searched for open reading frames.

# 3. Identifying Open Reading Frames (ORFs) in the Assembled Transcriptome using Transdecoder

Transdecoder outputs four files:

transcripts.fasta.transdecoder.pep : peptide sequences for the final candidate ORFs; all shorter candidates within longer ORFs were removed.
transcripts.fasta.transdecoder.cds : nucleotide sequences for coding regions of the final candidate ORFs
transcripts.fasta.transdecoder.gff3 : positions within the target transcripts of the final selected ORFs
transcripts.fasta.transdecoder.bed : bed-formatted file describing ORF positions, best for viewing using GenomeView or IGV.

The .cds file is the identified ORFS in the assembled transcriptome, which includes duplicates.

# 4. Removing Duplicate ORFs using CD-HIT

To reduce redundancy in the transcriptome, CD-HIT is executed on the transcriptome.fasta file. 

# 5. Annotating Transcriptome with BlastX

The database sequences for annotation were retreived from www.ensembl.org/biomart/martview/63a2a5523e122bc98f5b553dd30b6afe via the following steps:

  - In the drop down menu - CHOOSE DATABASE - select Ensembl Genes 104
  - In the - CHOOSE DATASET MENU - select the organism you want to use as reference
  - Under Attributes select Sequences, under Sequences check Peptide, and under Header Information check only the Gene Stable ID box
  - Click [Results], [Export all results to Compressed web file (notify by email)]
  - Enter your email and hit [Go]
  - You should get a link to download your database sequences as a .txt.gz file in fasta format

# 6. Annotating GO Terms

 - In the drop down menu [- CHOOSE DATABASE -] select [Ensembl Genes 104]
 - In the [- CHOOSE DATASET MENU -] select the organism you want to use as reference
 - Under [Attributes] select [Features], under [Gene] check the [Gene Stable ID] and [Gene Name] box
 - Under [External] check the [GO term accession], [GO term name], and [GO term definition] boxes
 - Click [Results], from the file type drop down menu select [CSV]
 - Click [Export all results to Compressed web file (notify by email)]
 - Enter your email and hit [Go]
 - You should get a link to download your database sequences as a .txt.gz file in fasta format

# 7. Determining Which Sequences Were/Weren't Annotated with the filter_blastx.sh Script

Concatenated all of the BLASTX output files together using the following code:

   cat A1_blastedamazonmolly A1_blastedmidascichlid A1_blastedgilthead A1_blastedlargeyellowcroaker > A1_blastedmaster
  
Concatenated all of the GO terms together using the following code:

   cat amazonmollyGO.csv giltheadseabreamGO.csv midascichlidGO.csv largeyellowcroakerGO.csv zebrafishGO.csv > masterGO.csv

Make the following adjustments to the filter_blastx.sh file:

  - Update the indir variable to the directory containing the A1_blastedmaster file
  - Update the blastfile variable to the name of your concatenated A1_blastedmaster file (in my case the file was actually called A1_blastedmaster)
  - Update the goinfo variable to the name of your concatenated masterGO.csv file (mine was also called masterGO.csv)

Ran the filter_blastx.sh on the supercomputer with 20 cores, 20gb memory, large queue, 24:00:00, dmc.
