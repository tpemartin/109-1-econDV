library(dplyr)
library(tidyr)
library(stringr)
library(ggplot2)
library(econDV)
econDV::setup_chinese(need2Knit = F)
rprojroot::is_rstudio_project -> .pj
.pj$make_fix_file() -> root
source(
  file.path(root(),"drake_plans/plan_drake_aesthetics1.R")
)
load_plan_drake_aesthetics1(ggplotBase)
load_plan_drake_aesthetics1(ggplotNewLegend)
options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/drake_plans/.aesthetics2", hash_algorithm = "xxhash64"))
# no params in the frontmatter
# plan_drake_aesthetics2------------
plan_drake_aesthetics2=drake::drake_plan(
# > plan begins -----------
# >> major_breaks--------------
major_breaks= {
  ggplotBase$data$西元年月 %>% unique() %>% sort() -> possibleValues
  starting <- possibleValues[[1]]
  ending <- possibleValues[[length(possibleValues)]]
  # major breaks
  major_breaks = {
      possibleValues %>%
        month() %>%
        {.==1} -> pickMajorBreaks
    
      # 留下1月
      major_breaks <- possibleValues[pickMajorBreaks]
      
      # 留下0/5 尾數年份
      major_breaks %>% year() %% 5 %>%
        {.==0} -> pick05endingYears
      major_breaks <- major_breaks[pick05endingYears]
      
      # 增加starting ending
      major_breaks <- c(starting, major_breaks, ending) %>% unique()
      
      major_breaks
  }
  major_breaks  
},

# >> labels--------------
labels = {
  major_breaks %>% year() -> breakYears
  major_breaks %>% month() -> breakMonths
  paste0(breakYears,"/",breakMonths)
},

# >> plot_breaksEditted--------------
plot_breaksEditted = {
  ggplotNewLegend +
    scale_x_date(
      breaks = major_breaks
    ) +
    theme(
      axis.text.x = element_text(angle = 45, hjust = 1)
    )
},

# >> plot_breaksLabelsEditted--------------
plot_breaksLabelsEditted = {
  ggplotNewLegend +
    scale_x_date(
      breaks = major_breaks, 
      labels = labels
    ) +
    theme(
      axis.text.x = element_text(angle = 45, hjust = 1)
    )
},

# >> ggplot0--------------
ggplot0 = {
  ggplotNewLegend +
    theme(
      axis.text.x = element_text(angle = 45, hjust = 1)
    )  
},

# >> sale1--------------
scale1 =
  scale_x_date(
      breaks = major_breaks
),

# >> sale2--------------
scale2 =
  scale_x_date(
      breaks = major_breaks, 
      labels = labels
),

# >> ggplot1_1--------------
ggplot1_1 = {
  ggplot0 +
    scale1
},

# >> ggplot1_2--------------
ggplot1_2 = {
  ggplot0 +
    scale2
},

# >> financialCrisis--------------
financialCrisis = data.frame(
  title=c("2008 Financial crisis"),
  start=ymd(c("2008-01-01")),
  end=ymd(c("2008-12-01"))
),

# >> ggplotWithEvent--------------
ggplotWithEvent = { # <drake_aes2>
  plot_breaksLabelsEditted + # <drake_aes2>
    geom_rect(
      mapping = aes(
        xmin = start, xmax = end
      ),
      data = financialCrisis, # <drake_aes2>
      ymax = Inf, ymin = -Inf # 定值的mapping放在aes()外
    )
},

# >> ggplotWithEventAlpha--------------
ggplotWithEventAlpha = { # <drake_aes2>
  plot_breaksLabelsEditted + # <drake_aes2>
    geom_rect(
      mapping = aes(
        xmin = start, xmax = end
      ),
      data = financialCrisis, # <drake_aes2>
      alpha= 0.3, # 透明度調整[0,1]間
      ymax = Inf, ymin = -Inf # 定值的mapping放在aes()外
    )
},

# >> financialCrisisShades--------------
financialCrisisShades = {
  geom_rect(
      mapping = aes(
        xmin = start, xmax = end
      ),
      data = financialCrisis, # <drake_aes2>
      alpha= 0.3, # 透明度調整[0,1]間
      ymax = Inf, ymin = -Inf # 定值的mapping放在aes()外
    )
},

# >> ggplotLegendTop--------------
ggplotLegendTop = { # <drake_aes2>
  ggplotWithEventAlpha + # <drake_aes2>
    theme(
      legend.position = "top"
    )
}

# > plan ends ------------
)

mk_plan_drake_aesthetics2= function(...)
{
library(dplyr)
library(tidyr)
library(stringr)
library(ggplot2)
library(econDV)
econDV::setup_chinese(need2Knit = F)
rprojroot::is_rstudio_project -> .pj
.pj$make_fix_file() -> root
source(
  file.path(root(),"drake_plans/plan_drake_aesthetics1.R")
)
load_plan_drake_aesthetics1(ggplotBase)
load_plan_drake_aesthetics1(ggplotNewLegend)
options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/drake_plans/.aesthetics2", hash_algorithm = "xxhash64"))
# no params in the frontmatter
drake::make(plan_drake_aesthetics2,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/drake_plans/.aesthetics2"),...)
}
vis_plan_drake_aesthetics2= function(...)
{
library(dplyr)
library(tidyr)
library(stringr)
library(ggplot2)
library(econDV)
econDV::setup_chinese(need2Knit = F)
rprojroot::is_rstudio_project -> .pj
.pj$make_fix_file() -> root
source(
  file.path(root(),"drake_plans/plan_drake_aesthetics1.R")
)
load_plan_drake_aesthetics1(ggplotBase)
load_plan_drake_aesthetics1(ggplotNewLegend)
options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/drake_plans/.aesthetics2", hash_algorithm = "xxhash64"))
# no params in the frontmatter
drake::vis_drake_graph(plan_drake_aesthetics2,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/drake_plans/.aesthetics2"),...)
}
load_plan_drake_aesthetics2= function(...)
{
drake::loadd(...,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/drake_plans/.aesthetics2"), envir = .GlobalEnv)
}
