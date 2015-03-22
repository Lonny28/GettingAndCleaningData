# Create one R script called run_analysis.R that does the following. 

#1 Merges the training and the test sets to create one data set.
#2 Extracts only the measurements on the mean and standard deviation for each measurement. 
#3 Uses descriptive activity names to name the activities in the data set
#4 Appropriately labels the data set with descriptive variable names. 
#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#librarys that I'll use
        library(data.table)
        library(dplyr)

#1 - merge all the data into one data set

#get to the right directory
        setwd("C:/Users/Lonny/School/Project/UCI HAR Dataset")

#Now lets go get all of our data

#Feature Names
        featNames <- read.table("features.txt")
        colnames(featNames) <- c("feature","featureName")

#Activity Labels
        actLabels <- read.table("activity_labels.txt")
        colnames(actLabels) <- c("cat","Activity")

#go get all training data
        subTrain <- read.table("./train/subject_train.txt", header = FALSE)
        actTrain <- read.table("./train/y_train.txt", header = FALSE)
        featTrain <- read.table("./train/X_train.txt", header = FALSE)

#go get test data
        subTest <- read.table("./test/subject_test.txt", header = FALSE)
        actTest <- read.table("./test/y_test.txt", header = FALSE)
        featTest <- read.table("./test/X_test.txt", header = FALSE)

#rbind all training and test data together
        sub <- rbind(subTrain,subTest)
        act <- rbind (actTrain,actTest)
        feat<- rbind (featTrain,featTest)
        
# add colnames to our three frames
        colnames(feat) <- t(featNames[2])
        colnames(act) <- "cat"
        colnames(sub) <- "Subject"
        
# and finally - column bind them all together:
        sData <- cbind(sub,act,feat)

#step 3 - let's get our activity labels now (yes, it's out of order)
# merge the activity name onto our data table for descriptive work
        fullData<- merge(actLabels,sData)

#step 2 - filter out columns we need
#now we find our Req columns we need with STD and Avg (plus first 3)
        colWithMeanStd <- grep(".*Mean.*|.*Std.*", names(fullData), ignore.case=TRUE)
        reqCol <- c(1,2,3,colWithMeanStd)
        fnlData <- fullData[,reqCol]

        
#step 4 - rename columns to something that makes a bit more sense:
        names(fnlData)<-gsub("^t", "Time_", names(fnlData))
        names(fnlData)<-gsub("^f", "Freq_", names(fnlData))
        names(fnlData)<-gsub("angle", "Angle_", names(fnlData))
        
#lets do a little cleanup now that we have a comprehensive data set
        rm(act,actLabels,actTest,actTrain,feat,featNames,featTest,
           featTrain,fullData, sData,sub, subTest,subTrain,
           colWithMeanStd,reqCol)

#step 5 - create the second, tidy data set and write it out
        #forgot to factor my subject
        fnlData$Subject <- as.factor(fnlData$Subject)
        TidyData <- aggregate(. ~Subject + Activity, fnlData, mean)
        TidyData <- TidyData[order(TidyData$Subject,TidyData$Activity),]
        write.table(TidyData, file = "Tidy.txt",sep = ",", row.names = FALSE)
        

        
        
        


