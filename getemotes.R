getemotes <- function(){
        normEmoticons <- c("Abathur", "AngelThump", "AYYYLMAO", "BasedGod", "BibleThump", 
                   "CallCatz", "CallChad", "CheekerZ", "DaFeels", "DAFUK", "DANKMEMES",
                   "DappaKappa", "DatGeoff", "DestiSenpaii", "Disgustiny", "Dravewin",
                   "DuckerZ","DURRSTINY","FeedNathan","FerretLOL","FIDGETLOL",
                   "FrankerZ","GameOfThrows","Heimerdonger","Hhhehhehe","INFESTINY",
                   "Kappa","Klappa","LeRuse","LIES","LUL",
                   "MASTERB8","MLADY","MotherFuckinGame","Nappa","NoTears",
                   "NOTMYTEMPO","OhKrappa","OverRustle","PEPE","Sippy",
                   "SoDoge","SoSad","SOTRIGGERED","SURPRISE",
                   "SWEATSTINY", "TooSpicy", "UWOTM8", "WhoahDude", "WORTH", "YEE", "OuO")
        bdggEmoticons <- c("4Head", "ASLAN", "BabyRage", "BrainSlug", "CARBUCKS", 
                   "CORAL", "CUX", "CallHafu", "ChanChamp", "ChibiDesti", 
                   "D:", "DESBRO", "DJAslan", "DSPstiny", "DansGame", 
                   "DatSheffy", "Depresstiny", "EleGiggle", "GabeN", 
                   "HerbPerve", "ITSRAWWW", "Jewstiny", "Keepo", "Kreygasm", 
                   "NiceMeMe", "OpieOP", "PJSalt", "POTATO", "PogChamp", 
                   "RaveDoge", "ResidentSleeper", "Riperino", "SMOrc",  "SSSsss", 
                   "SephURR", "ShibeZ", "SourPls", "SpookerZ", "SuccesS", "SwiftRage",
                   "TopCake", "WEOW", "WinWaker", "aaaChamp", "dayJoy", "kaceyFace", 
                   "lirikThump", "nathanDad")
        twitchEmoticons <- c("nathanDad", "nathanDank","nathanDubs1","nathanDubs2",
                     "nathanDUbs3","nathanFather","nathanFeels","nathanParty")
        emotes <- c(normEmoticons, bdggEmoticons, twitchEmoticons)
        emotelist <- tolower(emotes)
        return(emotelist)
}