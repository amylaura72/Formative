rule all:
    "The default rule"
    input: "logs/accel_log.log"

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