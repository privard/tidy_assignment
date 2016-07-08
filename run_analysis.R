# You should create one R script called run_analysis.R that does the following.
# 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr)

# Load the feature and activity names tables
features <- read.table('./UCI HAR Dataset/features.txt', col.names = c("id", "name"))
activities <- read.table('./UCI HAR Dataset/activity_labels.txt', col.names = c("id", "name"))

# Load the test data
test_data <- read.table('./UCI HAR Dataset/test/X_test.txt', col.names = features$name)
test_subjects <- read.table('./UCI HAR Dataset/test/subject_test.txt', col.names = 'subject')
test_activities <- read.table('./UCI HAR Dataset/test/y_test.txt', col.names = c("activityid"))

test_data <- cbind(test_activities, test_subjects, test_data)

# Load the training data
train_data <- read.table('./UCI HAR Dataset/train/X_train.txt', col.names = features$name)
train_subjects <- read.table('./UCI HAR Dataset/train/subject_train.txt', col.names = 'subject')
train_activities <- read.table('./UCI HAR Dataset/train/y_train.txt', col.names = c("activityid"))
train_data <- cbind(train_activities, train_subjects, train_data)

# Combine the training and test data
full_data <- rbind(test_data, train_data)

# Extract only the mean and standard deviation features for each measurements
desired_features <- features[grep("(mean\\(|std\\()", features$name),'id'] + 2
final_data <- full_data[,c(1, 2, desired_features)]

# Replace activity ids with their actual names
final_data$activityid <- activities[['name']][final_data$activityid]
final_data <- rename(final_data, activity = activityid)

## Remove unwanted periods for variable names and make them lowercase
colnames(final_data) <- tolower(gsub('\\.', '', names(final_data)))

## Create grouped table for final summary
grouped <- group_by(final_data, activity, subject)
summarized <- summarise_each(grouped, funs(mean))

write.table(summarized, file = 'tidydata.txt', row.name = FALSE)