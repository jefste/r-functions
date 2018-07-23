# from: https://www.r-bloggers.com/installing-packages-without-internet/

#----Getting packages when connected------------------

#' Get package dependencies
#'
#' @param packs A string vector of package names
#'
#' @return A string vector with packs plus the names of any dependencies
getDependencies <- function(packs){
  dependencyNames <- unlist(
    tools::package_dependencies(packages = packs, db = available.packages(), 
                                which = c("Depends", "Imports"),
                                recursive = TRUE))
  packageNames <- union(packs, dependencyNames)
  packageNames
}
# Calculate dependencies
packages <- getDependencies(c("tidyverse", "lubridate","readxl","broom"))

# SIDENOTE: want to include "ReporteRs" in the future; 
# See installation note:https://davidgohel.github.io/ReporteRs/index.html#installation
#  ReporteRs needs rJava with a java version >= 1.6 ; make sure you have an installed JRE.
# END SIDENOTE

# Download the packages to the working directory.
# Package names and filenames are returned in a matrix.
# The files can be written directly to a USB drive, or just put on desktop.
# The folder that you create can be copied anywhere (say from desktop to USB drive) when ready to do the offline install
setwd("C:/Users/your_user_name/Desktop/offline r packages")

pkgInfo <- download.packages(pkgs = packages, destdir = getwd(), type = "win.binary")
# Save just the package file names (basename() strips off the full paths leaving just the filename)
write.csv(file = "pkgFilenames.csv", basename(pkgInfo[, 2]), row.names = FALSE)

#------------Installing packages offline------------------- 
# Assuming we’ve downloaded our packages to a USB stick or similar, on site and without an
# internet connection we can now install the packages from disk.

# Set working directory to the location of the package files
# in this case, an file on a usb disk
setwd("E:/offline r packages/")

# Read the package filenames and install
pkgFilenames <- read.csv("pkgFilenames.csv", stringsAsFactors = FALSE)[, 1]
install.packages(pkgFilenames, repos = NULL, type = "win.binary")

#Packages should now be installed. 
#Confirm that packages are installed by checking them out using library.
#Example:  library(tidyverse)  
