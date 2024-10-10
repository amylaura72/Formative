library(this.path)
setwd(this.dir())
getwd()

#load in the two lists of IDs, will make combined list into the accel one so have given it a generic name
IDs = read.table('../data/derived/accel/accel_ids.txt', header=F, col.names='PID')
BMX = read.csv('../data/derived/BMX_IDs.txt')
colnames(BMX)[1] <- "PID"

#adding an indicator variable for accel IDs
IDs$accel <- 1

#add indicator to BMX data for whether they have BMI data or not
for (i in 1:nrow(BMX)){
  BMX$hasBMI[i] <- ifelse(is.na(BMX[i, 2]),0,1)
}

#merging the two data sets together
IDs <- merge(IDs, BMX, by.y='PID', all.x=T, all.y=T)

#adding 0's to those not in the accel data
for (i in 1:nrow(IDs)){
  if (is.na(IDs[i, 2])) {
    IDs[i, 2] <- 0
  } 
}

#checking which values are in the BMX data and which are not
for (i in 1:nrow(IDs)){
  IDs$sample[i] <- (IDs$accel[i]) * (IDs$hasBMI[i])
}

#find the number of poeple in (and not in) our sample
print(table(IDs$sample))

#save results to a file
write.csv(x = IDs[,c('PID', 'sample')], file='../data/derived/sampleIDs.csv')