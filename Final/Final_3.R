data=read_xls("features1.xls")
str(data)
data=data.table(data)

##Setting the output attribute -text cpmplexity- cpmplex accourding to column's median.
classification_data[,is_complex:=as.factor(paste0('complex',as.numeric(txtcomplexity>quantile(txtcomplexity,0.5))))]
classification_data[,abs_hours:=NULL]
classification_data[,txtcomplexity:=NULL]
head(classification_data,10)
classification_data=copy(data)


set.seed(1000)
split=sample.split(data$txtcomplexity,SplitRatio=0.6)
tree_tr=subset(data,split==TRUE)
tree_te=subset(data,split==FALSE)
tree=rpart(txtcomplexity~ ., data = tree_tr)
tree
fancyRpartPlot(tree)
##Confusion matrix and determining the quality of predictions.

pred=predict(data,newdata=tree_te,type="class")
table(tree_te$txtcomplexity,pred)

tree_fit=train(is.complex ~ ., data=data.frame(classification_data),
method = "rpart",
trControl = fitControl,
tuneLength = 5)
tree_fitpred=predict(tree_fit)
fit_tree=rpart(is_complex ~ ., data = classification_data,
control=rpart.control(maxdepth=3,minsplit=50,minbucket=25))
fit_tree


##Pruning the data
opt_index=which.min(fit_tree$cptable[,"xerror"])
cp_opt=fit_tree$cptable[opt_index,"CP"]
cp_opt
fit_tree_opt=prune.rpart(tree=fit_tree, cp=cp_opt)
rpart.plot(x=fit_tree_opt, yesno=2, type=2, extra=101)

##Random Forest
require(randomForest)
target=as.factor(classification_data$is_complex)
x=classification_data[,-c('is_absent'),with=F]
x=classification_data[,-c('is_complex'),with=F]
fitrf=randomForest(x,target,ntree=2000)
fitrf
dim(x)
plot(fitrf)
rf_grid=expand.grid(mtry = c(4, 6, 8),
splitrule = c("gini", "extratrees"),
min.node.size = c(5))
rf_grid


