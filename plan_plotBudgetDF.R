library(readr)
library(dplyr)
library(ggplot2)
library(svglite)
options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/.myCache", hash_algorithm = "xxhash64"))
params=readRDS("/Users/martinl/Github/109-1-econDV/params_plotBudgetDF.rds")
# plan_plotBudgetDF------------
plan_plotBudgetDF=drake::drake_plan(
# > plan begins -----------
# >> budgetDF5to9--------------
budgetDF5to9 ={
  load(file_in("budgetDF5to9.Rda"))
  budgetDF5to9 <<- budgetDF5to9
},

# >> target2--------------
target2 = {
  budgetDF5to9
}

# > plan ends ------------
)

mk_plan_plotBudgetDF= function()
{
library(readr)
library(dplyr)
library(ggplot2)
library(svglite)
options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/.myCache", hash_algorithm = "xxhash64"))
params=readRDS("/Users/martinl/Github/109-1-econDV/params_plotBudgetDF.rds")
drake::make(plan_plotBudgetDF,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/.myCache"))
}
vis_plan_plotBudgetDF= function(...)
{
library(readr)
library(dplyr)
library(ggplot2)
library(svglite)
options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/.myCache", hash_algorithm = "xxhash64"))
params=readRDS("/Users/martinl/Github/109-1-econDV/params_plotBudgetDF.rds")
drake::vis_drake_graph(plan_plotBudgetDF,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/.myCache"),...)
}
load_plan_plotBudgetDF= function(...)
{
drake::loadd(...,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/.myCache"), envir = .GlobalEnv)
}
