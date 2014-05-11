plotdata<-read.table("household_power_consumption.txt",sep=";",header=TRUE)
plotdata[,1]<-as.Date(plotdata[,1],"%d/%m/%Y")
pdata<-plotdata[plotdata$Date %in% as.Date(c('2007-02-01','2007-02-02')),]
is.na(pdata$Global_active_power)<-pdata$Global_active_power=="?"
is.na(pdata$Global_reactive_power)<-pdata$Global_reactive_power=="?"
is.na(pdata$Voltage)<-pdata$Voltage=="?"
is.na(pdata$Sub_metering_1)<-pdata$Sub_metering_1=="?"
is.na(pdata$Sub_metering_2)<-pdata$Sub_metering_2=="?"
is.na(pdata$Sub_metering_3)<-pdata$Sub_metering_3=="?"

newData<-pdata[,7:10]
newData[,1]<-as.character(newData[,1])
newData[,1]<-as.numeric(newData[,1])
newData[,2]<-as.character(newData[,2])
newData[,2]<-as.numeric(newData[,2])
newData[,3]<-as.character(newData[,3])
newData[,3]<-as.numeric(newData[,3])

pdata[,"timestamp"]<-as.POSIXct(paste(pdata$Date, pdata$Time), format="%Y-%m-%d %H:%M:%S")
pdata$Voltage<-as.character(pdata$Voltage)
pdata$Voltage<-as.numeric(pdata$Voltage)

data1<-pdata[,c(5,10)]
data1<-data1[complete.cases(data1),]
data1$Voltage<-as.character(data1$Voltage)
data1$Voltage<-as.numeric(data1$Voltage)

par(mfcol=c(2,2))
plot(pdata$Global_active_power*2/1000~pdata$timestamp,pdata,type="l",xlab="",ylab="Global Active Power (kilowatts)")

plot(newData$timestamp,newData$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(newData$timestamp,newData$Sub_metering_2,type="l",col="red")
lines(newData$timestamp,newData$Sub_metering_3,type="l",col="blue")
legend("topright",c("Sub Metering 1","Sub Metering 2","Sub Metering 3"),col=plotcol,lwd=2,y.intersp=0.25,cex=0.7,lty=1,bty="n")

plot(data1$timestamp,as.numeric(data1$Voltage),type="l",xlab="datetime",ylab="Voltage")


plot(as.numeric(pdata$Global_reactive_power)*2/1000~pdata$timestamp,pdata,type="l",xlab="",ylab="Global Reactive Power (kilowatts)")
dev.copy(png,file="plot4.png")
dev.off()
