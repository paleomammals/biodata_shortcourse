#download GBIF data for last exercise
names<-c("Microtus pennsylvanicus", "Lynx rufus", "Lontra canadensis", 
         "Marmota flaviventris", "Erethizon dorsatum", 
         "Bison bison", "Blarina brevicauda", "Lepus californicus")
require(dismo)
gbifdata<-vector("list", length(names))
names(gbifdata)<-names
for (i in 1:length(names)){
  name<-unlist(strsplit(names[i]," "))
  print(c(names[i],gbif(name[1],name[2],download = F)))
  t<-gbif(name[1],name[2],geo=TRUE)
  gbifdata[[i]]<-subset(t,!is.na(t$lon) & !is.na(t$lat))
}

save(gbifdata,file="gbif-raw.RData")