#### 4-2: Intro to ggplot ####

#library(tidyverse)
#adultdata <- read_csv("datasets/adult.data.csv")

ggplot(adultdata, aes(age)) + geom_density()
ggplot(adultdata, aes(age)) + geom_histogram()
ggplot(adultdata, aes(age)) + geom_histogram(binwidth = 5)

ggplot(adultdata, aes(`education-num`)) + geom_density()
ggplot(adultdata, aes(`education-num`)) + geom_density(adjust = 2) 

## What's weird about this plot? Why does it run without an error?
ggplot(adultdata, aes(race)) + geom_density()

ggplot(adultdata, aes(race)) + geom_bar() #+
    #theme(axis.text.x = element_text(angle=45,
                                     #hjust=1))

ggplot(adultdata, aes(race)) + geom_histogram()

## What's weird about this plot? Why does it give an error instead of a weird looking plot?
ggplot(adultdata, aes(race)) + geom_histogram(stat = "count") 

ggplot(adultdata, aes(occupation)) + geom_bar() #+
    #theme(axis.text.x = element_text(angle=45,
                                     #hjust=1))

## FILTER (OR MANIPULATE) THE DATA WITHIN THE GGPLOT FUNCTION

ggplot(filter(adultdata, occupation != "?"), aes(occupation)) +
    geom_bar()

## OR APPLY CHANGES TO THE DATA BEFORE YOU CALL THE PLOT

aduldata.occupations.noUNK <- adultdata %>%
    filter(occupation != "?")

ggplot(filter(adultdata, !is.na(occupation)), aes(occupation)) +
    geom_bar()

## Just running a ggplot() function will produce a figure you can see in the plot viewer, but if you ever want to refer to it later (e.g., to save it, add to it, call it in a paper) you need to save it as an object.

myplot <- ggplot(aduldata.occupations.noUNK, aes(occupation)) + geom_bar()
