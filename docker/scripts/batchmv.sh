#!/bin/bash
searchdir="$(pwd)""/"
for i in $(find $searchdir -type f -iname '*.gz')
do
    IFS='/'
    read -ra ADDR <<< "$i"
    length=${#ADDR[@]}-3
    name=${ADDR[$length]}
    IFS=' '
    VAR3=""
    for (( r=0; r<$length; ++r)); do
        VAR3="$VAR3${ADDR[$r]}""/"
    done
    if [[ "$i" == *"anat"* ]]; then
        mv $i $VAR3$name"/anat/"$name"_T1w.nii.gz" 2> /dev/null
    fi
    if [[ "$i" == *"func"* ]]; then
        mv $i $VAR3$name"/func/"$name"_task-rest_run-01_bold.nii.gz" 2> /dev/null
    fi
done
