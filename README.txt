-----environment set-up-----
use the following lines of code to set up the conda ervironment
"conda activate
conda env create -f project_environment.yml 
conda activate formative-env"
This environment incluses the versions of R and tidyverse used s well as anyother R packages. 

-----data processing-----
1. Check the BMX data: basic_checks_bm
2. check the accel data: basic_checks_accel
3. fix the accel data: fix_accel
4. extract the IDs from the accel data: get_ids

-----generating sample-----
find which paricipant we have data for: compare_ids

-----body measurements dataset-----
1. combine with demoraphics data: tidyverse/load_demo_data
2. find some key summary statistics: 

