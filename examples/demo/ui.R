
header <- dashboardHeader(
  title = "spsComps"
)

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Welcome", tabName = "welcome"),
    menuItem("Widgets", tabName = "widgets")
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(tabName = "welcome", uiWelcome("welcome")),
    tabItem(tabName = "widgets", h2("Widgets tab content"))
  )
)


ui <- dashboardPage(
  header = header,
  sidebar = sidebar,
  body =  body,
  title = "spsComps Demo"
)



