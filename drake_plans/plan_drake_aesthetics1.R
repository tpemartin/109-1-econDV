library(dplyr)
library(tidyr)
library(stringr)
library(ggplot2)
library(econDV)
library(drake)
econDV::setup_chinese(need2Knit = F)
rprojroot::is_rstudio_project -> .pj
.pj$make_fix_file() -> root
source(
  file.path(root(),"drake_plans/plan_drake_graphing_basics.R")
)
load_plan_drake_graphing_basics(ggline2Y3Y)
load_plan_drake_graphing_basics(subsetDataTWbank)
options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/drake_plans/.aesthetics1", hash_algorithm = "xxhash64"))
# no params in the frontmatter
# plan_drake_aesthetics1------------
plan_drake_aesthetics1=drake::drake_plan(
# > plan begins -----------
# >> canvasWithData--------------
canvasWithData = {
  ggplot(data=longData)
},

# >> gglineWithColorAes--------------
gglineWithColorAes ={
  canvasWithData +
    geom_line(
      aes(
        x=西元年月, y=利率, color=定存種類
      )
    )
},

# >> ggplotBase--------------
ggplotBase= {
  gglineWithColorAes+
    labs(
      title="臺灣銀行不同期限定存利率",
      subtitle="固定利率，單位：% 年率",
      caption="資料出處: 政府開放資料平台https://data.gov.tw/dataset/10359",
      y="",
      x=""
    )+theme_classic()
},

# >> longData--------------
longData = {
  
  longData <- {
  subsetDataTWbank %>%
    pivot_longer(
      cols = 3:8, # across(.cols=... )都可以用
      names_to = "定存種類",
      values_to = "利率"
    )
  }
  
  maturity <- c("一個月", "三個月", "六個月",
                "一年期", "二年期", "三年期")
  newLevels <- paste0("定存利率-",maturity,"-固定")
  longData %>%
    mutate(
      定存種類=factor(定存種類, 
                      levels=newLevels)
    ) -> longData2
  
  longData2$定存種類 %>% levels()
  
  longData2
},

# >> ggplotSubperiod--------------
ggplotSubperiod = {
  ggplotBase +
  scale_x_date(
    limits = c(ymd("2005-01-01"), ymd("2015-12-01"))
  )
},

# >> ggplotNewLegend--------------
ggplotNewLegend = {
  longData$定存種類 %>% levels() -> dataLevels
  dataLevels %>% stringr::str_extract("(?<=-)[:graph:]+(?=-)") -> dataLevelLabels
  ggplotSubperiod +
    scale_color_discrete(
      breaks= dataLevels,
      labels= dataLevelLabels,
      name="定存期限"
    )
}

# > plan ends ------------
)

mk_plan_drake_aesthetics1= function(...)
{
library(dplyr)
library(tidyr)
library(stringr)
library(ggplot2)
library(econDV)
library(drake)
econDV::setup_chinese(need2Knit = F)
rprojroot::is_rstudio_project -> .pj
.pj$make_fix_file() -> root
source(
  file.path(root(),"drake_plans/plan_drake_graphing_basics.R")
)
load_plan_drake_graphing_basics(ggline2Y3Y)
load_plan_drake_graphing_basics(subsetDataTWbank)
options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/drake_plans/.aesthetics1", hash_algorithm = "xxhash64"))
# no params in the frontmatter
drake::make(plan_drake_aesthetics1,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/drake_plans/.aesthetics1"),...)
}
vis_plan_drake_aesthetics1= function(...)
{
library(dplyr)
library(tidyr)
library(stringr)
library(ggplot2)
library(econDV)
library(drake)
econDV::setup_chinese(need2Knit = F)
rprojroot::is_rstudio_project -> .pj
.pj$make_fix_file() -> root
source(
  file.path(root(),"drake_plans/plan_drake_graphing_basics.R")
)
load_plan_drake_graphing_basics(ggline2Y3Y)
load_plan_drake_graphing_basics(subsetDataTWbank)
options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/drake_plans/.aesthetics1", hash_algorithm = "xxhash64"))
# no params in the frontmatter
drake::vis_drake_graph(plan_drake_aesthetics1,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/drake_plans/.aesthetics1"),...)
}
load_plan_drake_aesthetics1= function(...)
{
drake::loadd(...,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/drake_plans/.aesthetics1"), envir = .GlobalEnv)
}
