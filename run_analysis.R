###Load required packages
install.packages("dplyr")
library(dplyr)
install.packages("data.table")
library(data.table)
install.packages("tidyr")
library(tidyr)

# getting data into R

setwd("C:\\") # start with setting the working directory in C:
if(!file.exists("./wearable")){dir.create("./wearable")}
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "./wearable/wearable.zip")
unzip("./wearable/wearable.zip",exdir = "./wearable")
filepath <- "./wearable/UCI HAR Dataset"
setwd("C:\\wearable") # SETTING THE WORKING DIRECTORY 

# Read the above files and create data tables.
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
# QUESTION(1) Merges the training and the test sets to create one data set.
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

############################################################################
# QUESTION(2) Extracts only the measurements on the mean and standard 
# deviation for each measurement.
############################################################################

mean_std <- grep(".*Mean.*|.*Std.*", names(data_main), value = TRUE, ignore.case=TRUE)
length(mean_std) # A CHECK TO SEE HOW MANY VARIABLES FILTERED

mean_std <- union(c("subject","activitynum"), mean_std)

data_mean_std <- data_main[,names(data_main) %in% mean_std] 

data_main = data_mean_std # FINAL DATA SET FOR QUE-2

dim(data_main)  ## this data frame should have 10299 rows (all observations) 
# and 88 (2 + 86 matched for mean/std) columns.

############################################################################
# QUESTION(3) Uses descriptive activity names to name the activities in the data set.
############################################################################

data_main = merge(activity_labels, data_main, by.x = "activitynum", all = TRUE)  # FINAL DATA SET
dim(data_main)  ## this data frame should have 10299 rows (all observations) 
# and 89 (88 + 1 for labels) columns.

############################################################################
# QUESTION(4) Appropriately labels the data set with descriptive variable names.
############################################################################

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

############################################################################
# QUESTION(5) From the data set in step 4, creates a second, independent tidy data 
#     set with the average of each variable for each activity and each subject.
############################################################################

data_main_avg = data_main # COPY OF A TIDY DATA-SET
data_main_avg = ddply(data_main_avg, c("subject","activitynum", "activityname"), numcolwise(mean))  # FINAL DATA SET
dim(data_main_avg) ## this data frame should have 180 rows (30 subjects X 6 activities) and 89 columns.
write.table(data_main_avg, file = "data_main_avg.txt", row.names = FALSE) # creating a txt file of a final tidy data-set

