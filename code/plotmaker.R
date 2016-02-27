plotmaker <- function(user = 'Talley76', month = format(Sys.time(), "%B"), year = format(Sys.time(), "%Y")){
        library(tm) #Load Text mining package
        library(stringr)
        library(XML)
        library(RCurl)
        library(ggplot2)
        library(RTextTools)
        library(data.table)
        library(dplyr)
        library(wordcloud)
        library(RColorBrewer)
        path.data <- paste(getwd(), 'data',sep='/')
        path.code <- paste(getwd(),"code",sep='/')
        path.images <- paste(getwd(),paste(year,month,sep='_'),sep='/')
        if(!dir.exists(path.images)){
                dir.create(path.images)
        }
        source(paste(path.code,'/getemotes.R', sep=''))
        source(paste(path.code,'/grabusers.R', sep=''))
        source(paste(path.code,'/getlines.R', sep=''))
        source(paste(path.code,'/makefreqtable.R', sep=''))
        source(paste(path.code,'/makewordcloud.R', sep=''))
        source(paste(path.code,'/datacleaner.R', sep=''))
        
        
        foo <- getlines(month, user, year)
        emotelist <- getemotes(path.data)
        myuserlist <- grabusers(month, year)
        FreqMat <- makefreqtable(foo)
        dat <- datacleaner(foo, myuserlist, emotelist, FreqMat)
        
        hourplot <- ggplot(dat$neworder, aes(x = Weekday, y = N, fill = N), colour="black") + 
                geom_bar(stat = "identity") + 
                ggtitle(paste('Messages per hour for', user)) +
                labs(y = "Count") + facet_wrap(~Hour, nrow=4) + 
                scale_fill_gradient(low="white", high="black") 
        
        heatHour <- ggplot(dat$neworder, aes(x = Weekday, y = Hour), colour="black") +  
                ggtitle(paste('Messages per hour for', user)) +
                geom_tile(aes(fill=N)) + 
                scale_fill_gradient(low="white", high="black") +
                ggtitle(paste('Messages per hour for', user))
        
        emoteplot <- ggplot(head(dat$emotedf,21), aes(x = reorder(emote, -Freq), y = Freq, fill = class)) + 
                geom_bar(stat = "identity") +  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))+
                ggtitle(paste("Top 20 Emotes for", user)) + labs(x = "Emote", y = "Count") +
                theme(axis.text.x = element_text(hjust = 0.5)) + 
                geom_text(data=head(dat$emotedf,20), aes(x = emote, y = Freq, label = Freq), 
                          colour="black", size = 3, vjust = -1)
        
        userplot <- ggplot(head(dat$userdf,20), aes(x = ST, y = Freq)) + geom_bar(stat = "identity") + 
                ggtitle(paste("Favorite 20 People for" , user)) + labs(x = "User", y = "Count") +
                theme(axis.text.x = element_text(hjust = 0.5)) + 
                geom_text(data=head(dat$userdf,20), aes(x = ST, y = Freq, label = Freq), 
                          colour="black", size = 3, vjust = -.5)
        
        
        
        hourname <- paste(path.images,paste(paste( user, 'hourplot',sep='_'),'.png',sep=''), sep='/')
        emotename <- paste(path.images,paste(paste( user,'emoteplot', sep='_'),'.png',sep=''), sep='/')
        username <- paste(path.images,paste(paste(user,'userplot', sep='_'),'.png',sep=''), sep='/')
        heatname <- paste(path.images,paste(paste(user,'tileplot', sep='_'),'.png',sep=''), sep='/')
        wordcloudname<- paste(path.images,paste(paste(user,'wordcloud', sep='_'),'.png',sep=''), sep='/')
        
        
        #Save plots
        ggsave(filename=hourname, plot=hourplot)
        ggsave(filename=emotename, plot=emoteplot)
        ggsave(filename=username, plot=userplot)
        ggsave(filename=heatname, plot=heatHour)
        makewordcloud(FreqMat, user, wordcloudname)
}