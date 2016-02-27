makefreqtable <- function(foo){
        #Make freq table for who you talk to
        foo$string <- as.character(foo$string)
        docs <- foo[1,2]
        for(i in 2:nrow(foo)){
                docs <- c(docs, foo[i,2])
        }
        
        mycorpus <- Corpus(VectorSource(docs))
        ae.corpus <- tm_map(mycorpus, tolower)
        ae.corpus <- tm_map(mycorpus, PlainTextDocument)
        ae.corpus <- tm_map(ae.corpus, function(x) removeWords(x, stopwords("english")))
        #ae.corpus <- tm_map(ae.corpus, removePunctuation)
        
        
#         dtm <- DocumentTermMatrix(ae.corpus);
#         temp <- inspect(dtm);
#         FreqMat <- data.frame(ST = colnames(temp), Freq = colSums(temp));
        tdm <- TermDocumentMatrix(ae.corpus)
        m <- as.matrix(tdm)
        v <- sort(rowSums(m), decreasing=TRUE)
        FreqMat <- data.frame(ST = names(v), Freq=v)
        return(FreqMat)
}