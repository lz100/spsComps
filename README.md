# spsComps <img src="https://github.com/lz100/spsComps/blob/master/img/spscomps.png?raw=true" align="right" height="139" />

systemPipeShiny Components (spsComps) package is a collection of Shiny custom UI and 
server components. These components include different kinds of new inputs, buttons, animations,
progress loaders and more on the UI side. There are also components like exception handling, validation functions on server side. 

## Demos

| Demo | type | source code |
|---|---|---|
|[shiny](https://lezhang.shinyapps.io/spsComps)|shinyapps.io|[Github](https://github.com/lz100/spsComps/tree/master/examples/demo)|
|[Rmd](https://systempipe.org/sps/dev/spscomps/ui/)|Rmarkdown rendered|[Raw](https://raw.githubusercontent.com/systemPipeR/systemPipeR.github.io/main/content/en/sps/dev/spscomps/ui.Rmd)|

## Install

Install release version from CRAN:

```r
install.packages("spsComps")
```

Develop version:

```r
if (!requireNamespace("remotes", quietly=TRUE))
    install.packages("remotes")
remotes::install_github("lz100/spsComps")
```

## User manual 

- [User guide](https://systempipe.org/sps/dev/spscomps/)
- [Function references](https://systempipe.org/sps/sps_funcs/)

## Other packages in systemPipeShiny

| Package | Description | Documents | Function reference | Demo |
| --- | --- | --- | :---: | --- |
|<img src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/images/sps_small.png?raw=true" align="right" height="30" width="30"/>[systemPipeShiny](https://github.com/systemPipeR/systemPipeShiny) | SPS main package |[website](https://systempipe.org/sps/)|[link](https://systempipe.org/sps/funcs/sps/reference/)  | [demo](https://tgirke.shinyapps.io/systemPipeShiny/)|
|<img src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/images/spscomps.png?raw=true" align="right" height="30" width="30" />[spsComps](https://github.com/lz100/spsComps) | SPS UI and server components |[website](https://systempipe.org/sps/dev/spscomps/)|[link](https://systempipe.org/sps/funcs/spscomps/reference/)  | [demo](https://lezhang.shinyapps.io/spsComps)|
|<img src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/images/drawer.png?raw=true" align="right" height="30" width="30" />[drawer](https://github.com/lz100/drawer) | SPS interactive image editing tool |[website](https://systempipe.org/sps/dev/drawer/)|[link](https://systempipe.org/sps/funcs/drawer/reference/)  | [demo](https://lezhang.shinyapps.io/drawer)|
|<img src="https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/images/spsutil.png?raw=true" align="right" height="30" width="30" />[spsUtil](https://github.com/lz100/spsUtil) | SPS utility functions |[website](https://systempipe.org/sps/dev/spsutil/)|[link](https://systempipe.org/sps/funcs/spsutil/reference/)  | NA|

## some screenshots of spsComps

#### Animations

![animation](https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/spscomps/animations.gif?raw=true)

#### Loaders

![loader](https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/spscomps/loader.gif?raw=true)

#### Buttons

##### Code display button

![display_code](https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/spscomps/display_code.gif?raw=true)

##### Go top button

![gotop](https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/spscomps/gotop.gif?raw=true)

##### Input buttons

![buttons](https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/spscomps/buttons.png?raw=true)

##### Button groups

![buttons_tab](https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/spscomps/buttons_tab.png?raw=true)

##### Table of buttons

![buttons_table](https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/spscomps/buttons_table.png?raw=true)

#### Gallery

![gallery](https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/spscomps/gallery.png?raw=true)

#### Logos

![logos](https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/spscomps/logos.png?raw=true)

#### Progress tracking

##### Porgress panel

![pg_panel](https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/spscomps/pg_panel.gif?raw=true)

##### Timeline 

![timeline](https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/spscomps/timeline.gif?raw=true)

#### Tooltips

![tooltips](https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/spscomps/bstip.gif?raw=true)

![tooltips](https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/spscomps/bstip.png?raw=true)

#### Popovers

![popovers](https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/spscomps/bspopover.gif?raw=true)

![popovers](https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/spscomps/bspopover.png?raw=true)

#### Colorful titles

![spstitle](https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/spscomps/spstitle.png?raw=true)

#### Colorful divider lines

![spshr](https://github.com/systemPipeR/systemPipeR.github.io/blob/main/static/sps/img/spscomps/spshr.png?raw=true)

