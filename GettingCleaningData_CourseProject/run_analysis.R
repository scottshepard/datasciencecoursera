# The is a script for the course project in Getting and Cleaning Data

library(plyr)

# First clear your environnment
rm(list=ls())

# Set working directory to folder with data
DataFolder <- "~/code/datasciencecoursera/data/GettingCleaningData_CourseProject/UCI HAR Dataset/"
OutputFolder <- "~/code/datasciencecoursera/GettingCleaningData_CourseProject/"
setwd(DataFolder)

test_data <- read.table("test/X_test.txt")
test_subjects <- readLines("test/subject_test.txt")
test_activities <- readLines("test/y_test.txt")

train_data <- read.table("train/X_train.txt")
train_subjects <- readLines("train/subject_train.txt")
train_activities <- readLines("train/y_train.txt")

varnames <- read.table("features.txt")
names(test_data) <- names(train_data) <- varnames$V2
# Add subject and activity ids
test_data$subject_id <- test_subjects
train_data$subject_id <- train_subjects
test_data$activity_id <- test_activities
train_data$activity_id <- train_activities
# merge training data with test data
data <- rbind(test_data,train_data)
# name the datset with the activity lablels
activities <- read.table("activity_labels.txt")
names(activities) <- c("activity_id","activity_label")
data <- merge(data,activities,by="activity_id")
# Keep only mean and standard deviation variables
data <- data[,grepl("activity",names(data)) |
               grepl("subject",names(data)) | 
               grepl("mean",names(data)) & 
               !grepl("Freq",names(data)) | 
               grepl("std",names(data))
             ]
data_by_subject <- split(data,data$subject_id)
TidyData <- as.data.frame(matrix(nrow=0,ncol=67))
subject_ids <- unique(data$subject_id)
for (s_id in subject_ids) {
    TidyData <- rbind(TidyData,cbind(subject_id = s_id,daply(subset(data,subject_id == s_id),.(activity_label),function(y) colMeans(y[,2:67]))))
}
TidyData <- cbind(activity = gsub("[0-9]","",rownames(TidyData)),TidyData)
TidyData <- TidyData[order(as.integer(as.character(TidyData$subject_id))),]
