# 9/13/2022 her2@nih.gov
# Creating renv environment now

# initiate <- FALSE
if (initiate){
  
  auto.snapshot <- getOption("renv.config.auto.snapshot")
  options(renv.config.auto.snapshot = FALSE)
  
  renv::settings$snapshot.type("implicit")
  renv::init(bare = TRUE)
  print("Environment Initiated")
  
}else{
  
  print("Environment Not Initiated")
  
}