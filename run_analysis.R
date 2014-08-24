## Merges the training and the test sets to create one data set.
# load measurements
traindata <- read.table(unz("getdata-projectfiles-UCI HAR Dataset.zip", "UCI HAR Dataset/train/X_train.txt"))
testdata <- read.table(unz("getdata-projectfiles-UCI HAR Dataset.zip", "UCI HAR Dataset/test/X_test.txt"))

# load activities
trainactivity <- read.table(unz("getdata-projectfiles-UCI HAR Dataset.zip", "UCI HAR Dataset/train/y_train.txt"))
testactivity <- read.table(unz("getdata-projectfiles-UCI HAR Dataset.zip", "UCI HAR Dataset/test/y_test.txt"))

# load subjects
trainsubject <- read.table(unz("getdata-projectfiles-UCI HAR Dataset.zip", "UCI HAR Dataset/train/subject_train.txt"))
testsubject <- read.table(unz("getdata-projectfiles-UCI HAR Dataset.zip", "UCI HAR Dataset/test/subject_test.txt"))

# link measurements with associated activitiesand subjects
fulltestdata <- cbind(testactivity, testsubject, testdata)
fulltraindata <- cbind(trainactivity, trainsubject, traindata)

# merge train and test data sets
fulldata <- rbind(fulltestdata, fulltraindata)
# load cols definitions
featuredata <- read.table(unz("getdata-projectfiles-UCI HAR Dataset.zip", "UCI HAR Dataset/features.txt"), stringsAsFactors = FALSE)
colnames(fulldata)<-c("activity", "subject", featuredata[,2])


## Extracts only the measurements on the mean and standard deviation for each measurement. 
filtereddata <- fulldata[, grepl("mean\\(\\)", names(fulldata)) | grepl("std\\(\\)", names(fulldata)) | "activity"==names(fulldata) | "subject"==names(fulldata)]

## Uses descriptive activity names to name the activities in the data set
activitydata <- read.table(unz("getdata-projectfiles-UCI HAR Dataset.zip", "UCI HAR Dataset/activity_labels.txt"))
filtereddata$activity <- as.factor(filtereddata$activity)
levels(filtereddata$activity) <- activitydata[,2]
filtereddata$subject <- as.factor(filtereddata$subject)

## Appropriately labels the data set with descriptive variable names. 
names(filtereddata) <- gsub("mean\\(\\)", "Mean", names(filtereddata))
names(filtereddata) <- gsub("std\\(\\)", "Deviation", names(filtereddata))
names(filtereddata) <- gsub("-X", "Xaxis", names(filtereddata))
names(filtereddata) <- gsub("-Y", "Yaxis", names(filtereddata))
names(filtereddata) <- gsub("-Z", "Zaxis", names(filtereddata))
names(filtereddata) <- gsub("Mag-", "Magnitude", names(filtereddata))
names(filtereddata) <- gsub("tBody", "Body", names(filtereddata))
names(filtereddata) <- gsub("fBody", "FrequencyBody", names(filtereddata))
names(filtereddata) <- gsub("tGravity", "Gravity", names(filtereddata))
names(filtereddata) <- gsub("Jerk-", "Jerk", names(filtereddata))
names(filtereddata) <- gsub("BodyBodyGyro", "BodyAngularVelocity", names(filtereddata))
names(filtereddata) <- gsub("BodyBodyAcc", "BodyAcceleration", names(filtereddata))
names(filtereddata) <- gsub("BodyGyro", "BodyAngularVelocity", names(filtereddata))
names(filtereddata) <- gsub("BodyAcc", "BodyAcceleration", names(filtereddata))
names(filtereddata) <- gsub("GravityAcc-", "GravityAcceleration", names(filtereddata))
names(filtereddata) <- gsub("-", "", names(filtereddata))

## Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
tidydata <- aggregate(. ~ activity + subject, data = filtereddata, FUN = mean)
write.table(tidydata, "tidy_data.txt", row.name=FALSE)

