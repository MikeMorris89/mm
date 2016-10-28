install.packages('RSQLite',dep=T)
install.packages('sqldf')
install.packages('XLConnect')
install.packages('compare')
install.packages('FinCal')
install.packages('lubridate')
install.packages('data.table')
library('data.table')
library('sqldf')
library('XLConnect')
library("RSQLite")
library("compare")
library('FinCal')
library('lubridate')
library('plotly')
setwd("C:/Users/mikem/.babun/cygwin/home/mikem/shiny/lc/data")

#Functions
datefix<-function(dt){
  dt<-gsub('Jan-','01-01-',dt)
  dt<-gsub('Feb-','02-01-',dt)
  dt<-gsub('Mar-','03-01-',dt)
  dt<-gsub('Apr-','04-01-',dt)
  dt<-gsub('May-','05-01-',dt)
  dt<-gsub('Jun-','06-01-',dt)
  dt<-gsub('Jul-','07-01-',dt)
  dt<-gsub('Aug-','08-01-',dt)
  dt<-gsub('Sep-','09-01-',dt)
  dt<-gsub('Oct-','10-01-',dt)
  dt<-gsub('Nov-','11-01-',dt)  
  dt<-gsub('Dec-','12-01-',dt)
}
substrRight <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}
#wc<-function(x){writeClipboard(as.character(x))}
wc<-function(x){writeClipboard(write.table(x, "clipboard-128", sep="\t", row.names=FALSE))}


# connect to the sqlite file
# db <- dbConnect(SQLite(), dbname="database.sqlite")
# sqldf("attach 'database.sqlite' as new")
# 
# dbListTables(db) 
# dbListFields(db, 'loan')
# 
# dfsql<- dbReadTable(db, 'loan')
# dfcsv<-read.csv("loan.csv")
# 
# class(dfsql)
# class(dfcsv)
# 
# colnames(dfsql)
# colnames(dfcsv)
# writeClipboard(colnames(dfsql))
# writeClipboard(colnames(dfcsv))
# nrow(dfsql)
# nrow(dfcsv)
# 
# comparison <- compare(data.frame(dfsql$id),data.frame(dfcsv$id),allowAll=TRUE)
# 
# dfsql$id<-as.numeric(dfsql$id)
# dfcsv$id<-as.numeric(dfcsv$id)
# 
# difference <-
#   data.frame(lapply(1:ncol(data.frame(dfsql$id)),function(i)setdiff(data.frame(dfsql$id)[,i],comparison$tM[,i])))
# colnames(difference) <- colnames(data.frame(dfsql$id))
# difference
# 
# 
# a1NotIna2 <- sqldf('SELECT id FROM dfsql EXCEPT SELECT id FROM dfcsv')
# a2NotIna1 <- sqldf('SELECT id FROM dfcsv EXCEPT SELECT id FROM dfsql')
# a1NotIna2
# a2NotIna1

###############################################
# Risk free cashflow ##########################
###############################################
df1<-read.csv("loan.csv",skip=0,nrows=100000)
df2<-read.csv("loan.csv",skip=100000,nrows=100000,col.names=(colnames(read.csv("loan.csv",skip=0,nrows=1))))
df3<-read.csv("loan.csv",skip=200000,nrows=100000,col.names=(colnames(read.csv("loan.csv",skip=0,nrows=1))))
df4<-read.csv("loan.csv",skip=300000,nrows=100000,col.names=(colnames(read.csv("loan.csv",skip=0,nrows=1))))
df5<-read.csv("loan.csv",skip=400000,nrows=100000,col.names=(colnames(read.csv("loan.csv",skip=0,nrows=1))))
df6<-read.csv("loan.csv",skip=500000,nrows=100000,col.names=(colnames(read.csv("loan.csv",skip=0,nrows=1))))
df7<-read.csv("loan.csv",skip=600000,nrows=100000,col.names=(colnames(read.csv("loan.csv",skip=0,nrows=1))))
df8<-read.csv("loan.csv",skip=700000,nrows=100000,col.names=(colnames(read.csv("loan.csv",skip=0,nrows=1))))
df9<-read.csv("loan.csv",skip=800000,nrows=100000,col.names=(colnames(read.csv("loan.csv",skip=0,nrows=1))))
#887379
##REMOVE NULL
df0<-df9
df0<-df0[!is.na(df0$id),]
head(df0)
rm("df1","df2","df3","df4","df5","df6","df7","df8","df9")


#scrub
df0<-df0[,c("term","issue_d","installment")]
df0$term<-as.numeric(gsub("months","",gsub(" ","",df0$term)))
df0$installment<-as.numeric(df0$installment)
df0$issue_d<-as.Date(datefix(df0$issue_d),format = "%m-%d-%Y")
summary(df0$issue_d)

df.riskfree.ex <- df0[rep(row.names(df0), df0$term),]

#check
sum(df0$term)
nrow(df.riskfree.ex )

rm(df0)


df.riskfree.ex$mobtmp1<-as.numeric(gregexpr('[.]',row.names(df.riskfree.ex)))
df.riskfree.ex$mobtmp2<-nchar(row.names(df.riskfree.ex))
df.riskfree.ex$mob<-substrRight(row.names(df.riskfree.ex),df.riskfree.ex$mobtmp2-df.riskfree.ex$mobtmp1)
df.riskfree.ex$mob[df.riskfree.ex$mobtmp1==-1]<-0
df.riskfree.ex$mob<-as.numeric(df.riskfree.ex$mob)+1

df.riskfree.ex$m<- as.Date(df.riskfree.ex$issue_d+months(df.riskfree.ex$mob))
#df.riskfree.ex.dt<-as.data.table(df.riskfree.ex)

rf.cf<-dcast(df.riskfree.ex, m ~ term, value.var="installment", fun.aggregate	= sum)

rf.cf<-melt(rf.cf, id="m")
colnames(rf.cf)<-c("month","term","riskfree")
rf.cf$term<-paste(rf.cf$term,"month term",sep=" ")

plotly::plot_ly(rf.cf,x=rf.cf$month,color = rf.cf$term)%>%  
  add_lines(y=rf.cf$riskfree)

#rfcf1<-rf.cf
#save("rfcf1",file="rfcf1.R")
#rfcf2<-rf.cf
#save("rfcf2",file="rfcf2.R")
#rfcf3<-rf.cf
#save("rfcf3",file="rfcf3.R")
# rfcf4<-rf.cf
# save("rfcf4",file="rfcf4.R")
#rfcf5<-rf.cf
#save("rfcf5",file="rfcf5.R")
#rfcf6<-rf.cf
#save("rfcf6",file="rfcf6.R")
#rfcf7<-rf.cf
#save("rfcf7",file="rfcf7.R")
#rfcf8<-rf.cf
#save("rfcf8",file="rfcf8.R")
#rfcf9<-rf.cf
#save("rfcf9",file="rfcf9.R")


rfcf<-rbind(rfcf1,rfcf2)
rfcf<-rbind(rfcf,rfcf3)
rfcf<-rbind(rfcf,rfcf4)
rfcf<-rbind(rfcf,rfcf5)
rfcf<-rbind(rfcf,rfcf6)
rfcf<-rbind(rfcf,rfcf7)
rfcf<-rbind(rfcf,rfcf8)
rfcf<-rbind(rfcf,rfcf9)
rfcf<-rfcf[order(rfcf$term,rfcf$month),]

rfcf<-aggregate(rfcf$riskfree, by=list(rfcf$month,rfcf$term),FUN=sum, na.rm=TRUE)
colnames(rfcf)<-c("month","term","riskfree")

save("rfcf",file="rfcf.R")
plotly::plot_ly(rfcf,x=rfcf$month,color = rfcf$term)%>%  
  add_lines(y=rfcf$riskfree)

rm(df.riskfree.ex)

write.table(rfcf, "clipboard-128", sep="\t", row.names=FALSE)

head(rfcf)

#######################################
#check pmts vs rate vs term
#######################################
df1<-read.csv("loan.csv",skip=0,nrows=100000)
df2<-read.csv("loan.csv",skip=100000,nrows=100000,col.names=(colnames(read.csv("loan.csv",skip=0,nrows=1))))
df3<-read.csv("loan.csv",skip=200000,nrows=100000,col.names=(colnames(read.csv("loan.csv",skip=0,nrows=1))))
df4<-read.csv("loan.csv",skip=300000,nrows=100000,col.names=(colnames(read.csv("loan.csv",skip=0,nrows=1))))
df5<-read.csv("loan.csv",skip=400000,nrows=100000,col.names=(colnames(read.csv("loan.csv",skip=0,nrows=1))))
df6<-read.csv("loan.csv",skip=500000,nrows=100000,col.names=(colnames(read.csv("loan.csv",skip=0,nrows=1))))
df7<-read.csv("loan.csv",skip=600000,nrows=100000,col.names=(colnames(read.csv("loan.csv",skip=0,nrows=1))))
df8<-read.csv("loan.csv",skip=700000,nrows=100000,col.names=(colnames(read.csv("loan.csv",skip=0,nrows=1))))
df9<-read.csv("loan.csv",skip=800000,nrows=100000,col.names=(colnames(read.csv("loan.csv",skip=0,nrows=1))))
#887379
##REMOVE NULL
df0<-df1
df0<-df0[!is.na(df0$id),]

df0[1:5,1:5]
df0[1:5,6:10]

#installment


#######################################
#check pmts vs rate vs term
#######################################
df1$term<-as.numeric(gsub("months","",gsub(" ","",df1$term)))
df1$installment<-as.numeric(df1$installment)
df1$int_rate<-as.numeric(gsub(" ","",gsub("%","",df1$int_rate)))
df1$pv<-round(FinCal::pv(r=df1$int_rate/100/12,n=df1$term,fv = 0,pmt=df1$installment*-1),0)

#accounts do not reconcile. compliance issues...
df1[df1$pv!=df1$funded_amnt,]
