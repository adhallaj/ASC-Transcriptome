#!/bin/bash
#script to run transdecoder
#load the module
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load transdecoder/5.5.0
TransDecoder.LongOrfs -t /home/aubaxh001/trinity/trinityoutput/A1_assembled.Trinity.fasta
TransDecoder.Predict -t /home/aubaxh001/trinity/trinityoutput/A1_assembled.Trinity.fasta
