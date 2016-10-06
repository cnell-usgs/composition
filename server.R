library(DT)
library(devtools)
library(shiny)
library(ggplot2)
library(dplyr)
library(d3heatmap)
library(vegan)
library(reshape2)


source_url("https://raw.githubusercontent.com/collnell/R_vis/master/theme_mooney.R")#ggplot theme
doon<-as.data.frame(dune)
doon.df<-round(doon,2)
dune.dist<-vegdist(doon)
dune.df<-round(as.matrix(dune.dist),2)

shinyServer(function(input,output){

  values<-reactiveValues(sxsp=dune.df)

  observeEvent(input$runit,{
    if(is.null(input$getcsv)) {
      values$sxsp<-as.data.frame(dune)
    } else{
      inFile<-input$getcsv
      temp.df<-read.csv(inFile$datapath)##needs to sites x species matrix, with 1st col as grouping var
      temp.df[is.na(temp.df)]<-0
      values$sxsp<-as.data.frame(temp.df)
    }
    
    if (input$distin == "Bray-Curtis"){
      distmat<-vegdist(values$sxsp,method="bray")
      values$dist.df<-round(as.matrix(distmat))
    }else{
      distmat<-vegdist(values$sxsp,method="jaccard")
      values$dist.df<-round(as.matrix(distmat))
    }
    
  })
  
  
  output$heat<-renderD3heatmap({

    he.ma<-d3heatmap(values$dist.df,scale="column",colors="RdYlBu",breaks=5,Rowv=FALSE,Colv=FALSE,dendrogram='none')
    he.ma
  })
  
  output$comm.viz<-renderD3heatmap({
    comm.heat<-d3heatmap(doon,scale="column",colors="Spectral",breaks=5,Rowv=FALSE,Colv=FALSE,dendrogram='none')
  })
  
  output$dist.matrix<-renderDataTable(
    values$dist.df,extensions='FixedColumns',
    options=list(pageLength=nrow(dune.df),dom='t',scrollX=TRUE,scrollY='400px',fixedColumns=list(leftColumns=1)),
    class="compact"
    
  )
  
  output$comm.matrix<-renderDataTable(
    doon.df,extensions='FixedColumns',
    options=list(pageLength=nrow(doon.df),dom='t',scrollX=TRUE,scrollY='400px',fixedColumns=list(leftColumns=1)),
    class="compact"
    
  )



})