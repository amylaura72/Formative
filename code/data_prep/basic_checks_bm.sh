 #!/bin/bash

##this code will run basic checks and investigation on the body measures data.
##This code is designed to be run from the formative folder, as code/data_prep/basic_checks_bm

#counting the number of lines of data
count=`wc -l data/original/BMX_D.csv`
echo "We have ${count} lines of data"

#looking at the top 15 lines (to see how it is layed out and also check if there is any extra stuff at the top
echo "  "
echo "these are the top 15 lines:"
head -n15 data/original/BMX_D.csv

#also looking at the last 10 to check it looks the same towards the bottom
echo "  "
echo "and these are the bottom 10 lines:"
tail data/original/BMX_D.csv

#checking for columns which dont have the same number of columns as the first line
echo "  "
num=`awk -F, '{print NF}' data/original/BMX_D.csv | head -n1`
echo "the first line has ${num} columns"
count2=`awk -F, '{print NF}' data/original/BMX_D.csv | grep -v 28 | wc -l`
echo "${count2} lines of the data have a different number of columns to the first line"