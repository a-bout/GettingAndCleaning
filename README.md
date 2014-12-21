GettingAndCleaning
==================
## Introduction

This assignment uses dataset from the <a href="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip">.

The script is work as following:
* Download and unzip all neccessary files in the working directory.
* All train and test sets data is merged. Some columns are renamed underline.
* From file features.txt is selected only features that contains following patterns: -mean() or -std(). Other features are supposed no to be appropriate.
* Activities are renamed using naming conventions from activity_labels.txt
* For making variables naming descriptive all unappopriate symbols are removed
* Tidy dataset is obtained from previous step as average of each variable for each activity and each subject.

Script require dplyr library.