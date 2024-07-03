install.packages("dismo")
install.packages("maps")
install.packages("sf")
install.packages("concaveman")
install.packages("geodata")
install.packages("raster")
install.packages("here")
install.packages("remotes")
remotes::install_github("MoisesExpositoAlonso/rbioclim")
transformlong <- function(longitude) {
  result <- longitude
  k <- which(result < 0)
  result[k] <- 360 + result[k]
  return(result)
}
