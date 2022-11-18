options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/drake_plans/.technique", hash_algorithm = "xxhash64"))
# no params in the frontmatter
# plan_technique------------
plan_technique=drake::drake_plan(
# > plan begins -----------
# >> cars--------------
cars=summary(cars),

# >> pressure--------------
pressure=plot(pressure)

# > plan ends ------------
)

mk_plan_technique= function()
{
options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/drake_plans/.technique", hash_algorithm = "xxhash64"))
# no params in the frontmatter
drake::make(plan_technique,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/drake_plans/.technique"))
}
vis_plan_technique= function(...)
{
options(rstudio_drake_cache = storr::storr_rds("/Users/martinl/Github/109-1-econDV/drake_plans/.technique", hash_algorithm = "xxhash64"))
# no params in the frontmatter
drake::vis_drake_graph(plan_technique,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/drake_plans/.technique"),...)
}
load_plan_technique= function(...)
{
drake::loadd(...,
cache=drake::drake_cache(
  path="/Users/martinl/Github/109-1-econDV/drake_plans/.technique"), envir = .GlobalEnv)
}
