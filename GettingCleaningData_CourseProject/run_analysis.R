# The is a script for the course project in Getting and Cleaning Data

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

test_data$subject_id <- test_subjects
train_data$subject_id <- train_subjects
test_data$activity_id <- test_activities
train_data$activity_id <- train_activities

data <- rbind(test_data,train_data)

activities <- read.table("activity_labels.txt")
names(activities) <- c("activity_id","activity_label")
data <- merge(data,activities,by="activity_id")

colMeans(data[,2:561])
