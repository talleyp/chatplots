plotmaker <- function(user, month){
        library(tm) #Load Text mining package
        library(stringr)
        library(XML)
        library(ggplot2)
        library(RTextTools)
        library(data.table)
        library(dplyr)
        source('getemotes.R')
        source('grabusers.R')
        source('getlines.R')
        source('makefreqtable.R')

        foo <- getlines(month, user)
        emotelist <- getemotes()
        myuserlist <- grabusers(month)
        FreqMat <- makefreqtable(foo)
        
        #Make the message freq by hour table
        datevec <- strptime(foo[,1], "[%Y-%m-%d %H:%M:%S UTC] ", tz = "UTC")
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
        #class(freqTable$Hour) = "numeric"
        dayOrder = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
        hourOrder = c("0-5 UTC", "6-11 UTC", "12-17 UTC", "18-23 UTC")
        neworder = arrange(transform(freqTable, Hour = factor(Hour, levels=hourOrder), 
                                     Weekday = factor(Weekday, levels=dayOrder)),Hour, Weekday)
        hourplot <- ggplot(neworder, aes(x = Weekday, y = N, fill = N), colour="black") + 
                geom_bar(stat = "identity") + 
                ggtitle(paste('Messages per hour for', user)) +
                labs(y = "Count") + facet_wrap(~Hour, nrow=4) + 
                scale_fill_gradient(low="white", high="black") 
        heatHour <- ggplot(neworder, aes(x = Weekday, y = Hour), colour="black") +  
                        ggtitle(paste('Messages per hour for', user)) +
                        geom_tile(aes(fill=N)) + 
                        scale_fill_gradient(low="white", high="black") +
                        ggtitle(paste('Messages per hour for', user))
                        
        
        totalLines <- length(hourVec)
        #Subset the emote from the freq table
        emotedf <- FreqMat[FreqMat$ST %in% emotelist,]
        emotedf <- emotedf[order(-emotedf$Freq),]
        
        #Percentage emote table
        totalemote <- sum(emotedf$Freq)
        emotetab <- data.table(emotedf)
        emotetab[,Freq:= Freq/totalemote]
        specify_decimal <- function(x, k) format(round(x, k), nsmall=k)
        emotetab[,Freq:= specify_decimal(Freq,2)]
        emotetab[,Freq:= as.numeric(Freq)]
        
        #Subset users from freq table
        userdf <- FreqMat[FreqMat$ST %in% myuserlist,]
        userdf <- subset(userdf, !(ST %in% emotelist))
        userdf <- userdf[order(-userdf$Freq),]
        
        emoteplot <- ggplot(head(emotedf,20), aes(x = ST, y = Freq)) + geom_bar(stat = "identity") + 
                        ggtitle(paste("Top 20 Emotes for", user)) + labs(x = "Emote", y = "Count") +
                        theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
                        geom_text(data=head(emotedf,20), aes(x = ST, y = Freq, label = Freq), 
                                colour="black", size = 3, vjust = -.5)
        
        emopercplot <- ggplot(head(emotetab,20), aes(x = ST, y = Freq)) + geom_bar(stat = "identity") + 
                ggtitle(paste("Top 20 Emotes as % for", user)) + labs(x = "Emote", y = " As % Of Total Emotes") +
                theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
                geom_text(data=head(emotetab,20), aes(x = ST, y = Freq, label = Freq), 
                          colour="black", size = 3, vjust = -.5)
                        
        userplot <- ggplot(head(userdf,20), aes(x = ST, y = Freq)) + geom_bar(stat = "identity") + 
                        ggtitle(paste("Favorite 20 People for" , user)) + labs(x = "User", y = "Count") +
                        theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
                        geom_text(data=head(userdf,20), aes(x = ST, y = Freq, label = Freq), 
                                  colour="black", size = 3, vjust = -.5)
        
        hourname <- paste(paste( user, 'hourplot',sep='_'),'.png',sep='')
        emotename <- paste(paste( user,'emoteplot', sep='_'),'.png',sep='')
        emotepername <- paste(paste( user,'emoteperplot', sep='_'),'.png',sep='')
        username <- paste(paste(user,'userplot', sep='_'),'.png',sep='')
        heatname <- paste(paste(user,'tileplot', sep='_'),'.png',sep='')
        
        ggsave(filename=hourname, plot=hourplot)
        ggsave(filename=emotename, plot=emoteplot)
        ggsave(filename=username, plot=userplot)
        ggsave(filename=emotepername, plot=emopercplot)
        ggsave(filename=heatname, plot=heatHour)
}