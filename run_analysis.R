library(dplyr)
#download and unzip necessary files
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", temp)
unzip(temp)
unlink(temp)

#merge data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_merged <- rbind(subject_train, subject_test)
rm(subject_test, subject_train)

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
x_merged <- rbind(x_train, x_test)
rm(x_test, x_train)

y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
y_merged <- rbind(y_train, y_test)
rm(y_test, y_train)

names(subject_merged) <- c("subject")
names(y_merged) <- c("activityID")
merged <- cbind(x_merged, y_merged, subject_merged)
rm(x_merged, y_merged, subject_merged)

# Get feature names
fNames <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)
featuresNames <- tbl_df(fNames)
rm(fNames)
#Filter only mean and std variables
filteredNames <- filter(featuresNames, grepl("*-mean\\(\\)*|*-std\\(\\)*", V2))
selectedColumns <- paste("V", filteredNames$V1,sep="")
selectedColumns <- c("activityID", "subject",selectedColumns)
mergedFiltered <- merged[,selectedColumns]
#change variables naming to descriptive
meanPattern <- "-mean\\(\\)-?"
stdPattern <- "-std\\(\\)-?"
bodyBodyPatern <- "BodyBody"
descriptiveNames <- as.character(sapply(filteredNames$V2,gsub,pattern=meanPattern,replacement="Mean"))
descriptiveNames <- as.character(sapply(descriptiveNames,gsub,pattern=stdPattern, replacement="Std"))
descriptiveNames <- as.character(sapply(descriptiveNames,gsub,pattern=bodyBodyPatern, replacement="Body"))
names(mergedFiltered) <- c("activityID", "subject", descriptiveNames)
mergedFiltered <- tbl_df(mergedFiltered)
# read and add descriptive activity names
activityNames <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)
activityNames <- tbl_df(activityNames)
mergedPrepared<- left_join(mergedFiltered, activityNames, by=c("activityID"="V1"))
# change columns order for convinience
mergedPrepared <- mergedPrepared[,c(69, 2:68)]
colnames(mergedPrepared)[1] <- "activity" 
tidyDataset <- summarise_each(group_by(mergedPrepared, subject, activity), funs(mean))
write.table(tidyDataset, "tidy.txt", row.name=FALSE)
