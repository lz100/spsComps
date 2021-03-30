# spsComps 0.2.0

## New features

-   `animateIcon`: create font-awesome icons with animations!

-   `animateUI`, `animateServer`: add animations to any HTML/Shiny element, one is called from the UI, one is called from the server side.

-   `animationRemove`: remove animations of an element, call from server only.

-   `cssLoader`: creates 12 different loaders to indicate busy status.

-   `shinyCatch`: now has this argument `trace_back`. It will log detailed traceback information on console if enabled. Similar to Rstudio's built-in traceback, it shows the function calls and file+line number if there is any.

## Bug fix 

-   `bsHoverPopover` now works on `body` tag instead of within the target element so that it will not be hidden if the parent of target has some overflow settings.

# spsComps 0.1.1

## Bug fix

-   fix links in shiny demo
-   fix `hrefTab` and `hrefTable` incompatible with Rmarkdown by replacing the \<a\> tag `href` from none to `javascript:null;`.

## Other

-   Remove `shinydashboardPlus` dependency. The 2.0.0 update breaks `progressPanel` entirely, rewrite it by ourselves.
-   Remove `shinydashboard` dependency. Rewrite the CSS by myself to reduce dependency.

# spsComps 0.1

## Major

-   Migrated from systemPipeShiny

## New features

-   Enhanced `gallery` arguments.

    -   Now allow users to enlarge pictures in 2 different ways.

-   New `textButton`, text input group with button

-   New `textInputGroup`, text input group with icon or text on both ends

-   Better *hover* effects on `hrefTab`, `hrefTable`, gallery, `hexLogo`, `hexPanel`

    -   hover effect change when there is no link attached to the item.

-   New arguments in **`updateSpsTimeline`** to allow users update up/down text in `spsTimeline`.

-   `pgPaneUI` no longer needs to work inside `shinydashboard::dashboardPage()`, dependencies automatically added when calls this function.

-   New `spsCodeBtn` function to create a button to show code in Shiny by a modal or a collapse element.

-   More styles and arguments added to `spsGoTop` button.

-   Rewrite some part of `spsValidate`, now it no longer requires users to return `TRUE` in the end of the expression. Anything returns at the end of the expression will be accepted. The way to fail the validation is to create error inside expression.
