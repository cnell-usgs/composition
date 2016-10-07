##Community Data Structures in R
#By Colleen Nell (www.collnell.com)

##This code covers:
#1. Converting a data frame between long and short forms
#2. Transposing data
#3. Data transformations, and converting abundance data to proportions
#4. Converting a community matrix to a distance matrix
#5. Running ANOSIM (analysis of similarity)
#5. Plotting values in a heatmap


#load needed libraries
#any packages that have not been used before need to be installed using install.packages("packagename")

library(dplyr) ##calculating proportion data
library(reshape2) #long to short form
library(vegan) #calculate distance matrix, ANOSIM
library(d3heatmap) #plotting heatmaps

##read in community data
df<-read.csv("datafile.csv") #change with file location

##for demonstration purposes I will use the 'dune' dataset in R which is a site x species community matrix of species abundances
df<-data.frame(dune) #do not run if using own data. replace variable names in code with appropriate variables in own df
head(df)#dune data is already in short form- sites x species
##for demonstration purposes, I am adding 'Plot' and "Site' goruping variables to this dataframe
df$Site<-rep(1:5, each=4)
df$Plot<-rep(1:4,5)

##convert short data to long data
df.long<-melt(df, id.vars=c("Site","Plot"),variable.name="Species",na.rm=FALSE,value.name="Abundance")
#id.vars are any grouping variables for your dataset
#variable.name names a new variable that stores the column names that are 'melted', default is 'variable'
#value.name sets a name for the variable storing values from 'melted' columns, default is 'value'

View(df.long) # see that each species abservation now has its' own row with the respective grouping variables
##and a column of species names + column of species abundances


##convert long data to short data
#reversing what we jsut did
df.short<-dcast(df.long,Site+Plot~Species)




