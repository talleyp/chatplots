makewordcloud <- function(d)
{
         
         pal <- brewer.pal(8,"Dark2")
         png("wordcloud.png", width=1280,height=800)
         wordcloud(d$ST,d$Freq, scale=c(10,.8),min.freq=2,
                   max.words=250, random.order=FALSE, rot.per=.15, colors=pal)
         dev.off()
}