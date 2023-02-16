print("Loading and recording sessionInfo now...")

# Load packages
list_of_package <- scan("package_list.txt", what="", sep="\n")

for (packages in list_of_package){
  lapply(packages,
         function(x) suppressMessages(library(x,
                                              character.only = TRUE,
                                              quietly=TRUE,
                                              warn.conflicts = FALSE)))
}


sessionInfoName <- "sessionInfo.txt"
writeLines(capture.output(sessionInfo()), sessionInfoName)
print("SessionInfo printed.")
