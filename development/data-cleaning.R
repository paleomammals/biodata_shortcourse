neotomadata<-neotomadata[-which(names=="Synaptomys cooperi")]
save(neotomadata,file="neotoma-raw.RData")
gbifdata<-gbifdata[-which(names=="Synaptomys cooperi")]
save(gbifdata,file="gbif-raw.RData")

#clean GBIF data
require(maptools) #load the mapping library
data(wrld_simpl)
load("gbif-raw.RData")
gbif<-vector("list",length=length(gbifdata))

i<-8
df<-gbifdata[[i]]

plot(wrld_simpl,axes=TRUE,col="lightgreen",main=names[i],xlim=range(df$lon,na.rm=T), ylim=range(df$lat,na.rm=T))
points(df$lon,df$lat,col="red",pch=20)

obs<-which(!(df$basisOfRecord=="HUMAN_OBSERVATION" | df$basisOfRecord=="OBSERVATION"))
points(df[obs,]$lon,df[obs,]$lat,col="black",pch=21)
table(df[obs,"basisOfRecord"])
remove<-obs
df<-df[-remove,] #remove the incorrect points
rm(remove)
table(df$basisOfRecord)

test1<-which(df$lon > -10) #as many times as necessary
points(df[test1,]$lon,df[test1,]$lat,col="black",pch=21)
df[test1,c("lon","lat","country","adm1","basisOfRecord","year")]

test2<-which(df$lat < 30 & df$lon < -95)
points(df[test2,]$lon,df[test2,]$lat,col="black",pch=21)
df[test2,c("lon","lat","country","adm1","basisOfRecord","year")]
table(df[test2,"basisOfRecord"])

test3<-which(df$lat < 25)
points(df[test3,]$lon,df[test3,]$lat,col="black",pch=21)
df[test3,c("lon","lat","country","adm1","basisOfRecord")]

test3<-which(df$lat < 30)
points(df[test3,]$lon,df[test3,]$lat,col="black",pch=21)
df[test3,c("lon","lat","country","adm1","basisOfRecord")]

remove<-c(test1);df<-df[-remove,];rm(remove)

gbif[[i]]<-df

names(gbif)<-names(gbifdata)
save(gbif,file="gbif.RData")

rm(gbif,gbifdata)

#clean NeotomaDB data
#they don't really need it, they're fine
i<-1
j<-2
df<-neotoma_lonlat[[i]][[j]]
data(wrld_simpl)

plot(wrld_simpl,axes=TRUE,col="lightgreen",main=names[i],xlim=range(df$long,na.rm=T), ylim=range(df$lat,na.rm=T))
points(df$long,df$lat,col="red",pch=20)

test1<-which(df$long< -50 & df$long> -100) #as many times as necessary

remove<-c(test1)
df<-df[-remove,] #remove the incorrect points
rm(remove)

neotoma_lonlat[[i]][j]<-df
save(neotoma_lonlat,file="neotoma.RData")
rm(neotoma_lonlat)