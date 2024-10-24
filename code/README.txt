-----environment set-up-----
use the following lines of code to set up the conda ervironment
"conda activate
conda env create -f project_environment.yml 
conda activate formative-env"
This environment incluses the versions of R and tidyverse used s well as anyother R packages. 
Code used to set up the conda environment can be found in the conda folder. 

-----data processing-----
All code is found in the data_prep folder and should be run from the main formative folder
1. Check the BMX data: basic_checks_bm.txt
2. check the accel data: basic_checks_accel.txt
3. fix the accel data: fix_accel.txt

-----generating sample-----
All code is found in the data_prep folder and should be run from the main formative folder
1. extract the IDs from the accel data: get_ids.txt
2. find which paricipant we have data for: compare_ids.R

-----body measurements dataset-----
All code is found in the tidyverse folder
1. combine with demoraphics data: load_demo_data.R
2. find some key summary statistics: data_summary.R

