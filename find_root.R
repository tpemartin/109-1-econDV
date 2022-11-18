find_root <- function(f, rangeX, errorThreshold=1e-10, maxIt=500)
{
  rangeX <- seq(from=rangeX[[1]], to=rangeX[[2]], length.out = 100)

    # 取得f_mapping (11.3)
  f_mapping <- get_f_mapping(f, rangeX)
  
  # 取得所有root-covering intervals (11.4)
  startInterval <- get_rootCoveringInterval(f_mapping)
  
  # 針對第一個root-covering interval, 計算它的refinedResult (11.5)
  startIntervalX <- startInterval[[1]]
  
  # initial condition
  .x <- 0
  flag <- T
  maxIt <- 500
  errorThreshold <- 1e-10
  cat('Iteration starts: \n')
  while(flag && .x <= maxIt)
  {
    # iterate generation
    .x <- .x + 1
    refinedResult <- get_refinedResult(f, startIntervalX)
    startIntervalX <- refinedResult$refinedInterval
    
    # continuation flag generation
    flag <- abs(refinedResult$f_root) >= errorThreshold
    cat(
      glue::glue(
        '.x={.x}, root={refinedResult$root}, abs(error)={abs(refinedResult$f_root)}\n\n'
      )
    )
  }
  
  refinedResult
}


# helpers -----------------------------------------------------------------
get_f_mapping <- function(f, rangeX){
  return(
    list(
      fx=f(rangeX),
      x=rangeX
    )
  )
}
get_rootCoveringInterval <- function(f_mapping){
  x_previous <- f_mapping$x[[1]]
  fx_previous <- f_mapping$fx[[1]]
  list_rootSource <- list()
  # start from 2nd x
  for (.x in 2:length(f_mapping$fx))
  {
    # .x <-3
    # browser()
    x_current <- f_mapping$x[[.x]]
    fx_current <- f_mapping$fx[[.x]]
    
    flag_change <- (sign(fx_current) != sign(fx_previous))
    if (flag_change) list_rootSource[[length(list_rootSource) + 1]] <- c(x_previous, x_current)
    
    x_previous <- x_current
    fx_previous <- fx_current
  }
  
  return(list_rootSource)
}
get_refinedResult <- function(f, startInterval){
  # assertthat::assert_that(sign(f(startInterval[[1]])) != sign(f(startInterval[[2]])),
  #                         "f(x[[1]]) and f(x[[2]]) where x from startInterval must have different signs")
  # 取得均值
  root <- {
    mean(startInterval)
  }
  
  # 取得均值函數值
  f_root <- {
    f(root)
  }
  
  # 找出startInterval裡誰的f(x)與f(meanX)不同正負號
  signDifferentX <- {
    whichHasOppositeSign <- which(sign(f(startInterval)) != sign(f_root))
    startInterval[[whichHasOppositeSign]]
  }
  
  # 得到refinedInterval
  refinedInterval <- c(signDifferentX, root)
  
  refinedResult <-
    list(
      root = root,
      f_root = f_root,
      refinedInterval = refinedInterval
    )
  return(refinedResult)
}
