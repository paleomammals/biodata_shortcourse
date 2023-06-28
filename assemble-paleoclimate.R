#assemble climate layers into rasterstacks
require(raster)
#Last glacial maximum, 22ka
filenames<-list.files("climatelayers/lgm/",full.names=T)
lgm<-stack(filenames)
#Mid-Holocene, 6ka
filenames<-list.files("climatelayers/midH/",full.names=T)
midH<-stack(filenames)
#Modern, 1960-2000CE
modern<-getData('worldclim',var='bio',res=2.5)
#Future, 2070CE
filenames<-list.files("climatelayers/future2070/",full.names=T)
future<-stack(filenames)
save(lgm,midH,modern,future,file="climatelayers.RData")



