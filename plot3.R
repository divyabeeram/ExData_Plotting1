plotdata<-read.table("household_power_consumption.txt",sep=";",header=TRUE)
plotdata[,1]<-as.Date(plotdata[,1],"%d/%m/%Y")
pdata<-plotdata[plotdata$Date %in% as.Date(c('2007-02-01','2007-02-02')),]

is.na(pdata$Sub_metering_1)<-pdata$Sub_metering_1=="?"
is.na(pdata$Sub_metering_2)<-pdata$Sub_metering_2=="?"
is.na(pdata$Sub_metering_3)<-pdata$Sub_metering_3=="?"

pdata[,"timestamp"]<-as.POSIXct(paste(pdata$Date, pdata$Time), format="%Y-%m-%d %H:%M:%S")

newData<-pdata[,7:10]
newData[,1]<-as.character(newData[,1])
newData[,1]<-as.numeric(newData[,1])
newData[,2]<-as.character(newData[,2])
newData[,2]<-as.numeric(newData[,2])
newData[,3]<-as.character(newData[,3])
newData[,3]<-as.numeric(newData[,3])
plotcol=c("black","red","blue")
plot(newData$timestamp,newData$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(newData$timestamp,newData$Sub_metering_2,type="l",col="red")
lines(newData$timestamp,newData$Sub_metering_3,type="l",col="blue")
legend("topright",c("Sub Metering 1","Sub Metering 2","Sub Metering 3"),col=plotcol,lwd=2)
dev.copy(png,file="plot3.png")
dev.off()

