#############################################################################################
##  run_analysis.R
##
##  Written by: Romanov Aleksandr (22.08.15)
##
##  Purpose:
##  
##  This script prepare tidy data that can be used for later analysis.
##  1. Merges the training and the test sets to create one data set.
##  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
##  3. Uses descriptive activity names to name the activities in the data set
##  4. Appropriately labels the data set with descriptive variable names. 
##  5. From the data set in step 4, creates a second, independent tidy data set with the 
##     average of each variable for each activity and each subject.
##
#############################################################################################


##  Import the packages
library(data.table)
library(reshape2)
library(plyr)

##  Download and unzip file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = ".\\data\\UCI_HAR_Dataset.zip")
unzip(".\\data\\UCI_HAR_Dataset.zip", exdir = ".\\data")

##  Load tables from dataset
X_train         <- read.table(".\\data\\UCI HAR Dataset\\train\\X_train.txt")
X_test          <- read.table(".\\data\\UCI HAR Dataset\\test\\X_test.txt")
y_train         <- read.table(".\\data\\UCI HAR Dataset\\train\\y_train.txt")
y_test          <- read.table(".\\data\\UCI HAR Dataset\\test\\y_test.txt")
subject_train   <- read.table(".\\data\\UCI HAR Dataset\\train\\subject_train.txt")
subject_test    <- read.table(".\\data\\UCI HAR Dataset\\test\\subject_test.txt")
activity_labels <- read.table(".\\data\\UCI HAR Dataset\\activity_labels.txt")
features        <- read.table(".\\data\\UCI HAR Dataset\\features.txt")

##  1. Merges the training and the test sets to create one data set.
subject_all  <- rbind(subject_test,subject_train)
y_all        <- rbind(y_test, y_train)
x_all        <- rbind(X_test, X_train)
names(subject_all) <- "subject"
names(y_all) <- "activity"
names(x_all) <- c(as.character(features[, 2]))
data_raw     <- cbind(subject_all, y_all, x_all)

##  2. Extracts only the measurements on the mean and standard deviation for each measurement.
data_raw <- data_raw[ ,c(1, 2, grep("-mean\\(\\)|-std\\(\\)", names(data_raw)))]

##  3. Uses descriptive activity names to name the activities in the data set
activity_labels[,2]  <- gsub("_",".",tolower(activity_labels[,2]))
data_raw[,2]            <- activity_labels[data_raw[,2], 2]

##  4. Appropriately labels the data set with descriptive variable names.
names(data_raw)         <- gsub("-",".",tolower(names(data_raw)))
names(data_raw)         <- gsub("(","",names(data_raw),fixed=TRUE)
names(data_raw)         <- gsub(")","",names(data_raw),fixed=TRUE)
names(data_raw)         <- gsub("bodybody","body",names(data_raw))

##  5. From the data set in step 4, creates a second, independent tidy data set with the 
##     average of each variable for each activity and each subject.
tidy_data <- ddply(data_raw, c("subject","activity"), numcolwise(mean))
tidy_data <- melt(tidy_data, id.vars=c("subject","activity"))

##  Save tidy data
write.table(tidy_data, file = ".\\data\\tidy_data.txt", row.names=FALSE)