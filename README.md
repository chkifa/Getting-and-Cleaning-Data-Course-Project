## Getting and Cleaning Data Course Project
README.md in the repo describing how the script works



1* Select sets to read in for merging:
read in the subject ids, read in the activity ids, read in the feature values for test data, and concatenate data produced in previous step,
the same operation for train data, finally we merged all data in one set.
2* Extracting the required features:
select from merged data the first two columns, and any others that contain the phrases "mean" or "std" in isolation, merge data produced for each operation
3* Naming the activities in the data set:
merge the data set produced in 2 with activity_labels by id_activity to get the descriptive activity names in the data set.
4*Appropriately labels the data set with descriptive variable names
rename all the variable with the appropriate labels dudected from "features_info.txt"
5* tidy data set with the average of each variable for each activity and each subject.

