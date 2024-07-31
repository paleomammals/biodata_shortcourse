#assemble climate layers into rasterstacks
require(raster); require(terra); require(here); require(geodata)

#Last glacial maximum, 22ka
filenames <- grep("tif$",list.files(here("paleoclimate/chelsa_LGM_v1_2B_r2_5m/"),full.names = T), value = T)
filenames <- filenames[c(1,12:19,2:11)]
lgm <- stack(filenames)
names(lgm) <- gsub("_","",names(lgm))

#Mid-Holocene, 6ka
filenames <- grep("tif$",list.files(here("paleoclimate/MH_v1_2_5m/"),full.names = T), value = T)
filenames <- filenames[c(1,12:19,2:11)]
midH <- stack(filenames)
names(midH) <- gsub("_","",names(midH))

#Modern, 1960-2000CE
modern <- worldclim_global(var = 'bio',res = 2.5,path = here())
modern <- stack(modern)
names(modern) <- unlist(sapply(1:19,function(x) paste0("bio",x)))

#Future, 2070CE
future <- cmip6_world(model = "MIROC-ES2L",ssp = "370",time = "2061-2080",
                      var = "bioc",res = 2.5,path = here())
future <- stack(future)
names(future) <- unlist(sapply(1:19,function(x) paste0("bio",x)))

#Save results
rm(filenames)
save(lgm,midH,modern,future,file = "climatelayers.RData")


