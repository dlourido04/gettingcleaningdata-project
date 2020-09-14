# Getting and cleanning data course project
# install.packages("reshape2")
library(reshape2)

# 1. Merges the training and the test sets to create one data set.
# -------------------------------------------------------------------
# 1.1 Getting datasets
#wk_dir <- getwd()
wk_dir <- "D:/Coursera/Getting and Cleaning Data/Week4"

data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filepath <- paste(wk_dir, "rawData.zip", sep = "/")

if (!file.exists(filepath)) {
    download.file(data_url, destfile = filepath)
    unzip(zipfile = filepath, exdir = wk_dir)
}

data_dir <- paste(wk_dir, "UCI HAR Dataset", sep = "/")

# 1.2 Reading files
features <- read.table(paste(data_dir,"features.txt",sep = "/"))
activities <- read.table(paste(data_dir,"activity_labels.txt",sep = "/"))

# Train data
train <- read.table(paste(data_dir,"train","X_train.txt",sep = "/"))
colnames(train) <- features$V2

y_train <- read.table(paste(data_dir,"train","y_train.txt",sep = "/"))
train$activity <- y_train$V1

subject_train <- read.table(paste(data_dir,"train","subject_train.txt",sep = "/"))
train$subject <- factor(subject_train$V1)

# Test data
test <- read.table(paste(data_dir,"test","X_test.txt",sep = "/"))
colnames(test) <- features$V2

y_test <- read.table(paste(data_dir,"test","y_test.txt",sep = "/"))
test$activity <- y_test$V1

subject_test <- read.table(paste(data_dir,"test","subject_test.txt",sep = "/"))
test$subject <- factor(subject_test$V1)

# 1.3 Merging Files
dataset <- rbind(test, train)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement
# -------------------------------------------------------------------
# 2.1 Filtering columns that contains standard deviation and mean values
column.names <- colnames(dataset)
column.names.filtered <- grep("std\\(\\)|mean\\(\\)|activity|subject", column.names, value=TRUE)
dataset.filtered <- dataset[, column.names.filtered]

# 3. Uses descriptive activity names to name the activities in the data set
dataset.filtered$activitylabel <- factor(dataset.filtered$activity, labels= c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))

# 4. Appropriately labels the data set with descriptive variable names
features.colnames = grep("std\\(\\)|mean\\(\\)", column.names, value=TRUE)
dataset.melt <-melt(dataset.filtered, id = c('activitylabel', 'subject'), measure.vars = features.colnames)
dataset.tidy <- dcast(dataset.melt, activitylabel + subject ~ variable, mean)

# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject
write.table(dataset.tidy, file = "tidydataset.txt", row.names = FALSE)

