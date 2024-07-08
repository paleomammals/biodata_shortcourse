#this GCM reports temperature values in degC/10, very annoying, correct this

#LGM layers
filenames <- grep("tif$",list.files(here("uncorrected-paleoclimate/chelsa_LGM_v1_2B_r2_5m/"),full.names = T), value = T)
filenames <- filenames[c(1,12:19,2:11)]
filenames.new <- grep("tif$",list.files(here("paleoclimate/chelsa_LGM_v1_2B_r2_5m/"),full.names = T), value = T)
filenames.new <- filenames.new[c(1,12:19,2:11)]
tenthdegC <- c(1,2,4,5,7:11)
for (i in tenthdegC) {
  temp <- rast(filenames[i])
  temp <- temp/10
  writeRaster(temp, filename = filenames.new[i], overwrite = T, gdal = "COMPRESS=DEFLATE")
  rm(temp)
}

#MidH layers
filenames <- grep("tif$",list.files(here("uncorrected-paleoclimate/MH_v1_2_5m/"),full.names = T), value = T)
filenames <- filenames[c(1,12:19,2:11)]
filenames.new <- grep("tif$",list.files(here("paleoclimate/MH_v1_2_5m/"),full.names = T), value = T)
filenames.new <- filenames.new[c(1,12:19,2:11)]
tenthdegC <- c(1,2,4:11)
for (i in tenthdegC) {
  temp <- rast(filenames[i])
  temp <- temp/10
  writeRaster(temp, filename = filenames.new[i], overwrite = T, gdal = "COMPRESS=DEFLATE")
  rm(temp)
}

#forgot to compress
filenames <- list.files(here("paleoclimate_temp/"),recursive = T,full.names = T)
filenames.new <- list.files(here("paleoclimate/"),recursive = T,full.names = T)
I <- 1
pb = txtProgressBar(min = 0, max = length(filenames), initial = 0) 
for (i in I:length(filenames)) {
  temp <- rast(filenames[i])
  writeRaster(temp, filename = filenames.new[i], overwrite = T, gdal = "COMPRESS=DEFLATE")
  setTxtProgressBar(pb,i)
}
close(pb)
