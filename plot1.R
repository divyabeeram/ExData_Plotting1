plotdata<-read.table("household_power_consumption.txt",sep=";",header=TRUE)
plotdata[,1]<-as.Date(plotdata[,1],"%d/%m/%Y")
pdata<-plotdata[plotdata$Date %in% as.Date(c('2007-02-01','2007-02-02')),]
is.na(pdata$Global_active_power)<-pdata$Global_active_power=="?"

hist(as.numeric(pdata$Global_active_power)*2/1000,main="Global Active Power",xlab="Global Active Power (kilowatts)",ylab="Frequency",col="orangered")
dev.copy(png,file="plot1.png")
dev.off()
