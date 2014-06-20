Code Book
=========


Intro
-----

Below is a list of each column/field present in my second tidy dataset - the one printed
by my run_analysis.R script (which is identical to my first tidy dataset, 'tidy1', with the 
exception of a calculated mean column in place of the original measurement column). Below 
each column name there is a description of the data contained therein and any 
methodological information about the method by which they were obtained from the 
original data.


Columns
-------

**FEATURE**

  A subset of the features described in the features_info.txt. These values were recorded 
  in columns in the original X_test.txt and X_train.txt. These data were converted to 
  rows by using the melt function. I believe this is the tidiest form of the data,
  following the conventions described in the Hadley paper (http://vita.had.co.nz/papers
  /tidy-data.pdf), as well as the discussion forum thread on long vs. wide data 
  (https://class.coursera.org/getdata-004/forum/thread?thread_id=262). 
  These values represent the subset of the full list of features that are calculations of 
  the mean and standard deviation for each measurement. Although there are additional 
  columns that include the word mean, I believe they do not represent means of the 
  measurements made in this experiment, but rather metadata on the direct measurements. 
  
  values ::
  
  - tBodyAcc-mean()-X
  
  - tBodyGyro-mean()-Z
  
  - tBodyGyro-std()-Z
  
  - tBodyGyroJerk-mean()-Z
  
  - tBodyGyroJerk-std()-Z
  
  - tBodyAccMag-std()
  
  - tBodyAccJerkMag-mean()
  
  - tBodyGyroMag-std()
  
  - fBodyAcc-mean()-X
  
  - fBodyAcc-std()-X
  
  - tBodyAcc-mean()-Z
  
  - fBodyAccJerk-mean()-Z
  
  - fBodyAccJerk-std()-Z
  
  - tGravityAcc-mean()-Y
  
  - fBodyGyro-mean()-Z
  
  - fBodyGyro-std()-Z
  
  - tGravityAcc-std()-Y
  
  - fBodyAccMag-mean()
  
  - fBodyBodyAccJerkMag-std()
  
  - fBodyBodyGyroJerkMag-mean()
  
  - tBodyAccJerk-mean()-X
  
  - tBodyAccJerk-std()-X
  
  - tBodyGyro-mean()-X
  
  - tBodyGyro-std()-X
  
  - tBodyGyroJerk-mean()-X
  
  - tBodyGyroJerk-std()-X
  
  - tBodyAcc-mean()-Y
  
  - tGravityAccMag-mean()
  
  - tBodyAccJerkMag-std()
  
  - tBodyGyroJerkMag-mean()
  
  - fBodyAcc-mean()-Y
  
  - fBodyAcc-std()-Y
  
  - fBodyAccJerk-mean()-X
  
  - fBodyAccJerk-std()-X
  
  - tBodyAcc-std()-X
  
  - fBodyGyro-mean()-X
  
  - fBodyGyro-std()-X
  
  - tGravityAcc-mean()-Z
  
  - tGravityAcc-std()-Z
  
  - fBodyAccMag-std()
  
  - fBodyBodyGyroMag-mean()
  
  - fBodyBodyGyroJerkMag-std()
  
  - tBodyAccJerk-mean()-Y
  
  - tBodyAccJerk-std()-Y
  
  - tBodyGyro-mean()-Y
  
  - tBodyGyro-std()-Y
  
  - tBodyGyroJerk-mean()-Y
  
  - tBodyGyroJerk-std()-Y
  
  - tBodyAccMag-mean()
  
  - tGravityAccMag-std()
  
  - tBodyGyroMag-mean()
  
  - tBodyGyroJerkMag-std()
  
  - fBodyAcc-mean()-Z
  
  - fBodyAcc-std()-Z
  
  - fBodyAccJerk-mean()-Y
  
  - fBodyAccJerk-std()-Y
  
  - tGravityAcc-mean()-X
  
  - fBodyGyro-mean()-Y
  
  - fBodyGyro-std()-Y
  
  - tGravityAcc-std()-X
  
  - tBodyAcc-std()-Y
  
  - fBodyBodyAccJerkMag-mean()
  
  - fBodyBodyGyroMag-std()
  
  - tBodyAcc-std()-Z
  
  - tBodyAccJerk-mean()-Z
  
  - tBodyAccJerk-std()-Z


**SUBJECT**

  The subject for which the data were collected from. These data were connected to the 
  sensor data by binding the columns from the X_test.txt and X_train.txt with the 
  column from the subject_test.txt and subject_train.txt respectively.
  values :: 1-30 unique identifier for each subject


**ACTIVITY_TYPE**

  Description of the activity category that the data correspond to. These data were
  connected to the sensor data by merging the combined test and train data with the
  table in activity_labels.txt. 
  values :: LAYING, SITTING, STANDING, WALKING,  WALKING_DOWNSTAIRS,  WALKING_UPSTAIRS


**MEAN**

  The mean calculated for each of the subset of features taken from the original dataset
  which are described in features_info.txt. The original measurement values were 
  recorded in columns in the original X_test.txt and X_train.txt. These 
  data were converted to rows by using the melt function. 
  values :: -0.99770-0.97450


**FEATURE_DOMAIN**

  One part of the descriptive explanation of each variable (feature), this indicates 
  whether the variable is of the time or frequency domain. These data were extracted
  from the feature using regular expressions.
  values :: frequency, time
  

**FEATURE_STATISTIC**

  One part of the descriptive explanation of each variable (feature), this indicates 
  whether the variable is for the mean or standard deviation statistic. These data were 
  extracted from the feature using regular expressions.
  values :: mean, std


**FEATURE_DIRECTION**

  One part of the descriptive explanation of each variable (feature), this indicates 
  which direction the activity was measured in. These data were extracted  from the
  feature using regular expressions.
  values :: X,Y,Z


**FEATURE_ACCELERATION_TYPE**

  One part of the descriptive explanation of each variable (feature), this indicates 
  whether the acceleration measured was a signal from the subject's body or from
  gravity. These data were extracted from the feature using regular expressions.
  values :: body, gravity
  

**FEATURE_INSTRUMENT**

  One part of the descriptive explanation of each variable (feature), this indicates 
  which type of instrument the signal came from. These data were extracted
  from the feature using regular expressions.
  values :: accelerometer, gyroscope
  

**FEATURE_JERK**

  One part of the descriptive explanation of each variable (feature), this indicates 
  whether the variable is a calculated jerk measurement or not. These data were 
  extracted from the feature using regular expressions.
  values :: yes, no
  

**FEATURE_MAGNITUDE**

  One part of the descriptive explanation of each variable (feature), this indicates 
  whether the variable is a calculated magnitude or not. These data were extracted
  from the feature using regular expressions.
  values :: yes, no