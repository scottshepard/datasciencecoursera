TidyData.txt CodeBook
====================

This is the CodeBook for the TidyData.txt contained in this directory.

The best place to learn about the raw data and where the data was collected is from the UCI Machine Learning Repository here

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

This data is information on wearable computing. Thirty different subjects engaged in six different activities multiple times and lots of data were collected on their movements.

Rows
---

Each row is one observation per subject per activity. 
There were thirty subjects in this study and six activites:

1. Laying
2. Sitting
3. Standing
4. Walking
5. Walking downstairs
6. Walking upstairs

There are 180 total observations in this data set, one for each subject and activity.

Columns
-------

Each column represents a kind of data collected. The full data has many more variables than what we kept. We only kept the mean and standard deviation variables. Each variable was observed many times for each subject. Here we have taken the mean of all of those observations and so condensed the data set. Each cell is mean of all of the dozens of raw observations taken.

The variables observed were. The ones labled XYZ were observed in three differnet dimensions. Mean and standard deviations were collected.

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag
