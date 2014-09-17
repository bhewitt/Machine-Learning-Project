# Download file for the training set
download.file("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv",
              "trainingdata.csv",method="auto")
training <- read.csv("trainingdata.csv")
head(training)
