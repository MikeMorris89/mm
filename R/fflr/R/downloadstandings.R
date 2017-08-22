#' main
#'
#' @param
#'
#' @return
#' @export
#'
#' @examples
downloadstandings<-function(){

# Setup the app
cKey     <- readLines("personal/keys/yahoo.txt", warn=FALSE)[1]
cSecret  <- readLines("personal/keys/yahoo.txt", warn=FALSE)[2]

yahoo    <-oauth_endpoints("yahoo")

creds <- read.table("personal/keys/yahoo.txt", stringsAsFactors=F)
consumer.key <- creds[1,1]
consumer.secret <- creds[2,1]
oauth_endpoints("yahoo")
myapp <- oauth_app("yahoo", key = consumer.key, secret = consumer.secret)
token <- oauth1.0_token(oauth_endpoints("yahoo"), myapp)

myapp <- oauth_app("yahoo", key=cKey, secret=cSecret)
yahoo_token<- oauth2.0_token(yahoo, myapp, cache=T, use_oob = T)
sig <- sign_oauth1.0(myapp, yahoo_token$oauth_token, yahoo_token$oauth_token_secret)
save(sig,file="Fantasy.Rdata")


baseURL     <- "http://fantasysports.yahooapis.com/fantasy/v2/league/"
leagueID    <- "371.l.891274"
standingsURL<-paste(baseURL, leagueID, "/standings", sep="")

page <-GET(standingsURL, config(token = token))
XMLstandings<- content(page, as="text", encoding="utf-8")

doc<-xmlTreeParse(XMLstandings, useInternal=TRUE)
myList<- xmlToList(xmlRoot(doc))


FromMyList<- function(x){
  A<-myList$league$standings$teams[[x]]$name
  B<-myList$league$standings$teams[[x]]$team_id
  C<-unlist(myList$league$standings$teams[[x]]$team_standings$outcome_totals)
  D<-unlist(myList$league$standings$teams[[x]]$team_standings$streak)
  names(A)<-names(B)<-names(C)<-names(D)<-NULL
  c(A,B,C,D)
}

FromMyList

# Combine the data into a dataframe
Standings<- as.data.frame(matrix(unlist(lapply(1:12, function(x) FromMyList(x))),
                                 byrow=T,
                                 ncol=5),
                          row.names = NULL)

# Apply formatting
names(Standings)<- c("Team Name", "ID",  "Streak Type", "Streak")

print(Standings, row.names = FALSE)
}
