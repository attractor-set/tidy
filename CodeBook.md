# Code Book

## Data

### Input

Human Activity Recognition Using Smartphones
([zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip),
[info](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones))

Each person performed 6 activities.  The file `activity_labels.txt` in the source dataset for the activities. Dataset: 10299 X 561

Exist two types of the data:
Train - 70%
Test  - 30%

Each group have been placed in the necessary folder: "train" or "test"

The observations are split in 3-3 files for each group:

 * `train/X_train.txt` and `test/X_test.txt` contain the measurements 561 X 15,
 * `train/y_train.txt` and `test/y_test.txt` list the activity codes current value 1:6,
 * `train/subject_train.txt` and `test/subject_test.txt` list the identifier of
   the subjects curernt value 1:30.

The name of each measurement corresponding to columns of the "X" files are
listed in `features.txt`.

### Output

The tidy dataset produced by the `run_analysis.R` script contains 180
observations (30 subjects * 6 activities) of 81 variables:

 * `Subject`: name of the subject
 * `Activity`: name of the activity corresponding activity
 * 79 measurement variables: average of the respective variable for the given
   subject and activity.  Out of the 561 original variables, only those
   containing mean and standard deviation are present.  Column names match the
   names of the original measurement variables, eg. `tBodyAcc-mean()-X`.

## Transformation steps

 1. Read params: `activity_labels.txt` and `features.txt`.
 1. Load and bind data types of each type.
 1. Calculate mean
 1. Calculate standard deviation
 1. Clone the loaded data to the data.table
 1. Apply SD and Mean to the cloned table
 1. Finally save the table to the `tidy.txt` in data.table format.