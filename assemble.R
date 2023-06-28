path <- file.path(system.file(package="dismo"), 'ex')
file <- list.files(path, pattern='biome.grd', full.names=TRUE )
biome <- raster(file)
bioclim <- addLayer(bioclim, biome)
