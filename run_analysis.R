library(data.table)

## Load test file by type
getTestData <- function(type, columns) {
    test_file <- paste(c("./Dataset/test/", type, "_test.txt"), collapse="")
    test <- read.table(test_file, ,header=FALSE)
    colnames(test) <- columns
    test
}

## Load train file by type
getTrainData <- function(type, columns) {
    train_file <- paste(c("./Dataset/train/", type, "_train.txt"), collapse="")
    train <- read.table(train_file, ,header=FALSE) 
    colnames(train) <- columns
    train
}

## Merge test filetypes
getTestJoinTable <- function(features, activities) {
    X <- getTestData("X", features$V2)
    Y <- getTestData(c("y"), c("Activity")) 
    Y$Activity <- factor(Y$Activity, levels=activities$V1, labels=activities$V2)
    subject <- getTestData("subject", c("Subject"))
    cbind(cbind(X ,Y), subject)
}

## Merge train filetypes
getTrainJoinTable <- function(features, activities) {
    X <- getTrainData("X", features$V2)
    Y <- getTrainData("y", c("Activity"))
    Y$Activity <- factor(Y$Activity, levels=activities$V1, labels=activities$V2)
    subject <- getTrainData("subject", c("Subject"))
    cbind(cbind(X, Y), subject)
}

## init params for the table
activities <- read.table("./Dataset/activity_labels.txt", header=FALSE, colClasses="character")
features <- read.table("./Dataset/features.txt", header=FALSE, colClasses="character")
## clean and merge data
data <- rbind(getTestJoinTable(features, activities), getTrainJoinTable(features, activities))

## calculate mean
data_mean<-sapply(data, mean, na.rm=TRUE)
## calculate standard deviation
data_sd<-sapply(data, sd, na.rm=TRUE)

## clone table from data
DT <- data.table(data)
## create second tidy data
tidy<-DT[,lapply(.SD,mean),by="Activity,Subject"]
## save to file
write.table(tidy, "tidy.txt")