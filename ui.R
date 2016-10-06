library(shinydashboard)

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Community Matrix",tabName="topic",icon=icon("calculator",lib="font-awesome")),
    menuItem("Distance Matrix",tabName="dist",icon=icon("twitter", lib="font-awesome")),
    menuItem("Learn More",tabName="lit",icon=icon("book", lib="glyphicon")),
    br()
    
  ) 
)

body <- dashboardBody(
  tabItems(
    tabItem(tabName="topic",
            fluidRow(
              column(width=6,
                     box(title=tags$b("What is a site x species community matrix?"), width=NULL,collapsible = TRUE,status="primary",
                         p("Sites are ROWS"),
                         p("Species and COLUMNS"),
                         p("These can be transposed in some situation, but in general there is a column for each species and rows are sites/plots or the observations 
                           taken of the species. This format is commonly used in many types of analyses and does not pertain exclusively to species abundance data.
                           This also has applications to chemical analyses, genetic analyses, and really anything you can measure many variables for.
                           It is necessary to replicate species measurements to exhaustively survey them, in addition to feeling confident in your data.")),
                     box(title = tags$b("Measuring Diversity"),width=NULL,status="primary",
                         p("this is what a matrix looks like"),
                         p("Upload a site x species matrix for a community. Pressing 'Run' will visualize the data in a heatmap"),
                         fileInput("getcsv","Upload data",multiple=FALSE,accept=c("text/csv","text/comma-separated-values,text/plain",".csv"))
                     ),
                     box(title=tags$b("Data Matrix"), width=NULL,
                         dataTableOutput("comm.matrix"))
              ),
              column(width=6,
                     box(title = "Heatmap",width=NULL,status="primary",
                         d3heatmapOutput(" ")),
                     box(title="??",width=NULL,
                         p("mouseover data?")
                         ))
              )
            
    ),
    tabItem(tabName="lit",
            fluidRow(
              column(width=6,
                     box(title=tags$b("Literature"),width=NULL,
                         p("Magurran, A. E. 1988. Ecological Diversity and its Measurement. Princeton University Press, Princeton, NJ."),
                         p(""),
                         a("See pdf", href="web address",target="_blank"))),
              column(width=6,
                     box(title=tags$b("R packages"),width=NULL,
                         p("Several R packages have been developed for XXXXX.
                           The following were used in the development of this app."),
                         h4("package"),
                         p("description."),
                         a("Documentation",href="docadd",target="_blank")),
                     box(title=tags$b("This app"), solidHeader=TRUE,status="warning",width=NULL,
                         p("This app was made by",a("Colleen Nell",href="www.collnell.com",target="_blank"),"with support from the", a("UCI Data Science Initiative summer fellowship (2016)",
                                                                                                                href="http://datascience.uci.edu/2016/06/27/2016-data-science-summer-fellow/",target="_blank")),
                         p(tags$b("Get R script for these analyses:")),br(),
                         a(href="",target="_blank"),br(),
                         p("If you are new to R, check out this",a("Intro to R cookbook for Ecologists",href="http://rpubs.com/mooneyk/213152",target="_blank")),
                         a("See code for application",href="githublink",target="_blank")
                         )
                     )
            )
    ),
    
    tabItem(tabName="dist",
            fluidRow(
              column(width=5,
                     box(title=tags$b("Distance Matrix"),width=NULL,
                     p("description"),br()
                     ),
                     box(title="Methods",width=NULL,
                         p("Species composition of an ecological community tells us more about the community, beyond species richness and diversity. 
                           Many ecological communities contain a great diversity of species, many of which may be rare or uncommon. The next layer of information 
                           is in species composition. One way to visualize large amount of data on many species of variables is by creating a distance matrix.
                           A distance matrix is a way of comparing relative species composition and similarity/dissimilarity among sites/plots."),
                         p("Bray-curtis and Jaccard are the main dissimilarity indices. Bray-curtis incorporates species abundance while Jaccard does not
                           and is absence/presence data. Both provide valuable information. "),
                         p("Bray-curtis"),
                         p("Jaccard"),
                         selectInput("distin","Dissimilarity Index",choices=c("Bray-Curtis","Jaccard")),
                         p("Data transformations may be necessary to normalize data and alleviate the effects of dominant species on your results. An alternative
                           approach is to convert species abundances to proportion data. Sqrt works. "),
                         selectInput("df.tr","Data transformation:",choices=c("None","square root","log","proportions"),selected="none"),br(),
                         p("Upload a community matrix. Pressing 'Run' will calculate a distance matrix for your community and visualize it in a heatmap."),
                         fileInput("getcsv","Upload data",multiple=FALSE,accept=c("text/csv","text/comma-separated-values,text/plain",".csv")))
                     
            ),
            column(width=7,
              box(title = "Visualizing something",width=NULL,status="primary",
                  d3heatmapOutput("heat")),
              box(title="Distance Matrix",width=NULL,
                  dataTableOutput("dist.matrix"))
                    
                     
            )
    )
    
    
  )
))
# Put them together into a dashboardPage
dashboardPage(skin = "black",
              dashboardHeader(title = "Measuring Diversity", titleWidth=250),
              sidebar,
              body
)