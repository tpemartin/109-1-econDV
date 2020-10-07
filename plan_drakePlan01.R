# plan_drakePlan01------------
plan_drakePlan01=drake::drake_plan(
# > plan begins -----------
# >> youBikeRightClass--------------
youBikeRightClass = { # deal with class
  df_newTaipeiYouBike %>% map(class)
  
  numericVs <- c("tot","sbi","lat","lng")
  
  df_newTaipeiYouBike %>% 
    mutate(
      across(
        all_of(numericVs),
        as.numeric
      )
    ) -> df_newTaipeiYouBike2
  
  factorVs <- c("sarea")
  df_newTaipeiYouBike2 %>%
    mutate(
      across(
        all_of(factorVs),
        as.factor
      )
    ) -> df_newTaipeiYouBike3
  
  df_newTaipeiYouBike3 %>%
    mutate(
      mday=ymd_hms(mday)
    )
},

# >> checkNA--------------
checkNA={
  totNA <- function(.x) sum(is.na(.x))
  smplSize <- function(.x) length(.x) - totNA(.x)
  youBikeRightClass %>%
    summarise(
      across(
        everything(),
        list(na=totNA, size=smplSize) # na, size會成為欄位名稱一部份
      )
    )
},

# >> df_inflationTW--------------
df_inflationTW={
  require(lubridate)
  df_cpiTW %>%
    filter(
      str_detect(TYPE, "年增率"),
      Item=="總指數(民國105年=100)"
    ) %>% #View() %>%
    mutate(
      date=ymd(
        glue::glue("{TIME_PERIOD}D01")),
      year=year(date)
    ) %>%
    group_by(
      year
    ) %>%
    mutate(
      n=n() # n() basically count nObs
    ) %>%
    filter(
      n==12
    ) %>%
    mutate(
      Item_VALUE=parse_number(Item_VALUE)
    ) %>%
    summarise( # !!! summarise 一定會ungroup
      inflation=mean(Item_VALUE)
    ) %>%
    mutate(
      iso2c="TW",
      country="Taiwan"
    ) -> df_inflationTW
  df_inflationTW
},

# >> df_worldInflation--------------
df_worldInflation={
  world_inflation %>%
    rename(
      inflation=FP.CPI.TOTL.ZG
    ) -> world_inflation2
  
  world_inflation2 %>%
    bind_rows(
      df_inflationTW
    ) -> df_worldInflation
  
  df_worldInflation
},

# >> world_inflationComplete--------------
world_inflationComplete = {
  world_inflation %>%
    rename(
      inflation=FP.CPI.TOTL.ZG
    ) -> world_inflation2
  
  bind_rows(
    df_inflationTW,
    world_inflation2
  )
},

# >> world_inflationWithTaiwan--------------
world_inflationWithTaiwan = {
  world_inflation %>%
    rename(
      inflation=FP.CPI.TOTL.ZG
    ) -> world_inflation2
  
  world_inflation2 %>%
    left_join(
      ISOcountry %>%
        select(-en), # 不選en
      by = c("iso2c" = "code")
    ) -> world_inflationWithTaiwan
  world_inflationWithTaiwan
},

# >> world_inflationComplete_wide--------------
world_inflationComplete_wide = {
  world_inflationComplete %>%
    pivot_wider(
      id_cols = c("year", "country", "inflation"),
      names_from = "country",
      values_from = "inflation"
    ) ->
  world_inflationComplete_wide
  world_inflationComplete_wide
}

# > plan ends ------------
)

# make plan -----------------
mk_plan_drakePlan01 = function(cachePath="/Users/martin/Github/109-1-econDV/.dataCleaning"){
# no params in the frontmatter


library(drake)
options(rstudio_drake_cache = storr::storr_rds("/Users/martin/Github/109-1-econDV/.dataCleaning", hash_algorithm = "xxhash64"))
make(plan_drakePlan01, cache=drake::drake_cache(path=cachePath))
}

vis_plan_drakePlan01 <- function(cachePath="/Users/martin/Github/109-1-econDV/.dataCleaning"){
# no params in the frontmatter

drake::vis_drake_graph(plan_drakePlan01, cache=drake::drake_cache(path=cachePath))
}
meta_plan_drakePlan01=
list(
cachePath="/Users/martin/Github/109-1-econDV/.dataCleaning",
readd=function(t) {
  drake::readd(t,cache=drake::drake_cache(path="/Users/martin/Github/109-1-econDV/.dataCleaning"))},
clean=function(t=NULL) {
  drake::clean(t,cache=drake::drake_cache(path="/Users/martin/Github/109-1-econDV/.dataCleaning"))})

