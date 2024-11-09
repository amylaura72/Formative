import glob
import re
# Get the list of pid values from the filenames in data/original/accel/
accel_files = glob.glob("data/original/accel/accel-*.txt")
ACC_PID = [int(re.search(r"accel-(\d+).txt", f).group(1)) for f in accel_files]

rule all:
    "The default rule"
    input: "logs/data_summary_log.log"

rule BMX_check:
    "check the BMX data"
    input: "data/original/BMX_D.csv"
    output: "logs/bm_log.log"
    shell: """
    mkdir -p logs
    bash code/data_prep/basic_checks_bm.sh > logs/bm_log.log
    """

rule accel_check:
    "check the accel data"
    input: 
        expand("data/original/accel/accel-{pid}.txt", pid=ACC_PID),
        "logs/bm_log.log"
    output: "logs/accel_log.log"
    shell: """
    mkdir -p logs
    bash code/data_prep/basic_checks_accel.sh > logs/accel_log.log
    """

rule accel_fix:
    "fix the accel data"
    input: 
        "logs/accel_log.log",
        expand("data/original/accel/accel-{pid}.txt", pid=ACC_PID)
    output: 
        expand("data/derived/accel/accel-{pid}.txt", pid=ACC_PID),
        "logs/accel_fix_log.log"
    shell: """
    bash code/data_prep/fix_accel.sh > logs/accel_fix_log.log
    """

rule get_ids:
    "get a list of IDs present in both data sets"
    input: 
        expand("data/derived/accel/accel-{pid}.txt", pid=ACC_PID),
        "data/original/BMX_D.csv",
        "logs/accel_fix_log.log"
    output: 
        "data/derived/accel_ids.txt",
        "data/derived/BMX_IDs.txt",
        "logs/get_ID_log.log"
    shell: """
    bash code/data_prep/get_ids.sh  > logs/get_ID_log.log
    """

rule id_list:
    "make a list of which IDs are contained in both datasets"
    input:
        "data/derived/accel_ids.txt",
        "data/derived/BMX_IDs.txt",
        "logs/get_ID_log.log"
    output: 
        "data/derived/sampleIDs.csv",
        "logs/id_list_log"
    shell: """
    Rscript code/data_prep/compare_ids.R  > logs/id_list_log
    """

rule merge_data:
    input:
        "data/original/BMX_D.csv",
        "data/original/DEMO_D.XPT",
        "data/derived/sampleIDs.csv",
        "logs/id_list_log"
    output:
        "data/derived/body_measurements.csv",
        "logs/merge_log.log"
    shell: """
    Rscript code/tidyverse/load_demo_data.R > logs/merge_log.log
    """

rule data_summary:
    input: 
        "logs/merge_log.log",
        "data/derived/body_measurements.csv"
    output: "logs/data_summary_log.log"
    shell: """
    Rscript code/tidyverse/data_summary.R > logs/data_summary_log.log
    """


