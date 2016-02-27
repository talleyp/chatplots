makewordcloud <- function(d, user, wordcloudname)
{
        #Wordcloud
        png(wordcloudname, width=1280,height=800)
        title <- paste("Wordcloud of", user, sep=" ")
        pal <- colorRampPalette(brewer.pal(8,"Set2"))(100)
        layout(matrix(c(1, 2), nrow=2), heights=c(0.1, 5))
        par(mar=rep(0, 4))
        plot.new()
        text(x=0.5, y=0.5, title)
        cloud <- wordcloud(d$ST,d$Freq, scale=c(10,.8),min.freq=10,
                  max.words=500, random.order=FALSE, rot.per=.15, colors=pal,
                  main="Title")
        dev.off()
}
