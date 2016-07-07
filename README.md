Getting and Cleaning Data: Course Project

You should create one R script called run_analysis.R that does the following.

    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement.
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive activity names.
    5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Steps to work on this course project:

1. "run_analysis.R" file is the script file.
2. as far as you have C: drive on your machine, just run this script. this script automatically set the working directory, creates a folder if not found, unzip the files etc.
3. this script will create 2 FINAL data-sets and 2 txt files for these 2 data-sets as a final output.
4. tidy data-set 1 : data_main (data_main.txt file in "c:/wearable/" folder. this is the tidy data set that covers all the requirements asked in questions 1 to 4. dimensions = 10299 x 89)
5. tidy data-set 2 : data_main_avg (data_main_avg.txt in "c:/wearable/" folder. this is the tidy data set no. 2 that covers all the requirements asked in question 5. dimensions = 180 x 89).


About the Code Book:

The CodeBook.md file describes the variables, the data, and any transformations or work that is performed to clean up the data.