# lubridate: 
library(lubridate)
## %--% creates interval of time
## %within% check if time falls within an interval of time

# 天命：1616-1626

start <- ymd("1616-01-01")
end <- ymd("1626-12-31")

TianMingInterval = start %--% end

# case 1
year <- 1618
inputTime <- ymd(paste0(year, "01-01"))
isTianMing <- inputTime %within% TianMingInterval
isTianMing

# case 2
year <- 1636
inputTime <- ymd(paste0(year, "01-01"))
isTianMing <- inputTime %within% TianMingInterval
isTianMing

