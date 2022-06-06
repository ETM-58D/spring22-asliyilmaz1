library(openxl)
library(openxlsx)
library(caret)
library(rpart)
library(data.table)
library(randomForest)
library(rattle)
data=read_xls("in-vehicle-coupon-recommendation.xls")
str(data)

##Here the aim is obtaining the best model for predicting the adresses for targeting to sell coupons.

library(caTools)
set.seed(1000)
split=sample.split(data$Response, SplitRatio = 0.6)
split
summary(split)
train=subset(data,split==TRUE)
test=subset(data,split==FALSE)
tree=rpart(Response~ ., data = train)
tree

fancyRpartPlot(tree)
##Setting the model using Rpart function.

fit_tree=rpart(Response ~ ., data = train,
control=rpart.control(cp=0))
predict(tree,test,type="vector")

##10-fold Cross Validation
require(caret)

n_repeats=10
n_folds=10
fitControl=trainControl(method = "repeatedcv",
number = n_folds,
repeats = n_repeats,
summaryFunction=twoClassSummary,
classProbs=TRUE)
fitControl
tree_fit=train(Response,method = "rpart",
 ~ ., data=data.frame(classification_data),
trControl = fitControl,
tuneLength = 5)
tree_fit
confusionMatrix(train,data,positive=1)
##Consfusion tree would show the TP/FP/TN/FN table to evaluate the predictions.(error)

fit_tree=rpart(is_absent ~ ., data = train,
               control=rpart.control(maxdepth=3,minsplit=50,minbucket=25))
fit_tree
summary(fit_tree)

##Pruning the tree
opt_index=which.min(fit_tree$cptable[,"xerror"])
cp_opt=fit_tree$cptable[opt_index,"CP"]
cp_opt
fit_tree_opt=prune.rpart(tree=fit_tree, cp=cp_opt)
rpart.plot(x=fit_tree_opt, yesno=2, type=2, extra=101)

##Random Forest
require(randomForest)
target=as.factor(classification_data$Response)
fitrf=randomForest(x,target,ntree=2000)
fitrf
dim(x)
plot(fitrf)
rf_grid=expand.grid(mtry = c(4, 6, 8),
                    splitrule = c("gini", "extratrees"),
                    min.node.size = c(5))
rf_grid

                    
           









