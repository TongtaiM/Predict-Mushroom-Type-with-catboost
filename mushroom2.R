mushroomdata = read.csv("C:/Users/matages/Desktop/MushroomDataset/mushroomdata_clean.csv")
library(dplyr)

mushroomdata = mushroomdata %>% select(-X)

mushroomdata = mushroomdata %>% mutate(class = ifelse(class=="e",0,1))
table(mushroomdata$class)
mushroomdata = mushroomdata %>% mutate_if(is.character, as.factor)
str(mushroomdata)

library(caTools)
split <- sample.split(mushroomdata$class, SplitRatio = 0.7) 
split
mushroomdata2 = data.frame(mushroomdata);mushroomdata2
table(mushroomdata2$class,split)

#Training Data
data_train <- subset(mushroomdata2, split == "TRUE") 
str(data_train)
#Testing Data
data_test <- subset(mushroomdata2, split == "FALSE") 
str(data_test)


# Choose Variables
train_set = data_train %>% select(-class)
str(train_set)
test_set  = data_test %>% select(-class)
str(test_set)
