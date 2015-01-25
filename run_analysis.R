############################################################################
#################Getting and Cleaning Data Course Project###################
############################################################################
## run_analysis.R script that does the following activities:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation 
##    for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, 
##    independent tidy data set with the average of each 
##    variable for each activity and each subject.
##====================================================================
##===1. Merges the training and the test sets to create one data set=
#get names of variables used the training and the test sets
features<-read.table("./GCD/UCI HAR Dataset/features.txt",header = FALSE)
names(features)=c("id_features","features")
#get names of activity
activity<-read.table("./GCD/UCI HAR Dataset/activity_labels.txt",header = FALSE)
names(activity)=c("id_activity","activity")

#load data from the test sets
X_test<-read.table("./GCD/UCI HAR Dataset/test/X_test.txt",header = FALSE)
Y_test<-read.table("./GCD/UCI HAR Dataset/test/Y_test.txt",header = FALSE)
subject_test<-read.table("./GCD/UCI HAR Dataset/test/subject_test.txt",header = FALSE)

#rename variables
names(subject_test)<-"subject"
names(Y_test)<-"id_activity"
names(X_test)<-features[,2]

#Merge colonne for test data
XYZ_test<-cbind(subject_test,Y_test,X_test)

#load data for Train
X_train<-read.table("./GCD/UCI HAR Dataset/train/X_train.txt",header = FALSE)
Y_train<-read.table("./GCD/UCI HAR Dataset/train/Y_train.txt",header = FALSE)
subject_train<-read.table("./GCD/UCI HAR Dataset/train/subject_train.txt",header = FALSE)

#rename variable
names(subject_train)<-"subject"
names(Y_train)<-"id_activity"
names(X_train)<-features[,2]

#Merge colonne for train data
XYZ_train<-cbind(subject_train,Y_train,X_train)

# HCI dataset produced by merged rows for train data and test data
HCI_data<-rbind(XYZ_train,XYZ_test)

#order HCI_data by subject
HCI<-HCI_data[order(HCI_data$subject),]
##====================================================================
#===============2. Extracts mean and standard deviation measurements.

#Extracts only the measurements on the mean
mean_measurements <- features[grepl("mean" , features[,2]), ]

#Extracts only the measurements on the standard deviation
std_measurements <- features[grepl("std" , features[,2]), ]

#Merge Extracts measurements (mean and standard deviation)
Ext_measurements<-t(rbind(mean_measurements,std_measurements))

#Extracts data for mean and standard deviation from dataset.
Ext_HCI<-cbind(HCI[1],HCI[2],HCI[,Ext_measurements[2,]])
##====================================================================
##==================== 3. Uses descriptive activity names to name the activities in the data set

# merge the data set containing the activity names with data set 
# activity table loaded previously in first step.
Ext_HCI_activity<-merge(activity,Ext_HCI,by="id_activity")
##====================================================================
##==================== 4. Appropriately labels the data set with descriptive variable names.

library(dplyr)
Clean_HCI<-select(Ext_HCI_activity,-(id_activity))
Clean_HCI<-arrange(Clean_HCI, subject, activity)

names(Clean_HCI)<-gsub("\\()","",names(Clean_HCI))
names(Clean_HCI)<-gsub("^t","time",names(Clean_HCI))
names(Clean_HCI)<-gsub("^f","frequency",names(Clean_HCI))
names(Clean_HCI)<-gsub("Acc","-accelerometer",names(Clean_HCI))
names(Clean_HCI)<-gsub("Gyro","-gyroscope",names(Clean_HCI))
names(Clean_HCI)<-gsub("Body","-body",names(Clean_HCI))
names(Clean_HCI)<-gsub("Gravity","-gravity",names(Clean_HCI))
names(Clean_HCI)<-gsub("Mag","-magnitude",names(Clean_HCI))
names(Clean_HCI)<-gsub("Jerk","-jerk",names(Clean_HCI))
names(Clean_HCI)<-gsub("meanFreq","mean_frequency",names(Clean_HCI))
##====================================================================
##============= 5. From the data set in step 4, creates a second,
##============= independent tidy data set with the average of each 
##============= variable for each activity and each subject.

library(reshape2)
melt_Clean_HCI<-melt(Clean_HCI,id=c("activity","subject"))


#data set with the average of each variable for each activity and each subject

sub_act_avg <- dcast(melt_Clean_HCI, subject+activity~variable, mean)

#arranged-it if not
#sub_act_avg<-arrange(sub_act_avg, subject, activity)
#write txt file to upload in Getting and Cleaning Data Course Project
write.table(Clean_HCI,file="./GCD/gcd_data.txt",sep = ",",row.name=FALSE)

