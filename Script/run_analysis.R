library(dplyr)
X_test <- read.delim('.\\data\\X_test.txt',header = FALSE,  sep = '')
X_train <- read.delim('.\\data\\X_train.txt',header = FALSE, sep = '')
y_test <- read.delim('.\\data\\y_test.txt',header = FALSE, sep = '')
y_train <- read.delim('.\\data\\y_train.txt',header = FALSE, sep = '')
names_features <- read.delim('.\\data\\features.txt',header = FALSE, sep = '')
activity_names <- read.delim('.\\data\\activity_labels.txt',header = FALSE, sep = '')
names(names_features) <- c('Num', 'Names')
names(X_test) <- names_features$Names
names(X_train) <- names_features$Names
names(y_test) <- c('activity_label')
names(y_train) <- c('activity_label')
names(activity_names) <- c('Code', 'Name')
X_train <- X_train[,grepl('mean|std',names(X_train))]
X_test <- X_test[,grepl('mean|std',names(X_test))]

train <- X_train
train[['activity_label']] <- y_train[['activity_label']]
train[['subject']] <- 1

test <- X_test
test[['activity_label']] <- y_test[['activity_label']]
test[['subject']] <- 2

full_data <- rbind(test, train)


names(full_data) <- gsub('\\()', '', names(full_data))

means_data <- full_data %>% group_by(activity_label, subject) %>% summarize_all(funs(mean))
for (i in (1 : nrow(full_data))){
    label <- full_data[i, 'activity_label']
    full_data[i, 'activity_label'] <- activity_names[label, 'Name']
    if (full_data[i, 'subject'] == 1){full_data[i, 'subject'] <- 'train'}
    else {full_data[i, 'subject'] <- 'test'}
        
}
means_data <- mutate(means_data, subject_name = '')
means_data <- mutate(means_data, activity = '')

for (j in (1 : nrow(means_data))){
    labell <- as.numeric(means_data[j, 'activity_label'])
    means_data[j, 'activity'] <- activity_names[labell, 'Name']
    if (means_data[j, 'subject'] == 1){means_data[j, 'subject_name'] <- 'train'}
    else {means_data[j, 'subject_name'] <- 'test'}
}
means_data <- means_data %>%select(activity, subject_name, everything(), -activity_label, -subject)