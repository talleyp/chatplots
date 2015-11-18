getemotes <- function(){
        normEmoticons <- c("Dravewin","INFESTINY","FIDGETLOL","Hhhehhehe",
                           "GameOfThrows","WORTH","FeedNathan","Abathur","LUL",
                           "Heimerdonger","SoSad","DURRSTINY","SURPRISE",
                           "NoTears","OverRustle","DuckerZ","Kappa","Klappa",
                           "DappaKappa","BibleThump","AngelThump","FrankerZ",
                           "BasedGod","TooSpicy","OhKrappa","SoDoge","WhoahDude",
                           "MotherFuckinGame","DaFeels","UWOTM8","CallCatz",
                           "CallChad","DatGeoff","Disgustiny","FerretLOL",
                           "Sippy","DestiSenpaii","Nappa","DAFUK","AYYYLMAO",
                           "DANKMEMES","MLADY","SOTRIGGERED","MASTERB8",
                           "NOTMYTEMPO","LIES","LeRuse","YEE","SWEATSTINY",
                           "PEPE","CheekerZ","SpookerZ","SLEEPSTINY","PICNIC",
                           "Memegasm","WEEWOO","KappaRoss","nathanDad",
                           "nathanFather","nathanDubs1","nathanDubs2",
                           "nathanDubs3","nathanParty","nathanDank","nathanFeels")
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
        emotes <- c(normEmoticons, bdggEmoticons)
        emotelist <- tolower(emotes)
        return(emotelist)
}
