# no params in the frontmatter
library(dplyr)
library(tidyr)
library(readr)
library(stringr)
library(ggplot2)
library(econDV)
library(scales)
library(colorspace)
library(purrr)
econDV::setup_chinese(need2Knit = F)
rprojroot::is_rstudio_project -> .pj
.pj$make_fix_file() -> .root
theme_set(theme_classic())
options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/.statfunction", hash_algorithm = "xxhash64"))
# plan_drake_statfunction------------
plan_drake_statfunction=drake::drake_plan(
# > plan begins -----------
# >> makecondition2--------------
election2020 = jsonlite::fromJSON(
  "https://www.dropbox.com/s/a3torx0p41hheb6/presidentElection2020.json?dl=1"
),

# >> canvas--------------
canvas=ggplot(data=election2020),

# >> plt_election01--------------
plt_election01 = {
  canvas + 
  geom_col(
    aes(
      x=`鄉(鎮、市、區)別`, 
      y=`(3)
 蔡英文
 賴清德`)
  )
},

# >> plt_election_turnX270--------------
plt_election_turnX270 = {
  plt_election01 +
    theme(
      axis.text.x = 
        element_text(angle=270, size=unit(10, "pt"))
      # angle = 90, "區峽三"，angle = -90 (要寫360-90) 才"三峽區"
      )+
      labs(
        title="2020台灣總統大選",
        subtitle = "民進黨候選人得票率（單位：%）",
        caption="中央選舉委員會",
        y="", x=NULL
      )
},

# >> plt_election_xVeritical--------------
plt_election_xVeritical = {
  plt_election01 %+% 
    {
      # 行政區名每個字換行
      plt_election01$data$`鄉(鎮、市、區)別` %>%
        stringr::str_split("") %>%
        map_chr(paste0, collapse="\n") ->
        plt_election01$data$`鄉(鎮、市、區)別`
      
      plt_election01$data # { }最後一行必需是個data frame
    } +
      labs(
        title="2020台灣總統大選",
        subtitle = "民進黨候選人得票率（單位：%）",
        caption="中央選舉委員會",
        y=NULL, x=NULL
      )
},

# >> str_turnVertical--------------
str_turnVertical = function(strVector){
  require(dplyr)
  strVector %>%
    stringr::str_split("") %>%
    purrr::map_chr(paste0, collapse="\n")
},

# >> plt_election_verticalWord--------------
plt_election_verticalWord = {
  plt_election01 %+% {
    plt_election01$data %>%
      mutate(
        `鄉(鎮、市、區)別`=
          str_turnVertical(`鄉(鎮、市、區)別`)
        )
    }
},

# >> plt_election01_green--------------
plt_election01_green = {
  canvas + 
  geom_col(
    aes(
      x=`鄉(鎮、市、區)別`, 
      y=`(3)
 蔡英文
 賴清德`), fill="#5E9A43"
  )
},

# >> plt_election_xVeritical_green--------------
plt_election_xVeritical_green = {
  plt_election_xVeritical

  plt_election_xVeritical$layers[[1]]$aes_params$fill <- "#5E9A43"
  
  plt_election_xVeritical
},

# >> plt_election_verticalWord_green--------------
plt_election_verticalWord_green ={
    plt_election_verticalWord # 另外取名，方便後面討論
},

# >> data_chosenLevels--------------
data_chosenLevels = {
  plt_election_xVeritical_green$data %>%
  arrange(`(3)
 蔡英文
 賴清德`) %>%  # ---> (*)
  .$`鄉(鎮、市、區)別` -> chosenLevels
  
  plt_election_xVeritical_green$data %>%
    mutate(
      `鄉(鎮、市、區)別`=factor(
        `鄉(鎮、市、區)別`,
        levels=chosenLevels # ---> (**)
      )
    )
},

# >> plt_election_xVeritical_green_chosenLevels--------------
plt_election_xVeritical_green_chosenLevels = {
  plt_election_xVeritical_green %+%
    data_chosenLevels
},

# >> data_chosenLevels_rev--------------
data_chosenLevels_rev = {
  plt_election_xVeritical_green$data %>%
  arrange(`(3)
 蔡英文
 賴清德`) %>%  # ---> (*)
  .$`鄉(鎮、市、區)別` -> chosenLevels
  
  plt_election_xVeritical_green$data %>%
    mutate(
      `鄉(鎮、市、區)別`=factor(
        `鄉(鎮、市、區)別`,
        levels=rev(chosenLevels) # ---> (**)
      )
    )
},

# >> plt_election_xVeritical_green_chosenLevels_rev--------------
plt_election_xVeritical_green_chosenLevels_rev = {
  plt_election_xVeritical_green %+%
    data_chosenLevels_rev
},

# >> plt_xVertical_yGrounded--------------
plt_xVertical_yGrounded = {
  plt_election_xVeritical_green_chosenLevels_rev +
  scale_y_continuous(
    expand = expansion(mult = 0, add = 0) # since it's default, expansion() will do
  )
},

# >> testPlot--------------
testPlot = {
    testdata <- 
      data.frame(
        x=1:100,
        y=1:100
      )
    ggplot(testdata) +
      geom_blank(
        aes(x=x, y=y)
      )
},

# >> theme_method1--------------
theme_method1 = theme(
  axis.ticks.x = element_blank(),
  axis.line.y = element_blank(),
  axis.ticks.y = element_blank(),
  panel.grid.major.y = element_line(size=0.5, colour = "#b8c7d0")
),

# >> theme_method2--------------
theme_method2 = function(...){
  theme(
    axis.ticks.x = element_blank(),
    axis.line.y = element_blank(),
    axis.ticks.y = element_blank(),
    panel.grid.major.y = element_line(size=0.5, colour = "#b8c7d0"),
    ...
  )
},

# >> theme_method3--------------
theme_method3 = function(otherThemeSetting=theme()){
  theme(
    axis.ticks.x = element_blank(),
    axis.line.y = element_blank(),
    axis.ticks.y = element_blank(),
    panel.grid.major.y = element_line(size=0.5, colour = "#b8c7d0")
  ) + otherThemeSetting
},

# >> add_theme_economist--------------
add_theme_economist = function(gg,...){
  assertthat::assert_that(is.ggplot(gg))
  gg+scale_y_continuous(
      expand=expansion(0,0))+
    theme_method2(...)
}

# > plan ends ------------
)

mk_plan_drake_statfunction= function(...)
{
# no params in the frontmatter
library(dplyr)
library(tidyr)
library(readr)
library(stringr)
library(ggplot2)
library(econDV)
library(scales)
library(colorspace)
library(purrr)
econDV::setup_chinese(need2Knit = F)
rprojroot::is_rstudio_project -> .pj
.pj$make_fix_file() -> .root
theme_set(theme_classic())
options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/.statfunction", hash_algorithm = "xxhash64"))
drake::make(plan_drake_statfunction,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/.statfunction"),...)
}
vis_plan_drake_statfunction= function(...)
{
# no params in the frontmatter
library(dplyr)
library(tidyr)
library(readr)
library(stringr)
library(ggplot2)
library(econDV)
library(scales)
library(colorspace)
library(purrr)
econDV::setup_chinese(need2Knit = F)
rprojroot::is_rstudio_project -> .pj
.pj$make_fix_file() -> .root
theme_set(theme_classic())
options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/.statfunction", hash_algorithm = "xxhash64"))
drake::vis_drake_graph(plan_drake_statfunction,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/.statfunction"),...)
}
load_plan_drake_statfunction= function(...)
{
drake::loadd(...,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/.statfunction"), envir = .GlobalEnv)
}
