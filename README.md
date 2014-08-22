GCDataAssignment
================

This Repository is for my Coursera Getting and Cleaning Data Assignment files

This is the Read.me file for the Getting and Cleaning Data Assignment by Abigail Moore

This file explains how my code (file: "run_analysis.R"") works to complete the assigment, i.e. to produce a tidy data set from the source data.

This file is also accompanied by file "Code_Book_Abigail.txt" which describes the variables used, the source data, and the transformations/actions performed to clean up the data.

* The source data were downloaded from: "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" and saved to my working directory for this course called "G_C_Data" 

The files were then extracted within this directory ("G_C_Data") to a sub-directory called "UCI HAR Dataset", using WinRAR. The "UCI HAR Dataset" directory then contained the following:

* Two folders (train and test) each of which contain 3 files plus another folder called "inertial data", containing raw data not used by me in this assignment. The files of interest are are (1) "X_train.txt" and X_test.txt: Training data set; (2) "y_train.txt" and "y_test.txt", labels for the Training data set (numbers between 1 and 6) showing what the subjects were doing when each data row was recorded; and (3) "subject_train.txt" and "subject_test.txt", giving the subjects from whome each data row in the training or test data came.
* 'README.txt'
*'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features meaning all variables measured/calculated by the researchers
* 'activity_labels.txt': Links the class labels with their activity name.

The data also included a text file "README.txt" with information on the project and the data, in a format very hard to understand, certainly not a user-friendly code book or documentation; and

A text file "features_info.txt" describing the features and variables used for the analysis which had been done by the researchers.

What the code does:

1. Step 1: Merge the training and the test sets to create one data set. The steps are as follows:

* set the working directory to the directory where the files are (on my computer working directory "WD_Assignment"
* opening from the library the required packages
* read in the files using read.delim for the single column data on subjects and activities and read.table for the test and train data with 561 variables.
* merge the subject, activity and variables data into one table for each data set (train and test) using cbind
* provide column names using "subject", "actvity" and the variable data names supplied, even though these are not yet tidy, the main thing is that they are the same for both tables so the merge works well using rbind
* The merged output dataset from stage 1 is sorted by subject and activity, although this is not a requirement, as this makes the data easier to look at and check.
* The output file which complies with the requirements is called "activitytable"

2. Step 2: Extract only the measurements on the mean and standard deviation for each measurement. This is done by:

* looking for column names with "Mean" or "std"  in the column name from column 3 to 563 and producing a vector of desired variable column numbers

* selecting and binding columns 1 and 2 plus the columns corresponding to this vector.  

* This returns a data set with 88 columns, of which 86 contain mean or standard deviation variables while the first two contain the subject codes and activity codes (not names as yet).

* The output file is called "mydata" and complies wiht the requirements of part 2

3. Step 3: Replace the activity codes with descriptive activity names to name the activities in the data set. 

* This means replacing values in column2. The code first selects column 2 (activity codes) as a vector 

*gsub is used to replace each codes with the appropriate nam, producing a vector of activity names 

* A new file is made combining the first and 3rd-88th columns of the mydata table from step 2 and using the resultant activity vector which now has activity names not codes as column 2. 

NB: This could be done more elegantly I am sure but I spent hours looking for the elegant way and this one does work and is actually very fast.

The output from part 3 is "activitydat", a table which now satisfies the requirements of step 3.

4. Step 4. Appropriately label the data set with descriptive variable names

In fact the original names are not that bad, and to improve much on the basic content would make them very long. However they are very messy. Therefore there is a real need to get rid of all the messy extras lurking in them and to make letters lower case, except for the variables X Y and Z which indicate the three axes of movement. The t is not really necessary and f is not readily understood, and is replaced by "fourier", as it represents a fourier transform

The code used is an iterative process to tidy the headers and make them more explanatory by replacing certain parts of the character strings in all or some variables. The resulting column headings are as follows:

 [1] "subject"                                             
 [2] "activity"                                            
 [3] "bodyaccelerationmeanX"                               
 [4] "bodyaccelerationmeanY"                               
 [5] "bodyaccelerationmeanZ"                               
 [6] "gravityaccelerationmeanX"                            
 [7] "gravityaccelerationmeanY"                            
 [8] "gravityaccelerationmeanZ"                            
 [9] "bodyaccelerationjerkmeanX"                           
[10] "bodyaccelerationjerkmeanY"                           
[11] "bodyaccelerationjerkmeanZ"                           
[12] "bodygyromeanX"                                       
[13] "bodygyromeanY"                                       
[14] "bodygyromeanZ"                                       
[15] "bodygyrojerkmeanX"                                   
[16] "bodygyrojerkmeanY"                                   
[17] "bodygyrojerkmeanZ"                                   
[18] "bodyaccelerationmagneticmean"                        
[19] "gravityaccelerationmagneticmean"                     
[20] "bodyaccelerationjerkmagneticmean"                    
[21] "bodygyromagneticmean"                                
[22] "bodygyrojerkmagneticmean"                            
[23] "fourierbodyaccelerationmeanX"                        
[24] "fourierbodyaccelerationmeanY"                        
[25] "fourierbodyaccelerationmeanZ"                        
[26] "fourierbodyaccelerationfrequencymeanX"               
[27] "fourierbodyaccelerationfrequencymeanY"               
[28] "fourierbodyaccelerationfrequencymeanZ"               
[29] "fourierbodyaccelerationjerkmeanX"                    
[30] "fourierbodyaccelerationjerkmeanY"                    
[31] "fourierbodyaccelerationjerkmeanZ"                    
[32] "fourierbodyaccelerationjerkfrequencymeanX"           
[33] "fourierbodyaccelerationjerkfrequencymeanY"           
[34] "fourierbodyaccelerationjerkfrequencymeanZ"           
[35] "fourierbodygyromeanX"                                
[36] "fourierbodygyromeanY"                                
[37] "fourierbodygyromeanZ"                                
[38] "fourierbodygyrofrequencymeanX"                       
[39] "fourierbodygyrofrequencymeanY"                       
[40] "fourierbodygyrofrequencymeanZ"                       
[41] "fourierbodyaccelerationmagneticmean"                 
[42] "fourierbodyaccelerationmagneticfrequencymean"        
[43] "fourierbodyBodyaccelerationjerkmagneticmean"         
[44] "fourierbodyBodyaccelerationjerkmagneticfrequencymean"
[45] "fourierbodyBodygyromagneticmean"                     
[46] "fourierbodyBodygyromagneticfrequencymean"            
[47] "fourierbodyBodygyrojerkmagneticmean"                 
[48] "fourierbodyBodygyrojerkmagneticfrequencymean"        
[49] "anglebodyaccelerationmeangravity"                    
[50] "anglebodyaccelerationjerkmeangravitymean"            
[51] "anglebodygyromeangravitymean"                        
[52] "anglebodygyrojerkmeangravitymean"                    
[53] "angleXgravitymean"                                   
[54] "angleYgravitymean"                                   
[55] "angleZgravitymean"                                   
[56] "bodyaccelerationstdevX"                              
[57] "bodyaccelerationstdevY"                              
[58] "bodyaccelerationstdevZ"                              
[59] "gravityaccelerationstdevX"                           
[60] "gravityaccelerationstdevY"                           
[61] "gravityaccelerationstdevZ"                           
[62] "bodyaccelerationjerkstdevX"                          
[63] "bodyaccelerationjerkstdevY"                          
[64] "bodyaccelerationjerkstdevZ"                          
[65] "bodygyrostdevX"                                      
[66] "bodygyrostdevY"                                      
[67] "bodygyrostdevZ"                                      
[68] "bodygyrojerkstdevX"                                  
[69] "bodygyrojerkstdevY"                                  
[70] "bodygyrojerkstdevZ"                                  
[71] "bodyaccelerationmagneticstdev"                       
[72] "gravityaccelerationmagneticstdev"                    
[73] "bodyaccelerationjerkmagneticstdev"                   
[74] "bodygyromagneticstdev"                               
[75] "bodygyrojerkmagneticstdev"                           
[76] "fourierbodyaccelerationstdevX"                       
[77] "fourierbodyaccelerationstdevY"                       
[78] "fourierbodyaccelerationstdevZ"                       
[79] "fourierbodyaccelerationjerkstdevX"                   
[80] "fourierbodyaccelerationjerkstdevY"                   
[81] "fourierbodyaccelerationjerkstdevZ"                   
[82] "fourierbodygyrostdevX"                               
[83] "fourierbodygyrostdevY"                               
[84] "fourierbodygyrostdevZ"                               
[85] "fourierbodyaccelerationmagneticstdev"                
[86] "fourierbodyBodyaccelerationjerkmagneticstdev"        
[87] "fourierbodyBodygyromagneticstdev"                    
[88] "fourierbodyBodygyrojerkmagneticstdev" 

These tidy names are then used to replace the column headers producing a table called "activity.dat"" which now satisfies the criteria of step 4. The 88 column headers produced are listed in the code-book.txt 

#5. Step 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

I decided to transform the data into long format rather than wide format. To do this I have used the arrange and melt commands.

This outputs a long data table with four columns, activity, subject, variable and value. However this needs to be summarised by calculating the means for each variable by activity and subject.

The menas are both calculated and tabulated as the output from the aggregate function, applied to value by the three parameters variable, subject and activity. Using the factors in this order produces the correct row order but incorrect column order. That is:
* all of each activity is in blocks, divided into subjects, with each subject divided into variables. The mean values of the means come first, then the mean values of the standard deviations. 

* To get the desired column order (well, the one I htink best), I then rearranged the columns using subsetting and cbind

* Really the data could now be rearranged in various orders, but I think this one is tidy and likely to be reasonably user-friendly. For some applications it might be best to make a wide tidy data set, with a column for each variable.

* The final ouptut called mytidydata was then written to a  delimited text file called mytidydata.txt" using write.table, using spaces " " as the delimiting character. This file has been posted (uploaded) on the Coursera submission page and can be loaded into R in a tidy manner using the command yourfilename <- read.delim("mytidydata.txt", sep = " "). I have checked this works nicely.

The code file called "run_analysis.R" was committed to my Github repository on  https://github.com/abigail2105/GCDataAssignment/tree/bfded6225acacdcdba0707e389de55b7acb05f41

The code book "code_book.txt" can also be seen in the https://github.com/abigail2105/GCDataAssignment directory.
