
header <- dashboardHeader(
  title = "spsComps"
)

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Welcome", tabName = "welcome", icon = icon("star")),
    menuItem("Animations", tabName = "animation", icon = animateIcon("carrot", "float", color = "orange"), badgeLabel = "0.2 NEW"),
    menuItem("Loaders", tabName = "loader", icon = animateIcon("spinner", "spin", color = "teal"), badgeLabel = "0.2 NEW"),
    menuItem("Tooltip, Popover", tabName = "poptip", icon = animateIcon("info", "rising", color = "#0275d8"), badgeLabel = "0.3 NEW"),
    menuItem("Input Control", tabName = "text", icon = icon("font")),
    menuItem("Image Display", tabName = "images", icon = icon("images")),
    menuItem("Buttons", tabName = "buttons", icon = icon("square")),
    menuItem("Progress control", tabName = "progress", icon = icon("tasks")),
    menuItem("Upload components", tabName = "upload_file", icon = icon("file-upload")),
    menuItem("Server Components", tabName = "server_col", icon = icon("server")),
    menuItem("Misc", tabName = "other", icon = icon("border-all"), badgeLabel = "0.3 Updates")
  )
)

body <- dashboardBody(
  tags$head(
    tags$link(href = "demo.css", rel = "stylesheet"),
    tags$script(src = "demo.js"),
    tags$link(href = "https://github.com/lz100/spsComps/blob/master/img/spscomps.png?raw=true", rel = "icon"),
    HTML(
      "
      <script async src=\"https://www.googletagmanager.com/gtag/js?id=G-STGQZ2PFM0\"></script>
      <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag(\'js\', new Date());

        gtag(\'config\', \'G-STGQZ2PFM0\');

        $(document).on('click', 'a', function(e) {
          var href = $(e.currentTarget).attr('href');
          var domain = window.location.hostname;
          var type = href.startsWith('#') ||
                href.startsWith(domain) ||
                href.startsWith(`https://${domain}`)
                ? 'internal' : 'external';
          gtag('send', 'link', type, $(e.currentTarget).attr('href') || '');
        });

        $(document).on('click', 'button', function(e) {
          var el = $(e.currentTarget);
          var elId = el.attr('id');
          var elText = el.text();
          gtag('send', 'btn', elId || '', elText || '');
        });
      </script>
      "
    )
  ),
  tabItems(
    tabItem(tabName = "welcome", uiWelcome("welcome")),
    tabItem(tabName = "text", uiText("text")),
    tabItem(tabName = "images", uiImages("images")),
    tabItem(tabName = "buttons", uiButtons("buttons")),
    tabItem(tabName = "animation", uiAnimation("animation")),
    tabItem(tabName = "loader", uiLoader("loader")),
    tabItem(tabName = "poptip", uiPoptip("poptip")),
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



