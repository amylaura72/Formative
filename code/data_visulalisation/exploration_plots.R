#librarys needed for this code:
library(this.path)
library(ggplot2)
library(tidyverse)
 
setwd(this.dir())

#read in the body meanurements dataset 
bmd <- read_csv('../../data/derived/body_measurements.csv')

#plot waist against bmi
plot1 <- ggplot(data = bmd, mapping = aes(x = bmxwaist, y = bmxbmi)) +
  geom_point()

#read in accel_39771
accel_39771 <- read_tsv('../../data/derived/accel/accel-39771.txt')

#plot activity over time in accel_39771
plot2 <- ggplot(data = accel_39771, mapping = aes(x = PAXN, y = PAXSTEP)) +
  geom_point()

ggsave("../../results/waist_bmi.png", plot = plot1)
ggsave("../../results/accel_39771.png", plot = plot2)
