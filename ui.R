library(shinydashboard)
library(d3heatmap)

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Community Matrix",tabName="topic",icon=icon("calculator",lib="font-awesome")),
    menuItem("Distance Matrix",tabName="dist",icon=icon("twitter", lib="font-awesome")),
    menuItem("Data Wrangling",tabName="howto"),
    menuItem("Learn More",tabName="lit",icon=icon("book", lib="glyphicon")),
    br()
    
  ) 
)

body <- dashboardBody(
  tabItems(
    tabItem(tabName="topic",
            fluidRow(
              column(width=4,
                     box(title=tags$b("What is a site x species community matrix?"), width=NULL,collapsible = TRUE,status="primary",
                         p("Sites are ROWS"),
                         p("Species abundances or absence/presence data in the COLUMNS"),
                         p("This is the basis for species composition analyses. This is also an efficient format for dataset with many variables or when you have replicated data/nested design."),
                         
                         p("These can be transposed in some situation, but in general there is a column for each species and rows are sites/plots or the observations 
                           taken of the species. This format is commonly used in many types of analyses and does not pertain exclusively to species abundance data.
                           This also has applications to chemical analyses, genetic analyses, and really anything you can measure many variables for.
                           It is necessary to replicate species measurements to exhaustively survey them, in addition to feeling confident in your data.")),
                     box(title = tags$b("Abundance Matrix"),width=NULL,status="primary",
                         p("Community matrices are commonly used to display species abundances across multiple sites or observations. Shown to the right is a heatmap
                           of the abundance values for the species measured in the 'dune' dataset in R. Each row of the data are XXX and each column of the data matrix are 
                           species. The colors in the heatmap vary to reflect the species abundances."),
                         p("A heatmap could also be used to display many variables at one time."),
                         p("In the heatmap the columns and rows are the same, but hte values are visualized with a color scale that is not pictured. "),
                         p("Upload your won site x species matrix of communitymeasurements. Pressing 'Run' will re-run the heatmap visualization for the uploaded data and 
                           print the corresponding data in the table."),
                         fileInput("getcsv","Upload community matrix",multiple=FALSE,accept=c("text/csv","text/comma-separated-values,text/plain",".csv")),
                         actionButton("runit","Update Matrix"),br()
                     )
              ),
              column(width=8,
                     box(title = tags$b("Visualizing the data matrix"),width=NULL,status="primary",
                         d3heatmapOutput("comm.viz")),
                     box(title=tags$b("Data Matrix"), width=NULL,
                         dataTableOutput("comm.matrix"))
              )
            
    )),
    tabItem(tabName="lit",
            fluidRow(
              column(width=6,
                     box(title=tags$b("Learn More"),width=NULL,
                         p("Magurran, A. E. 1988. Ecological Diversity and its Measurement. Princeton University Press, Princeton, NJ."),
                         p("Legendre P, Legendre L. Numerical Ecology. 2nd ed. Amsterdam: Elsevier, 1998. ISBN 978-0444892508."),
                         a("See pdf", href="web address",target="_blank"))),
              column(width=6,
                     box(title=tags$b("R packages"),width=NULL,
                         p("The following R packages draw heatmaps and distance matrices:"),
                         h4("D3heatmap"),
                         h4("heatmaply"),
                         h4("phyloseq"),
                         h4("vegan"),
                         
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
              column(width=4,
                     box(title=tags$b("Distance Matrix"),width=NULL,
                     p("Using you community matrix you can create a distance matrix, which calculates pairwise similarity/dissimilarity among your sites or sampling units.
                       This tells your overall information about how they are similar, no shit. The diagonal line on the distance matrix falls where sites are compared to themselves.
                       Because of this they are either 1 or zero, depending on how your matrix was calculated"),br()
                     ),
                     box(title=tags$b("Methods"),width=NULL,
                         p("Species composition of an ecological community tells us more about the community, beyond species richness and diversity. 
                           Many ecological communities contain a great diversity of species, many of which may be rare or uncommon. The next layer of information 
                           is in species composition. One way to visualize large amount of data on many species of variables is by creating a distance matrix.
                           A distance matrix is a way of comparing relative species composition and similarity/dissimilarity among sites/plots."),
                         p("Bray-curtis and Jaccard are the main dissimilarity indices. These are rank-order similar meaning XXX. Bray-curtis incorporates species abundance while Jaccard does not
                           and is absence/presence data. Both provide valuable information. In the distance matrix the species columns are gone and columns and rows
                           both correspond to the sites, or rows of the data file. Each value indicates the pairwise degree of similarity for every site. These
                           values mean this xxx"),
                         p("Bray-curtis"),
                         p("Jaccard"),
                         selectInput("distin","Dissimilarity Index",choices=c("Bray-Curtis"="bray","Jaccard"="jacc")),
                         p("Data transformations may be necessary to normalize data and alleviate the effects of dominant species on your results. An alternative
                           approach is to convert species abundances to proportion data. Sqrt works. "),
                         selectInput("df.tr","Data transformation:",choices=c("None","square root","log","proportions"),selected="none"),
                         actionButton("runit2","Calculate"),br(),
                         p("Upload a community matrix. Pressing 'Run' will calculate a distance matrix for your community and visualize it in a heatmap."),
                         fileInput("getcsv","Upload data",multiple=FALSE,accept=c("text/csv","text/comma-separated-values,text/plain",".csv"))
                     )
                     
            ),
            column(width=8,
              box(title = tags$b("Visualizing the Distance Matrix"),width=NULL,status="primary",
                  d3heatmapOutput("heat")),
              box(title=tags$b("Distance Matrix"),width=NULL,
                  dataTableOutput("dist.matrix"))
                    
                     
            )
    )
    
    
  ),
  tabItem(tabName="howto",
          fluidRow(
            box(title="Prepping your data", width = NULL,
                p("In the field it is common to take data in the long format. It is not necessarily convenient or paper friendly to print out a species matrix for 
                  a large number of speices that may all be fairly rare, thus the page stay unused. "),
                p("The following steps will transform your data from the long format to short format (community matrix) in R. Long format means that each line of your data 
                  are an observation/value of a single species."),p("show a little examples of long and short data."),
                p(tags$code("library(reshape2)")),
                p(tags$code("long.data<-read.csv('filename.csv')")),
                p(tags$code(""))
          ))
)))
# Put them together into a dashboardPage
dashboardPage(skin = "black",
              dashboardHeader(title = "Community Data", titleWidth=250),
              sidebar,
              body
)