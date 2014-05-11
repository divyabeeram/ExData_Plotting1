plotdata<-read.table("household_power_consumption.txt",sep=";",header=TRUE)
plotdata[,1]<-as.Date(plotdata[,1],"%d/%m/%Y")
pdata<-plotdata[plotdata$Date %in% as.Date(c('2007-02-01','2007-02-02')),]
is.na(pdata$Global_active_power)<-pdata$Global_active_power=="?"

pdata[,"timestamp"]<-as.POSIXct(paste(pdata$Date, pdata$Time), format="%Y-%m-%d %H:%M:%S")

plot(pdata$Global_active_power*2/1000~pdata$timestamp,pdata,type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.copy(png,file="plot2.png")
dev.off()
