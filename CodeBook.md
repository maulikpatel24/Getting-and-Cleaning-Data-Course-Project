
CODEBOOK.md

Getting and Cleaning Data Course Project

Instructions for project The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

    Merges the training and the test sets to create one data set.
    Extracts only the measurements on the mean and standard deviation for each measurement.
    Uses descriptive activity names to name the activities in the data set
    Appropriately labels the data set with descriptive variable names.
    From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Description of the DATA

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix ‘t’ to denote time) were captured at a constant rate of 50 Hz. and the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) – both using a low pass Butterworth filter.

The body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

A Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the ‘f’ to indicate frequency domain signals).
Description of abbreviations of measurements

    leading t or f is based on time or frequency measurements.
    Body = related to body movement.
    Gravity = acceleration of gravity
    Acc = accelerometer measurement
    Gyro = gyroscopic measurements
    Jerk = sudden movement acceleration
    Mag = magnitude of movement
    mean and SD are calculated for each subject for each activity for each mean and SD measurements.

The units given are g’s for the accelerometer and rad/sec for the gyro and g/sec and rad/sec/sec for the corresponding jerks.

These signals were used to estimate variables of the feature vector for each pattern:
‘-XYZ’ is used to denote 3-axial signals in the X, Y and Z directions. They total 33 measurements including the 3 dimensions - the X,Y, and Z axes.

    tBodyAcc-XYZ
    tGravityAcc-XYZ
    tBodyAccJerk-XYZ
    tBodyGyro-XYZ
    tBodyGyroJerk-XYZ
    tBodyAccMag
    tGravityAccMag
    tBodyAccJerkMag
    tBodyGyroMag
    tBodyGyroJerkMag
    fBodyAcc-XYZ
    fBodyAccJerk-XYZ
    fBodyGyro-XYZ
    fBodyAccMag
    fBodyAccJerkMag
    fBodyGyroMag
    fBodyGyroJerkMag

The set of variables that were estimated from these signals are:

    mean(): Mean value
    std(): Standard deviation

Data Set Information:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.


Steps to work on this course project:

1. "run_analysis.R" file is the script file you need to run in R. it is a reproducible file that can be run on any machine. 
2. as far as you have C: drive on your machine, just run this script. this script automatically set the working directory, creates a folder if not found, unzip the files etc.
3. this script will create 2 FINAL data-sets and 2 txt files for these 2 data-sets as a final output.
4. tidy data-set 1 : data_main (data_main.txt file in "c:/wearable/" folder. this is the tidy data set that covers all the requirements asked in questions 1 to 4. dimensions = 10299 x 89)
5. tidy data-set 2 : data_main_avg (data_main_avg.txt in "c:/wearable/" folder. this is the tidy data set no. 2 that covers all the requirements asked in question 5. dimensions = 180 x 89).


Load required packages

###Install & Load required packages
install.packages("dplyr")
library(dplyr)
install.packages("data.table")
library(data.table)
install.packages("tidyr")
library(tidyr)



### Download the Data - getting data into R

setwd("C:\\") # start with setting the working directory in C:
if(!file.exists("./wearable")){dir.create("./wearable")}
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "./wearable/wearable.zip")
unzip("./wearable/wearable.zip",exdir = "./wearable")
filepath <- "./wearable/UCI HAR Dataset"
setwd("C:\\wearable") # setting the working directory



### Files in folder ‘UCI HAR Dataset’ that will be used are:

    SUBJECT FILES

    test/subject_test.txt
    train/subject_train.txt

    ACTIVITY FILES

    test/X_test.txt
    train/X_train.txt

    DATA FILES

    test/y_test.txt
    train/y_train.txt

    features.txt - Names of column variables in the dataTable

    activity_labels.txt - Links the class labels with their activity name.



### Read the above files and create data tables.
subject_train = tbl_df(read.table(file.path(filepath, "train", "subject_train.txt")))
subject_test = tbl_df(read.table(file.path(filepath, "test", "subject_test.txt")))

activity_train = tbl_df(read.table(file.path(filepath, "train", "y_train.txt")))
activity_test = tbl_df(read.table(file.path(filepath, "test", "y_test.txt")))

data_train = tbl_df(read.table(file.path(filepath, "train", "X_train.txt")))
data_test = tbl_df(read.table(file.path(filepath, "test", "X_test.txt")))

data_features = tbl_df(read.table(file.path(filepath, "features.txt")))
activity_labels = tbl_df(read.table(file.path(filepath, "activity_labels.txt")))

sub_train = read.table(file.path(filepath, "train", "subject_train.txt"))



############################################################################
### QUESTION(1) Merges the training and the test sets to create one data set.
############################################################################

all_subject = rbind(subject_train, subject_test)
setnames(all_subject, "V1", "subject")

all_activity = rbind(activity_train, activity_test)
setnames(all_activity, "V1", "activitynum")

setnames(data_features, names(data_features), c("featurenum", "featurename"))

data_table = rbind(data_train, data_test)
colnames(data_table) <- data_features$featurename

setnames(activity_labels, names(activity_labels), c("activitynum", "activityname"))

data_main = cbind(all_subject, all_activity, data_table) # FINAL DATA SET FOR QUE-1

dim(data_main) # should be 10299 x 563



########################################################################################################
### QUESTION(2) Extracts only the measurements on the mean and standard deviation for each measurement.
########################################################################################################

mean_std <- grep(".*Mean.*|.*Std.*", names(data_main), value = TRUE, ignore.case=TRUE)
length(mean_std) # A CHECK TO SEE HOW MANY VARIABLES FILTERED

mean_std <- union(c("subject","activitynum"), mean_std)

data_mean_std <- data_main[,names(data_main) %in% mean_std] 

data_main = data_mean_std # FINAL DATA SET FOR QUE-2

dim(data_main)  ## this data frame should have 10299 rows (all observations) # and 88 (2 + 86 matched for mean/std) columns.




#####################################################################################
### QUESTION(3) Uses descriptive activity names to name the activities in the data set.
#####################################################################################

	data_main = merge(activity_labels, data_main, by.x = "activitynum", all = TRUE)  # FINAL DATA SET
	dim(data_main)  ## this data frame should have 10299 rows (all observations) # and 89 (88 + 1 for labels) columns.


################################################################################
### QUESTION(4) Appropriately labels the data set with descriptive variable names.
################################################################################

Appropriately labels the data set with descriptive variable names.

    leading t or f is based on time or frequency measurements.
    Body = BodyMovement
    Acc = AccelerometerMeasurement
    Gyro = GyroscopicMeasurement
    Mag = magnitude of movement
    mean and SD are calculated for each subject for each activity for each mean and SD measurements. The units given are g’s for the accelerometer and rad/sec for the gyro and g/sec and rad/sec/sec for the corresponding jerks.


names(data_main)<-gsub("std", "StandardDeviation", names(data_main))
names(data_main)<-gsub("^t", "timeMeasurement_", names(data_main))
names(data_main)<-gsub("^f", "frequencyMeasurement_", names(data_main))
names(data_main)<-gsub("^angle\\(t", "angle(timeMeasurement_", names(data_main))
names(data_main)<-gsub("^angle\\(f", "angle(frequencyMeasurement_", names(data_main))
names(data_main)<-gsub("Acc", "AccelerometerMeasurement_", names(data_main))
names(data_main)<-gsub("Gyro", "GyroscopicMeasurement_", names(data_main))
names(data_main)<-gsub("Mag", "Magnitude", names(data_main))
names(data_main)<-gsub("BodyBody", "Body", names(data_main))
names(data_main)<-gsub("Body", "BodyMovement_", names(data_main))
write.table(data_main, file = "data_main.txt") # creating a txt file of a final tidy data-set


###############################################################################################################################################################
### QUESTION(5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
###############################################################################################################################################################

data_main_avg = data_main # COPY OF A TIDY DATA-SET
data_main_avg = ddply(data_main_avg, c("subject","activitynum", "activityname"), numcolwise(mean))  # FINAL DATA SET
dim(data_main_avg) ## this data frame should have 180 rows (30 subjects X 6 activities) and 89 columns.
write.table(data_main_avg, file = "data_main_avg.txt", row.names = FALSE) # creating a txt file of a final tidy data-set

