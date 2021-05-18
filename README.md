# ASC-Transcriptome
Pipeline for assembly and annotation of a de-novo transcriptome using the Alabama SuperComputer.

# Notes before starting:

All .sh scripts need to have the [chmod +x] command executed on them to be able to run via run_script on the ASC.

To be compatible with the ASC queue system, all scripts need to be modified with the following command:

    chmod +x scriptname.sh

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

The database sequences for annotation were retreived from http://useast.ensembl.org/biomart/martview/ via the following steps:

  - In the drop down menu - CHOOSE DATABASE - select Ensembl Genes 104
  - In the - CHOOSE DATASET MENU - select the organism you want to use as reference
  - Under Attributes select Sequences, under Sequences check Peptide, and under Header Information check only the Gene Stable ID box
  - Click [Results], [Export all results to Compressed web file (notify by email)]
  - Enter your email and hit [Go]
  - You should get a link to download your database sequences as a .txt.gz file in fasta format

Ran BLASTX with the following parameters:

    medium queue, 16 cores, 50:00:00, 16gb, DMC

The output of BLASTX is a table file (chosen via the -outfmt '6 std qcovhsp' parameter). The rows are each match, and the columns are the following:

    Name of your sequence(s) | Name of Matching Database Sequence | pident | length | mismatch | gapopen | qstart | qend | sstart | send | evalue | bitscore | qcovhsp

# 6. Filtering and Annotating GO Terms

Sequences with high percent identity matches (>75%), low evalues (<1e-10), and high query coverage per high similarity pairs (>26, where 33 is the max since these are amino acid sequences) were selected and matched to their corresponding GO Terms using the filter_blastx.sh script. Script written by Katherine Eaton, PhD candidate @ Auburn Unvisersity. 

The GO terms were retreived from http://useast.ensembl.org/biomart/martview/ via the following steps:

 - In the drop down menu [- CHOOSE DATABASE -] select [Ensembl Genes 104]
 - In the [- CHOOSE DATASET MENU -] select the organism you want to use as reference
 - Under [Attributes] select [Features], under [Gene] check the [Gene Stable ID] and [Gene Name] box
 - Under [External] check the [GO term accession], [GO term name], and [GO term definition] boxes
 - Click [Results], from the file type drop down menu select [CSV]
 - Click [Export all results to Compressed web file (notify by email)]
 - Enter your email and hit [Go]
 - You should get a link to download your database sequences as a .txt.gz file in fasta format

Instead of running the filter script iteratively on each BLASTX output, the BLASTX outputs were concatenated:

    cat A1_blastedamazonmolly A1_blastedmidascichlid A1_blastedgilthead A1_blastedlargeyellowcroaker > A1_blastedmaster
  
For the filter script to work, the GO Terms were also concatenated:

    cat amazonmollyGO.csv giltheadseabreamGO.csv midascichlidGO.csv largeyellowcroakerGO.csv zebrafishGO.csv > masterGO.csv

Make the following adjustments to the filter_blastx.sh file:

  - Update the indir variable to the directory containing the A1_blastedmaster file
  - Update the blastfile variable to the name of your concatenated A1_blastedmaster file (in my case the file was actually called A1_blastedmaster)
  - Update the goinfo variable to the name of your concatenated masterGO.csv file (mine was also called masterGO.csv)

Ran the filter_blastx.sh on the supercomputer with the following parameters:

    20 cores, 20gb memory, large queue, 24:00:00, dmc.

The final output of the Filtered and GO Term annotated sequences are in a file called annotated_table.csv, the columns are:

    Name of your sequence(s),percent identity match,evalue,Matching Ensmbl Database Sequence,GO accession ID,gene name,gene description
