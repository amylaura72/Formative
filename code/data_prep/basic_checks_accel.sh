#!/bin/bash

##this code investigates and checks the accel data
##should be run from the formative file as code/data_prep/basic_checks_accel

#counting how many files we have in this folder
count=`ls data/original/accel | wc -l`
echo "we have ${count} files of accel data"

#counting how many lines there are in two different random files a random file
echo "   "
count1=`wc -l data/original/accel/accel-31396.txt`
count2=`wc -l data/original/accel/accel-39812.txt`
echo "we have ${count1} and ${count2} in the two random files checked"

#looking at the top 10 lines of two random files
echo "   "
echo "the top 10 lines of two random file:"
head data/original/accel/accel-38693.txt
head data/original/accel/accel-32943.txt

#checking the last 10 to make sure it looks the same at the bottom
echo "   "
echo "the bottom 10 lines of two random file:"
tail data/original/accel/accel-38693.txt
tail data/original/accel/accel-32943.txt

#check that there are no lines with a different number of columns in any of the files and find the number of columns
#in those rows
echo "   "
echo "terun the lengh of any rows which don't have 8 columns"
cat data/original/accel/a*.txt | grep -v '<' | awk -F'\t' '{print NF}' | grep -v 8 | sort -u

#find the contents and locations of the lines with only 3 columns
echo "   "
echo "The lines with only 3 columns contain the folowing"
cat data/original/accel/a*.txt | grep -v '<' | awk -F'\t' '(NF!=8) {print $0}' | sort -u
echo "   "
echo "These lines are found in the following files:"
grep -vH '<' data/original/accel/a*.txt | awk -F'\t' '(NF!=8) {print $0}' | sort -u

#counting the number with the correct header to ensure it is the number of files
echo "   "
headcount=`cat data/original/accel/a*.txt | awk -F'\t' '($1=="\"PAXSTAT\"" && $2=="\"PAXCAL\"" && $3=="\"PAXDAY\"" && $4=="\"PAXN\"" && $5=="\"PAXHOUR\"" && $6=="\"PAXMINUT\"" && $7=="\"PAXINTEN\"" && $8=="\"PAXSTEP\"") {print $0}' | wc -l`
echo "there are ${headcount} files with the correct header line"
