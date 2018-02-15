# gathering_and_cleaning_data
Repo for "Gathering and Cleaning Data" Coursera Course Project

#Requirements
The define requirements for this project are:
    1. The submitted data set is tidy.
    2. The Github repo contains the required scripts.
    3. GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
    4. The README that explains the analysis files is clear and understandable.
    5. The work submitted for this project is the work of the student who submitted it.
	
#The R Script
The R script, "run_analysis.R", provided completes the following steps:
	1. Loads the "dplyr" library
	2. If you do not already have the "getdata_projectfiles_UCI HAR Dataset.zip" file in your working directory, it downloads the file from the source
		"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	3. Reads the column names from "features.txt" and manipulates strings into more reader-friendly format (eliminating "(", ")" and "-")
	4. Loads the "X_test.txt" test data, using the column names from step 3, and appends the "y_test.txt" to the "activityNum" column and the "subject_test.txt" to the "subject column
	5. Loads the "X_train.txt" test data, using the column names from step 3, and appends the "y_train.txt" to the "activityNum" column and the "subject_train.txt" to the "subject column
	6. Binds both datasets together into one masterData data frame
	7. Imports the activity cross-reference from "activity_labels.txt" and joins to masterData to replace the activity reference number with the descriptive label
	8. Selects only the subject, activity and mean and standard deviations
	9. Aggregates the data into a tidy data frame with averages of mean and standard deviation for each activity for each subject
	10. Saves the tidy data into a file "tidyData.txt" in the working directory