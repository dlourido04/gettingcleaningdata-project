# Getting and cleaning data project
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set.

## Required packages
- library(reshape2)

## Getting data
- wk_dir: working directory
- data_url: Here are the data for the project
- filepath: destination of the compressed project data
- data_dir: destination of the uncompressed project data
- ``` download.file(data_url, destfile = filepath) ``` to download project data
- ``` unzip(zipfile = filepath, exdir = wk_dir) ```  to unzip project data

## Reading data
- features: it constains column names
- activities: it contains activity descriptions asociated to a number
- train: it contains the results corresponding to feature columns of the train directory
- ``` colnames(train) <- features$V2 ``` Associates the column names
- y_train: it contains the results corresponding to activity column of the train directory
- ``` train$activity <- y_train$V1 ``` Creates a new column called 'activity' and merge the data from y_train
- subject_train: it contains the results corresponding to the subject of the train directory
- ``` train$subject <- factor(subject_train$V1) ``` Creates a new column called 'activity' and merge the data from subject_train 
- test: it contains the results corresponding to feature columns of the test directory
- ``` colnames(test) <- features$V2 ``` Associates the column names
- y_test: it contains the results corresponding to activity column of the test directory
- ``` test$activity <- y_test$V1 ``` Creates a new column called 'activity' and merge the data from y_test
- subject_test: it contains the results corresponding to the subject of the test directory
- ``` test$subject <- factor(subject_test$V1) ``` Creates a new column called 'activity' and merge the data from subject_test 
- ```dataset <- rbind(test, train)``` Merge all data in one dataset

## Filtering data
- ``` column.names <- colnames(dataset) ``` to obtain column names of the dataset
- ``` column.names.filtered <- grep("std\\(\\)|mean\\(\\)|activity|subject", column.names, value=TRUE) ``` filter all columns that name contains | mean | std | activity | subject |
- ``` dataset.filtered <- dataset[, column.names.filtered] ``` save the filtered information in the filtered attribute of the dataset

## Rename data | labels
- ``` dataset.filtered$activitylabel <- factor(dataset.filtered$activity, labels= c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")) ``` Change numeric key value to label value corresponding to activities
- ``` features.colnames = grep("std\\(\\)|mean\\(\\)", column.names, value=TRUE) ``` 
- ``` dataset.melt <-melt(dataset.filtered, id = c('activitylabel', 'subject'), measure.vars = features.colnames) ```
- ``` dataset.tidy <- dcast(dataset.melt, activitylabel + subject ~ variable, mean) ``` Appropriately labels the data set with descriptive variable names

## Write file
- ``` write.table(dataset.tidy, file = "tidydataset.txt", row.names = FALSE) ```




