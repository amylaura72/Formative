#!/bin/bash

##this code aims to fix the issues identified through the data check code. It will also re-run some of the previous
##checks to ensure that the fixes have worked.
##Should be run from the formative folder as code/data_prep/fix_accel.txt

#moving all files to derived data
mkdir data/derived/accel
cp data/original/accel/a*.txt data/derived/accel

#removing the top line of all derived files
#sed -i '1d' data/derived/accel/a*.txt
#####keeping this code (above) as a comment to avoid removing the header lines

#removing NA lines from 31268 and 34974
sed -i '/NA\tNA\tNA/d' data/derived/accel/accel-31268.txt
sed -i '/NA\tNA\tNA/d' data/derived/accel/accel-34974.txt

#checking to ensure that the files now have the correct header as the first lin
head -n1 data/derived/accel/a*.txt | awk -F'\t' '($1=="\"PAXSTAT\"" && $2=="\"PAXCAL\"" && $3=="\"PAXDAY\"" && $4=="\"PAXN\"" && $5=="\"PAXHOUR\"" && $6=="\"PAXMINUT\"" && $7=="\"PAXINTEN\"" && $8=="\"PAXSTEP\"") {print $0}' | wc -l

#checking to ensure there are now 8 columns in every row
cat data/derived/accel/a*.txt | grep -v '<' | awk -F'\t' '{print NF}' | grep -v 8 | wc -l
