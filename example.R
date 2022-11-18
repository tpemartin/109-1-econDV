a <- 3
cc <- 15
examplePlan <- drake::drake_plan(
  target1 = {
    a + 5 -> b
    cc <- 0
    if (b < 10) b 
  },
  target2 = {
    cc 
  },
  target3 = {
    target1 + a +target2
  }
)
make(examplePlan)
vis_drake_graph(examplePlan)