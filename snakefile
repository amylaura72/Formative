rule all:
    "The default rule"
    input: "data/derived/sampleIDs.csv"

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
    input: "data/original/accel/accel-31128.txt"
    output: "logs/accel_log.log"
    shell: """
    mkdir -p logs
    bash code/data_prep/basic_checks_accel.sh > logs/accel_log.log
    """

rule accel_fix:
    "fix the accel data"
    input: "data/original/accel/accel-31128.txt"
    output: "data/derived/accel/accel-31128.txt"
    shell: """
    bash code/data_prep/fix_accel.sh
    """

rule get_ids:
    "get a list of IDs present in both data sets"
    input: 
        acceldata = "data/derived/accel/accel-31128.txt",
        BMXdata = "data/original/BMX_D.csv"
    output: 
        accelIDs = "data/derived/accel/accel_ids.txt",
        bmxIDs = "data/derived/BMX_IDs.txt"
    shell: """
    bash code/data_prep/get_ids.sh {input.acceldata} {input.BMXdata} {output.accelIDs} {output.bmxIDs}
    """

rule id_list:
    "make a list of which IDs are contained in both datasets"
    input:
        accelIDs = "data/derived/accel/accel_ids.txt",
        bmxIDs = "data/derived/BMX_IDs.txt"
    output: 
        outfile = "data/derived/sampleIDs.csv"
    shell: """
    Rscript code/data_prep/compare_ids.R {input.accelIDs} {input.bmxIDs} {output.outfile}
    """