import glob
import re
# Get the list of pid values from the filenames in data/original/accel/
accel_files = glob.glob("data/original/accel/accel-*.txt")
ACC_PID = [int(re.search(r"accel-(\d+).txt", f).group(1)) for f in accel_files]

# The list of PID prefixes to use as batches
indexes = [str(x) for x in range(31, 42)]

# Create a dictionary of PID prefixes to lists of PID values
# This is a dictionary of lists, one list for every index in `indexes`
ACC_PID_dict = {index: [pid for pid in ACC_PID if str(pid).startswith(index)] for index in indexes}

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

for index in indexes:
    rule:
        name: f"{index}_check_accel_data"
        params: index=f"{index}"
        input:
            "logs/1-data-check-bm.log",
            expand("data/original/accel/accel-{pid}.txt", pid=ACC_PID_dict[index])
        output: f"logs/accel_log_{index}.log"
        shell: """
            mkdir -p logs       
            bash code/data_prep/basic_checks_accel.sh {params.index} > logs/accel_log_{index}.log
            """

for index in indexes:
    rule:
        name: f"{index}_fix_accel_data"
        params: index=f"{index}"
        input: 
            f"logs/2-data-check-accel_{index}.log",
                expand("data/original/accel/accel-{pid}.txt", pid=ACC_PID_dict[index])
        output: 
            expand("data/derived/accel/accel-{pid}.txt", pid=ACC_PID_dict[index]),
            f"logs/accel_fix_log_{index}.log"
        shell: """
            bash code/data_prep/fix_accel.sh {params.index} > logs/accel_fix_log_{index}.log
            """

rule get_ids:
    "get a list of IDs present in both data sets"
    input: 
        expand("data/derived/accel/accel-{pid}.txt", pid=ACC_PID),
        "data/original/BMX_D.csv",
        expand("logs/3-data-fix-accel_{index}.log", index=indexes)
    output: 
        "data/derived/accel_ids.txt",
        "data/derived/BMX_IDs.txt",
        "logs/get_ID_log.log"
    shell: """
    bash code/data_prep/get_ids.sh  > logs/get_ID_log.log
    """

rule id_list:
    "make a list of which compares Ids that are in both datasets"
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


