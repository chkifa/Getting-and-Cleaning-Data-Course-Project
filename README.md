## Getting and Cleaning Data Course Project
The run_analysis.R works according to the steps below:

####  Download data set from internet location and unzip it in the working directory (./GCD)
####	Select sets to read for merging:

in test set 
Read the "features.txt", to read the list of variables' name.
Concatenate variables’ names to "X_test" 
Attributes variables’ names，to "subject_test"，"Y_test"
Merge "X_test"，"subject_test"，"Y_test" to "XYZ_test"

in train set
Read the "features.txt", to read the list of variables' name.
Concatenate variables’ names to "X_train" 
Attributes variables’ names，to "subject_train"，"Y_train"
Merge "X_train"，"subject_train"，"Y_train" to "XYZ_train"

Merges the training and the test sets to create one data set and order it by subject.

####  Extracts only the measurements on the mean and standard deviation for each measurement.

Find out which names include target strings including "mean" and "std"
Merge and transpose Extracts measurements in one vector
Read only data for measurement fond previously from global data set
Combine it with "subject" and "activity" with right names.

####  Use descriptive activity names in "activity_labels.txt" to name the activities in the data set
Merge the data set containing the activity names, loaded previously in first step, with extracted data set.

####  Appropriately label the data set with descriptive variable names.
Extract the old names of variables from the extracted data set
Use regular expressions and "gsub()" function to update the names to more descriptive ones
Replace the variables’ names with the updated vector of names in the extracted data set

####  tidy data set with the average of each variable for each activity and each subject.

Melt the data set from previous step with the id of "subject" and "activity"
Then "dcast()" the melted data with both "subject" and "activity", calculate the mean of each variables in the data set
write the latest data set to a txt file called "gcd_data.txt"
