temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", temp, method="curl")
unzip(temp)
unlink(temp)

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

names(subject_merged) <- c("subject_V1")
names(y_merged) <- c("y_V1")
merged <- cbind(x_merged, y_merged, subject_merged)
rm(x_merged, y_merged, subject_merged)

fNames <- read.table("UCI HAR Dataset/features.txt")
featuresNames <- tbl_df(fNames)
rm(fNames)
