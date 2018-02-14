#Load libraries
library(dplyr)
#If the zip file has not been downloaded, download it to the working directory
destFile <- "data.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists(destFile)){
  setInternet2(TRUE)
  download.file(fileURL, destFile, method = "auto")
}

#Read the features.txt to get the column names for the test data
columns <- read.table(unz(destFile,"UCI HAR Dataset/features.txt"))$V2
columns <- gsub("-","",gsub("\\(\\)","",gsub("mean","Mean",gsub("std","Std",columns))))

#Import the test data, subject and activity
testData <- read.table(unz(destFile,"UCI HAR Dataset/test/X_test.txt"),col.names = columns)
testData$activityNum <- read.table(unz(destFile,"UCI HAR Dataset/test/y_test.txt"),col.names = "activityNum")$activityNum
testData$subject <- read.table(unz(destFile,"UCI HAR Dataset/test/subject_test.txt"),col.names = "subject")$subject

#Import the train data, subject and activity
trainData <- read.table(unz(destFile,"UCI HAR Dataset/test/X_test.txt"),col.names = columns)
trainData$activityNum <- read.table(unz(destFile,"UCI HAR Dataset/test/y_test.txt"),col.names = "activityNum")$activityNum
trainData$subject <- read.table(unz(destFile,"UCI HAR Dataset/test/subject_test.txt"),col.names = "subject")$subject

#Merge testData and trainData into masterData
masterData <- bind_rows(tbl_df(testData),tbl_df(trainData))

#Remove testData, trainData and columns from workspace
rm(testData,trainData,columns)

#Import activity list and join with masterData to replace activity numbers with labels
activityList <- read.table(unz(destFile,"UCI HAR Dataset/activity_labels.txt"),col.names = c("activityNum","activity")) %>% tbl_df
masterData <- masterData %>% left_join(activityList, by = "activityNum") %>% select(-activityNum)

#Select only columns with mean and standard deviation measurements
masterData <- masterData %>% select(subject, activity, matches('Mean[x-zX-Z]|std|Mean$'))

#Create tidy dataset with mean of each variable grouped by Subject and Activity
tidyData <- masterData %>% group_by(subject,activity) %>% summarise_all(funs(mean))

#Write tidyData out to tidyData.txt and cleanup workspace
write.table(tidyData,"tidyData.txt",row.names = FALSE)
rm(activityList,masterData,destFile,fileURL,tidyData)