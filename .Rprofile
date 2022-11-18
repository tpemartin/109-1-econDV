.packages_init = c(
  "stats",
  "lubridate", "stringr", "ggplot2",
  "plotly", "purrr", "future", "drake", #"renv",
  "svglite", "jsonlite", "readr", "rlang",
  "tidyr", "showtext", "rprojroot", "fst", "magrittr",
  "xml2", "rvest", "rdbnomics", "dplyr", "magick",
  "sf", "osmdata", "grDevices", "colorspace",
  "shinyjs", "devtools", "clipr", "googlesheets4"
)
invisible(purrr::map(
  .packages_init,
  ~require(.x, character.only = T)
))
# sysfonts::font_add_google("Noto Sans TC")
showtext::showtext_auto(enable=TRUE) #啟用字體
ggplot2::theme_set(ggplot2::theme_classic(
  base_family="Noto Sans TC"
))
utils::browseURL("https://tpemartin.github.io/economic-data-visualization/zh-tw/")
library(NTPUclassmanagement)
system(
  'open -a "Ink2Go"'
)
# system(
#   'open -a "FonePaw Screen Recorder"'
# )
