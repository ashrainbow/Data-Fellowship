---
  title: "Data Fellowship Hackathon"
output: html_notebook
---

  #Set WD 
setwd("C:/Users/Ashley Rainbow/Desktop/Data Fellowship/data-fellowship/Hackathon 1")
library(tidyverse)
library(ggplot2)
library(googleVis)

sidebarPanel(
  sliderInput("obs", 
              "Number of observations:", 
              min = 200,
              max = 2018, 
              value = 500)
)

# Show a plot of the generated distribution
mainPanel(
  plotOutput("distPlot")
)



#Import data
olympics <- read.csv("athlete_events.csv")
NOC <- read.csv("noc_regions.csv")

#Assign values to meadals
olympics$Value[olympics$Medal == "Gold"] <- 3
olympics$Value[olympics$Medal == "Silver"] <- 2
olympics$Value[olympics$Medal == "Bronze"] <- 1
olympics$Value[is.na(olympics$Medal)] <- 0

#Structuring the data
olympics <- merge(olympics,NOC,by="NOC")
modern_olympics <- subset(olympics, olympics$Year >= 2000)

#Country Scores
country_collapse <- modern_olympics %>% group_by(region) %>% summarise(Total = sum(Value))
#View(country_collapse)

country_collapse <- na.exclude(country_collapse)
country_collapse$region <- as.character(country_collapse$region) 
country_collapse$region[country_collapse$region == 'USA'] <- 'United States'
country_collapse$region[country_collapse$region == 'UK'] <- 'United Kingdom'
country_collapse$region[country_collapse$region == 'Boliva'] <- "Bolivia"
country_collapse$region[country_collapse$region == 'Republic of Congo'] <- 'CG'
country_collapse$region[country_collapse$region == 'Democratic Republic of the Congo'] <- 'CD'
country_collapse$region[country_collapse$region == 'South Sudan'] <- 'SS'
#country_collapse$region[country_collapse$region == "USA"] <- "United States"
map <- gvisGeoChart(country_collapse, locationvar = 'region', colorvar = 'Total', hovervar = 'Total', options = list(width=1000, height=700))
plot(map)
