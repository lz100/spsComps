# spsComps <img src="https://github.com/lz100/spsComps/blob/master/img/spscomps.png?raw=true" align="right" height="139" />

The {[systemPipeShiny](https://github.com/systemPipeR/systemPipeShiny)} (SPS) framework comes with many UI and server 
components. However, installing the whole framework is heavy and takes some time. If you 
would like to use UI and server components from SPS in your own Shiny apps, but do not want to 
install the whole framework, just install {spsComps}. 

**View the online demo**: https://lezhang.shinyapps.io/spsComps

## Install

Install release version from CRAN:

```r
install.packages("spsComps")
```

Develop version:

```r
if (!requireNamespace("spsComps", quietly=TRUE))
    remotes::install_github("lz100/spsComps")
```

## User manual 

Read details of these components on our website

- [UI](https://systempipe.org/sps/dev/ui/)
- [server](https://systempipe.org/sps/dev/server/)

## Other packages in systemPipeShiny

| Package | Description | Documents | Demo |
| --- | --- | --- | --- |
|<img src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/images/sps_small.png?raw=true" align="right" height="25" />[systemPipeShiny](https://github.com/systemPipeR/systemPipeShiny) | SPS main package |[website](https://systempipe.org/sps/)|[demo](https://tgirke.shinyapps.io/systemPipeShiny/)|
|<img src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/images/spscomps.png?raw=true" align="right" height="25" />[spsComps](https://github.com/lz100/spsComps) | SPS UI and server components |[website](https://systempipe.org/sps/dev/ui/)|[demo](https://lezhang.shinyapps.io/spsComps)|
|<img src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/images/spsutil.png?raw=true" align="right" height="25" />[spsUtil](https://github.com/lz100/spsUtil) | SPS utility functions |[website](https://systempipe.org/sps/dev/general/)|NA|
|<img src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/images/drawr.png?raw=true" align="right" height="25" />[drawR](https://github.com/lz100/drawR) | SPS interactive image editting tool |[website](https://systempipe.org/sps/canvas/)|[demo](https://lezhang.shinyapps.io/drawR)|
