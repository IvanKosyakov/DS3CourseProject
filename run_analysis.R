library (dplyr)

## Read data from source files
features <- read.table (".\\UCI HAR Dataset\\features.txt", sep = " ")
#dataSetColumns <- c (features, c("subject", "activity"))
activities <- read.table (".\\UCI HAR Dataset\\activity_labels.txt", sep = " ")
colnames(activities) <- c("id", "activity_name")

## Reading subject training and test sets.
subject_train <- read.table (".\\UCI HAR Dataset\\train\\subject_train.txt")
subject_test <- read.table (".\\UCI HAR Dataset\\test\\subject_test.txt")
activity_train <- read.table (".\\UCI HAR Dataset\\train\\y_train.txt")
activity_test <- read.table (".\\UCI HAR Dataset\\test\\y_test.txt")

## Reading TEST measurements.
test <- read.table (".\\UCI HAR Dataset\\test\\X_test.txt") # As we need "std" and "mean" variables, 
                                                            #  we read only from one file.
colnames (test) <- features[,2]
test$subject <- subject_test$V1 #as.vector (as.matrix (subject_test))
test$activity <- activity_test$V1 #as.vector (as.matrix (activity_test))

## Reading TRAIN measurements.
train <- read.table (".\\UCI HAR Dataset\\train\\X_train.txt")
colnames (test) <- features[,2]
train$subject <-  subject_train$V1 
train$activity <-  activity_train$V1

# Merges the training and the test sets to create one data set.
dataset <- rbind (test, train)

# Creating tidy data set.
TidyDataSet1 <- dataset [, c(562:563, 1:6, 41:46, 81:86, 121:126, 161:166, 201, 202, 214, 215, 227, 228, 240, 241, 253, 254, 266:271, 345:350, 424:429, 503, 504, 516, 517, 529, 530, 542, 543)]
colnames (TidyDataSet1)[1] <- "subject"
colnames (TidyDataSet1)[2] <- "activity"
TidyDataSet1 <- merge (activities, TidyDataSet1, by.x = "id", by.y = "activity") # Add activities.
TidyDataSet1 <- select (TidyDataSet1, -id) # Removind unnecessary columns.
write.table (TidyDataSet1, file = "TidyDataSet1.txt")

## Calculate second data set task in not accomplished. Sorry.
