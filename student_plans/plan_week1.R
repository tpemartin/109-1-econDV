library(readr)
library(ggplot2)
library(drake)
library(rmd2drake)
library(dplyr)
library(showtext)
library(stringr)
library(jsonlite)
library(lubridate)

rprojroot::is_rstudio_project -> .pj
.pj$make_fix_file() -> .root

imageFolder <- file.path(.root(),"img")
dataFolder <- file.path(.root(),"data")

if(!dir.exists(imageFolder)) dir.create(imageFolder)
if(!dir.exists(dataFolder))dir.create(dataFolder)
options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/student_plans/.week1_graphs", hash_algorithm = "xxhash64"))
params=readRDS("/Users/martinl/Github/109-1-econDV/student_plans/params_week1.rds")
# plan_week1------------
plan_week1=drake::drake_plan(
# > plan begins -----------
# >> datadownload--------------
income=fromJSON("https://quality.data.gov.tw/dq_download_json.php?nid=44218&md5_url=5108938196a413ee42cca40b2e599084"),

# >> myggplot--------------
myggplot = {
  canvas ={
    ggplot()
  }
},

# >> subset_of_income--------------
subset_of_income = {
  income$Item_VALUE <- as.integer(income$Item_VALUE)

  pick <- income$Item == "國內生產毛額GDP(名目值，百萬元)" & income$TYPE == "原始值"

  Item_VALUE <- income$Item_VALUE[pick]

  TIME_PERIOD <- income$TIME_PERIOD[pick]

  subset_of_income <- data.frame(
    `年` = TIME_PERIOD,
    `國內生產毛額GDP(名目值，百萬元)` = Item_VALUE
  )
  subset_of_income
},

# >> ggpoint--------------
ggpoint = {
  myggplot +
    geom_point(
      mapping =  aes(x = `年`, y = `國內生產毛額GDP.名目值.百萬元.`  ),
      subset_of_income
    )
},

# >> ggTWGDPTrend--------------
ggTWGDPTrend= {
  ggpoint +
    labs(
      title="國內生產毛額GDP走勢圖(1951-2019)",
      subtitle="年,國內生產毛額GDP(名目值，百萬元)",
      caption="資料出處: 政府開放資料平台https://data.gov.tw/dataset/10359",
      y="",
      x=""
    )+theme_classic()
},

# >> save_ggplot--------------
save_ggplot = {

  ggsave(
    plot=ggTWGDPTrend,
    filename=file.path(imageFolder, "ggTWGDPTrend.svg"),
    width = 8,
    height = 5
  )
}

# > plan ends ------------
)

mk_plan_week1= function(...)
{
library(readr)
library(ggplot2)
library(drake)
library(rmd2drake)
library(dplyr)
library(showtext)
library(stringr)
library(jsonlite)
library(lubridate)

rprojroot::is_rstudio_project -> .pj
.pj$make_fix_file() -> .root

imageFolder <- file.path(.root(),"img")
dataFolder <- file.path(.root(),"data")

if(!dir.exists(imageFolder)) dir.create(imageFolder)
if(!dir.exists(dataFolder))dir.create(dataFolder)
options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/student_plans/.week1_graphs", hash_algorithm = "xxhash64"))
params=readRDS("/Users/martinl/Github/109-1-econDV/student_plans/params_week1.rds")
drake::make(plan_week1,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/student_plans/.week1_graphs"),...)
}
vis_plan_week1= function(...)
{
library(readr)
library(ggplot2)
library(drake)
library(rmd2drake)
library(dplyr)
library(showtext)
library(stringr)
library(jsonlite)
library(lubridate)

rprojroot::is_rstudio_project -> .pj
.pj$make_fix_file() -> .root

imageFolder <- file.path(.root(),"img")
dataFolder <- file.path(.root(),"data")

if(!dir.exists(imageFolder)) dir.create(imageFolder)
if(!dir.exists(dataFolder))dir.create(dataFolder)
options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/student_plans/.week1_graphs", hash_algorithm = "xxhash64"))
params=readRDS("/Users/martinl/Github/109-1-econDV/student_plans/params_week1.rds")
drake::vis_drake_graph(plan_week1,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/student_plans/.week1_graphs"),...)
}
load_plan_week1= function(...)
{
drake::loadd(...,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/student_plans/.week1_graphs"), envir = .GlobalEnv)
}
