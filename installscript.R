install.packages("dismo")
install.packages("maps")
install.packages("sf")
install.packages("concaveman")
install.packages("geodata")
install.packages("terra")
install.packages("raster")
install.packages("here")
install.packages("rJava")

transform_lon <- function(longitude) {
  result <- longitude
  k <- which(result < 0)
  result[k] <- 360 + result[k]
  return(result)
}
reload_raster <- function(rasterlayer) {
  filestring <- paste0(c("temp/",as.character(substitute(rasterlayer)),".tif"),collapse="")
  writeRaster(rasterlayer, filename = filestring, gdal = "COMPRESS=DEFLATE", overwrite = TRUE)
  return(raster(rast(filestring)))
}
