## This is the programming ceript file for the Getting and Cleaning Data Coursera course Assignment written by Abigail Moore
## I, Abigail Moore, hereby acknowledge that this script has been inspired by the discussion forum thread initiated by David Hood (https://class.coursera.org/getdata-006/forum/thread?thread_id=43).

## 1. Step 1. Merge the training and the test sets to create one data set

## This is the first stage of step 1, settign the workign directory, opening from the library required packages and reading in the files which have ben unzipped and copied into my working directory "WD_Assignment". 

## 

setwd("WD_Assignment")
library(plyr)
library(reshape2)
library(stringr)
library(data.table)
library(XML)


## using the function read.delim(file, header = FALSE, sep = "\t"), read in the subject list files

subjecttrain <- read.delim("subject_train.txt", header = FALSE, sep = "\t")
subjecttest <- read.delim("subject_test.txt", header = FALSE, sep = "\t")

## using the function read.delim(file, header = FALSE, sep = "\t"), read in the activity list files

activitytrain <- read.delim("y_train.txt", header = FALSE, sep = "\t")
activitytest <- read.delim("y_test.txt", header = FALSE, sep = "\t")

## using the function read.table, read the data files into tables with 561 columns

test <- read.table("X_test.txt", header = FALSE)
train <- read.table("X_train.txt", header = FALSE)

## This step attaches the three files together for each set, giving 10299 observations of 563 variables. Column 1 contains the subject, with column name "subject" Column 2 contains the activity code with column name "activity" and Columns 3-563 contain the data (561 variables)with column names taken from the list of variables in "features.txt"

datatrainbind <- cbind(subjecttrain, activitytrain, train)
datatestbind <- cbind(subjecttest, activitytest, test)

## this little subroutine gets the column headers described above into a usable format
features <- read.delim("features.txt", header = FALSE, sep = "\t")
feat1 <- features[,1]
feat2 <- as.vector(feat1)
head2 <- c("subject", "activity", feat2, recursive = TRUE)

## I now give the same set of headers to the columns of each data file 

colnames(datatrainbind) <- head2
colnames(datatestbind) <- head2

## I now Merge the two files and reorder the data by subject then activity

rawdataset <- rbind(datatestbind,datatrainbind)
activitytable <- arrange(rawdataset, subject, activity)

## activitytable now contains the merged data, sorted by subject then activity, thus completing the requirements of step 1. However the data are not tidy, because there are two many columns, and the column names do not yet satisfy the tidy data requirements. The names will be tideed later once the definitive columns have been selected.

## 2. Step 2. Extract only the measurements on the mean and standard deviation for each measurement.

## This can be done by looking for column names with "Mean" or "std"  in the column name from column 3 to 563 and then selecting column 1 and 2 plus these columns.  This returns a data set with 88 columns, of which 86 contain mean or standard deviation variables while the first two contain the subject codes and activity codes (not names as yet).

## identify the mean and standard deviation data column numbers using grep
cols2 <- grep("std", head2, ignore.case = TRUE)
cols1 <- grep("Mean", head2, ignore.case = TRUE)

## combine and add column 1 and 2 () 
colset <- c(1,2,cols1, cols2, recursive = TRUE)

## use this set to select the correct columns
mydata <- activitytable[, colset]

## this is now a table which cmplies with the isntructions for step 2.

## 3. Step 3. Replace the activity codes with descriptive activity names to name the activities in the data set. This means replacing values in column2.

## Select column 2 (activity codes) as a vector and use gsub to replace the codes with names. Then make a new file using the first and 3rd-88th columns of the mydata table from step 2 and using the resultant vector which now has activity names not codes as column 2. This could be done more elegantly I am sure but I spent hours looking for the elegant way and this one works.
             
mydata2 <- mydata[,2]
mydata3 <- gsub("1", "walking", mydata2, fixed = TRUE)
mydata4 <- gsub("2", "walkingupstairs", mydata3, fixed = TRUE)
mydata5 <-gsub("3", "walkingdownstairs", mydata4, fixed = TRUE)
mydata6 <-gsub("4", "sitting", mydata5, fixed = TRUE)
mydata7 <-gsub("5", "standing", mydata6, fixed = TRUE)
mydata8 <-gsub("6", "laying", mydata7, fixed = TRUE)

activitydat <- cbind(mydata[,1], mydata8, mydata[,3:88])

## The activitydat table now satisfies teh requirements of step 3.

## 4. Step 4. Appropriately label the data set with descriptive variable names. In fact the original names are not bad, and to improve much on the basic content would make them very long. However they are very messy. Therefore there is a real need to get rid of all the messy extras lurking in them and to make all the letters lower case, except for the variables X Y and Z which indicate the three axes of movement. The t is not really necessary and f is not readily understood, and is replaced by "fourier", as it represents a fourier transform.

## the following code is an iterative process to tidy the headers and make them more explanatory. 

cnames <- colnames(activitydat)
cnames1 <- gsub("[0-9]", "", cnames)
cnames2 <- gsub(" ", "", cnames1)
cnames3 <- as.character(cnames2)
cnames4 <- gsub("[\\(,\\),\\-]", "", cnames3)
cnames5 <- c("subject", "activity", cnames4[3:88])
cnames6 <- gsub("fBody", "fourierbody", cnames5)
cnames7 <- gsub("tBody", "body", cnames6)
cnames8 <- gsub("Acc", "acceleration", cnames7)
cnames9 <- gsub("Jerk", "jerk", cnames8)
cnames10 <- gsub("Gyro", "gyro", cnames9)
cnames11 <- gsub("Mag", "magnetic", cnames10)
cnames12 <- gsub("tGravity", "gravity", cnames11)
cnames13 <- gsub("meanFreq", "frequencymean", cnames12)
cnames14 <- gsub("Mean", "mean", cnames13)
cnames15 <- gsub("std", "stdev", cnames14)

## this final step puts the tidy column names in place in the "activitydat" file 

colnames(activitydat) <- cnames15

## activity.dat now satisfies the criteria of step 4. The 88 column headers produced are listed in the Code-Book.txt and README.md files.

#5. Step 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

## transrom the data into long form
tab1 <- arrange(activitydat, activity, subject)

tab2 <- melt(tab1, id.vars=c("activity","subject"))


## calculate means for each variable by activity and subject

tab3 <- aggregate(value ~ variable + subject + activity, data = tab2, FUN= "mean" )

## This table only has the means for each of tha variables, but it is not yet tidy as the order of the columns is wrong and the column heads are not ideal

tab4 <- cbind(tab3[3], tab3[2],tab3[1], tab3[4])

colnames(tab4) <- c("activity", "subject", "test/train variable", "mean value")

mytidydata <- tab4

## "mytidydata" now contains the required data set in long/narrow tidy format. This could be transformed into wide tidy format but I consider this format is more appropriate in this case. 

## produce tidy data file in space-separated delimited text file format. mytifydata can be read back in as a nice tidy narrow/long dataset in table form using the command "mytidydatareload <- read.delim("mytidydata.txt", sep = " "). I have checked this does work.

write.table(mytidydata, file = "mytidydata.txt", row.name=FALSE)

## This file now complies with the requirements of stage/step 5 and I have uploaded it to the Coursera submission site.
##For further details please see the README.md and code-book.txt files. 

