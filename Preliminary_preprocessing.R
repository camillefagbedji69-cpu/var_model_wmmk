## Import libraries 
library(tidyverse)
library(modifiedmk)
library(trend)


## Import dataset 
dataset <- read.csv("SWV_serie.csv", 
                    sep = ";")

## Annual dataset 

aggre_data <- dataset |> 
  group_by(year) |> 
  summarise(npp = mean(NPP), 
            ei = mean(EI))

## Trend analysis with Modified Mann-Kendall test

mmkh(aggre_data$npp) ## For NPP

mmkh(aggre_data$ei) ## For EI

## Rupture analysis 

pettitt.test(aggre_data$npp) ## For analysis

pettitt.test(aggre_data$ei)  ## For EI



