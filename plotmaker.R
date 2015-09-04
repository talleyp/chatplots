plotmaker <- function(user, month){
        library(tm) #Load Text mining package
        library(stringr)
        library(XML)
        library(ggplot2)
        library(RTextTools)
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
        hourplot <- qplot(hourVec, geom='histogram') + ggtitle(paste('Messages per hour for', user)) +
                        labs(x = "Hour [UTC]", y = "Count")
                        
        
        #Subset the emote from the freq table
        emotedf <- FreqMat[FreqMat$ST %in% emotelist,]
        emotedf <- emotedf[order(-emotedf$Freq),]
        
        #Subset users from freq table
        userdf <- FreqMat[FreqMat$ST %in% myuserlist,]
        userdf <- subset(userdf, !(ST %in% emotelist))
        userdf <- userdf[order(-userdf$Freq),]
        
        emoteplot <- ggplot(head(emotedf,20), aes(x = ST, y = Freq)) + geom_bar(stat = "identity") + 
                        ggtitle(paste("Top 20 Emotes for", user)) + labs(x = "Emote", y = "Count") +
                        theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
                        geom_text(data=head(emotedf,20), aes(x = ST, y = Freq, label = Freq), 
                                colour="black", size = 3, vjust = -.5)
                        
        userplot <- ggplot(head(userdf,20), aes(x = ST, y = Freq)) + geom_bar(stat = "identity") + 
                        ggtitle(paste("Favorite 20 People for" , user)) + labs(x = "User", y = "Count") +
                        theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
                        geom_text(data=head(userdf,20), aes(x = ST, y = Freq, label = Freq), 
                                  colour="black", size = 3, vjust = -.5)
        
        hourname <- paste(paste('hourplot', user, sep='_'),'.jpg',sep='')
        emotename <- paste(paste('emoteplot', user, sep='_'),'.jpg',sep='')
        username <- paste(paste('userplot', user, sep='_'),'.jpg',sep='')
        
        ggsave(filename=hourname, plot=hourplot)
        ggsave(filename=emotename, plot=emoteplot)
        ggsave(filename=username, plot=userplot)
}