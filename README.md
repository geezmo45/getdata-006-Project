getdata-006-Project
===================
#run-analysis.r

(more detailed operations are in the actual code)

## Merge the training and the test sets to create one data set.
1. load data measurements from the test and train sets with read.table
2. load the subject and activity corresponding to each line
3. group test/train data along with the corresponding subjects and activities using rbind
4. read the column names of the measurements from feature.txt, and name cols in the dataset accordingly

## Extract only the measurements on the mean and standard deviation for each measurement. 
filter out columns using grepl, only columns containing the "mean()" or "std()" substrings are kept
(as well as the activity and subject colums)

## Use descriptive activity names to name the activities in the data set
get activity names from the activity_labels.txt file, and name factors accordingly

## labels the data set with descriptive variable names. 
rename columns by replacing substrings with gsub, so as to make labels more explicit and compatibl with R
camel case was used so that names would stay humanly readable

## Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
peform an aggregate() operation to average column data along the activity and subject criteria
