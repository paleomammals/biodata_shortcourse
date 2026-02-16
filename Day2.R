
m1 <- bioclim(stack(climate),df[,c("lon","lat")])

p <- predict(climate,m1,progress = "text") # this line of code takes a minute or two to run.
p <- reload_raster(p)

plot(p, main = "Bioclim model", legend.args = list(text = 'Suitability', side = 4, 
                                                   font = 2, line = 2.5, cex = 0.8)) 

xrange <- range(df$lon,na.rm = T) + c(-1,1)
yrange <- range(df$lat,na.rm = T) + c(-5,5)

plot(p, main = "Bioclim model prediction",
     xlim = xrange, ylim = yrange,
     legend.args = list(text = 'Suitability', side = 4, 
                        font = 2, line = 2.5, cex = 0.8)) 
points(df$lon, df$lat, col=rgb(1,0,0,0.5), pch=20,cex=0.5)

# build linear model

# presence points
presvals <- extract(climate, df[,c("lon", "lat")])
presvals <- presvals[,-which(names(presvals)=="ID")]

# pseudo-absence points
set.seed(0)
backgr <- randomPoints(mask=raster(climate$bio1), 
                       n=max(nrow(df), 1000),
                       p=df[,c("lon", "lat")],
                       ext= extent(rbind(range(df$lon), range(df$lat)))
                       )


map("world2", col="darkgray",
    xlim=range(transform_lon(df$lon), na.rm=T)+c(-1,1),
    ylim=range(df$lat, na.rm=T)+c(-1,1))
map.axes()
points(transform_lon(backgr[, "x"]), 
       backgr[,"y"], 
       col="lightblue", pch=20)
points(transform_lon(df$lon), df[,"lat"], col="darkblue", pch=20)


absvals <- extract(climate, backgr)
pb<- c(rep(1, nrow(presvals)), rep(0, nrow(absvals)))

sdmdata <- data.frame(cbind(pb, rbind(presvals, absvals)))

m2 <- glm(pb ~ bio1 + bio2 + bio3 + bio4 + bio5 + bio6 + bio7 + 
            bio8 + bio9 + bio10 + bio11 + bio12 + bio13 + bio14 + 
            bio15 + bio16 + bio17 + bio18 + bio19, data = sdmdata)
summary(m2)

pvalues <- summary(m2)$coefficients[,4]
plot(pvalues, type="n")
text(pvalues, labels=0:19)
segments(0, 0.05, 21, 0.05, col="red", lty=2)

plotpredictors <- c("bio3", "bio12", "bio13")

par(mfrow=c(1,1))

for (i in plotpredictors){
  boxplot(sdmdata[[i]] ~ sdmdata$pb,
          xlab="species presence",
          ylab="value of bioclim variable",
          main=i)
}

q <- predict(climate, m2, progress = "text")
q <- reload_raster(q)

plot(q, main = "Linear model prediction",
     xlim=range(df$lon, na.rm=T),
     ylim=range(df$lat, na.rm=T))
points(df$lon, df$lat, col=rgb(1,0,0,0.5), pch=20, cex=0.5)


modelmatch <- data.frame(bioclim = extract(p, df[,c("lon", "lat")]),
                         linear = extract(q, df[,c("lon", "lat")]))

par(mfrow=c(2,1), mar=c(1,0,1,0))
hist(na.omit(modelmatch$bioclim/max(modelmatch$bioclim,na.rm = T)), col = "darkblue", main = "")
legend("topright",legend = names(modelmatch), col = c("darkblue","turquoise"), pch = 15)
hist(na.omit(modelmatch$linear/max(modelmatch$linear,na.rm = T)), col = "turquoise", main = "")


# Now we are starting to work with paleoclimate data

source('assemble-paleoclimate.R')

plot(lgm)
plot(lgm[[1]])
plot(lgm[[2]])

par(mfrow=c(1,1))
plot(lgm[[1]])

# UCM: 37.3647° N, 120.4242° W

UCM_lonlat <- data.frame(lon = -120.4242, lat = 37.3647)
UCM_lonlat
points(UCM_lonlat)

lgm_UCM <- extract(lgm, UCM_lonlat)
midH_UCM <- extract(midH, UCM_lonlat)
modern_UCM <- extract(modern, UCM_lonlat)
future_UCM <- extract(future, UCM_lonlat)

lgm_UCM

climate_UCM <- data.frame(rbind(lgm_UCM, midH_UCM, modern_UCM, future_UCM))

rownames(climate_UCM) <- c("lgm", "midH", "modern", "future")

climate_UCM

plot(climate_UCM$bio1)
par(mar=c(5,4,4,1)+0.1)

date <- c(-21000, -6000, 0, 50)
plot(x = date, y = climate_UCM$bio1,
     type="o",
     main = "Temperature at UCM Through Time",
     xlab = "Years before / after present",
     ylab = "BIO1: Annual Mean Temperature (degrees C)")


plot(x = date, y = climate_UCM$bio12,
     type="o",
     main = "Precipitation at UCM Through Time",
     xlab = "Years before / after present",
     ylab = "BIO12: Total Annual Precipitation (mm)")


# Morocco lonlat :  31.7917° N, 7.0926° W

Morocco_lonlat <- data.frame(lon = -7.0926, lat = 31.7917)
Morocco_lonlat
points(Morocco_lonlat)

lgm_Morocco <- extract(lgm, Morocco_lonlat)
midH_Morocco <- extract(midH, Morocco_lonlat)
modern_Morocco <- extract(modern, Morocco_lonlat)
future_Morocco <- extract(future, Morocco_lonlat)

lgm_Morocco

climate_Morocco <- data.frame(rbind(lgm_Morocco, midH_Morocco, modern_Morocco, future_Morocco))

rownames(climate_Morocco) <- c("lgm", "midH", "modern", "future")

climate_Morocco

plot(climate_Morocco$bio1)
par(mar=c(5,4,4,1)+0.1)

date <- c(-21000, -6000, 0, 50)
plot(x = date, y = climate_Morocco$bio1,
     type="o",
     main = "Temperature at Morocco Through Time",
     xlab = "Years before / after present",
     ylab = "BIO1: Annual Mean Temperature (degrees C)")


plot(x = date, y = climate_Morocco$bio12,
     type="o",
     main = "Precipitation at Morocco Through Time",
     xlab = "Years before / after present",
     ylab = "BIO12: Total Annual Precipitation (mm)")


# Starting paleo modeling

load("neotoma_lonlat.RData")
load("gbif.RData")

names(neotoma_lonlat)
names(gbif)

index <- 1

species_name <- names(gbif)[index]
species_name

data_lgm <- neotoma_lonlat[[index]]$LGM
data_midH <- neotoma_lonlat[[index]]$MidH
data_now <- gbif[[index]][,c("lon", "lat")]

#rm(gbif, neotoma_lonlat)

xrange <- transform_lon(range(c(data_lgm$lon, data_midH$lon, data_now$lon), na.rm=T)) + c(-1,1)
yrange <- range(c(data_lgm$lat, data_midH$lat, data_now$lat), na.rm=T) + c(-1,1)

require(maps)
map("world2", col="grey", xlim=xrange, ylim=yrange)
map.axes()
points(transform_lon(data_now$lon), data_now$lat, col="lightpink", pch=20, cex=0.8)
points(transform_lon(data_midH$lon),data_midH$lat,col = "darkorchid",pch = 20,cex = 0.8)
points(transform_lon(data_lgm$lon),data_lgm$lat,col = "blue",pch = 20,cex = 0.8)

legend(x = "bottomleft",legend = c("22,000 ybp (LGM)","6,000 ybp (Mid-Holocene)","Present"),pch = 20,col = c("blue","darkorchid","lightpink"), cex=0.75)





presvals22k <- extract(lgm, data_lgm[, c("long", "lat")])
presvals6k <- extract(midH, data_midH[, c("long", "lat")])
presvals0 <- extract(modern, data_now[, c("lon", "lat")])

presvals <- data.frame(rbind(presvals22k, presvals6k, presvals0))
dim(presvals)


set.seed(0) #initialize random number generator
backgr  <-  randomPoints(mask = modern, n = 5000, p = presvals) #this step can take a long time
absvals <- rbind(extract(lgm,backgr),
                 extract(midH,backgr),
                 extract(modern,backgr)) #extract climate values at those points
pb <- c(rep(1, nrow(presvals)), rep(0, nrow(absvals))) #make a vector that indicates whether the species is present at that point or not
sdmdata <- data.frame(cbind(pb, rbind(presvals, absvals))) #bind the presence and absence values together into a single data frame
colnames(sdmdata) <- c("pb",names(modern))


mod <- glm(pb ~ bio1 + bio2 + bio3 + bio4 + bio5 + bio6 + bio7 + bio8 + bio9 + bio10 + bio11 + bio12 + bio13 + bio14 + bio15 + bio16 + bio17 + bio18 + bio19, data = sdmdata)

names(midH) <- names(lgm) <- names(future) <- names(modern)

predlgm <- predict(lgm,mod,progress = "text")
predlgm <- rast(predlgm)

predmidH <- predict(midH,mod,progress = "text")
predmidH <- rast(predmidH)

prednow <- predict(modern,mod,progress = "text")
prednow <- rast(prednow)

pred2070 <- predict(future,mod,progress = "text")
pred2070 <- rast(pred2070)


# Plot the data

xrange <- range(c(data_lgm$lon,data_midH$lon,data_now$lon),na.rm = T) + c(-5,5)
yrange <- range(c(data_lgm$lat,data_midH$lat,data_now$lat),na.rm = T) + c(-5,5)

par(mfrow = c(2,2),mar = c(1,3,4,1))
plot(predlgm, main = "22,000 ya",xlim = xrange,ylim = yrange)
points(data_lgm$lon,data_lgm$lat,col = "lightblue",pch = 20,cex = 0.8)
plot(predmidH, main = "6,000 ya",xlim = xrange,ylim = yrange)
points(data_midH$lon,data_midH$lat,col = "darkorchid",pch = 20,cex = 0.8)
plot(prednow, main = "today",xlim = xrange,ylim = yrange)
points(data_now$lon,data_now$lat,col = "lightpink",pch = 20,cex = 0.8)
plot(pred2070, main = "2070 CE",xlim = xrange,ylim = yrange)
