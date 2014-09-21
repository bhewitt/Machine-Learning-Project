# Set the seed and load in necessary packages
library(caret);library(ggplot2)
set.seed(12322)
# These only need to be run on the first time
download.file("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv",
              "trainingdata.csv",method="auto")
download.file("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv",
              "testingdata.csv",method="auto")

# Read in the data
trainingdata <- read.csv("trainingdata.csv")
finaltesting <- read.csv("testingdata.csv")

# Partition the data set into training and testing subsets to calculate the 
# out of sample error rate
inTrain <- createDataPartition(y=trainingdata$classe, p=.8, list=F)
training <- trainingdata[inTrain,]
testing <- trainingdata[-inTrain,]

# Plotting the data by index and user_name
qplot(X,classe, colour = user_name,data=training)

# Removing calculated variable columns from the tidy data set
names(training)
sumcols <- grep("X|user_name|timestamp|window|total|kurtosis|skewness|max|min|avg|var|stddev|amplitude",
                names(training))
trainingclean <- training[,-sumcols]

# Perform preprocessing using PCA - will be done again in the model, but I 
# want a count of the relevant variables used
preProc <- preProcess(trainingclean[,-49], method="pca")
preProc$rotation

# Fit the model
modFit <- train(classe ~ ., data = trainingclean, method = "rf", preProcess = "pca")

# Apply the model to the testing data set to get the out of sample error rate
confusionMatrix(predict(modFit2,testing),testing$classe)

# Function for creating the submission files
pml_write_files = function(x){
        n = length(x)
        for(i in 1:n){
                filename = paste0("problem_id_",i,".txt")
                write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
        }
}

# Use the model to predict the answers from the final data set
answers <-as.character(predict(modFit, finaltesting))

# Write the answers to individual files for submission
pml_write_files(answers)