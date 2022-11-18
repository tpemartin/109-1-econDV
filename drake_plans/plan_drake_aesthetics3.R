library(dplyr)
library(tidyr)
library(stringr)
library(googledrive)
library(readr)
library(ggplot2)
library(scales)
library(colorspace)
library(econDV)
econDV::setup_chinese(need2Knit = F)
rprojroot::is_rstudio_project -> .pj
.pj$make_fix_file() -> .root

imageFolder <- file.path(.root(),"img")
dataFolder <- file.path(.root(),"data")
if(!dir.exists(imageFolder)) dir.create(imageFolder)
if(!dir.exists(dataFolder)) dir.create(dataFolder)

dataFilename=file.path(dataFolder, "taiwanBusinessCycles.Rdata")
if(!file.exists(dataFilename)){
  xfun::download_file("https://www.dropbox.com/s/50jb8va5shyxfse/taiwanBusinessCycles.Rdata?dl=1",dataFilename)
}
load(dataFilename)
options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/drake_plans/.aesthetics3", hash_algorithm = "xxhash64"))
# no params in the frontmatter
# plan_drake_aesthetics3------------
plan_drake_aesthetics3=drake::drake_plan(
# > plan begins -----------
# >> df_bcWithLights--------------
df_bcWithLights = {
  
  df_realGDP %>%
    left_join(
      businessCycleLights %>%
        select(
          date, `景氣對策信號(分)`
        ),
      by = c("time" = "date")
    ) -> df_realGDP2

  df_realGDP2$`景氣對策信號(分)` %>%
    cut(c(8, 16, 22, 31, 37, 45)) -> df_realGDP2$light
  
  # levels(df_realGDP2$light) -> lightScoreRage
  # 
  # levels(df_realGDP2$light) <-
  #   c("#1d1bce", "#ccc980", "#d4fcd7", "#f9b32f", "#fd1b19")

  df_realGDP2 %>%
    na.omit()
},

# >> canvas--------------
canvas = ggplot(
  data=df_bcWithLights,
  mapping=aes(
    x=time, y=growthRate
)),

# >> plt_basic--------------
plt_basic = {
  canvas +
    geom_line(size=1.5)
},

# >> plt_withColors--------------
plt_withColors0 = {
  plt_basic +
    geom_line(
      aes(color=light)
    )
},

# >> plt_withColors--------------
plt_withColors = {
  plt_basic +
    geom_line(
      aes(color=light, group=1)
    )
},

# >> canvasOrdered--------------
canvasOrdered = { 
  plt_basic %+% # %+% 會將data frame替換掉
    {
      df_bcWithLights %>%
        mutate(
          light=ordered(light)
        )
    }
},

# >> plt_withColors_order--------------
plt_withColors_order = {
  canvasOrdered +
    geom_line(
      aes(color=light, group=1)
    )
},

# >> plt_color_orderLegend--------------
plt_color_orderLegend = {
  plt_withColors_order +
    scale_color_viridis_d(
      name = "景氣訊號",
      labels = c("低迷", "低迷-穩定間", "穩定", "穩定-熱絡", "熱絡")
    )
},

# >> plt_qualitative_default--------------
plt_qualitative_default= {
  canvas +
  geom_line(
    size=1.5
  ) +
  geom_line(
    aes(color=light, group=1)
  ) 
},

# >> myRY_palette--------------
myRY_palette = 
  scales::colour_ramp(
    c(rgb(1,0,0),rgb(1,1,0))
),

# >> scale_color_myRY--------------
scale_color_myRY = function(...){
  continuous_scale(
  "color", # 給什麼aesthetic元素用
  "myRY_palette", # 有錯誤時要怎麼稱呼你的scale
  palette=myRY_palette, # palette function: [0,1] -> color
  ...)
},

# >> myHuePalette--------------
myHuePalette=hue_pal(h=c(100,200)),

# >> scale_color_myHue--------------
scale_color_myHue = function(...){
  discrete_scale(
    "color",
    "myHue",
    palette=myHuePalette,
    ...
  )
}

# > plan ends ------------
)

mk_plan_drake_aesthetics3= function(...)
{
library(dplyr)
library(tidyr)
library(stringr)
library(googledrive)
library(readr)
library(ggplot2)
library(scales)
library(colorspace)
library(econDV)
econDV::setup_chinese(need2Knit = F)
rprojroot::is_rstudio_project -> .pj
.pj$make_fix_file() -> .root

imageFolder <- file.path(.root(),"img")
dataFolder <- file.path(.root(),"data")
if(!dir.exists(imageFolder)) dir.create(imageFolder)
if(!dir.exists(dataFolder)) dir.create(dataFolder)

dataFilename=file.path(dataFolder, "taiwanBusinessCycles.Rdata")
if(!file.exists(dataFilename)){
  xfun::download_file("https://www.dropbox.com/s/50jb8va5shyxfse/taiwanBusinessCycles.Rdata?dl=1",dataFilename)
}
load(dataFilename)
options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/drake_plans/.aesthetics3", hash_algorithm = "xxhash64"))
# no params in the frontmatter
drake::make(plan_drake_aesthetics3,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/drake_plans/.aesthetics3"),...)
}
vis_plan_drake_aesthetics3= function(...)
{
library(dplyr)
library(tidyr)
library(stringr)
library(googledrive)
library(readr)
library(ggplot2)
library(scales)
library(colorspace)
library(econDV)
econDV::setup_chinese(need2Knit = F)
rprojroot::is_rstudio_project -> .pj
.pj$make_fix_file() -> .root

imageFolder <- file.path(.root(),"img")
dataFolder <- file.path(.root(),"data")
if(!dir.exists(imageFolder)) dir.create(imageFolder)
if(!dir.exists(dataFolder)) dir.create(dataFolder)

dataFilename=file.path(dataFolder, "taiwanBusinessCycles.Rdata")
if(!file.exists(dataFilename)){
  xfun::download_file("https://www.dropbox.com/s/50jb8va5shyxfse/taiwanBusinessCycles.Rdata?dl=1",dataFilename)
}
load(dataFilename)
options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/drake_plans/.aesthetics3", hash_algorithm = "xxhash64"))
# no params in the frontmatter
drake::vis_drake_graph(plan_drake_aesthetics3,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/drake_plans/.aesthetics3"),...)
}
load_plan_drake_aesthetics3= function(...)
{
drake::loadd(...,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/drake_plans/.aesthetics3"), envir = .GlobalEnv)
}
