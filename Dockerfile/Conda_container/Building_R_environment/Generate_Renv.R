# 9/13/2022 her2@nih.gov
# Creating renv environment now

#############################################################

print("Loading repos...")
repos <- c(CRAN = "https://cloud.r-project.org", 
           biocsoftv314 = "https://bioconductor.org/packages/3.14/bioc/",
           biocsoftv315 = "https://bioconductor.org/packages/3.15/bioc/",
           biocanadatav313 = "https://bioconductor.org/packages/3.14/data/annotation/",
           biocexpdatav314 = "https://bioconductor.org/packages/3.14/data/experiment/",
           biocworkflowv314 = "https://bioconductor.org/packages/3.14/workflows/")
options(repos = repos)
print("Repos loaded.")

###############################################################

print("Setting up plain R environment now...")

if(!file.exists("DESCRIPTION")){
  
  print("No existing DESCRIPTION file in current working directory:")
  print(getwd())
  print("Exiting Environment setup now.")
  
  auto.snapshot <- getOption("renv.config.auto.snapshot")
  options(renv.config.auto.snapshot = TRUE)
  break
  
}else{
  
  print("Installing Packages from DESCRIPTION now...")
  
  renv::install()
  
  print("Packages installed.")
  

  auto.snapshot <- getOption("renv.config.auto.snapshot")
  options(renv.config.auto.snapshot = TRUE)
  
}


