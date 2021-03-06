library(stringr)
library(lubridate)
library(tidyr)
library(dplyr)
library(econDV)
library(SOAR)
SOAR::Attach() # 將/.R_Cache裡的資料形成可搜尋物件的地方
library(WDI)
library(ggplot2)
rprojroot::is_rstudio_project -> .pj
.pj$make_fix_file() -> .root

chosenYear=2017
options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/2020_10_15/.taiwanXMGDPRatio", hash_algorithm = "xxhash64"))
# no params in the frontmatter
# plan_taiwanXMGDPRatio------------
plan_taiwanXMGDPRatio=drake::drake_plan(
# > plan begins -----------
# >> world_import--------------
world_import = {
  import_search <- WDIsearch(string = "Imports of goods and services")
  world_import %=% WDI(indicator = import_search[12, 1])
  world_import
},

# >> world_export--------------
world_export = {
  export_search <- WDIsearch(string = "Exports of goods and services")
  world_export %=% WDI(indicator = export_search[13, 1])
  world_export
},

# >> worldTrade--------------
worldTrade = {
    world_import %>%
      inner_join(
        world_export %>% select(-country), 
        by = c("iso2c", "year")) %>%
      select(
        year, iso2c, country, contains("indicator")) %>%
      rename(
        "M"="indicator.x",
        "X"="indicator.y"
      )
    
},

# >> df_taiwanXMGDPratio--------------
df_taiwanXMGDPratio = {
    load(url("https://www.dropbox.com/s/cjn53a4sroueyrz/df_taiwanGDPcomponents.rda?dl=1"))
    df_taiwanGDPcomponents %>% 
      mutate(year = year(time)) %>% 
      group_by(year) %>% 
      mutate(n = n()) %>% 
      ungroup() %>% 
      filter(n == 4) %>% 
      group_by(year) %>%
      summarise(
        across(
          all_of(
            c("GDP","X", "M")), 
          sum)) %>% 
      mutate(
        across(
          all_of(c("X", "M")), 
          function(x) {
            round(x/.data$GDP * 100, 2)
        })) %>%
      select(year, X, M) %>% 
      mutate(iso2c = "TW", country = "Tawain")
},

# >> worldTradeIncTaiwan--------------
worldTradeIncTaiwan = {
  worldTrade %>%
    select(
      year, iso2c,
      country, X, M
    ) %>%
    bind_rows(df_taiwanXMGDPratio) %>%
    left_join(
      econDV::ISOcountry,
      by = c(iso2c = "code")
    ) %>%
    na.omit() %>%
    group_by(year) %>%
    mutate(
      tradeVolume = X + M,
      rank_tradeVolume = get_rankNumber(tradeVolume)
    ) %>%
    arrange(rank_tradeVolume) %>%
    ungroup()
},

# >> canvasData--------------
canvasData = {
    worldTradeIncTaiwanchosenYear <- 
      worldTradeIncTaiwan %>% 
      filter(year == chosenYear) %>%
      arrange(rank_tradeVolume) %>% 
      pivot_longer(
        cols = c("X", "M"), 
        names_to = "type", 
        values_to = "value"
        )
    worldTradeIncTaiwanchosenYear %>%
      filter(
        rank_tradeVolume <= 40)
},

# >> geomLayer--------------
geomLayer = {
  canvasData %>% 
    ggplot() + 
    geom_col(
      aes(x = zh, y = value, 
        fill = type))
},

# >> geomScale--------------
geomScale = {
  geomLayer +
  scale_x_discrete(
      limits = rev(canvasData$zh), 
        ) + 
  scale_y_continuous(
      sec.axis = dup_axis()
      )
},

# >> themeLayer--------------
themeLayer = {
  theme(
  axis.line.y = element_blank(), 
  panel.grid.major.x = element_line()
  ) 
},

# >> gg_worldXMGDPRatio--------------
gg_worldXMGDPRatio = {
  geomScale +
    themeLayer +
    coord_flip()
},

# >> save_gg_worldXMGDPRatio--------------
save_gg_worldXMGDPRatio = {
    scale = 5/8
    height = 8
    destdir = 
      file.path(.root(),"img")
    if(!dir.exists(destdir)) dir.create(destdir)
    ggsave(
      plot = gg_worldXMGDPRatio, 
      filename = 
        file.path(destdir, "gg_worldXMGDPRatio.svg"), 
      width = 5, height = 8)
}

# > plan ends ------------
)

mk_plan_taiwanXMGDPRatio= function()
{
library(stringr)
library(lubridate)
library(tidyr)
library(dplyr)
library(econDV)
library(SOAR)
SOAR::Attach() # 將/.R_Cache裡的資料形成可搜尋物件的地方
library(WDI)
library(ggplot2)
rprojroot::is_rstudio_project -> .pj
.pj$make_fix_file() -> .root

chosenYear=2017
options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/2020_10_15/.taiwanXMGDPRatio", hash_algorithm = "xxhash64"))
# no params in the frontmatter
drake::make(plan_taiwanXMGDPRatio,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/2020_10_15/.taiwanXMGDPRatio"))
}
vis_plan_taiwanXMGDPRatio= function(...)
{
library(stringr)
library(lubridate)
library(tidyr)
library(dplyr)
library(econDV)
library(SOAR)
SOAR::Attach() # 將/.R_Cache裡的資料形成可搜尋物件的地方
library(WDI)
library(ggplot2)
rprojroot::is_rstudio_project -> .pj
.pj$make_fix_file() -> .root

chosenYear=2017
options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/2020_10_15/.taiwanXMGDPRatio", hash_algorithm = "xxhash64"))
# no params in the frontmatter
drake::vis_drake_graph(plan_taiwanXMGDPRatio,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/2020_10_15/.taiwanXMGDPRatio"),...)
}
load_plan_taiwanXMGDPRatio= function(...)
{
drake::loadd(...,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/2020_10_15/.taiwanXMGDPRatio"), envir = .GlobalEnv)
}
