# README

## Usage

- Download the data set from the following URL : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and extract it into the project folder. 
- execute run_analysis.R to create a tidy data set from the original data

## Data transformations 

run_analysis.R will perform the following operations on the original data set : 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
