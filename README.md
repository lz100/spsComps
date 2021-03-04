# spsComps <img src="https://github.com/lz100/spsComps/blob/master/img/spscomps.png?raw=true" align="right" height="139" />

The {[systemPipeShiny](https://github.com/systemPipeR/systemPipeShiny)} (SPS) framework comes with many UI and server 
components. However, installing the whole framework is heavy and takes some time. If you 
would like to use UI and server components from SPS in your own Shiny apps, but do not want to 
install the whole framework, just install {spsComps} (systemPipeShiny Components). 

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

Read details of these components on our [website](https://systempipe.org/sps/dev/spscomps/)


## Other packages in systemPipeShiny

| Package | Description | Documents | Function reference | Demo |
| --- | --- | --- | :---: | --- |
|<img src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/images/sps_small.png?raw=true" align="right" height="30" width="30"/>[systemPipeShiny](https://github.com/systemPipeR/systemPipeShiny) | SPS main package |[website](https://systempipe.org/sps/)|[link](https://systempipe.org/sps/funcs/sps/reference/)  | [demo](https://tgirke.shinyapps.io/systemPipeShiny/)|
|<img src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/images/spscomps.png?raw=true" align="right" height="30" width="30" />[spsComps](https://github.com/lz100/spsComps) | SPS UI and server components |[website](https://systempipe.org/sps/dev/spscomps/)|[link](https://systempipe.org/sps/funcs/spscomps/reference/)  | [demo](https://lezhang.shinyapps.io/spsComps)|
|<img src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/images/drawer.png?raw=true" align="right" height="30" width="30" />[drawer](https://github.com/lz100/drawer) | SPS interactive image editing tool |[website](https://systempipe.org/sps/dev/drawer/)|[link](https://systempipe.org/sps/funcs/drawer/reference/)  | [demo](https://lezhang.shinyapps.io/drawer)|
|<img src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/images/spsutil.png?raw=true" align="right" height="30" width="30" />[spsUtil](https://github.com/lz100/spsUtil) | SPS utility functions |[website](https://systempipe.org/sps/dev/spsutil/)|[link](https://systempipe.org/sps/funcs/spsutil/reference/)  | NA|
