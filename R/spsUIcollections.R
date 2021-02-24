################## A Collections of HTML components#############################
# can be used outside SPS framework, like other shiny projects
## use on top of shiny


#' A shiny gallery component
#' @description Create a gallery to display images or photos
#'
#' `texts`, `hrefs`, `images` Must have the same length
#'
#' If there is any image that you do not want to add links, use `""` to occupy the space, e.g
#'
#' `hrefs = c("https://xxx.com", "", "https://xxx.com")`
#'
#' If the link is empty, there will be no hover effect on that image, and you cannot click it.
#'
#' Similar to `hrefs`, for the `texts`, use `""` to  occupy space
#'
#' @importFrom assertthat assert_that
#'
#' @param Id ID of this gallery
#' @param title Title of gallery
#' @param title_color Title color
#' @param texts vector of labels under each image
#' @param hrefs vector of links when each image is clicked
#' @param image_frame_size integer, 1-12, this controls width. How large is each
#' image. 12 is the whole width of the screen and 1 is 1/12 of the screen. Consider
#' numbers than can fully divide 12, like 1, 2, 3, 4, 6 or 12 (if you want only 1 image
#' per row).
#' @param images a vector of image sources, can be online urls or local resource paths.
#' @param enlarge bool,  when click on the image, enlarge
#' it? If enlarge is enabled, click the photo will enlarge intead of jump to the link.
#' Only the title below contains the link if enlarge is enabled.
#' @param enlarge_method  how the photo is enlarged on click,
#' one of "inline" -- within the gallery change the size of photo to 12, "modal" --
#' display photo in a pop-up modal.
#' @param style additional CSS style you want to add to the most outside component "div"
#'
#' @export
#' @return a gallery component
#'
#' @examples
#' if(interactive()){
#'   texts <- c("p1", "p2", "", "p4", "p5")
#'   hrefs <- c("https://unsplash.it/1200/768.jpg?image=251",
#'              "https://unsplash.it/1200/768.jpg?image=252",
#'              "",
#'              "https://unsplash.it/1200/768.jpg?image=254",
#'              "https://unsplash.it/1200/768.jpg?image=255")
#'   images <- c("https://unsplash.it/600.jpg?image=251",
#'               "https://unsplash.it/600.jpg?image=252",
#'               "https://unsplash.it/600.jpg?image=253",
#'               "https://unsplash.it/600.jpg?image=254",
#'               "https://unsplash.it/600.jpg?image=255")
#'   library(shiny)
#'
#'   ui <- fluidPage(
#'     column(
#'       6,
#'       gallery(texts = texts, hrefs = hrefs, images = images, title = "Default gallery"),
#'       spsHr(),
#'       gallery(texts = texts, hrefs = hrefs, images = images,
#'               image_frame_size = 2, title = "Photo size"),
#'       spsHr(),
#'       gallery(texts = texts, hrefs = hrefs, images = images,
#'               enlarge = TRUE, title = "Inline enlarge"),
#'       spsHr(),
#'       gallery(
#'         texts = texts, hrefs = hrefs, images = images,
#'         enlarge = TRUE, title = "Modal enlarge",
#'         enlarge_method = "modal"
#'       )
#'     )
#'   )
#'
#'   server <- function(input, output, session) {
#'
#'   }
#'
#'   shinyApp(ui, server)
#' }
gallery <- function(texts,
                    hrefs,
                    images,
                    Id = NULL,
                    title = "Gallery",
                    title_color = "#0275d8",
                    image_frame_size = 4,
                    enlarge = FALSE,
                    enlarge_method = c("inline", "modal"),
                    style = ""){

    if (is.null(Id)) Id <- glue("gallery{sample(1000000:9999999, 1)}")
    assertthat::assert_that(is.character(texts))
    assertthat::assert_that(is.character(hrefs))
    assertthat::assert_that(is.character(images))
    image_frame_size <- as.integer(image_frame_size)
    stopifnot(image_frame_size > 0 && image_frame_size <=12)
    stopifnot(is.logical(enlarge))
    assertthat::assert_that(
        length(texts) == length(hrefs) & length(hrefs) == length(images),
        msg = "texts, hrefs and images must have the same length")
    enlarge_method <- match.arg(enlarge_method, c("inline", "modal"))

    texts[texts == ""] <- "&nbsp;"
    hrefs_clean <- hrefs
    img_ids <- paste0(Id, "-", seq_len(length(hrefs)))
    hrefs[hrefs != ""] <- glue('href="{hrefs[hrefs != ""]}"')
    href_hover <- rep("", length(hrefs))
    href_hover[hrefs == ""] <- "gallery-nohover"

    gallery_div <- if(enlarge && enlarge_method == "inline") {
      HTML(glue('
      <div class="col-sm-{image_frame_size} sps-tab-link inline-enlarge" style="right: 1px;">
        <img src="{images}" class="img-gallery {href_hover}" height=300 width=400 style="width: 100%;">
        <a {hrefs}><p class="text-center h4">{texts}</p></a>
      </div>
      '))
    } else if (enlarge) {
      HTML(glue('
      <div  id={img_ids} class="col-sm-{image_frame_size} sps-tab-link" style="right: 1px;">
        <img
          src="{images}" class="img-gallery {href_hover}"
          height=300 width=400
          style="width: 100%;"
          onclick=galEnlarge("#{img_ids}")
        >
        <a {hrefs}><p class="text-center h4">{texts}</p></a>
      </div>
      '))
    } else {
      HTML(glue('
      <a {hrefs} class="col-sm-{image_frame_size} sps-tab-link" style="right: 1px;">
        <img src="{images}" class="img-gallery {href_hover}" height=300 width=400 style="width: 100%;">
        <p class="text-center h4">{texts}</p>
      </a>
      '))
    }

    div(
        id = Id, class = "col sps-gallery",
        style = style,
        p(class = "text-center h2",
          style = glue("color: {title_color};"),
          title),
        div(
            class = "row", style = "  margin: 10px;",
            gallery_div
        ),
        if(enlarge && enlarge_method == "modal") {
          singleton(
            div(
              id = "sps-gallery-modal",class = "gallery-modal",
              onclick = "galModalClose()",
              tags$span(
                class="gallery-modal-close",
                "X"
              ),
              tags$img(id="sps-gallery-modal-content", class="gallery-modal-content"),
              div(class = "gallery-caption")
            )
          )
        } else "",
        tags$script(glue('fixGalHeight("{Id}")')),
        spsDepend("basic")
    )
}


#' Display a list of links in a row of buttons
#' @description `hrefTab` creates a small section of link buttons
#' @importFrom assertthat assert_that
#'
#' @param Id optional element ID
#' @param title element title
#' @param title_color title color
#' @param label_texts individual tab labels
#' @param hrefs individual tab links
#' @param bg_colors individual tab button background color, either 1 value  to apply for all of
#' them or specify for each of them in a vector
#' @param text_colors individual tab button text color, either 1 value to apply for all of
#' them or specify for each of them in a vector
#' @param ... other arguments to be passed to the html element
#'
#' @return a Shiny component
#' @details
#' 1. `label_texts`, `hrefs` must be the same length
#' 2. If more than one value is provided for `bg_colors` or/and `text_colors`,
#' the length of these 2 vectors must be the same as `label_texts`
#' 3.  Use `""` to occupy the space if you do not want a label contains a link,
#' e.g `hrefs = c("https://google.com/", "", "")`
#' 4. If a label does not have a link, you cannot click it and there is no hovering
#' effects.
#' @export
#' @examples
#' if(interactive()){
#'     ui <- fluidPage(
#'         hrefTab(
#'             title = "Default",
#'             label_texts = c("Bar Plot", "PCA Plot", "Scatter Plot"),
#'             hrefs = c("https://google.com/", "", "")
#'         ),
#'         hrefTab(
#'             title = "Different background",
#'             label_texts = c("Bar Plot", "PCA Plot", "Scatter Plot"),
#'             hrefs = c("https://google.com/", "", ""),
#'             bg_colors = c("#eee", "orange", "green")
#'         ),
#'         hrefTab(
#'             title = "Different background and text colors",
#'             label_texts = c("Bar Plot", "Disabled", "Scatter Plot"),
#'             hrefs = c("https://google.com/", "", ""),
#'             bg_colors = c("green", "#eee", "orange"),
#'             text_colors = c("#caffc1", "black", "blue")
#'         )
#'     )
#'
#'     server <- function(input, output, session) {
#'
#'     }
#'     shinyApp(ui, server)
#' }
hrefTab <- function(label_texts,
                    hrefs,
                    Id = NULL,
                    title = "A list of tabs",
                    title_color = "#0275d8",
                    bg_colors = "#337ab7",
                    text_colors = "white",
                     ...
                    ){
    if (is.null(Id)) Id <- glue("list-tab{sample(1000000:9999999, 1)}")
    assert_that(is.character(bg_colors) && length(bg_colors) > 0)
    assert_that(is.character(text_colors) && length(text_colors) > 0)
    assert_that(length(label_texts) == length(hrefs),
                msg = "texts and hrefs must have the same length")
    if (length(bg_colors) > 1) assert_that(length(label_texts) == length(bg_colors))
    if (length(text_colors) > 1) assert_that(length(label_texts) == length(text_colors))

    hrefs[hrefs != ""] <- glue('href="{hrefs[hrefs != ""]}"')
    href_hover <- rep("", length(hrefs))
    href_hover[hrefs == ""] <- "nohover"

    div(
        id = Id, class = "col", ... ,
        p(class = "h4",
          style = glue("color: {title_color}; text-align: left;"),
          title),
        div(
            HTML(glue('
            <a
              {hrefs}
              class="href-button sps-tab-link {href_hover}"
              style="background-color: {bg_colors}; color: {text_colors};"
             >
              {label_texts}
            </a>\n
                '))
        ),
        spsDepend("basic")
    )
}

#' A table of hyper reference buttons
#' @description creates a table in Shiny which the cells are hyper reference (links)
#' buttons. This function is similar to [hrefTab], but that function only creates
#' a single row of link buttons, and this function creates a table of rows.
#'
#' The table has two columns, the first column is row names, second column is different
#' link buttons.
#' @details
#' 1. `item_titles`, `item_labels`, `item_hrefs` must have the same
#' length. Each vector in `item_labels`, `item_hrefs` must also have the same
#' length. For example, if we want to make a table of two rows, the first row
#' has 1 cell and the second row has 2 cells:
#'
#' ```
#'  hrefTable(
#'      item_titles = c("row 1", "row 2"),
#'      item_labels = list(c("cell 1"), c("cell 1", "cell 2")),
#'      item_hrefs = list(c("link1"), c("link1", "link2")
#'  )
#' ```
#'
#' 2. If `item_title_colors`, `item_text_colors` are given more than one value,
#' the list must have the same length as `item_titles`, and length of each vector
#' in the list must match the vector in `item_labels` in the same order.
#' 3. If  `item_title_colors` is given more than one value, the vector must have
#' the same length as `item_titles`.
#' 4.  Use `""` to occupy the space if you do not want a label contains a link,
#' e.g `item_hrefs = list(c("https://www.google.com/"), c("", ""))`
#' 5. If a label does not have a link, you cannot click it and there is no hovering
#' effects.
#' @importFrom assertthat assert_that
#'
#' @param Id optional ID
#' @param title title of this table
#' @param item_titles vector of strings, a vector of titles for table row names
#' @param item_labels list, a list of character vectors to specify button
#' labels in each table row, one vector per row
#' @param item_hrefs list, a list  of character vectors to specify button hrefs
#' links in each table row, one vector per row
#' @param item_bg_colors a single character value or a list, a list  of character
#' vectors to specify button background colors in each table row, one vector per row
#' @param item_text_colors  a single character value or a list, a list  of character
#' vectors to specify button text colors in each table row, one vector per row
#' @param first_col_name first column name
#' @param second_col_name second column name
#' @param title_color table title color
#' @param ... other HTML param you want to pass to the table
#' @param item_title_colors  a single character value or a character vector to
#' specify button title text colors of each row name
#'
#' @export
#' @return HTML elements
#' @examples
#' if(interactive()){
#'     ui <- fluidPage(
#'         hrefTable(
#'             title = "default",
#'             item_titles = c("workflow 1", "unclickable"),
#'             item_labels = list(c("tab 1"), c("tab 3", "tab 4")),
#'             item_hrefs = list(c("https://www.google.com/"), c("", ""))
#'         ),
#'         hrefTable(
#'             title = "Change button color and text color",
#'             item_titles = c("workflow 1", "No links"),
#'             item_labels = list(c("tab 1"), c("tab 3", "tab 4")),
#'             item_hrefs = list(c("https://www.google.com/"), c("", "")),
#'             item_bg_colors =  list(c("blue"), c("red", "orange")),
#'             item_text_colors =  list(c("black"), c("yellow", "green"))
#'         ),
#'         hrefTable(
#'             title = "Change row name colors and width",
#'             item_titles = c("Green", "Red", "Orange"),
#'             item_labels = list(c("tab 1"), c("tab 3", "tab 4"), c("tab 5", "tab 6", "tab 7")),
#'             item_hrefs = list(
#'                 c("https://www.google.com/"),
#'                 c("", ""),
#'                 c("https://www.google.com/", "https://www.google.com/", "")
#'             ),
#'             item_title_colors = c("green", "red", "orange"),
#'             style = "width: 50%"
#'         )
#'
#'     )
#'
#'     server <- function(input, output, session) {
#'
#'     }
#'
#'     shinyApp(ui, server)
#' }
hrefTable <- function(item_titles,
                      item_labels,
                      item_hrefs,
                      item_title_colors = "#0275d8",
                      item_bg_colors = "#337ab7",
                      item_text_colors = "white",
                      Id = NULL,
                      first_col_name = "Category",
                      second_col_name = "Options",
                      title = "A Table buttons with links",
                      title_color = "#0275d8",
                      ...) {

    if (is.null(Id)) Id <- glue("list-table{sample(1000000:9999999, 1)}")
    assert_that(is.character(item_title_colors) && length(item_title_colors) > 0)
    if(length(item_title_colors) > 1) assert_that(length(item_title_colors) == length(item_titles))
    assert_that(length(item_bg_colors) > 0)
    item_length <- lapply(item_labels, length)
    if(length(item_bg_colors) > 1) {
        assert_that(is.list(item_bg_colors))
        mapply(function(len, color){
            assert_that(is.character(color))
            assert_that(
                length(color) == len,
                msg = "vectors in item_bg_colors has different length than vectors in  item_labels"
            )
        },
        item_length, item_bg_colors
        )
    }
    assert_that(length(item_text_colors) > 0)
    if(length(item_text_colors) > 1) {
        assert_that(is.list(item_text_colors))
        mapply(function(len, color){
            assert_that(is.character(color))
            assert_that(
                length(color) == len,
                msg = "vectors in item_text_colors has different length than vectors in  item_labels"
            )
        },
        item_length, item_text_colors
        )
    }


    assert_that(is.list(item_labels)); assert_that(is.list(item_hrefs))
    assert_that(length(item_titles) == length(item_labels) &
                    length(item_labels) == length(item_hrefs),
                msg = glue("item_titles, item_labels and ",
                            "item_hrefs must have the same length"))

    mapply(
        function(label, href) {
            assert_that(length(href) == length(label),
                        msg = paste0("'", paste0(label, collapse = ", "),
                                     "' must have the same length as '",
                                     paste0(href, collapse = ", "), "'")
                        )
            },
        item_labels, item_hrefs
        )
    btns <- mapply(
        function(label, href, bg_color, text_color) {
            href[href != ""] <- glue('href="{href[href != ""]}"')
            href_hover <- rep("", length(href))
            href_hover[href == ""] <- "nohover"
            glue('
            <a
              {href}
              class="href-button {href_hover} sps-tab-link"
              style="background-color: {bg_color}; color: {text_color};"
            >
              {label}
            </a>'
            ) %>% glue::glue_collapse()
            },
        item_labels, item_hrefs, item_bg_colors,item_text_colors
        )
    tags$table(
        id = Id, class = "table table-hover table-href table-striped",
        ...,
        tags$caption(class = "text-center h2",
                     style = glue("color: {title_color};"),
                     title),
        HTML(glue('<thead>
                <tr class="info">
                  <th>{first_col_name}</th>
                  <th>{second_col_name}</th>
                </tr>
              </thead>')),
       tags$tbody(HTML(glue(
       '
          <tr>
            <td class="h4" style="color: {item_title_colors};">{item_titles}</td>
            <td>{btns}</td>
          </tr>\n
        '
        ))),
       spsDepend("basic")
    )
}


#' Render some collapsible markdown text
#' @description write some text in markdown format and it will help you
#' render to markdown, use [shiny::markdown] but it is collapsible.
#' @param desc one character string in markdown format
#' @param id element ID
#' @export
#' @return HTML elements
#' @examples
#' if(interactive()){
#'     desc <-
#'         "
#'     # Some desc
#'     - xxxx
#'     - bbbb
#'
#'     This is a [link](https://www.google.com/).
#'
#'     `Some other things`
#'     > other markdown things
#'
#'     1. aaa
#'     2. bbb
#'     3. ccc
#'     "
#'     ui <- fluidPage(
#'         renderDesc(id = "desc", desc),
#'     )
#'
#'     server <- function(input, output, session) {
#'
#'     }
#'
#'     shinyApp(ui, server)
#' }
renderDesc <- function(id, desc) {
    tagList(
        HTML(glue('
        <div class="desc">
          <div class="collapse desc-body" id="{id}" aria-expanded="false">
           {HTML(markdown(glue(desc, .open = "@{", .close = "}@")))}
          </div>

          <a role="button" class="collapsed" data-toggle="collapse"
             href="#{id}" aria-expanded="false" aria-controls="{id}">
          </a>
        </div>
      ')),
      spsDepend("basic")
    )
}


#' hr line with color #3b8dbc38
#' @export
#' @return HTML <hr> element
#' @examples
#' spsHr()
spsHr <- function() {
    hr(style ='border: 0.5px solid #3b8dbc38;')
}


#' @rdname hexPanel
#' @param hex_img single value of `hex_imgs`
#' @param hex_link single value of `hex_links`
#' @param footer single value of `footers`
#' @param footer_link single value of `footer_links`
#' @param x number, X offset, e.g. "-10" instead of -10L
#' @param y number, Y offset
#' @export
hexLogo <- function(id, title="", hex_img, hex_link = "" ,
                    footer = "", footer_link= "", x="-10", y="-20"){
    title_text <- if(!emptyIsFalse(title)) ''
    else glue('<span class="text-info">{title}</span><br>')
    hex <-  if(!emptyIsFalse(hex_link)) {
        glue('<polygon points="50 1 95 25 95 75 50 99 5 75 5 25"',
             'fill="url(#{id}-hex)" stroke="var(--primary)"',
             'stroke-width="2"/>')
    } else {
        glue('<a href="{hex_link}" target="_blank">',
             '<polygon class="hex" points="50 1 95 25 95 75 50 99 5 75 5 25"',
             'fill="url(#{id}-hex)" stroke="var(--primary)"',
             'stroke-width="2"/></a>')
    }
    footer_link <- if(!emptyIsFalse(footer_link)) '' else glue('href="{footer_link}"')
    footer_class <- if(emptyIsFalse(footer_link)) 'powerby-link' else 'powerby-link nohover'
    footer_text <- if(!emptyIsFalse(footer)) ''
    else glue('<text x=10 y=115><a class="{footer_class}"',
              '{footer_link} target="_blank">{footer}</a></text>')
    tagList(
        HTML(glue('
        <div id="{id}" class="hex-container">
          {title_text}
          <svg class="hex-box" viewBox="0 0 100 115" version="1.1" xmlns="http://www.w3.org/2000/svg">
            <defs>
              <pattern id="{id}-hex" patternUnits="userSpaceOnUse" height="100%" width="100%">
                <image href="{hex_img}" x="{x}" y="{y}" height="125%" width="125%" />
              </pattern>
            </defs>
            {hex}
            {footer_text}
          </svg>
        </div>
         ')),
        spsDepend("basic")
    )

}


#' Hexagon logo and logo panel
#' @description Shiny UI widgets to generate hexagon logo(s).
#' [hexLogo()] generates a single hexagon, and [hexPanel()]
#' generates a panel of hex logos
#' @param id input ID
#' @param title title of the logo, display on top of logo or title of logo panel
#' displayed on the left
#' @param hex_imgs a character vector of logo image source, can be online or
#' local, see details
#' @param hex_links a character vector of links attached to each logo, if not
#' `NULL`, must be the same length as `hex_imgs`
#' @param hex_titles similar to `hex_links`, titles of each logo
#' @param footers a character vector of footer attached to each logo
#' @param footer_links a character vector of footer links, if not `NULL`,
#' must be the same length as `footers`
#' @param xs a character vector X coordinate offset value for each logo image,
#' default -10, mist be the same length as `hex_imgs`
#' @param ys Y coordinates offset, must be the same length as `xs`, default -20
#' @details
#' The image in each hexagon is resized to the same size as the hex border
#' and then enlarged 125%. You may want to use x, y offset value to change
#' the image position.
#'
#' If your image source is local, you need to add your local directory to the
#' shiny server, e.g. `addResourcePath("sps", "www")`. This example add `www`
#' folder under my current working directory as `sps` to the server. Then you
#' can access my images by `hex_imgs = "sps/my_img.png"`.
#'
#' some args in `hexPanel` are character vectors, use `NULL` for the default
#' value. If you want to change value but not all of your logos, use `""` to
#' occupy space in the vector. e.g. I have 3 logos, but I only want to add
#' 2 footer and only 1 footer has a link:
#' `footers = c("footer1", "footer2", "")`,
#' `footer_links = c("", "https://mylink", "")`. By doing so  `footers` and
#' `footer_links` has the same required length.
#'
#' @export
#' @return HTML elements
#' @importFrom assertthat not_empty assert_that
#' @examples
#' if(interactive()){
#'     ui <- fluidPage(
#'         hexLogo(
#'             "logo", "Logo",
#'             hex_img = "https://live.staticflickr.com/7875/46106952034_954b8775fa_b.jpg",
#'             hex_link = "https://www.google.com",
#'             footer = "Footer",
#'             footer_link = "https://www.google.com"
#'         ),
#'         hexLogo(
#'             "x", "Change X offset",
#'             hex_img = "https://live.staticflickr.com/7875/46106952034_954b8775fa_b.jpg",
#'             x = "40"
#'         ),
#'         hexLogo(
#'             "y", "Change Y offset",
#'             hex_img = "https://live.staticflickr.com/7875/46106952034_954b8775fa_b.jpg",
#'             y = "-60"
#'         ),
#'         hexPanel(
#'             "demo1", "basic panel:" ,
#'             rep("https://live.staticflickr.com/7875/46106952034_954b8775fa_b.jpg", 2)
#'
#'         ),
#'         hexPanel(
#'             "demo2", "panel with links:" ,
#'             c(paste0("https://d33wubrfki0l68.cloudfront.net/",
#'               "2c6239d311be6d037c251c71c3902792f8c4ddd2/12f67/css/images/hex/ggplot2.png"),
#'               paste0("https://d33wubrfki0l68.cloudfront.net/",
#'               "621a9c8c5d7b47c4b6d72e8f01f28d14310e8370/193fc/css/images/hex/dplyr.png")
#'             ),
#'             c("https://ggplot2.tidyverse.org/", "https://dplyr.tidyverse.org/"),
#'             c("ggplot2", "dplyr")
#'         ),
#'         hexPanel(
#'             "demo3", "footer with links:" ,
#'             rep("https://live.staticflickr.com/7875/46106952034_954b8775fa_b.jpg", 2),
#'             footers = c("hex1", "hex2"),
#'             footer_links = rep("https://www.google.com", 2)
#'         ),
#'         hexPanel(
#'             "demo4", "panel offsets" ,
#'             hex_imgs = rep("https://live.staticflickr.com/7875/46106952034_954b8775fa_b.jpg", 4),
#'             footers = paste0("hex", 1:4),
#'             ys = seq(-20, -50, by = -10),
#'             xs = seq(20, 50, by = 10)
#'         )
#'     )
#'     server <- function(input, output, session) {
#'     }
#'     shinyApp(ui, server)
#' }
hexPanel <- function(id, title, hex_imgs, hex_links=NULL, hex_titles = NULL,
                     footers=NULL, footer_links=NULL, xs=NULL, ys=NULL){
    if(not_empty(hex_titles)) assert_that(length(hex_titles) == length(hex_imgs))
    if(not_empty(hex_links)) assert_that(length(hex_imgs) == length(hex_links))
    if(not_empty(footers)) assert_that(length(footers) == length(hex_imgs))
    if(not_empty(footer_links)) assert_that(length(footers) == length(footer_links))
    if(not_empty(xs)) assert_that(length(hex_imgs) == length(xs))
    if(not_empty(ys)) assert_that(length(hex_imgs) == length(ys))

    if(is.null(xs)) xs <- rep("-10", length(hex_imgs))
    if(is.null(ys)) ys <- rep("-20", length(hex_imgs))
    lapply(seq_along(hex_imgs), function(i){
        div(class="hex-item",
            hexLogo(id = paste0(id, i), title = hex_titles[i],
                    hex_img = hex_imgs[i], hex_link = hex_links[i],
                    footer = footers[i], footer_link = footer_links[i],
                    x = xs[i], y=ys[i])
        )
    }) %>% {
        fluidRow(class = "hex-panel",
                 h5(class = "text-primary", title),
                 tagList(.)
        )
    }
}

#' h2 title with bootstrap info color
#' @description Mostly used under SPS framework to create the tab title.
#' @param title title text
#' @param ... other attributes and children to this element
#' @return a h2 level heading with bootstrap4 "info" color(bt4 color not the
#' default bt3 info color)
#' @export
#'
#' @examples
#' tabTitle("This title")
tabTitle <- function(title, ...){
    h2(title, style = "color:#17a2b8;", ...)
}



#' Bootstrap popover trigger on hover instead of click
#' @description enhanced Bootstrap 3 popover by hovering, see
#' [bsplus::bs_embed_popover] for details. Everything is similar but has
#' additional trigger method, default "hover". Original method only works with
#' "click" on buttons.
#' @param tag [htmltools::tag], generally htmltools::tags$button() or htmltools::tags$a(),
#' or [shiny::actionButton()]
#' @param title character, title for the popover, generally text
#' @param content character, content for the popover body, can be HTML
#' @param placement character, placement of the popover with respect to `tag`
#' @param trigger trigger method, default "hover", one of click | hover |
#' focus | manual.
#' @param ... other named arguments, passed to [bsplus::bs_set_data()]
#' @importFrom bsplus bs_embed_popover
#' @return shiny element
#' @export
#'
#' @examples
#' if(interactive()){
#'     library(shiny)
#'     ui <- fluidPage(
#'         column(2),
#'         column(
#'             8,
#'             actionButton('a', 'On button') %>%
#'                 bsHoverPopover(
#'                     title = "title a",
#'                     content = "popover works on a button",
#'                     placement = "bottom"
#'                 ),
#'             tags$a("On link") %>%
#'                 bsHoverPopover(
#'                     title = "title b",
#'                     content = "popover works on a link",
#'                     placement = "bottom"
#'                 )
#'         )
#'
#'     )
#'     server <- function(input, output, session) {}
#'     shinyApp(ui, server)
#' }
bsHoverPopover <- function(
    tag, title = NULL, content = NULL, placement = "top", trigger="hover", ...){
    tagList(
        bsplus::bs_embed_popover(
            tag, title = title, content = content, placement = placement, ...) %>%{
                if(trigger == "hover")
                    tagAppendAttributes(., `pop-toggle` = trigger)
                else tagAppendAttributes(., `data-trigger` = trigger)
            },
        spsDepend("pop-tip")
    )
}


# internal css loader unit
spsLoader <- function(id=NULL){
    if(is.null(id)) id = paste0("loader", sample(1000000, 1))
    tagList(
        singleton(
            tags$style('
            .sps-loader {
              height: auto;
              display: inline-block;
              align-items: center;
              justify-content: center;
            }
            .sps-loader .container {
              width: 80px;
              height: 60px;
              text-align: center;
              font-size: 10px;
            }
            .sps-loader .container .boxLoading {
              background-color: #3c8dbc;
              height: 100%;
              width: 6px;
              display: inline-block;
              -webkit-animation: sps-loading 1.2s infinite ease-in-out;
              animation: sps-loading 1.2s infinite ease-in-out;
            }
            .sps-loader .container .boxLoading2 {
              -webkit-animation-delay: -1.1s;
              animation-delay: -1.1s;
            }
            .sps-loader .container .boxLoading3 {
              -webkit-animation-delay: -1s;
              animation-delay: -1s;
            }
            .sps-loader .container .boxLoading4 {
              -webkit-animation-delay: -0.9s;
              animation-delay: -0.9s;
            }
            .sps-loader .container .boxLoading5 {
              -webkit-animation-delay: -0.8s;
              animation-delay: -0.8s;
            }

            @-webkit-keyframes sps-loading {
              0%,
              40%,
              100% {
                -webkit-transform: scaleY(0.4);
              }
              20% {
                -webkit-transform: scaleY(1);
              }
            }
            @keyframes sps-loading {
              0%,
              40%,
              100% {
                transform: scaleY(0.4);
                -webkit-transform: scaleY(0.4);
              }
              20% {
                transform: scaleY(1);
                -webkit-transform: scaleY(1);
              }
            }
          ')
        ),
        tags$div(
            id = id, class = "sps-loader",
            HTML('
            <div class="container">
                <div class="boxLoading boxLoading1"></div>
                <div class="boxLoading boxLoading2"></div>
                <div class="boxLoading boxLoading3"></div>
                <div class="boxLoading boxLoading4"></div>
                <div class="boxLoading boxLoading5"></div>
            </div>
           ')
        )
    )
}


#' Match height of one element to the other element
#' @description Match the height of one element to the second element.
#' If the height of second element change, the height of first element will change
#' automatically
#' @param div1 element ID, or jquery selector if `isID = FALSE`. The first element
#' that you want to match the height to the other element
#' @param div2 matched element ID or selector, the other element
#' @param isID bool, if `TRUE`, `div1` and `div2` will be treated as ID, otherwise
#' you can use complex jquery selector
#'
#' @return will be run as javascript
#' @export
#'
#' @examples
#' if(interactive()){
#'     library(shiny)
#'     library(shinyjqui)
#'     ui <- fluidPage(
#'         column(
#'             3, id = "a",
#'             style = "border: 1px black solid; background-color: gray;",
#'             p("This block's height is matched with orange one")
#'         ),
#'         shinyjqui::jqui_resizable(column(
#'             2, id ="b",
#'             style = "border: 1px black solid; background-color: orange;",
#'             p("drag the bottom-right corner")
#'         )),
#'         column(
#'             3, id = "c",
#'             style = "border: 1px black solid; background-color: red;",
#'             p("This block's is not matched with others")
#'         ),
#'         heightMatcher("a", "b"),
#'         spsDepend("basic", css = FALSE),
#'         spsDepend("basic", js = FALSE)
#'     )
#'
#'     server <- function(input, output, session) {
#'
#'     }
#'     # Try to drag `b` from bottom right corner and see what happens to `a`
#'     shinyApp(ui, server)
#' }
heightMatcher <- function(div1, div2, isID=TRUE){
    if(isID) {
        div1 <- paste0("#", div1)
        div2 <- paste0("#", div2)
    }
    tagList(
        tags$script(paste0(
            'heightMatcher("', div1, '",', ' "', div2, '")'
        )),
        spsDepend("basic", css = FALSE)
    )

}


#' Go top button
#' @description add a go top button on your shiny app. When the user clicks the
#' button, scroll the window all the way to the top. Just add this function anywhere
#' in you UI.
#'
#' @details The button hides if you are on very top of the page. If you scroll
#' down 50px, this button will appear.
#' @param id element ID
#' @param icon [shiny::icon] if you do not want to use the default rocket image
#' @param right character string, css style, the button's position to window right
#' @param bottom character string, css style, the button's position to window bottom
#' @param color color of the icon.
#'
#' @return a shiny component
#' @export
#' @examples
#' if(interactive()){
#'     library(shiny)
#'
#'     ui <- fluidPage(
#'         h1("Scroll the page..."),
#'         lapply(1: 100, function(x) br()),
#'         spsGoTop("default"),
#'         spsGoTop("mid", right = "50%",  bottom= "50%", icon = icon("home"), color = "red"),
#'         spsGoTop("up", right = "95%",  bottom= "95%", icon = icon("arrow-up"), color = "green")
#'     )
#'
#'     server <- function(input, output, session) {
#'
#'     }
#'
#'     shinyApp(ui, server)
#' }
spsGoTop <- function(
    id = "gotop",
    icon = NULL,
    right = "1rem",
    bottom = "10rem",
    color = "#337ab7"
    ){
    inner <-
        if (inherits(icon, "shiny.tag")) icon
        else HTML('
          <svg viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg">
            <path d="M526.60727968 10.90185116
              a27.675 27.675 0 0 0-29.21455937 0
              c-131.36607665 82.28402758-218.69155461 228.01873535-218.69155402
              394.07834331a462.20625001 462.20625001 0 0 0 5.36959153 69.94390903
              c1.00431239 6.55289093-0.34802892 13.13561351-3.76865779 18.80351572-32.63518765
              54.11355614-51.75690182 118.55860487-51.7569018 187.94566865a371.06718723 371.06718723 0 0 0 11.50484808 91.98906777
              c6.53300375 25.50556257 41.68394495 28.14064038 52.69160883 4.22606766 17.37162448-37.73630017
              42.14135425-72.50938081 72.80769204-103.21549295 2.18761121 3.04276886 4.15646224 6.24463696
              6.40373557 9.22774369a1871.4375 1871.4375 0 0 0 140.04691725 5.34970492 1866.36093723 1866.36093723 0 0 0 140.04691723-5.34970492
              c2.24727335-2.98310674 4.21612437-6.18497483 6.3937923-9.2178004 30.66633723 30.70611158
              55.4360664 65.4791928 72.80769147 103.21549355 11.00766384 23.91457269 46.15860503 21.27949489
              52.69160879-4.22606768a371.15156223 371.15156223 0 0 0
              11.514792-91.99901164c0-69.36717486-19.13165746-133.82216804-51.75690182-187.92578088-3.42062944-5.66790279-4.76302748-12.26056868-3.76865837-18.80351632a462.20625001
              462.20625001 0 0 0 5.36959269-69.943909c-0.00994388-166.08943902-87.32547796-311.81420293-218.6915546-394.09823051zM605.93803103
              357.87693858a93.93749974 93.93749974 0 1 1-187.89594924 6.1e-7 93.93749974 93.93749974 0 0 1 187.89594924-6.1e-7z">
            </path>
            <path d="M429.50777625 765.63860547C429.50777625 803.39355007 466.44236686
              1000.39046097 512.00932183 1000.39046097c45.56695499 0 82.4922232-197.00623328
              82.5015456-234.7518555 0-37.75494459-36.9345906-68.35043303-82.4922232-68.34111062-45.57627738-0.00932239-82.52019037
              30.59548842-82.51086798 68.34111062z">
            </path>
          </svg>
        ')
    div(
        class="sps-gotop",
        id=id,
        style = glue(
            .open = "@{", .close = "}@",
        '
        right: @{right}@;
        bottom: @{bottom}@;
        @{if(inherits(icon, "shiny.tag")) "color:" else "fill:"}@ @{color}@;
        '),
        `data-toggle`="tooltip",
        `data-placement`="left",
        title="Go Top",
        onclick="goTop()",
        inner,
        spsDepend("basic", js = FALSE),
        spsDepend("gotop")
    )
}


#' Display your code in a bootstrap modal or collapse
#' @description Developers often wants to show their code in a shiny app.
#' This function creates a button that when clicked, a modal or collapse
#' hidden element will show up to display your code.
#'
#' @param id element ID
#' @param code code you want to display, in a character string or vector.
#' @param label string, label to display on the button
#' @param title string, title of the modal or collapse
#' @param tool_tip string, what tooltip to display when hover on the button
#' @param show_span bool, use the `<span>` tag to show a little label of the
#' left of the button? The span text will use text from `tool_tip`
#' @param placement string, where to display the tooltip
#' @param btn_icon icon, [shiny::icon()], icon of the button
#' @param size string, one of "large", "medium", "small", only works for modal
#' @param language string, what programming language is the code, use [shinyAce::getAceModes()]
#' to see options
#' @param display string, one of "modal", "collapse"
#' @param color string, color of the button
#' @param shape string, shape of the button, one of "rect", "circular",
#' @param ... other args pass to the [shiny::actionButton]
#'
#' @details
#' 1. The modal or collapse has an ID, the ID is your button ID + "-modal" or "-collapse",
#' like "my_button-modal"
#' 2. You could update the code inside the collapse use [shinyAce::updateAceEditor]
#' on server, the code block ID is button ID + "-ace", like "my_button-ace" . See
#' examples.
#' @return a shiny element
#' @export
#'
#' @examples
#' if(interactive()){
#'     library(shiny)
#'     code <-
#'         '
#'     # load package and data
#'     library(ggplot2)
#'     data(mpg, package="ggplot2")
#'     # mpg <- read.csv("http://goo.gl/uEeRGu")
#'
#'     # Scatterplot
#'     theme_set(theme_bw())  # pre-set the bw theme.
#'     g <- ggplot(mpg, aes(cty, hwy))
#'     g + geom_jitter(width = .5, size=1) +
#'       labs(subtitle="mpg: city vs highway mileage",
#'            y="hwy",
#'            x="cty",
#'            title="Jittered Points")
#'     '
#'     html_code <-
#'         '
#'     <!DOCTYPE html>
#'     <html>
#'     <body>
#'
#'     <h2>ABC</h2>
#'
#'     <p id="demo">Some HTML</p>
#'
#'     </body>
#'     </html>
#'     '
#'     ui <- fluidPage(
#'         fluidRow(
#'             column(
#'                 6,
#'                 h3("Display by modal"),
#'                 column(
#'                     6, h4("default"),
#'                     spsCodeBtn(id = "a", code)
#'                 ),
#'                 column(
#'                     6, h4("change color and shape"),
#'                     spsCodeBtn(
#'                         id = "b", c(code, code),
#'                         color = "red", shape = "circular")
#'                 )
#'             ),
#'             column(
#'                 6,
#'                 h3("Display by collapse"),
#'                 column(
#'                     6, h4("collapse"),
#'                     spsCodeBtn(id = "c", code, display = "collapse")
#'                 ),
#'                 column(
#'                     6, h4("different programming language"),
#'                     spsCodeBtn(
#'                         id = "d", html_code,
#'                         language = "html", display = "collapse")
#'                 )
#'             )
#'         ),
#'         fluidRow(
#'             column(
#'                 6,
#'                 h3("Update code"),
#'                 spsCodeBtn(
#'                     "update-code",
#'                     "# No code here",
#'                     display = "collapse"
#'                 ),
#'                 actionButton("update", "change code in the left `spsCodeBtn`"),
#'                 actionButton("changeback", "change it back")
#'             )
#'         )
#'     )
#'
#'     server <- function(input, output, session) {
#'         observeEvent(input$update, {
#'             shinyAce::updateAceEditor(
#'                 session, editorId = "update-code-ace",
#'                 value = "# code has changed!\n 1+1"
#'             )
#'         })
#'         observeEvent(input$changeback, {
#'             shinyAce::updateAceEditor(
#'                 session, editorId = "update-code-ace",
#'                 value = "# No code here"
#'             )
#'         })
#'     }
#'
#'     shinyApp(ui, server)
#' }
spsCodeBtn <- function(
    id,
    code,
    language = "r",
    label = "",
    title="Code to Reproduce",
    show_span = FALSE,
    tool_tip = "Show Code",
    placement = "bottom",
    btn_icon = icon("code"),
    display = c("modal", "collapse"),
    size = c("large", "medium", "small"),
    color = "black",
    shape = c("rect", "circular"),
    ...
){
    shape <- match.arg(shape, c("rect", "circular"))
    size <- match.arg(size, c("large", "medium", "small"))
    display <- match.arg(display, c("modal", "collapse"))
    stopifnot(is.logical(show_span))

    b_radius <- if (shape == "rect"){
        btn_style <- glue(
            .open = '@{', .close = '}@',
            '
            color: @{color}@;
            '
        )
    } else {
        btn_style <- glue(
            .open = '@{', .close = '}@',
            '
            border-radius: 50%;
            width: 35px;
            height: 35px;
            padding: 0;
            color: @{color}@;
            '
        )
    }
    btn <- div(
        style = "display: inline-block",
        if (show_span) tags$span(tool_tip, class = "text-bold", style = "padding-right: 5px;") else "",
        actionButton(
            inputId = id,
            label = label,
            icon = btn_icon,
            `data-toggle`="tooltip",
            title = tool_tip,
            `data-placement` = placement,
            style = btn_style,
            ...
        )
    )
    if (display == "modal") {
        display_el <- bsplus::bs_modal(
            id = paste0(id, "-modal"),
            title = title,
            size = size,
            body = shinyAce::aceEditor(
                outputId = paste0(id, "-ace"),
                value = glue(.open = '@{', .close = '}@', glue_collapse(code)),
                mode = language,
                readOnly = TRUE,
                fontSize = "14"
            )
        )
        btn <- btn %>% bsplus::bs_attach_modal(id_modal = paste0(id, "-modal"))
    } else {
        display_el <- bsplus::bs_collapse(
            id = paste0(id, "-collapse"),
            content = div(
                h4(class="modal-title", title),
                shinyAce::aceEditor(
                    outputId = paste0(id, "-ace"),
                    value = glue(.open = '@{', .close = '}@', glue_collapse(code)),
                    mode = language,
                    readOnly = TRUE,
                    fontSize = "14"
                )
            )
        )
        btn <- btn %>% bsplus::bs_attach_collapse(id_collapse = paste0(id, "-collapse"))
    }
    tagList(
        btn,
        display_el,
        spsDepend("basic"),
        spsDepend("pop-tip")
    )
}


























































