getemotes <- function(folder){
        emotedat <- read.csv(paste(folder, '/emote.csv', sep=''), header = FALSE)
        emote <- tolower(as.character.factor(emotedat[,1]))
        class <- as.character.factor(emotedat[,2])
        emotes <- cbind(emote, class)

        return(emotes)
}
