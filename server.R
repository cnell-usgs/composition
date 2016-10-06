
library(devtools)
library(shiny)
library(DT)
library(ggplot2)
library(dplyr)
library(d3heatmap)
library(vegan)
library(reshape2)


source_url("https://raw.githubusercontent.com/collnell/R_vis/master/theme_mooney.R")#ggplot theme
doon<-as.data.frame(dune)
dune.dist<-vegdist(doon)
dune.df<-round(as.matrix(dune.dist),2)

shinyServer(function(input,output){

  
  
  values<-reactiveValues()
  
  output$heat<-renderD3heatmap({

    he.ma<-d3heatmap(dune.dist,scale="column",colors="Spectral")
    he.ma
  })
  
  output$dist.matrix<-renderDataTable(
    dune.df,options=list(dom='t')%>%
      formatRound(columns=names(dune.df),digits=2)
    
  )
  
  output$comm.matrix<-renderDataTable(
    doon,options=list(dom='t')%>%
      formatRound(columns=names(doon),digits=2)
    
  )



})