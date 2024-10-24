#!/bin/bash

##designed to be run from the formative folder as code/data_prep/get_accel_ids.txt
## this code will retrive the IDs for all the people we have data for

#getting the IDs for the accel data
ls data/derived/accel | grep -Eo '[0-9]+' > data/derived/accel/accel_ids.txt

#getting the IDs for the BMX data
cut -f2,12 -d',' data/original/BMX_D.csv > data/derived/BMX_IDs.txt
