# make plan -----------------
params=readRDS("/Users/martinl/Github/109-1-econDV/Weekly chart 1/params_weekly_chart.rds")

library(dplyr)
library(tidyr)
library(stringr)
library(googledrive)
library(readr)
library(ggplot2)
library(econDV)
#econDV::setup_chinese(need2Knit = F)
rprojroot::is_rstudio_project -> .pj
.pj$make_fix_file() -> .root

imageFolder <- file.path(.root(),"img")
dataFolder <- file.path(.root(),"data")

if(!dir.exists(imageFolder)) dir.create(imageFolder)
if(!dir.exists(dataFolder))dir.create(dataFolder)

# plan_weekly_chart------------
plan_weekly_chart=drake::drake_plan(
# > plan begins -----------
# >> datadownload--------------
datadownload = {
  # 下載google drive檔案 share link 到本機project folder, 本以graph4week.csv名稱儲存
  googledrive::drive_download(
    file_in("https://drive.google.com/file/d/18L7z13xz_Rn_bYcQBhZR9wLxGZFgeO9e/view?usp=sharing"),
    path=file.path(root(),"gdprate.csv"),
    overwrite = T
  )
  
  # 自本機project folder裡引入graph4week.csv為graph4week1 data frame物件
  graph4week1 <- read_csv(
    file.path(root(),"gdprate.csv")
  )
},

# >> myggplot--------------
myggplot = {
  ggline1 <- {
  canvas +
    geom_line(
      aes(x = `年份`, y = `GDP年增率`),
      data,color="red"
    )
}
ggline2 <- {
  ggline1 +
    geom_line(
      aes(x = `年份`, y = `開發中國家`),
      data,color="green"
    )
}
ggline3 <- {
  ggline2 +
    geom_line(
      aes(x = `年份`, y = `世界平均`),
      data,color="black"
    )+geom_rect(mapping=aes(
      xmin=1997.5,xmax=1999,alpha=0.1,ymin=-Inf,ymax=Inf)
    )+geom_rect(mapping=aes(
      xmin=1994.2,xmax=1993.9,alpha=0.1,ymin=-Inf,ymax=Inf)
    )+geom_rect(mapping=aes(
      xmin=1987.3,xmax=1989.2,alpha=0.1,ymin=-Inf,ymax=Inf)
    )+geom_rect(mapping=aes(
      xmin=1982.2,xmax=1985,alpha=0.1,ymin=-Inf,ymax=Inf)
    )+geom_rect(mapping=aes(
      xmin=1981,xmax=1981.5,alpha=0.1,ymin=-Inf,ymax=Inf)
    )
}
gglineGDP <- {
  ggline3 +
    labs(
      title = '國家發展階段GDP年增率比較',
      subtitle='單位:%年增率',
      caption='資料出處:IMFhttps://www.imf.org/external/datamapper/NGDP_RPCH@WEO/ADVEC/WEOWORLD/OEMDC'
    )+theme_classic()+theme_bw()
}
  
}
myggplot,

# >> save_ggplot--------------
save_ggplot = {

  ggsave(
    plot=myggplot,
    filename=file.path(
      root(),"img/gglineGDP.svg"
      ), width=8, height=5)
}

# > plan ends ------------
)

