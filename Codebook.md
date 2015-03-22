**Here is the codebook that explains the data in my Tidy Data File**

This data all came from the "Human Activity Recognition Using Smartphones Dataset" Version 1.0
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


A full description of the data is here:
  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


**The following codes explain the data in the Tidy file:**

Use Subject and Activity as Row Headers to identify each person and the activity they were doing:

Subject - The number assigned to each of the 30 subjects

Activity - The activity each subject was doing.  Consists of:
* Laying
* Sitting
* Standing
* Walking (normal)
* Walking Downstairs
* Walking Upstairs

cat - This is a single integer with the cateogry of the Activity

Other Column Names - These all represent the MEAN (average) of each variable in the data, as requested in the assignment.

Each will contain one of the following at the begining:
*  Time - represents the time it took to compelte the activity
*  Freq - the rate of occurance
*  Angle - the angle of the device

The middle section explains the measurement -
* Acc stands for Accelermetor
* Mag stands for Magnitude
* Gyro stands for Gyroscope

Finally, the last section of each word explains the calculation:
* Mean() is for the Mean
* std() is for the standard deviation


