# Getting-and-Cleaning-Data-Course-Project

## Note:
All the data used are stored in the "Data"" directory, and the script is in "Script" directory.

##Analysi Procedur:
1. Read all required datasets (X_ train and test, y_train and test, features names and activity names)
2. Rename the columns on the data based on the features names.
3. Select only columns with mean and std data
4. Merge the X and y datasets for each test and train
5. Add a column to indicate either it is train or test data
6. Rbind test and train data
7. Apply grouping by test/train, and by activity and then summarize by mean
8. map each activity label to its name.