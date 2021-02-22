# only load things if you are working in Rstudio

if(interactive() & Sys.getenv("RSTUDIO", "") == "1"){
    (function(){
        if (!requireNamespace("devtools", quietly = TRUE)) {
            return(cat("Install {devtools} to develop this package\n"))
        }
        cat("Load package funcs...\n")
        devtools::load_all()
    })()
} else if (interactive()) {
    cat("It is recommended to use Rstudio to develop this package.\n")
}


