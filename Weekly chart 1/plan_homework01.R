# make plan -----------------
params=readRDS("/Users/martinl/Github/109-1-econDV/Weekly chart 1/params_homework01.rds")

library(dplyr)
library(tidyr)
library(stringr)
library(googledrive)
library(readr)
library(ggplot2)
library(econDV)
library(lubridate)
econDV::setup_chinese(need2Knit = F)
rprojroot::is_rstudio_project -> .pj
# .pj$make_fix_file() -> .root
# 
# imageFolder <- file.path(.root(),"img")
# dataFolder <- file.path(.root(),"data")
# 
# if(!dir.exists(imageFolder)) dir.create(imageFolder)
#if(!dir.exists(dataFolder))dir.create(dataFolder)

# plan_homework01------------
plan_homework01=drake::drake_plan(
# > plan begins -----------
# >> datadownload--------------

datadownload = {
  # 下載google drive檔案 share link 到本機project folder, 本以graph4week.csv名稱儲存
  googledrive::drive_download(
    file_in("https://drive.google.com/file/d/1fnd0u6W-OgphKbYI89U1VX_DAgIELhZd/view?usp=sharing"),
    path=file.path(dataFolder,"DJI.csv"),
    overwrite = T
  )
  
  # 自本機project folder裡引入graph4week.csv為graph4week1 data frame物件
  DJI <- read_csv(
    file.path(dataFolder,"DJI.csv")
  )
},

# >> readcsv--------------
DJI=read.csv("D:/econDV/DJI.csv"),

# >> plot_breaksEditted--------------
ggplotWithScale = {
  ggplotWithElectionall +
    scale_x_date(
      breaks = breakx
    ) +
    theme(
      axis.text.x = element_text(angle = 45, hjust = 1)
    )+
    labs(title ="How election influence America finance")+
    labs(subtitle ="2008,2012,2016 elections")+
    labs(caption="https://finance.yahoo.com/quote/%5EDJI/history?p=%5EDJI")
   
},

# >> save_ggplot--------------
save_ggplot = {

  ggsave(
    plot=ggplotWithScale,
    filename=file.path("D:/econDV", "myPlot.svg"),
    width = 8,
    height = 5
  )
},

# >> save_ggplot--------------
save_ggplot = {

  ggsave(
    plot=ggplotWithElection03,
    filename=file.path("D:/econDV", "myPlot03.svg"),
    width = 8,
    height = 5
  )
}

# > plan ends ------------
)

