#!/bin/bash, change as necessary

	#the first time you ever run BUSCO, you'll need to run these lines
	#then you can comment them out
	#cd ~
	#mkdir augustus
	#cd augustus
	#cp -r /opt/asn/apps/anaconda_3-4.2.0_cent/pkgs/augustus-3.2.3-boost1.60_0/config .

	#source and load your module
	source /opt/asn/etc/asn-bash-profiles-special/modules.sh
	module load busco/4.1.2

	#the documentation from HPCdocs says that this should come before you call BUSCO, but the program didn't run when I did that
	#so I left it here because I don't think it's hurting, and I also copy/pasted it after calling busco
	export BUSCO_CONFIG_FILE="/home/aubaxh001/cdhit/config.ini" #path to your configuration file, change as necessary
	export AUGUSTUS_CONFIG_PATH="~/augustus/config" #DON'T CHANGE THIS

	#call the busco program
	#all the info the program needs is in the config file - give the program the path to this file after --config
	#the only other info that you need to specify here is -l, which is what lineage you want to search against
	#there is a list of possible lineages that you can look against at the following website: https://busco-data.ezlab.org/v5/data/lineages/
	#when you are putting in the lineage name (i.e., copying it from the website above), remove everything after _odb10
	#for example, on the website, it lists "eukaryota_odb10.2020-09-10.tar.gz", but you only need to put down "eukaryota_odb10" - the program will not run if you put down the whole filename
	busco -l actinopterygii_odb10 --config /home/aubaxh001/cdhit/config.ini

	export BUSCO_CONFIG_FILE="/home/aubaxh001/cdhit/config.ini" #path to your configuration file, change as necessary
	export AUGUSTUS_CONFIG_PATH="~/augustus/config" #DON'T CHANGE THIS
