# Download file for the training set (only need to do this once)
download.file("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv",
              "trainingdata.csv",method="auto")

# Download the test data (only need to do this once)
download.file("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv",
              "testingdata.csv",method="auto")

# Read files
training <- read.csv("trainingdata.csv")
testing <- read.csv("testingdata.csv")
head(training)

