##set working directory to place saved in

library(tidyverse)
library(haven)
demo <- read_xpt('data/original/DEMO_D.XPT')
demo |> select(SEQN, RIAGENDR, RIDAGEYR, RIDRETH1) |>
  rename(
    participant_id = SEQN,
    gender = RIAGENDR,
    age = RIDAGEYR,
    ethnicity = RIDRETH1
  )
