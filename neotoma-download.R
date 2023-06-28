#download Neotoma data
names<-c("Microtus pennsylvanicus", "Lynx rufus", "Lontra canadensis", 
         "Marmota flaviventris", "Erethizon dorsata", 
         "Bison bison", "Blarina brevicauda", "Lepus californicus")
#require(neotoma2)
neotomadata<-vector("list", length(names))
names(neotomadata)<-names
for (i in 1:length(names)){
  print(names[i])
  neotomadata[[i]]<-vector("list",2)
  names(neotomadata[[i]])<-c("LGM","MidH")
  neotomadata[[i]][1]<-get_sites(taxa=names[i],ageof=22000,all_data=T)
  neotomadata[[i]][2]<-get_sites(taxa=names[i],ageof=6000,all_data=T)
}

neotoma_longlat<-neotomadata
for (i in 1:length(neotomadata)){
  neotoma_longlat[[i]]$LGM<-coordinates(neotomadata[[i]]$LGM)
  neotoma_longlat[[i]]$MidH<-coordinates(neotomadata[[i]]$MidH)
  }

save(neotomadata,file="neotoma-raw.RData")
save(neotoma_lonlat,file="neotoma_lonlat.RData")