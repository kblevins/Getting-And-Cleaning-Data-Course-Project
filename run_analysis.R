## load required packages 

require(data.table) ## required for melt function
require(reshape2) ## required for melt function

## read in required data - this requires that the folder with the data be in your 
## working directory and named "UCI HAR Dataset"

feat <- read.table("UCI HAR Dataset/features.txt") ## list of features
x_test <- read.table("UCI HAR Dataset/test/X_test.txt") ## test dataset
y_test <- read.table("UCI HAR Dataset/test/y_test.txt",col.names="activity") ## column of 
## activity codes for test dataset
sub_test <- read.table("UCI HAR Dataset/test/subject_test.txt",col.names="subject")
## column of subject identifiers for test dataset
x_train <- read.table("UCI HAR Dataset/train/X_train.txt") ## train dataset
y_train <- read.table("UCI HAR Dataset/train/y_train.txt",col.names="activity") ## column
## of activity codes for train dataset
sub_train <- read.table("UCI HAR Dataset/train/subject_train.txt",col.names="subject")
## column of subject identifiers for train dataset
test <- cbind(y_test,sub_test,x_test) ## creates one dataframe that includes the activity
## codes, the subject identifiers, along with the data for the test dataset
train <- cbind(y_train,sub_train,x_train) ## does the same for the train dataset

## Merge the training and the test sets to create one data set.

data <- rbind(test,train) ## creates one dataframe with both the test and train datasets

## Extract only the measurements on the mean and standard deviation for each measurement. 

col <- grep("mean\\(|std\\(", feat$V2, value = FALSE) ## uses regular expressions to 
## identify values in the features list that end with mean() or std()
col2 <- c(1,2,col+2) ## creates a vector indicating the columns to keep in the merged
## dataset - the first & second columns (activity & subject), as well as the features 
## identified in the previous step as the mean and standard deviation for each measurement
data_s <- subset(data,select=col2) ## subsets the data to include only the desired columns

## Use descriptive activity names to name the activities in the data set

activity <- read.table("UCI HAR Dataset/activity_labels.txt",col.names=c("activity","activity_type"))
## reads in the table that lists the descriptive activity name associated with each
## activity code
data_s2 <- merge(data_s,activity) ## merges the activity dataframe with the subsetted
## data so that there is a column with the descriptive activity name for each row
data_s2$activity <- NULL ## drops the numeric activity code column

## Appropriately label the data set with descriptive variable names
data2 <- melt(data_s2,id=c("subject","activity_type"),variable.name="variable_code",
              value.name="measurement") ## melts the dataframe to create a narrow
## dataset instead of a wide dataset
var <- grep("mean\\(|std\\(", feat$V2, value = TRUE) ## creates a character vector
## with the relevant feature names from the features list
domain <- ifelse(grepl("f.*",var),"frequency",ifelse(grepl("t.*",var),"time",NA))
## uses regular expressions to populate a vector with either time or frequency for
## each of the feature names
statistic <- ifelse(grepl("mean",var),"mean",ifelse(grepl("std",var),"std",NA))
## uses regular expressions to populate a vector with either mean or standard deviation
## for each of the feature names
direction <- ifelse(grepl("-X",var),"X",ifelse(grepl("-Y",var),"Y",ifelse(grepl("-Z",var),"Z",NA)))
## uses regular expressions to populate a vector with either X,Y,Z, or NA for each of
## the feature names
acceleration_type <- ifelse(grepl("Body",var),"body",ifelse(grepl("Gravity",var),"gravity",NA))
## uses regular expressions to populate a vector with either body or gravity for each
## of the feature names
instrument <- ifelse(grepl("Acc",var),"accelerometer",ifelse(grepl("Gyro",var),"gyroscope",NA))
## uses regular expressions to populate a vector with either accelerometer or gyroscope
## for each of the feature names
jerk <- ifelse(grepl("Jerk",var),"yes","no")
## uses regular expressions to populate a vector with either yes or no to indicate 
## if it is a calculation of a jerk for each of the feature names
magnitude <- ifelse(grepl("Mag",var),"yes","no")
## uses regular expressions to populate a vector with either yes or no to indicate 
## if it is a calculation of a magnitude for each of the feature names
variable_code <- c(paste("V",col,sep="")) ## creates a vector of the column headings
## that will match the desired subset of those in the melted dataframe that were 
## converted to entries in the variable_code column
feat2 <- data.frame(variable_code=variable_code, feature = var, feature_domain=domain, 
                    feature_statistic=statistic, feature_direction=direction, 
                    feature_acceleration_type=acceleration_type, 
                    feature_instrument=instrument, feature_jerk=jerk, 
                    feature_magnitude=magnitude)
## creates a dataframe of all the vectors created above using regular expressions to 
## provide more detailed descriptions of each variable.
tidy1 <- merge(data2,feat2) ## merges the melted dataframe with the dataframe created
## in the previous step
tidy1$variable_code <- NULL ## drops the variable_code column

## Create a second, independent tidy data set with the average of each 
## variable for each activity and each subject.

sum <- tidy1 ## creates a copy of the first tidy dataset
sum$calc <- paste(sum$subject,sum$activity_type,sum$feature) ## creates a column that 
## combines the variables that we want to calculate the means for - the subject, 
## activity, and feature
sum2 <- data.frame(calc=sum$calc, measurement=sum$measurement) ## creates a dataframe
## that can be used in the aggregate calculation to produce the means desired
sum3 <- aggregate(sum2,list(sum2$calc),mean) ## calculates the means for each unique
## combination of subject, activity, and feature
sum3$calc <- NULL ## drops the original column of pasted values
subject <- regexpr("[0-9]+",sum3$Group.1) ## uses regular expressions to identify the
## string in the column created by the aggregate function that represents the subject
sum3$subject <- regmatches(sum3$Group.1,subject) ## creates a column of subjects from
## the output of the previous line of code
activity_type <-regexpr("[ABCDEFGHIJKLMNOPQRSTUVWXYZ_]+",sum3$Group.1) ## uses regular
## expressions to identify the string in the column created by the aggregate function
## that represents the activity_type
sum3$activity_type <- regmatches(sum3$Group.1,activity_type) ## creates a column of
## activity_type from the output of the previous line of code
feature <- regexpr("[\\)\\(a-zA-Z_-]+$",sum3$Group.1) ## uses regular expressions to
## identify the string in the column created by the aggregate function that represents
## the feature
sum3$feature <- regmatches(sum3$Group.1,feature) ## creates a column of feature from 
## the output of the previous line of code
sum3$Group.1 <- NULL ## drops the column created by the aggregate function
sum3$mean <- sum3$measurement ## copies the measurement column, which contains the 
## means calculated for each measurement in the aggregate function and renames the 
## column 'mean'
sum3$measurement <- NULL ## drops the measurement column
tidy2 <- merge(sum3,feat2) ## merges the dataframe created by the aggregate function
## with the dataframe created with the dataframe created above using regular expressions 
## to provide more detailed descriptions of each variable/feature.
tidy2$variable_code <- NULL ## drops the variable_code column
tidy2<-tidy2[with(tidy2,order(tidy2$subject,tidy2$feature,tidy2$activity_type)),]
## re-orders the second tidy dataset by subject, then feature, then activity type
## ## There are 66 features, 30 subjects, and 6 activities, resulting in 11,880 rows of 
## data in the second tidy dataset
write.table(tidy2,"tidy_dataset.txt",sep=",",row.names=FALSE) ## writes the second tidy
## dataset to your working directory
