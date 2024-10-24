#!/bin/bash

##this code investigates and checks the accel data
##should be run from the formative file as code/data_prep/basic_checks_accel

#counting how many files we have in this folder
ls data/original/accel | wc -l

#counting how many lines there are in two different random files a random file
wc -l data/original/accel/accel-31396.txt 
wc -l data/original/accel/accel-39812.txt

#looking at the top 10 lines of two random fil
head data/original/accel/accel-38693.txt
head data/original/accel/accel-32943.txt

#checking the last 10 to make sure it looks the same at the bottom
tail data/original/accel/accel-38693.txt
tail data/original/accel/accel-32943.txt

#check that there are no lines with a different number of columns in any of the files and find the number of columns
#in those rows
cat data/original/accel/a*.txt | grep -v '<' | awk -F'\t' '{print NF}' | grep -v 8 | sort -u

#find the contents and locations of the lines with only 3 columns
cat data/original/accel/a*.txt | grep -v '<' | awk -F'\t' '(NF!=8) {print $0}' | sort -u
grep -vH '<' data/original/accel/a*.txt | awk -F'\t' '(NF!=8) {print $0}' | sort -u

#counting the number with the correct header to ensure it is the number of files
cat data/original/accel/a*.txt | awk -F'\t' '($1=="\"PAXSTAT\"" && $2=="\"PAXCAL\"" && $3=="\"PAXDAY\"" && $4=="\"PAXN\"" && $5=="\"PAXHOUR\"" && $6=="\"PAXMINUT\"" && $7=="\"PAXINTEN\"" && $8=="\"PAXSTEP\"") {print $0}' | wc -l

