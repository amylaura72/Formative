#librarys needed for this code:
library(this.path)
library(ggplot2)
library(tidyverse)

setwd(this.dir())

#read in the body meanurements dataset 
bmd <- read_csv('../../data/derived/body_measurements.csv')

#keep only those who are in our accel sample:
bmd <- bmd |>
  filter(in_sample != 0)


# Create a list to store the data
accel_data <- data.frame()

# Iterate over each sequence and read the corresponding file, then bind to the data frame
for (seq in bmd$seqn) {
  temp_data <- read_tsv(sprintf('../../data/derived/accel/accel-%s.txt', seq))
  temp_data$seqn <- seq
  average_activity <- mean(temp_data$PAXSTEP)
  temp_data <- list(seq, average_activity)
  accel_data <- rbind(accel_data, temp_data)
}
# fix the names in the dataframe
names <- colnames(accel_data)

accel_data <- accel_data |>
  rename(
    seqn = names[1],
    activity = names[2]
  )

#add to the relevent BMX data
accel_data_bmi <-  merge(accel_data, bmd[, c("seqn", "bmxbmi", "riagendr")], by = "seqn")
accel_data_bmi <- na.omit(accel_data_bmi)

#rename these new columns
accel_data_bmi <- accel_data_bmi |>
  rename(
    gender = riagendr,
    bmi = bmxbmi
  )

#plot activity levels against BMI, stratified by gender
ggplot(data = accel_data_bmi, mapping = aes(x = bmi, y = activity, colour = as.factor(gender))) +
  geom_point() +
  scale_color_manual(values=c('skyblue','plum'), labels = c('Male', 'Female')) +
  theme_light() +
  labs(y = 'Average Steps per minute', x = 'BMI')
  
ggsave('../../results/plot.png',  width = 12, height = 8)



