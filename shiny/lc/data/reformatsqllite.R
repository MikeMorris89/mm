install.packages('RSQLite',dep=T)
install.packages('sqldf')
install.packages('XLConnect')
install.packages('compare')
install.packages('FinCal')
install.packages('lubridate')

library('sqldf')
library('XLConnect')
library("RSQLite")
library("compare")
library('FinCal')
library('lubridate')
setwd("C:/Users/mikem/.babun/cygwin/home/mikem/shiny/LendingClub/data")

#Functions
datefix<-function(dt){
  dt<-gsub('JAN-','01-01-',dt)
  dt<-gsub('FEB-','02-01-',dt)
  dt<-gsub('MAR-','03-01-',dt)
  dt<-gsub('APR-','04-01-',dt)
  dt<-gsub('MAY-','05-01-',dt)
  dt<-gsub('JUN-','06-01-',dt)
  dt<-gsub('JUL-','07-01-',dt)
  dt<-gsub('AUG-','08-01-',dt)
  dt<-gsub('SEP-','09-01-',dt)
  dt<-gsub('OCT-','10-01-',dt)
  dt<-gsub('NOV-','11-01-',dt)  
  dt<-gsub('Dec-','12-01-',dt)
}
substrRight <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}

# connect to the sqlite file
db <- dbConnect(SQLite(), dbname="database.sqlite")
sqldf("attach 'database.sqlite' as new")

dbListTables(db) 
dbListFields(db, 'loan')

dfsql<- dbReadTable(db, 'loan')
dfcsv<-read.csv("loan.csv")

class(dfsql)
class(dfcsv)

colnames(dfsql)
colnames(dfcsv)
writeClipboard(colnames(dfsql))
writeClipboard(colnames(dfcsv))
nrow(dfsql)
nrow(dfcsv)

comparison <- compare(data.frame(dfsql$id),data.frame(dfcsv$id),allowAll=TRUE)

dfsql$id<-as.numeric(dfsql$id)
dfcsv$id<-as.numeric(dfcsv$id)

difference <-
  data.frame(lapply(1:ncol(data.frame(dfsql$id)),function(i)setdiff(data.frame(dfsql$id)[,i],comparison$tM[,i])))
colnames(difference) <- colnames(data.frame(dfsql$id))
difference


a1NotIna2 <- sqldf('SELECT id FROM dfsql EXCEPT SELECT id FROM dfcsv')
a2NotIna1 <- sqldf('SELECT id FROM dfcsv EXCEPT SELECT id FROM dfsql')
a1NotIna2
a2NotIna1

##REMOVE NULL
dfsql<-dfsql[!is.na(dfsql$id),]

rm("comparison","difference","dfcsv")


##subset for testing
df1<-dfsql[1:100,]
head(df1)

#scrub
df1$int_rate<-as.numeric(gsub(" ","",gsub("%","",df1$int_rate)))
df1$term<-as.numeric(gsub("months","",gsub(" ","",df1$term)))
df1$installment<-as.numeric(df1$installment)
df1$issue_d<-as.Date(datefix(df1$issue_d),format = "%m-%d-%Y")


#check pmts vs rate vs term
df1$pv<-round(FinCal::pv(r=df1$int_rate/100/12,n=df1$term,fv = 0,pmt=df1$installment*-1),0)

#accounts do not reconcile. compliance issues...
df1[df1$pv!=df1$funded_amnt,]


df.riskfree<-df1[,c("term","issue_d","installment")]

df.riskfree.ex <- df.riskfree[rep(row.names(df.riskfree), df.riskfree$term),]

#check
sum(df.riskfree$term)
nrow(df.riskfree.ex )

head(df.riskfree.ex)
gregexpr('[.]',row.names(df.riskfree.ex))
str(as.numeric(gregexpr('[.]',row.names(df.riskfree.ex))))
gregexpr('[.]',row.names(df.riskfree.ex))[,1]
df.riskfree.ex$mobtmp1<-as.numeric(gregexpr('[.]',row.names(df.riskfree.ex)))
df.riskfree.ex$mobtmp2<-nchar(row.names(df.riskfree.ex))
df.riskfree.ex$mob<-substrRight(row.names(df.riskfree.ex),df.riskfree.ex$mobtmp2-df.riskfree.ex$mobtmp1)
df.riskfree.ex$mob[df.riskfree.ex$mobtmp1==-1]<-0
df.riskfree.ex$mob<-as.numeric(df.riskfree.ex$mob)+1

df.riskfree.ex$m<- df.riskfree.ex$issue_d+months(df.riskfree.ex$mob)
month(df.riskfree.ex$issue_d) + df.riskfree.ex$mob

head(df.riskfree.ex)
dtadd<-function(dt,n){
  return(seq.Date( dt, length=1, by=paste(n,'months',sep=' ') )[2])
}







