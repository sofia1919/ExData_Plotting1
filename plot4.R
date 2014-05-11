
Our goal here is  to examine how household energy usage varies over a 2-day period in February, 2007 and 
create a 4 plots with Global_active_power,Voltage, Energy Sub Mattering, Global_reactive_powerin in dependence to datetime variable.

setwd("C:/Users/user/Desktop/Coursera/exdata_data_household_power_consumption")

mydata<-read.csv("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?", colClasses=c("character","character" ,"numeric","numeric", "numeric", "numeric","numeric","numeric", "numeric"))
	library(data.table)
	DT=data.table(mydata)
	DT1<-DT[DT$Date=="1/2/2007"]			
	DT2<-DT[DT$Date=="2/2/2007"]
	l=list(DT1,DT2)
	rbindlist(l)
	DT3=rbindlist(l)						# Creates subset with 2880 rows and 9 colums for data betw."1/2/2007" and "2/2/2007"
      table<-data.frame(DT3)
      table[,3]<-as.numeric(table[,3])
      table[,4]<-as.numeric(table[,4])
      table[,5]<-as.numeric(table[,5])
      table[,6]<-as.numeric(table[,6])
      table[,7]<-as.numeric(table[,7])
      table[,8]<-as.numeric(table[,8])
      table[,9]<-as.numeric(table[,9])

Sys.setlocale(category = "LC_TIME", locale = "C")
Sys.setlocale(category = "LC_ALL", locale = "")

table$Date<-as.Date(table$Date, "%d/%m/%Y")      		# Format as.Date, output e.g."2007-02-01"

table$datetime<-strptime(paste(table$Date,table$Time),"%Y-%m-%d %H:%M:%S") # Create new column "datetime" and format as Date/Time

table$datetime<- as.POSIXct(table$datetime, format="%a")    # Format as "POSIXct" and "%a" gives abbreviated weekday name 

# Check so far:

head(table)

 Date     Time Global_active_power Global_reactive_power Voltage Global_intensity Sub_metering_1 Sub_metering_2 Sub_metering_3            datetime
1 2007-02-01 00:00:00               0.326                 0.128  243.15              1.4              0              0              0 2007-02-01 00:00:00
2 2007-02-01 00:01:00               0.326                 0.130  243.32              1.4              0              0              0 2007-02-01 00:01:00
3 2007-02-01 00:02:00               0.324                 0.132  243.51              1.4              0              0              0 2007-02-01 00:02:00
4 2007-02-01 00:03:00               0.324                 0.134  243.90              1.4              0              0              0 2007-02-01 00:03:00
5 2007-02-01 00:04:00               0.322                 0.130  243.16              1.4              0              0              0 2007-02-01 00:04:00
6 2007-02-01 00:05:00               0.320                 0.126  242.29              1.4              0              0              0 2007-02-01 00:05:00

  sm1<-table[ ,7]
  sm2<-table[ ,8]
  sm3<-table[ ,9]
  sm<c(sm1,sm2,sm3)
  max(sm)            		    # Check whicht of the 3 variables has the highest value to start plotting its line first  


# Create Plot4 as a summery of 4 subplots as follows: 
	- defing the par of margins for the 4 sub plots
	- splitting the screen into 4
	- create 4 subplots in the sequence:topleft Plot1, topright Plot2, create bottomleft Plot3 and bottomleft Plot4
      - saving Plot4 as a png file


  par(mar=c(6,4,4,4))
  par(mfrow=c(2,2))
  with(table, {
    plot(table$datetime,Global_active_power, type="l", xlab="", ylab="Global Active Power")
    plot(table$datetime,Voltage, type="l", xlab="datetime", ylab="Voltage")
    plot(table$datetime,sm1, type="l",xlab="", ylab="Energy Sub Mattering")
    lines(table$datetime, sm2, type="l",col="red")
    lines(table$datetime, sm3, type="l",col="blue")
    legend("topright", lty="solid", col=c("black","red","blue"),box.col=NA , legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex=0.8)
    plot(table$datetime,Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  })

 dev.copy(png, file="plot4.png", 480, 480)
 dev.off()
