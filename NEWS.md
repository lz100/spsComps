# spsComps 0.3.2.1

## Minor

-   Fix rds as requested by CRAN.

# spsComps 0.3.2.0

## New Features

-   `onNextInput`, a server callback that is run after next input value change. A hack to address [3348](https://github.com/rstudio/shiny/issues/3348).

# spsComps 0.3.1

## New Features

-   `incRv`, `multRv`, `diviRv`: reactive in-line numeric operations, like `i += 1`, `i *= 1`.
-   For server only functions, now attaching the JS and CSS dependency by adding `spsDepend("xxx")` on UI is not required anymore, it becomes optional. This process is handled internally. In case this will not work, users still have the option to attach the dependency manually via `spsDepend`.

## Bug fix

-   fix in `bsTooltip` and `bsPopover`, if text is defined in multiple lines and will cause js conflicts on calling the function. Now all line-change symbols are replaced before sending to js.
-   Fix some links and bugs in demos.
-   Fix text in `shinyCheckPkg`.
-   Fix Font Awesome introduced warnings

## Minor Change

-   Better help and examples for `shinyCatch`.

# spsComps 0.3.0

## New features

-   Add `animateAppend`, which allows users to add animations by pipe `%>%`

-   Add `animateAppendNested`, which allows users to add multiple animations to the same element by pipe `%>%`.

-   Custom loaders supported. A new `type`, `"gif"` is added to all loader functions. Users can choose this type and specify a remote URL or a local path to the gif file with the `src` argument to create their own custom loaders.

-   Rewrite `bsHoverPopover` and name it `bsPopover` and it's higher higher wrapper `bsPop`. This function allow users to create bootstrap3 Popover with deep customization, color, background, text size and more for each individual of them.

-   New function `bsTooltip` and `bsTip`: add a custom tooltip to any Shiny/ Rmarkdown element you want. You can change color, font size, position and more for each individual tooltip.

## Major change

-   Rewrite methods in `addLoader` class.

    -   Now it add the load to the document when first time `show` method is called instead of on class initialization. This solves the problem that some elements are not visible on app start so javascript functions cannot catch the dimensions to do the calculation.

    -   Add 2 new methods, `recreate` and `destroy`:

        -   `destroy` will remove the loader from the app (client side)

        -   `recreate` = `hide` + `destroy` + create a new loader, users can change type, color, method, etc and recalculate the loader dimensions.

    -   to reduce dependencies `loadDF`, `dynamicFile` and `dynamicFileServer` are moved to systemPipeShiny main package.

    -   Rewrite `spsTitle` and `spsHr`, now you can create colorful titles and horizontal divider lines with these two functions respectively.

## Minor change

-   add `…` argument to the `animateIcon`. Users can append additional attributes.
-   Now `animationRemove` can also remove animations add by `animateUI` and `animateIcon` functions.
-   Internal rewrite some functions so removed some imported packages.

# spsComps 0.2.0

## New features

-   `animateIcon`: create font-awesome icons with animations!

-   `animateUI`, `animateServer`: add animations to any HTML/Shiny element, one is called from the UI, one is called from the server side.

-   `animationRemove`: remove animations of an element, call from server only.

-   Loaders: 12 different loaders to indicate busy status.

    -   `cssLoader`: UI side function, directly add the load on UI when app starts

    -   `addLoader`: server side function, add loaders dynamically and control show and hide of the loader.

-   `shinyCatch`: now has this argument `trace_back`. It will log detailed traceback information on console if enabled. Similar to Rstudio's built-in traceback, it shows the function calls and file+line number if there is any.

-   Add target_blank argument for `gallery`, `hrefTab`, `hrefTable`, `hexLogo` and `hexPanel`: if `TRUE`, add `target="_blank"` to the link.

## Major Change

-   `gallery`:

    -   Change the `object-fil` of images from "cover" to "fill".

    -   Now image captions without link will be not clickable and color black.

    -   galleries with `enlarge` turned on will still have hover effects on all images but captions will be not clickable and color black for images without a link.

## Minor Change

## Bug fix

-   `bsHoverPopover` now works on `body` tag instead of within the target element so that it will not be hidden if the parent of target has some overflow settings.
-   `gallery`: Fix the height matching issues by adding the caption height in calculation. Now all images should be in the supposed rows.

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
