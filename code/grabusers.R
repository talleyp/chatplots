grabusers <- function(month, year){ 
        path.code <- paste(getwd(),"code",sep='/')
        source(paste(path.code,'htmlToText.R',sep='/'))
        #Grab users for the month
        site <- paste('http://overrustlelogs.net/Destinygg%20chatlog/', month, "%20",year,"/userlogs", sep="")
        txt <- htmlToText(site)
        spltxt <- strsplit(txt, " ")
        txtframe <- as.data.frame(spltxt)
        colnames(txtframe) <- 'ST'

        subuser <- apply(txtframe, 2, function(x) which(grepl("*.txt", x), arr.ind = FALSE))
        newframe <- as.data.frame(txtframe[subuser,])
        colnames(newframe) <- "ST"
        charframe <- as.data.frame(as.character.factor(newframe$ST))
        colnames(charframe) <- "ST"
        #newframe$ST <- as.character.factor(newframe)
        splvec<- as.vector(apply(charframe, 2, function(x) strsplit(x, ".txt")))
        userframe <- t(data.frame(users = splvec))
        colnames(userframe) <- 'user'
        userframe <- tolower(userframe)

        return(userframe)


}