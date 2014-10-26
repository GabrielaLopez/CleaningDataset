Read me.
Information on the steps followed to produce the Tidy_Dataset.txt submitted by Gabriela Lopez.

This document explains how to merge the train and test datasets to create a tidy dataset.

Data set information 

Download the datasets from the link:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

There are two files with metadata: a) features table ("features.txt") which includes a list of 561 features, b) activity lables table ("activity_labels.txt") which includes 6 lables.

The train and test datasets  each include 3 files, one with the subject information (subject), one with the values recorded (X), and one with the the activity information (y)

The full documentation on this dataset can be found in the ReadMe file downloaded from the link.

1. Merging datasets

The features, activity label, subject and X and Y files were all read using read.table.
The columns were relabeled for facilitate merging.

The X and Y files were binded and output was then merged with the activity labels.

2.  Selecting data with
The data was transfomred using tdiyr and dplyr packages. The values and the variables were transformed so each line corresponds to a variable and a subject using "gather".

The variable names were then linked to the names found in the features files. 
A subset was created by selecting only the records with variable names containing 'mean' or 'std', the funciton used was grep.

3. The Activity labels were assigned early in the excersie during the merge process. The labels applied come from the table activity labels.

4. A cleaner dataset  was created by selecting only the columns that were relavant for step 5, and I assign them names that are easy to identify. 

5. To produce the tidy dataset I used "aggregate" to calculate the mean of each value reported by variable, activity level and subject.

This dataset was saved as Tidy_Dataset using  write.table and row.name =FALSE


