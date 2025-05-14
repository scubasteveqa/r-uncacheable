library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "Installed Packages",
  sidebar = sidebar(
    h4("Package Information"),
    p("This app displays all currently installed R packages and their version numbers.")
  ),
  card(
    card_header("Installed R Packages"),
    card_body(
      verbatimTextOutput("packageInfo")
    )
  )
)

server <- function(input, output, session) {
  output$packageInfo <- renderPrint({
    # Get installed packages info
    pkgs <- installed.packages()
    # Create a data frame with package names and versions
    pkg_info <- data.frame(
      Package = pkgs[, "Package"],
      Version = pkgs[, "Version"],
      stringsAsFactors = FALSE
    )
    # Sort by package name
    pkg_info <- pkg_info[order(pkg_info$Package), ]
    # Print the information
    print(pkg_info, row.names = FALSE)
  })
}

shinyApp(ui, server)