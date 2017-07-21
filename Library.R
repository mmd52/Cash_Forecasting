# @Author MOhammed Topiwalla 15/07/2017
#This file loads all packages and incase they do not exist it installs them


checkInstallLoad <- function(libName) {
  if(!require(libName, character.only=TRUE)) {
    install.packages(libName)
    require(libName, character.only=TRUE)
  }
}
checkInstallLoad("car")
checkInstallLoad("shinydashboard")
checkInstallLoad("Ckmeans.1d.dp")
checkInstallLoad("arules")
checkInstallLoad("ROCR")
checkInstallLoad("nnet")
checkInstallLoad("data.table")
checkInstallLoad("Matrix")
checkInstallLoad("YaleToolkit")
checkInstallLoad("Amelia")
checkInstallLoad("Metrics")
checkInstallLoad("plyr")
checkInstallLoad("dplyr")
checkInstallLoad("stringr")
checkInstallLoad("lubridate")
checkInstallLoad("ggplot2")
checkInstallLoad("plot3D")
checkInstallLoad("pROC")
checkInstallLoad("caret")
checkInstallLoad("caretEnsemble")
checkInstallLoad("e1071")
checkInstallLoad("randomForest")
checkInstallLoad("xgboost")
checkInstallLoad("rpart")
checkInstallLoad("C50")
checkInstallLoad("adabag")
checkInstallLoad("ggplot2")
checkInstallLoad("Boruta")
checkInstallLoad("tabplot")
checkInstallLoad("plyr")
checkInstallLoad("dplyr")
checkInstallLoad("ModelMetrics")
checkInstallLoad("corrplot")
checkInstallLoad("MASS")
checkInstallLoad("dummies")

print("Loading libraries complete.")