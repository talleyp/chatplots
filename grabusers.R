grabusers <- function(month){        
        #Grab users for the month
        site <- paste('http://overrustlelogs.net/Destinygg%20chatlog/', month, "%202015/userlogs", sep="")
        userVec <- xpathApply( htmlTreeParse(site, 
                                             useInt=T), "//td", function(x) xmlValue(x))
        doc.text = gsub('.txt', '', userVec)
        trim <- function (x) gsub("^\\s+|\\s+$", "", x)
        users <- trim(doc.text)
        myuserlist <- tolower(users)
        return(myuserlist)
}