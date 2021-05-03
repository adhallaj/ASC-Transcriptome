#!/bin/bash
#  load the module
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load anaconda/3-2020.02
#  place commands here
cd-hit-est -i /home/aubaxh001/transdecoder/transdecoderoutput//A1_assembled.Trinity.fasta.transdecoder.cds -o /home/aubaxh001/cdhit/A1_rmdup -c 0.95 -n 10 -d 0 -M 0 -T 0
