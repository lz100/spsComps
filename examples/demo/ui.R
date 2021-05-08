
header <- dashboardHeader(
  title = "spsComps"
)

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Welcome", tabName = "welcome", icon = icon("star")),
    menuItem("Animations", tabName = "animation", icon = animateIcon("carrot", "float", color = "orange"), badgeLabel = "NEW"),
    menuItem("Loaders", tabName = "loader", icon = animateIcon("spinner", "spin", color = "teal"), badgeLabel = "NEW"),
    menuItem("Input Control", tabName = "text", icon = icon("font")),
    menuItem("Image Display", tabName = "images", icon = icon("images")),
    menuItem("Buttons", tabName = "buttons", icon = icon("square")),
    menuItem("Progress control", tabName = "progress", icon = icon("tasks")),
    menuItem("Upload components", tabName = "upload_file", icon = icon("file-upload")),
    menuItem("Server Components", tabName = "server_col", icon = icon("server")),
    menuItem("Misc", tabName = "other", icon = icon("border-all"))
  )
)

body <- dashboardBody(
  tags$head(
    tags$link(href = "demo.css", rel = "stylesheet"),
    tags$script(src = "demo.js"),
    tags$link(href = "https://github.com/lz100/spsComps/blob/master/img/spscomps.png?raw=true", rel = "icon"),
  ),
  tabItems(
    tabItem(tabName = "welcome", uiWelcome("welcome")),
    tabItem(tabName = "text", uiText("text")),
    tabItem(tabName = "images", uiImages("images")),
    tabItem(tabName = "buttons", uiButtons("buttons")),
    tabItem(tabName = "animation", uiAnimation("animation")),
    tabItem(tabName = "loader", uiLoader("loader")),
    tabItem(tabName = "progress", uiProgress("progress")),
    tabItem(tabName = "other", uiOther("other")),
    tabItem(tabName = "server_col", uiServerCol("server_col")),
    tabItem(tabName = "upload_file", uiUploadFile("upload_file"))
  )
)


ui <- dashboardPage(
  header = header,
  sidebar = sidebar,
  body =  body,
  title = "spsComps Demo"
)



