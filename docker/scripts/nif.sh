#!/bin/bash
set -e 
####Defining pathways
while getopts i:p: option
do
case "${option}"
in
i) INPUT=${OPTARG};;
p) PLIST=${OPTARG};;
esac
done
echo "Welcome to the Automatic Sidecar Generator.."

maindir=${INPUT}

####Anatomical Organization####
for subj in ${PLIST}; do
	echo "Processing subject $subj"
	cd ${maindir}"/"$subj"/anat/"
	for file in "*"; do
		cur=${maindir}"/"$subj"/anat/"$file
		python3 /home/brett/winhome/Users/Brett/KHDATA/NIFTIJSON/docker/scripts/script.py $cur
		
	done
	cd ${maindir}"/"$subj"/func/"
	for file in "*"; do
		cur=${maindir}"/"$subj"/func/"$file
		python3 /home/brett/winhome/Users/Brett/KHDATA/NIFTIJSON/docker/scripts/script.py $cur
		
	done
done

