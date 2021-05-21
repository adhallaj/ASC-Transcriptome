#!/bin/bash
#  load the module
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load seqkit/0.10.1

seqkit translate /home/aubaxh001/cdhit/A1_rmdup -o /home/aubaxh001/cdhit/peptides1
