library(readr)
library(ggplot2)
library(drake)
library(rmd2drake)
library(dplyr)
library(stringr)
library(showtext)
showtext_auto()
theme(
  text=element_text(family = "Noto Sans TC")
  ) %>%
  theme_set()

rprojroot::is_rstudio_project -> pj
pj$make_fix_file()->root
options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/drake_plans/.graphingBasics", hash_algorithm = "xxhash64"))
# no params in the frontmatter
# plan_drake_graphing_basics------------
plan_drake_graphing_basics=drake::drake_plan(
# > plan begins -----------
# >> big5bankInterestRates--------------
big5bankInterestRates=read_csv("https://www.cbc.gov.tw/public/data/OpenData/A13Rate.csv"),

# >> subsetDataTWbank--------------
subsetDataTWbank = {
  big5bankInterestRates %>%
    mutate(
       年月日={
         191100+as.integer(年月) -> mockDate
         paste0(stringr::str_sub(mockDate,1,4),"-",str_sub(mockDate,5,6),"-01") # 加了01日
       },
       西元年月=lubridate::ymd(年月日)
    )  %>%
    select(
      "銀行", "西元年月",
      matches("定存利率-([一三六]個月|[一二三]年期)-固定")
    ) %>%
    filter(
      銀行=="臺灣銀行"
    )
},

# >> canvas--------------
canvas = {
  ggplot()
},

# >> ggline--------------
ggline = {
  canvas +
    geom_line(
      aes(x = 西元年月, y = `定存利率-一個月-固定`),
      subsetDataTWbank
    )
},

# >> ggLinePoint--------------
ggLinePoint={
  ggline +
  geom_point(
    mapping=aes(x=西元年月,y=`定存利率-一個月-固定`), 
    subsetDataTWbank  
  )
},

# >> ggline3M--------------
ggline3M = {
  ggline +
    geom_line(
      aes(x = 西元年月, y = `定存利率-三個月-固定`),
      subsetDataTWbank,
      color="blue"
    )
},

# >> ggline1Y--------------
ggline1Y = {
  ggline3M +
    geom_line(
      aes(x = 西元年月, y = `定存利率-一年期-固定`),
      subsetDataTWbank,
      color="green"
    )
},

# >> ggline2Y3Y--------------
ggline2Y3Y = {
  ggline1Y + 
    geom_line(
      aes(x = 西元年月, y = `定存利率-二年期-固定`),
      subsetDataTWbank,
      color="brown"
    ) +
    geom_line(
      aes(x = 西元年月, y = `定存利率-三年期-固定`),
      subsetDataTWbank,
      color="red"
        )
},

# >> canvas2--------------
canvas2=ggplot(data=subsetDataTWbank),

# >> ggline2Y3Y_2--------------
ggline2Y3Y_2 = {
  canvas2 +
    geom_line(
      aes(x = 西元年月, y = `定存利率-一個月-固定`)
    ) +
    geom_line(
      aes(x = 西元年月, y = `定存利率-三個月-固定`),
      color = "blue"
    ) +
    geom_line(
      aes(x = 西元年月, y = `定存利率-一年期-固定`),
      color = "green"
    ) +
    geom_line(
      aes(x = 西元年月, y = `定存利率-二年期-固定`),
      color = "brown"
    ) +
    geom_line(
      aes(x = 西元年月, y = `定存利率-三年期-固定`),
      color = "red"
    ) 
    
},

# >> ggTwbInterestRates--------------
ggTwbInterestRates= {
  ggline2Y3Y +
    labs(
      title="臺灣銀行不同期限定存利率",
      subtitle="固定利率，單位：% 年率",
      caption="資料出處: 政府開放資料平台https://data.gov.tw/dataset/10359",
      y="",
      x=""
    )+theme_classic()
},

# >> ggTwbInterestRates--------------
ggTwbInterestRates_bw= {
  ggTwbInterestRates +
    theme_bw()
},

# >> saveGgline--------------
saveGgline = {
  ggsave(
    ggTwbInterestRates, 
    file=file.path(
      root(),"img/ggTwbInterestRates.svg"
      ), width=8, height=5)
}

# > plan ends ------------
)

mk_plan_drake_graphing_basics= function()
{
library(readr)
library(ggplot2)
library(drake)
library(rmd2drake)
library(dplyr)
library(stringr)
library(showtext)
showtext_auto()
theme(
  text=element_text(family = "Noto Sans TC")
  ) %>%
  theme_set()

rprojroot::is_rstudio_project -> pj
pj$make_fix_file()->root
options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/drake_plans/.graphingBasics", hash_algorithm = "xxhash64"))
# no params in the frontmatter
drake::make(plan_drake_graphing_basics,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/drake_plans/.graphingBasics"))
}
vis_plan_drake_graphing_basics= function(...)
{
library(readr)
library(ggplot2)
library(drake)
library(rmd2drake)
library(dplyr)
library(stringr)
library(showtext)
showtext_auto()
theme(
  text=element_text(family = "Noto Sans TC")
  ) %>%
  theme_set()

rprojroot::is_rstudio_project -> pj
pj$make_fix_file()->root
options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/drake_plans/.graphingBasics", hash_algorithm = "xxhash64"))
# no params in the frontmatter
drake::vis_drake_graph(plan_drake_graphing_basics,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/drake_plans/.graphingBasics"),...)
}
load_plan_drake_graphing_basics= function(...)
{
drake::loadd(...,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/drake_plans/.graphingBasics"), envir = .GlobalEnv)
}
