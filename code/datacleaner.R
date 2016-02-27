datacleaner <- function(foo, myuserlist, emotelist, FreqMat){
        #Make the message freq by hour table
        datevec <- as.POSIXct(strptime(foo[,1], "[%Y-%m-%d %H:%M:%S UTC] ", tz = "UTC"))
        hourVec <-  format(datevec, "%H")
        dateTable = data.table(datevec)
        dateTable[,Weekday:=weekdays(datevec)]
        dateTable[,Hour:=format(datevec, "%H")]
        class(dateTable$Hour) = "numeric"
        dateTable$HourGroup <- ifelse((dateTable$Hour >= 0) & (dateTable$Hour <= 5), "0-5 UTC", 
                                      ifelse((dateTable$Hour >= 6) & (dateTable$Hour <= 11), "6-11 UTC",
                                             ifelse((dateTable$Hour >= 12) & (dateTable$Hour <= 17), "12-17 UTC",
                                                    ifelse((dateTable$Hour >= 18) & (dateTable$Hour <= 23), "18-23 UTC", 5
                                                    ))))
        freqTable =  as.data.table(table(dateTable$HourGroup, dateTable$Weekday))
        setnames(freqTable,c("V1","V2"), c("Hour","Weekday"))
        dayOrder = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
        hourOrder = c("0-5 UTC", "6-11 UTC", "12-17 UTC", "18-23 UTC")
        neworder = arrange(transform(freqTable, Hour = factor(Hour, levels=hourOrder), 
                                     Weekday = factor(Weekday, levels=dayOrder)),Hour, Weekday)
        

        
        #Subset the emote from the freq table
        emotedf <- FreqMat[FreqMat$ST %in% emotelist[,1],]
        colnames(emotedf) <- c('emote', 'Freq')
        emotedf <- merge(emotedf, emotelist, by.x = 'emote', by.y = 'emote')
        emotedf <- emotedf[order(-emotedf$Freq),]
        
        
        #Subset users from freq table
        userdf <- FreqMat[FreqMat$ST %in% myuserlist,]
        userdf <- subset(userdf, !(ST %in% emotelist))
        userdf <- userdf[order(-userdf$Freq),]
        
        return(list(userdf=userdf, neworder=neworder, emotedf=emotedf))
        
}