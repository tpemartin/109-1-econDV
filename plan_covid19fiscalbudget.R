library(readr)
library(dplyr)
library(ggplot2)
library(svglite)
library(WDI)
library(xml2)
options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/.covid19", hash_algorithm = "xxhash64"))
params=readRDS("/Users/martinl/Github/109-1-econDV/params_covid19fiscalbudget.rds")
# plan_covid19fiscalbudget------------
plan_covid19fiscalbudget=drake::drake_plan(
# > plan begins -----------
# >> targetDataListFun--------------
targetDataListFun = function(url){
  covid19Expense05 <- xml2::read_xml(url)
  covid19Expense05 <- as_list(covid19Expense05)
  
  covid19Expense05$CGBAH100T_中央政府總預算收支執行狀況月報表本年度部分 -> targetDataList
  targetDataList
},

# >> listOfUrl--------------
listOfUrl ={
  list(
    "https://www.mof.gov.tw/download/c9e382ef465b40999cb31cf2dd376671",
    "https://www.mof.gov.tw/download/eaa49b3997d84c70ab732b919c18361e",
    "https://www.mof.gov.tw/download/fccd0f328a9a41e28768a500a6cf33f7",
    "https://www.mof.gov.tw/download/1bb58fd19a844757b9ae6d10875716c0",
    "https://www.mof.gov.tw/download/346ee1bf991b4a06980e83747ee402bd"
  )
},

# >> list_targetDataList--------------
list_targetDataList = {
  listOfUrl %>%
    map(
      targetDataListFun
    ) 
},

# >> budgetDF5to9--------------
budgetDF5to9 = {
  list_targetDataList %>%
  map_dfr(
    get_budgetDFfun
  )
},

# >> get_budgetDFfromMonthData--------------
get_budgetDFfromMonthData = function(targetBudgetMonth)
{
  

targetBudgetMonth[1:11] %>%
  map_dfc(
    ~.x[[1]]
  ) -> targetDF
targetDF
},

# >> get_budgetDFfun--------------
get_budgetDFfun =function(targetDataList){

targetDataList %>%
  map_dfr(
    get_budgetDFfromMonthData
  ) -> budgetDF

budgetDF
},

# >> saveBudgetDF--------------
saveBudgetDF = {
  save(budgetDF5to9,    file="budgetDF5to9.Rda")
}

# > plan ends ------------
)

mk_plan_covid19fiscalbudget= function()
{
library(readr)
library(dplyr)
library(ggplot2)
library(svglite)
library(WDI)
library(xml2)
options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/.covid19", hash_algorithm = "xxhash64"))
params=readRDS("/Users/martinl/Github/109-1-econDV/params_covid19fiscalbudget.rds")
drake::make(plan_covid19fiscalbudget,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/.covid19"))
}
vis_plan_covid19fiscalbudget= function(...)
{
library(readr)
library(dplyr)
library(ggplot2)
library(svglite)
library(WDI)
library(xml2)
options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/.covid19", hash_algorithm = "xxhash64"))
params=readRDS("/Users/martinl/Github/109-1-econDV/params_covid19fiscalbudget.rds")
drake::vis_drake_graph(plan_covid19fiscalbudget,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/.covid19"),...)
}
load_plan_covid19fiscalbudget= function(...)
{
drake::loadd(...,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/.covid19"), envir = .GlobalEnv)
}
