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
                     box(title=tags$b("Site x Species Community Matrix"), width=NULL,collapsible = TRUE,status="primary",
                         h4(tags$b("Rows:")),p("sites, samples, observations, or objects."),
                         h4(tags$b("Columns:")),p("species or other variables measured for each row unit. Cell values are species abundances or absence/presence at each site."),
                         p("Ecological systems are inherently complex, such that a single response variable may be insufficient to capture its' complexity. 
                           This app depicts the site x species matrix in the analysis of species abundance data. The site x species matrix 
                           is the foundation for multivariate analyses, which are able to evaluate multiple response variables simulateneously. 
                           This data structure is not exclusive to species data and can be generalized a diversity of data types that also follow an 'object' by 'variable' format.")
                         ),
                     box(title = tags$b("Species Abundances"),width=NULL,status="primary",
                         p("The heatmap on the right uses a color scale to reflect the values shown in a site x species matrix. In the plot and table below,
                           rows indicate sites and the columns are the abundances of species found in the sites. 
                           of the abundance values for the species measured in the 'dune' dataset in R."),
                         p("A heatmap is useful to display many variables at one time."),
                         p("Upload a community data matrix. Pressing 'Update Matrix' will update the heatmap and table to display the provided data. The default data are from the 'dune' dataset in R."),
                         fileInput("getcsv","Upload Community Matrix",multiple=FALSE,accept=c("text/csv","text/comma-separated-values,text/plain",".csv")),
                         actionButton("runit","Update Matrix"),br()
                     )
              ),
              column(width=8,
                     box(title = tags$b("Visualizing Species Data"),width=NULL,status="primary",
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
                         p("Johnson and Wichern (2002)"),
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
              column(width=5,
                     box(title=tags$b("Distance Data"),width=NULL,
                     p("Site and species dissimilarity can be derived from the community matrix. Pairwise", tags$b("site dissimilarity"),"(site-to-site) reflects
                       species composition among sites, while", tags$b("species dissimilarity"), "tells us the dissimilarity among species based on site occurances. 
                       Dissimilarities are distances or the differences between entities."),
                     p(tags$b("Dissimilarity values range between 0 and 1"), "in which a distance of 0 between two sites indicates that
                       they share all of the same species (and distance of 1 reflects no shared species).")
                     ),
                     box(title=tags$b("Dissimilarity Indices"),width=NULL,
                         h4("Bray-curtis:"),uiOutput("bray"),
                         h4("Jaccard:"),uiOutput("jaccard"),
                         selectInput("distin","Choose distance:",choices=c("Bray-Curtis"="bray","Jaccard"="jacc")),
                         p("Upload a site x species matrix, or use default dataframe 'dune'. Press 'Calculate' to generate pairwise site dissimilarity."),
                         column(width=3,br(),
                                actionButton("runit2","Calculate"),br()),
                         column(width=9,
                                fileInput("getcsv","Upload data",multiple=FALSE,accept=c("text/csv","text/comma-separated-values,text/plain",".csv")))),
                     box(title="Transforming Data",width=NULL,
                         p("Data transformations may be necessary to normalize data. Transformed variables should still represent the data, but will be more amenable 
                           to analysis or comparison. Often species data are converted to relative abundances (proportions)."),
                         selectInput("df.tr","Data transformation:",choices=c("None","square root","log","proportions"),selected="none"),
                         )
                   
            ),
            column(width=7,
              box(title = tags$b("Visualizing the Distance Matrix"),width=NULL,status="primary",
                  d3heatmapOutput("heat")),
              box(title=tags$b("Distance Matrix"),width=NULL,
                  dataTableOutput("dist.matrix"))
                    
                     
            )
    )
    
    
  ),
  tabItem(tabName="howto",
          fluidRow(
            column(width=6,
              box(title=tags$b("Converting data structure to site x species matrix"), width = NULL,
                  p(""),
                  p("The following steps will transform your data from long form to short form(site x species community matrix) in R. Long format means that each line of your data 
                    are an observation/value of a single species."),p("show a little examples of long and short data."),
                  p(tags$code("library(reshape2)")),
                  p(tags$code("long.data<-read.csv('filename.csv')")),
                  p(tags$code("")))),
            column(width=6,
                   box(title="Short data",width=NULL,
                       p("Site x Species matrix:"),
                       dataTableOutput("short",width="75%")),
                   box(title="Long data",width = NULL,
                       p(""),
                       dataTableOutput("long",width="50%")))
              
                  
          ))
))
# Put them together into a dashboardPage
dashboardPage(skin = "black",
              dashboardHeader(title = "Community Data", titleWidth=250),
              sidebar,
              body
)