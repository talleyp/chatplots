getlines <- function(month, user){
        site <- paste('http://overrustlelogs.net/Destinygg%20chatlog/',month,'%202016/userlogs/',user,'.txt', sep="")
        #load the data
        rawLines <- readLines(site)
        
        #change the data into a data frame
        l.df <- as.data.frame(rawLines)
        
        #split to seperate out lines
        foo <- data.frame(do.call('rbind', strsplit(as.character(l.df$rawLines), paste(user, ':', sep=""),fixed=TRUE)))
        foo <- foo[ ,(1:2)]
        colnames(foo) <- c("date","string")
        return(foo)
}
