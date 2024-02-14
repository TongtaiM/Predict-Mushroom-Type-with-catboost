#library(devtools)
#devtools::install_url('pkg:maven/ai.catboost/catboost-spark_2.12@0.25-rc3')
#install.packages("pkg:maven/ai.catboost/catboost-spark_2.12@0.25-rc3")

library(catboost)

train_pool = catboost.load_pool(data = train_set,label = data_train$CrmGroup)
test_pool  = catboost.load_pool(data = test_set, label = data_test$CrmGroup)

fit_params <- list(iterations = 1000, loss_function = "MultiClass",eval_metric = "Accuracy"
                   ,use_best_model = TRUE,od_type = 'Iter', od_wait = 30,logging_level = "Verbose")
model <- catboost.train(learn_pool = train_pool,test_pool = test_pool,params = fit_params)
summary(model)

fp  = catboost.get_feature_importance(model);fp

prediction  = catboost.predict(model,test_pool, prediction_type = 'Class')
prediction2 = data.frame(prediction)
prediction2 = prediction2 %>% mutate(prediction = ifelse(prediction == 0,"c1",ifelse(prediction == 1,"c2",ifelse(prediction == 2,"c3",ifelse(prediction == 3,"c4","ERROR")))))

prediction2$prediction = as.factor(prediction2$prediction)                                                                         

data_test2= data_test
data_test2 = data_test2 %>% mutate(CrmGroup = ifelse(CrmGroup == 1,"c1",ifelse(CrmGroup == 2,"c2",ifelse(CrmGroup == 3,"c3",ifelse(CrmGroup == 4,"c4","ERROR")))))

prediction_unseen  = prediction2$prediction
CrmGroup_test  = data_test2$CrmGroup
table_cat = table(prediction_unseen,CrmGroup_test);table_cat


#cf
library(caret)

prediction_unseen = as.factor(prediction_unseen)
CrmGroup_test = as.factor(CrmGroup_test)
confusionMatrix(prediction_unseen,CrmGroup_test);confusionMatrix

#accuracy
accuracy_Test <- sum(diag(table_cat)) / sum(table_cat)
print(paste('Accuracy for test', accuracy_Test))

#Precision
Precision_BTFV <- table_cat["c1", "c1"] / sum(table_cat["c1", ]);Precision_BTFV
Precision_THEFT <- table_cat["c2", "c2"] / sum(table_cat["c2", ]);Precision_THEFT
Precision_ASSAULT <- table_cat["c3", "c3"] / sum(table_cat["c3", ]);Precision_ASSAULT
Precision_THEFT_IDENTITY <- table_cat["c4", "c4"] / sum(table_cat["c4", ]);Precision_THEFT_IDENTITY
#Recall
Recall_BTFV <- table_cat["c1", "c1"] / sum(table_cat[ ,"c1"]);Recall_BTFV
Recall_THEFT <- table_cat["c2", "c2"] / sum(table_cat[ ,"c2"]);Recall_THEFT
Recall_ASSAULT <- table_cat["c3", "c3"] / sum(table_cat[ ,"c3"]);Recall_ASSAULT
Recall_THEFT_IDENTITY <- table_cat["c4", "c4"] / sum(table_cat[ ,"c4"]);Recall_THEFT_IDENTITY
#F_Measure
F_BTFV  = ((2*Recall_BTFV*Precision_BTFV)/(Recall_BTFV+Precision_BTFV));F_BTFV
F_THEFT  = ((2*Recall_THEFT*Precision_THEFT)/(Recall_THEFT+Precision_THEFT));F_THEFT
F_ASSAULT  = ((2*Recall_ASSAULT*Precision_ASSAULT)/(Recall_ASSAULT+Precision_ASSAULT));F_ASSAULT
F_THEFT_IDENTITY   = ((2*Recall_THEFT_IDENTITY*Precision_THEFT_IDENTITY)/(Recall_THEFT_IDENTITY+Precision_THEFT_IDENTITY));F_THEFT_IDENTITY




















