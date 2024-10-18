library(this.path)
setwd(this.dir())

#read in the body meanurements dataset 
library(tidyverse)
library(haven)
bmd <- read_csv('../../data/derived/body_measurements.csv')

#find the percentages of people who have accel data within those who are and aren't considered obese.
bmd |> group_by(obesity) |>
  summarise(
    percent_in = sum(in_sample)/n(),
    )

#find the percentages of people who have accel data within those of different genders
bmd |> group_by(riagendr) |>
  summarise(
    percent_in = sum(in_sample)/n(),
  )

#find the  maximum reported height in cm of a child under 16 
(bmd |> filter(ridageyr<16) |>
  arrange(desc(bmxht)) |>
  pull(bmxht))[1]
