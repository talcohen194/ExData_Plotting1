##set the working directory. i unziped the file manually.
setwd("C:/Users/ User/Desktop/talco/tat miun/coursera/4. Exploratory Data Analysis/week_1/project")

##astract the columns names
col.names <- names(read.table(file = "./household_power_consumption.txt", nrow = 1, header = TRUE, sep = ";"))

##read the the necessary data ( only data from the dates 2007-02-01 and 2007-02-02)
data.power <- read.table(file = "./household_power_consumption.txt", na.strings = "?", sep = ";", 
                         header = FALSE, col.names = col.names, 
                         skip = grep("^[1,2]/2/2007", readLines("./household_power_consumption.txt"))-1,
                         nrow = 2879 )

##changing the date and time format
data.power$Date <- as.Date(data.power$Date, format= "%d/%m/%Y")
data.power$Time <- strptime(data.power$Time, format = "%H:%M:%S")

data.power[1:1440,"Time"] <- format(data.power[1:1440,"Time"], "2007-02-01 %H:%M:%S")
data.power[1441:2880,"Time"] <- format(data.power[1441:2880,"Time"], "2007-02-02 %H:%M:%S")

## changing the time zone so the days will be shown in english
my_lc_time <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "English")

png("plot2.png", width=480, height=480)

##building the second plot
plot(data.power$Time,as.numeric(as.character(data.power$Global_active_power)), type="l", 
     xlab = "", ylab="Global Active Power (kilowatts)")

dev.off()




