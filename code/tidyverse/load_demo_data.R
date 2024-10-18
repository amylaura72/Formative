library(this.path)
setwd(this.dir())

#read in the demographics data and set all names to lowercase
library(tidyverse)
library(haven)
demo <- read_xpt('../../data/original/DEMO_D.XPT')
demo_subset <- demo |> select(SEQN, RIAGENDR, RIDAGEYR, RIDRETH1) |>
  janitor::clean_names()

#read in the demographics data and set all names to lowercase
bmx <- read_csv('../../data/original/BMX_D.csv')
bmx <- bmx |> janitor::clean_names()

#joining the bmx and demogramphic data sets together, keeping the rows from the demographic data
demo_bmi <- bmx |> left_join(demo_subset) |>
  relocate(riagendr:ridreth1 ,.after = seqn)

#loading in the accel id_indicator data
sample_ids <- read_csv('../../data/derived/sampleIDs.csv')
sample_ids <- sample_ids |> select(PID, sample)

#merging with our bmi-demographic data to add a new variable and nameing that variable in_sample
demo_bmi_accelid <- demo_bmi |> left_join(sample_ids, join_by(seqn==PID)) |>
  rename(in_sample = sample) |>
  relocate(in_sample, .after = seqn)

#creating an indicator variable called 'obesity' 
demo_bmi_accelid <- demo_bmi_accelid |> mutate(
  obesity = ifelse(bmxbmi<25,0,1)
)

write_csv(demo_bmi_accelid, '../../data/derived/body_measurements.csv')
