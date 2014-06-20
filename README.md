Course Project Files
====================

Intro
-----

The files contained in this repository are all part of the Course Project for the Coursera Getting and Cleaning Data course.

The goals of this project are as follows:
1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names. 

5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


Step-by-Step Guide
------------------

The following steps will result in the writing of the final tidy dataset (step 5 above)
to your working directory

1. Download and unzip the files from the link below to your working directory
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

2. Run all of the code in the script run_analysis, the entire script has been running on 
my computer in a little over 1 minute. This will require that you have the packages 
data.table and reshape2 installed. The run_analysis.R script takes the files from the 
downloaded dataset and does the following:

  a. compiles a single dataframe for the test and training datasets (dataframes called 
  'test'and 'train') by column binding the files 'X_test.txt', 'y_test.txt', and 
  'subject_test.txt' for the test dataset and the equivalent files for the training dataset

  b. merges the test and training datasets into one dataframe by row binding the 'test' and
  'train' dataframes into a single dataframe 'data'

  c. extracts only the measurements on the mean and standard deviation for each measurement
  by using regular expressions on the features list to identify the columns to keep and 
  then subsetting 'data' by the vector of columns to keep.

  d. creates descriptive activity names to name the activities in the data set by merging
  the dataframe in the 'activity_labels.txt' with the subsetted dataframe created in step c

  e. melts the newly created dataframe to create a narrow dataset instead of a wide dataset 
  so that the features are now variables in a single column rather than 66 columns

  f. appropriately labels the data set with descriptive variable names by breaking down the 
  features into their component parts and applying more descriptive labels to each 
  component. For example, the first part of each feature is either 't' of 'f' which 
  corresponds to either the time or frequency domain, so the code uses regular expressions
  to identify which letter the feature starts with and creates a new column named 'feature_
  domain' which is populated with either 'time' or 'frequency'. In addition to domain, the 
  other components that are broken out into columns are statistic (mean/std), direction 
  (X,Y,Z,NA), acceleration_type (body/gravity), instrument (accelerometer/gyroscope), jerk 
  (yes/no), and magnitude (yes/no)

  g. calculates the average of each variable for each activity and each subject by using
  the aggregate function. there are additional formatting steps done here to make a 
  dataframe that can be used in the aggregate function and then adding back in the other 
  columns to the table created by the aggregate function - these steps can be seen in the 
  script and are heavily commented.

3. The final tidy dataset will be in your working directory in a text file named 
tidy_dataset.txt. This text file contains comma-separated values.


References
----------

*Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human 
Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector 
Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, 
Spain. Dec 2012

*Hadley Wickham. Tidy Data. Journal of Statistical Software. pre-publication. Accessed on 6/20/2014 at http://vita.had.co.nz/papers/tidy-data.pdf
