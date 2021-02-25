
# UI
uiImages <- function(id) {
  ns <- NS(id)
  texts <- c("p1", "p2", "", "p4", "p5")
  hrefs <- c("https://github.com/lz100/spsComps/blob/master/img/1.jpg?raw=true",
             "https://github.com/lz100/spsComps/blob/master/img/2.jpg?raw=true",
             "",
             "https://github.com/lz100/spsComps/blob/master/img/4.jpg?raw=true",
             "https://github.com/lz100/spsComps/blob/master/img/5.jpg?raw=true")
  images <- c("https://github.com/lz100/spsComps/blob/master/img/1.jpg?raw=true",
              "https://github.com/lz100/spsComps/blob/master/img/2.jpg?raw=true",
              "https://github.com/lz100/spsComps/blob/master/img/3.jpg?raw=true",
              "https://github.com/lz100/spsComps/blob/master/img/4.jpg?raw=true",
              "https://github.com/lz100/spsComps/blob/master/img/5.jpg?raw=true")
  fluidRow(
      tabTitle("Display images and logos"),
      column(
        6,
        box(
          title = "gallery", solidHeader = TRUE, status = "primary", width = 12,
          div(
            class = "text-minor",
            markdown(
            '
            Create a responsive gallery to display images or photos with links. If there is no
            link attach to the image, there will be no hover effect. Image title below is also
            optional.
            ')
          ),
          gallery(texts = texts, hrefs = hrefs, images = images, title = "Default gallery"),
          spsCodeBtn(
            ns("code_gallery"),
            show_span = TRUE,
            '
            texts <- c("p1", "p2", "", "p4", "p5")
            hrefs <- c("https://github.com/lz100/spsComps/blob/master/img/1.jpg?raw=true",
                       "https://github.com/lz100/spsComps/blob/master/img/2.jpg?raw=true",
                       "",
                       "https://github.com/lz100/spsComps/blob/master/img/4.jpg?raw=true",
                       "https://github.com/lz100/spsComps/blob/master/img/5.jpg?raw=true")
            images <- c("https://github.com/lz100/spsComps/blob/master/img/1.jpg?raw=true",
                        "https://github.com/lz100/spsComps/blob/master/img/2.jpg?raw=true",
                        "https://github.com/lz100/spsComps/blob/master/img/3.jpg?raw=true",
                        "https://github.com/lz100/spsComps/blob/master/img/4.jpg?raw=true",
                        "https://github.com/lz100/spsComps/blob/master/img/5.jpg?raw=true")
            library(shiny)

            ui <- fluidPage(
              gallery(texts = texts, hrefs = hrefs, images = images)
            )

            server <- function(input, output, session) {

            }

            shinyApp(ui, server)
            '
          ),
          spsHr(),
          p(class = "text-minor", "You can change images sizes to control how many to display in a row"),
          gallery(texts = texts, hrefs = hrefs, images = images, image_frame_size = 2, title = "Photo size"),
          spsCodeBtn(
            ns("code_gallery_small"),
            show_span = TRUE,
            '
            # get image and link in the default example
            gallery(texts = texts, hrefs = hrefs, images = images, image_frame_size = 2)
            '
          ),
          spsHr(),
          div(class = "text-minor",
            markdown(
              '
              Photos can be enlarged on click, default is inline. If
              you turn on the `enlarge = TRUE` option, clicking will no longer
              jump to the link, but enlarge the photo. Only the caption below
              the photo contains the link in this case.
              '
            )
          ),
          gallery(texts = texts, hrefs = hrefs, images = images, enlarge = TRUE, title = "Inline enlarge"),
          spsCodeBtn(
            ns("code_gallery_inline"),
            show_span = TRUE,
            '
            # get image and link in the default example
            gallery(texts = texts, hrefs = hrefs, images = images, enlarge = TRUE, title = "Inline enlarge")
            '
          ),
          spsHr(),
          p(class = "text-minor", "Use a modal pop-up to display images, good for very large photos"),
          gallery(
            texts = texts, hrefs = hrefs, images = images,
            enlarge = TRUE, title = "Modal enlarge",
            enlarge_method = "modal"
          ),
          spsCodeBtn(
            ns("code_gallery_modal"),
            show_span = TRUE,
            '
            # get image and link in the default example
            gallery(
            texts = texts, hrefs = hrefs, images = images,
            enlarge = TRUE, title = "Modal enlarge",
            enlarge_method = "modal"
            )
            '
          )
        )
      ),
      column(
        6,
        box(
          title = "hexLogo & hexPanel", solidHeader = TRUE, status = "primary", width = 12,
          div(
            class = "text-minor",
            markdown(
            '
              Create responsive hexagon logo(s). `hexLogo()` generates a single hexagon,
              and `hexPanel()` generates a panel of hex logos. If there is no
              link attach to the logo or footer, there will be no hover effect.
            ')
          ),
          h3("Single logos"),
          hexLogo(
            ns("logo"), "Logo",
            hex_img = "https://live.staticflickr.com/7875/46106952034_954b8775fa_b.jpg",
            hex_link = "https://www.google.com",
            footer = "Footer",
            footer_link = "https://www.google.com"
          ),
          hexLogo(
            ns("x"), "Change X offset",
            hex_img = "https://live.staticflickr.com/7875/46106952034_954b8775fa_b.jpg",
            x = "40"
          ),
          hexLogo(
            ns("y"), "Change Y offset",
            hex_img = "https://live.staticflickr.com/7875/46106952034_954b8775fa_b.jpg",
            y = "-60"
          ),
          spsCodeBtn(
            ns("code_hex_logo"),
            show_span = TRUE,
            '
              hexLogo(
                  "logo", "Logo",
                  hex_img = "https://live.staticflickr.com/7875/46106952034_954b8775fa_b.jpg",
                  hex_link = "https://www.google.com",
                  footer = "Footer",
                  footer_link = "https://www.google.com"
              ),
              hexLogo(
                  "x", "Change X offset",
                  hex_img = "https://live.staticflickr.com/7875/46106952034_954b8775fa_b.jpg",
                  x = "40"
              ),
              hexLogo(
                  "y", "Change Y offset",
                  hex_img = "https://live.staticflickr.com/7875/46106952034_954b8775fa_b.jpg",
                  y = "-60"
              )
              '
          ), spsHr(), h3("logo panels"),
          hexPanel(
            "demo1", "basic panel:" ,
            rep("https://live.staticflickr.com/7875/46106952034_954b8775fa_b.jpg", 2)

          ),
          hexPanel(
            "demo2", "panel with links:" ,
            c(paste0("https://d33wubrfki0l68.cloudfront.net/",
                     "2c6239d311be6d037c251c71c3902792f8c4ddd2/12f67/css/images/hex/ggplot2.png"),
              paste0("https://d33wubrfki0l68.cloudfront.net/",
                     "621a9c8c5d7b47c4b6d72e8f01f28d14310e8370/193fc/css/images/hex/dplyr.png")
            ),
            c("https://ggplot2.tidyverse.org/", "https://dplyr.tidyverse.org/"),
            c("ggplot2", "dplyr")
          ),
          hexPanel(
            "demo3", "footer with links:" ,
            rep("https://live.staticflickr.com/7875/46106952034_954b8775fa_b.jpg", 2),
            footers = c("hex1", "hex2"),
            footer_links = rep("https://www.google.com", 2)
          ),
          hexPanel(
            "demo4", "panel offsets" ,
            hex_imgs = rep("https://live.staticflickr.com/7875/46106952034_954b8775fa_b.jpg", 4),
            footers = paste0("hex", 1:4),
            ys = seq(-20, -50, by = -10),
            xs = seq(20, 50, by = 10)
          ),
          spsCodeBtn(
            ns("code_hex_panel"),
            show_span = TRUE,
            '
            hexPanel(
                "demo1", "basic panel:" ,
                rep("https://live.staticflickr.com/7875/46106952034_954b8775fa_b.jpg", 2)

            ),
            hexPanel(
                "demo2", "panel with links:" ,
                c(paste0("https://d33wubrfki0l68.cloudfront.net/",
                  "2c6239d311be6d037c251c71c3902792f8c4ddd2/12f67/css/images/hex/ggplot2.png"),
                  paste0("https://d33wubrfki0l68.cloudfront.net/",
                  "621a9c8c5d7b47c4b6d72e8f01f28d14310e8370/193fc/css/images/hex/dplyr.png")
                ),
                c("https://ggplot2.tidyverse.org/", "https://dplyr.tidyverse.org/"),
                c("ggplot2", "dplyr")
            ),
            hexPanel(
                "demo3", "footer with links:" ,
                rep("https://live.staticflickr.com/7875/46106952034_954b8775fa_b.jpg", 2),
                footers = c("hex1", "hex2"),
                footer_links = rep("https://www.google.com", 2)
            ),
            hexPanel(
                "demo4", "panel offsets" ,
                hex_imgs = rep("https://live.staticflickr.com/7875/46106952034_954b8775fa_b.jpg", 4),
                footers = paste0("hex", 1:4),
                ys = seq(-20, -50, by = -10),
                xs = seq(20, 50, by = 10)
            )
            '
          )

        )
      )
    )
}

# Server
serverImages <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      output$text_clear_out <- renderPrint(input$text_clear)
    }
  )
}
