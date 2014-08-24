## Merges the training and the test sets to create one data set.
# read cols definitions
featuresdata <- read.table(unz("getdata-projectfiles-UCI HAR Dataset.zip", "UCI HAR Dataset/features.txt"))

# load activities
trainactivity <- read.table(unz("getdata-projectfiles-UCI HAR Dataset.zip", "UCI HAR Dataset/train/y_train.txt"), col.names=c("activity"))
testactivity <- read.table(unz("getdata-projectfiles-UCI HAR Dataset.zip", "UCI HAR Dataset/test/y_test.txt"), col.names=c("activity"))

# load measurements
traindata <- read.table(unz("getdata-projectfiles-UCI HAR Dataset.zip", "UCI HAR Dataset/train/X_train.txt"))
testdata <- read.table(unz("getdata-projectfiles-UCI HAR Dataset.zip", "UCI HAR Dataset/test/X_test.txt"))

# link measurements with associated activities
fulltestdata <- cbind(testactivity, testdata)
fulltraindata <- cbind(trainactivity, traindata)

# merge train and test data sets
alldata <- rbind(fulltestdata, fulltraindata)

## Extracts only the measurements on the mean and standard deviation for each measurement. 
#TODO

## Uses descriptive activity names to name the activities in the data set
activitydata <- read.table(unz("getdata-projectfiles-UCI HAR Dataset.zip", "UCI HAR Dataset/activity_labels.txt"))
# qualify activities properly
alldata$activity <- as.factor(alldata$activity)
levels(alldata$activity) <- activitydata[,2]

## Appropriately labels the data set with descriptive variable names. 
featuresdata <- read.table(unz("getdata-projectfiles-UCI HAR Dataset.zip", "UCI HAR Dataset/features.txt"), stringsAsFactors=FALSE)
colnames(alldata) <- c("activity", featuresdata[,2])

## Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


