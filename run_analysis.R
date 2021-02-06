#A script to tidy data from UCI - Human Activity Recognition Using Smartphones Data Set


fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "UCI_Dataset.zip", method = "curl")
downloadedDate <- date()
unzip("UCI_Dataset.zip")
setwd("./UCI HAR Dataset")

#read in features.txt to be used as table header
features <- read.table("./features.txt", sep = " ", col.names = c("column_id", "column_name"))

#load test data X and Y
subject_test <- read.table("./test/subject_test.txt", col.names = "subject")
X_test <- read.table("./test/X_test.txt", col.names = features$column_name)
Y_test <-read.table("./test/Y_test.txt", col.names = "activity_id")
#column bind test data together
test <- cbind(subject_test, X_test, Y_test)

#load train data X and Y
subject_train <- read.table("./train/subject_train.txt", col.names = "subject")
X_train <- read.table("./train/X_train.txt", col.names = features$column_name)
Y_train <- read.table("./train/Y_train.txt", col.names = "activity_id")
#column bind train data together
train <- cbind(subject_train, X_train, Y_train)

#merge training data with test data to create one dataset
data <- rbind(train, test)

#Extracts only the measurements on the mean and standard deviation for each measurement. 
data <- data[, grepl("mean", names(data)) | grepl("std", names(data)) | names(data) =="activity_id" | names(data) =="subject"]

###Use descriptive activity names to name the activities in the data set
#read in activity labels
activity_labels <- read.table("./activity_labels.txt", sep =" ", header = FALSE, col.names = c("activity_id", "activity"))
#load dplyr library
library(dplyr)
#merge on activity names
data <- left_join(data, activity_labels, by="activity_id")

#rename columns
library(purrr)
library(stringr)
data <- data %>%
        purrr::set_names(~str_replace_all(.,"BodyAcc", "BodyAcceleration") %>%
                          str_replace_all("GravityAcc", "GravityAcceleration") %>%
                          str_replace_all("BodyAccJerk", "BodyAccelerationJerk") %>%
                          str_replace_all("BodyGyro", "BodyGyrometer") %>%
                          str_replace_all("BodyGyroJerk", "BodyGyrometerJerk") %>%
                          str_replace_all("BodyAccMag", "BodyAccelerationMagnitude") %>%
                          str_replace_all("GravityAccMag", "GravityAcclerationMagnitude") %>%
                          str_replace_all("BodyAccJerkMag", "BodyAccerlationJerkMagnitude") %>%
                          str_replace("^t", "Time") %>%
                          str_replace("^f", "Frequency") %>%
                          str_replace_all("\\.", ""))

#Calculate the mean of each variable by subject and activity
data_grouped <- data %>%
        group_by(subject, activity) %>%
        summarise_at(vars(TimeBodyAccelerationmeanX:FrequencyBodyBodyGyrometerJerkMagmeanFreq), mean)

#export tidy data
write.table(data_grouped, file = "../tidy_data.csv", row.names = FALSE)

