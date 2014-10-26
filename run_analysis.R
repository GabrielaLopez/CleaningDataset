#
#Read the files. Set working directory

features <- read.table ("features.txt")
#dim(features)
activity_labels <- read.table("activity_labels.txt")
#dim(activity_labels)
colnames(activity_labels) <- c('ActivityID', 'ActivityLabel')

#train set
trainsubject <- read.table("train/subject_train.txt")
colnames(trainsubject) <- ("subjectID")

trainX <- read.table ('train/X_train.txt')
trainY <-  read.table ('train/y_train.txt')

#test set
testsubject <- read.table ("test/subject_test.txt")
colnames(testsubject) <- ("subjectID")

testX <- read.table ('test/X_test.txt')
testY <-  read.table ('test/y_test.txt')


### Add more labels to facilitate merging
colnames(trainY) <- c('ActivityID')
colnames(testY) <- c ('ActivityID')

## Binding and merging train and test datasets
## bind x and y datasets
train_a <- cbind (trainY, trainX)
test_a <- cbind (testY, testX)

# bind with subject information
train_b <- cbind (trainsubject, train_a)
test_b <- cbind(testsubject, test_a)

# merge
train_c <- merge (activity_labels, train_b, by = 'ActivityID')
test_c <- merge (activity_labels, test_b, by = 'ActivityID')

# Merge train and test datasets
train_test <- rbind(test_c, train_c)
## 2. Extracting only measurement on the mean and standard deviation
library(tidyr)
library(dplyr)

#transform the data so the 561 variables are not in a column
tidier <- train_test %>% gather (Varname, Value, V1:V561)

# code a new variable in features to allow mergin the dataset
features <- transform(features, Varname = sprintf('V%d', V1 ))

tidier_b <- merge(tidier, features, by = "Varname")
#Selecting only columns which contain 'mean' or ' std'

train_test_mean_sd<- tidier_b[(grep('mean|std',tidier_b$V2)) ,     ]

# 3. Activity Labels were obtained from the Activity Labels file. There are 6 activities.
head(train_test_mean_sd,1)

#4 The clean dataset has

#selecting the columns for the clean subset
clean_a <- train_test_mean_sd[ , c("ActivityID", "ActivityLabel", "subjectID", "Varname", "V2","Value")]
#renaming headers
colnames(clean_a) <- c ('ActivityID','ActivityLabel', 'SubjectID', 'VariableID', 'VariableName', 'Value')
#renaming Clean dataset
CleanDataset <- clean_a

#5 tidy dataset with the average of each variable for each activity and each subject
Tidy_Dataset<- aggregate (Value ~ VariableName + ActivityLabel+SubjectID, CleanDataset, mean, na.rm=TRUE)

#write dataset
write.table(Tidy_Dataset, "TidyDataSet.txt", row.name=FALSE)




