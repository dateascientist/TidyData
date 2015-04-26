# Load dplyr library
library(dplyr)

## Read in train data
subject_train <- read.table("train/subject_train.txt")
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")

## Read in test data
subject_test <- read.table("test/subject_test.txt")
x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")

## Read in features data for variable names
featureset <- read.table("features.txt")

## Extract feature names as character vector
featureNames <- as.character(featureset[,2])
rm(featureset)

# extract ID numbers as numeric
testSubjectID <- as.numeric(subject_test[,1])
trainSubjectID <- as.numeric(subject_train[,1])
rm(subject_test)
rm(subject_train)

# Set the feature variable names
names(x_test) <- featureNames
names(x_train) <- featureNames
rm(featureNames)

## Add activity column to test data
x_test <- cbind(y_test[,1], x_test)
rm(y_test)

## Add activity column to train data
x_train <- cbind(y_train[,1], x_train)
rm(y_train)

## Add ID column to test data
x_test <- cbind(testSubjectID, x_test)
rm(testSubjectID)

## Add ID column to train data
x_train <- cbind(trainSubjectID, x_train)
rm(trainSubjectID)

## Rename variables for merging
names(x_test)[1] <- "ID"
names(x_train)[1] <- "ID"
names(x_test)[2] <- "Activity"
names(x_train)[2] <- "Activity"

## Combine data frames by row bind
mergedData <- rbind(x_test, x_train)
rm(x_test, x_train)

## Fix duplicate columns
valid_column_names <- make.names(names=names(mergedData), unique = TRUE, 
      allow_ = FALSE)
names(mergedData) <- valid_column_names
rm(valid_column_names)

## Select only the mean and std calculations
## I chose to only use mean() & std() calculations
meanStdSubset <- select(mergedData, ID, Activity, contains("mean.."), 
        contains("std.."), -contains("gravityMean"))


## Label all the activities with descriptions
meanStdSubset$Activity <- gsub("1", "Walking", meanStdSubset$Activity)
meanStdSubset$Activity <- gsub("2", "WalkingUpstairs", meanStdSubset$Activity)
meanStdSubset$Activity <- gsub("3", "WalkingDownstairs", meanStdSubset$Activity)
meanStdSubset$Activity <- gsub("4", "Sitting", meanStdSubset$Activity)
meanStdSubset$Activity <- gsub("5", "Standing", meanStdSubset$Activity)
meanStdSubset$Activity <- gsub("6", "Laying", meanStdSubset$Activity)

## Tidy up variable names so they are more descriptive
names(meanStdSubset) <- gsub("Acc", "Acceleration", names(meanStdSubset))
names(meanStdSubset) <- gsub("Mag", "Magnitude", names(meanStdSubset))
names(meanStdSubset) <- gsub("\\.", "", names(meanStdSubset))
names(meanStdSubset) <- gsub("mean", "Mean", names(meanStdSubset))
names(meanStdSubset) <- gsub("std", "Std", names(meanStdSubset))
names(meanStdSubset) <- gsub("^f", "Frequency", names(meanStdSubset))
names(meanStdSubset) <- gsub("^t", "Time", names(meanStdSubset))

## Create and group new data frame
newTidy <- group_by(meanStdSubset,ID,Activity)

## Calculate the means for each variable & subject
newTidy <- summarise_each(newTidy, funs(mean), 3:68)

## Write the new tidy data frame
write.table(newTidy, file = "tidy.txt", row.name = FALSE)

