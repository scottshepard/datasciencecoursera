# The is a script for the course project in Getting and Cleaning Data

library(plyr)

# First clear your environnment
rm(list=ls())

# Set working directory to folder with data
DataFolder <- "~/code/datasciencecoursera/data/GettingCleaningData_CourseProject/UCI HAR Dataset/"
OutputFolder <- "~/code/datasciencecoursera/GettingCleaningData_CourseProject/"
setwd(DataFolder)


## Part 1: Read in, format, and merge the data sets
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

## Part 2: Create the tidy dataset

# Create empty data.frame to write to
TidyData <- as.data.frame(matrix(nrow=0,ncol=67))
# Loop through all subject ids
# For each subject id, subset the data, then use the daply function to split by activity and get the column means
# bind this with labels for the subject to the TidyData data.frame
subject_ids <- unique(data$subject_id)
for (s_id in subject_ids) {
    TidyData <- rbind(TidyData,cbind(subject_id = s_id,daply(subset(data,subject_id == s_id),.(activity_label),function(y) colMeans(y[,2:67]))))
}
# Now bind the activty name as a column to the TidyData data.frame
TidyData <- cbind(activity = gsub("[0-9]","",rownames(TidyData)),TidyData)
# Finally order the data.frame properly and get rid of the rownames
TidyData <- TidyData[order(as.integer(as.character(TidyData$subject_id))),]
rownames(TidyData) <- 1:nrow(TidyData)
write.table(TidyData,paste0(OutputFolder,"TidyData.txt"))
