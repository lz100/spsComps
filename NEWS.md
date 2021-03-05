# spsComps 0.1.0.9

## Bug fix

-   fix links in shiny demo
-   fix `hrefTab` and `hrefTable` incompatible with Rmarkdown by replacing the \<a\> tag `href` from none to `javascript:null;`.

## Other

-   remove `shinydashboardPlus`. The 2.0.0 update breaks `progressPanel` entirely, rewrite it by ourselves.

# spsComps 0.1

## Major

-   Migrated from systemPipeShiny

## New features

-   Enhanced `gallery` arguments.

    -   Now allow users to enlarge pictures in 2 different ways.

-   New `textButton`, text input group with button

-   New `textInputGroup`, text input group with icon or text on both ends

-   Better *hover* effects on hrefTab, hrefTable, gallery, hexLogo, hexPanel

    -   hover effect change when there is no link attached to the item.

-   New arguments in **`updateSpsTimeline`** to allow users update up/down text in `spsTimeline`.

-   `pgPaneUI` no longer needs to work inside `shinydashboard::dashboardPage()`, dependencies automatically added when calls this function.

-   New `spsCodeBtn` function to create a button to show code in Shiny by a modal or a collapse element.

-   More styles and arguments added to `spsGoTop` button.

-   Rewrite some part of `spsValidate`, now it no longer requires users to return `TRUE` in the end of the expression. Anything returns at the end of the expression will be accepted. The way to fail the validation is to create error inside expression.
