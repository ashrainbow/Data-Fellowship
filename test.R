Package: compendium
Version: 0.1.0
Depends: tidyverse, rmarkdown

f <- list.files(recursive = TRUE)
Rmds <- f[grepl(".Rmd$", f)]
lapply(Rmds, rmarkdown::render)