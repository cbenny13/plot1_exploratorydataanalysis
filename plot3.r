
R version 3.3.0 (2016-05-03) -- "Supposedly Educational"
Copyright (C) 2016 The R Foundation for Statistical Computing
Platform: x86_64-apple-darwin13.4.0 (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

[R.app GUI 1.68 (7202) x86_64-apple-darwin13.4.0]

[Workspace restored from /Users/cbenny13/.RData]
[History restored from /Users/cbenny13/.Rapp.history]

> library(dplyr)

Attaching package: ‘dplyr’

The following objects are masked from ‘package:stats’:

    filter, lag

The following objects are masked from ‘package:base’:

    intersect, setdiff, setequal, union

> library(ggplot2)
> library(reshape2)
> library(gridExtra)

Attaching package: ‘gridExtra’

The following object is masked from ‘package:dplyr’:

    combine

> library(grid)
> temp <- tempfile()
> download.file("https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip",temp)
trying URL 'https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip'
Content type 'application/zip' length 20640916 bytes (19.7 MB)
==================================================
downloaded 19.7 MB

data <- read.table(unz(temp, "household_power_consumption.txt"),
                       sep = ";", header = TRUE, stringsAsFactors = FALSE)
> data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";", header = TRUE, stringsAsFactors = FALSE)
> data0 <- tbl_df(data0)
> dataFil <- filter(data0, Date == "2/2/2007" | Date == "1/2/2007")
> dataFil <- mutate(dataFil, Date_Time = paste(Date, Time, sep = " "))
> dataFil$Date_Time <- strptime(dataFil$Date_Time, "%d/%m/%Y %H:%M:%S")
> dataFil[, 3:9] <- lapply(dataFil[, 3:9], as.numeric)
> 
> dataFil <- dataFil[, c(10, 3:9)]
> dataFil <- rename(dataFil, Kitchen = Sub_metering_1, Laundry_room = Sub_metering_2, Water_heater_AC = Sub_metering_3)
> plot(dataFil$Date_Time, dataFil$Kitchen, type = "l", ylab = "Energy sub metering", xlab = "")
> points(dataFil$Date_Time, dataFil$Laundry_room, type = "l", col = "red")
Error in plot.xy(xy.coords(x, y), type = type, ...) : 
  plot.new has not been called yet
> points(dataFil$Date_Time, dataFil$Water_heater_AC, type = "l", col = "blue")
Error in plot.xy(xy.coords(x, y), type = type, ...) : 
  plot.new has not been called yet
> plot(dataFil$Date_Time, dataFil$Kitchen, type = "l", ylab = "Energy sub metering", xlab = "")
> points(dataFil$Date_Time, dataFil$Laundry_room, type = "l", col = "red")
> points(dataFil$Date_Time, dataFil$Water_heater_AC, type = "l", col = "blue")
> legend("topright", lty = c(1,1,1), lwd = c(2,2,2), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
> dev.copy(png, file="plot3.png", width=480, height=480)
quartz_off_screen 
                3 
> dev.off()
quartz 
     2 
> cat("plot3.png has been saved in", getwd())
plot3.png has been saved in /Users/cbenny13
> 