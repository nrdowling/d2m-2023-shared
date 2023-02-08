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


### 5-1 PLOTTING WITH 1, 2, AND 3 VARIABLES ###

#library(tidyverse)

#One variable
ggplot(iris, aes(x = Sepal.Length)) + geom_density()

#Two variables
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) + geom_point()

#Three variables (after three, visualization gets trickier—more on this next time)
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +	geom_point()

ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width,	shape = Species)) + geom_point()

ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width,	color = Species, shape = Species)) + geom_point()

## Two continuous variables

#adultdata <- read_csv("datasets/adult.data.csv")

ggplot(adultdata, aes(age, `education-num`)) + 
    geom_point()


ggplot(adultdata, aes(age, `education-num`)) + 
    geom_point()

ggplot(adultdata, aes(age, `education-num`)) + 
    geom_jitter() # how is jitter different from point? why would this be helpful? when would it be unnecessary?
ggplot(adultdata, aes(age, `education-num`)) + 
    geom_smooth()

ggplot(adultdata, aes(age, `education-num`)) + 
    geom_jitter() + 
    geom_smooth(method = "lm")

ggplot(adultdata, aes(age, `education-num`)) + 
    geom_smooth() +
    geom_jitter(method = "lm")


#Two variables, one continuous and one discrete: age and education number 
#(treating one or the other as a factor)

ggplot(adultdata, aes(age, factor(`education-num`))) + 
    geom_boxplot()

ggplot(adultdata, aes(age, factor(`education-num`),
                      group = factor(`education-num`))) +
    geom_violin()

ggplot(adultdata, aes(age, factor(`education-num`))) +
    geom_violin() ## looks the same without the group argument

## A note about violin plots^^ : In last week's slides I said I didn't understand why fill and color were bolded (indicating they were aesthetics). After looking at the documentation and messing around a bit -- turns out I was right to be confused!! Those arguments should be set OUTSIDE the aes() (or at least, for that plot example in the slides they were). Color was directly mapped to blue and fill to gray, but neither was dependent on data. Behold:

ggplot(adultdata, aes(age, factor(`education-num`))) +
    geom_violin(color='blue', fill='gray') ## outside aes() - colors look as expected

ggplot(adultdata, aes(age, factor(`education-num`))) +
    geom_violin(aes(color=`capital-gain`)) ## continuous variable inside aes() hmm, nothing seems to be changing here

ggplot(adultdata, aes(age, factor(`education-num`))) +
    geom_violin(aes(color=workclass)) ## factor variable inside aes() - SOMETHING is happening, but what's going on???

ggplot(adultdata, aes(age, factor(`education-num`))) +
    geom_violin(aes(fill=sex)) ## factor inside aes() - aha! reasonably, this adds a new grouping variable (similar for fill)

# From the ggplot documentation about the group aesthetic

#For most applications the grouping is set implicitly by mapping one or more discrete variables to x, y, colour, fill, alpha, shape, size, and/or linetype. This is demonstrated in the examples below.

#There are three common cases where the default does not display the data correctly. The examples below use a longitudinal dataset, Oxboys, from the nlme package to demonstrate these cases. Oxboys records the heights (height) and centered ages (age) of 26 boys (Subject), measured on nine occasions (Occasion). 

# Geoms commonly used with groups: geom_bar(), geom_histogram(), geom_line()

# See more (including examples with explanations for why group= is or is not needed) with ?aes_group_order

ggplot(adultdata, aes(age, factor(`education-num`),
                      group = factor(`education-num`))) +	
    geom_boxplot() +	
    geom_jitter()

## Wait what happened to the boxplot? It's hidden under the jitter because of the order we called the layers

ggplot(adultdata, aes(age, factor(`education-num`),
                      group = factor(`education-num`))) +	
    geom_jitter() +	
    geom_boxplot()

# that better, but it's hard to read. add some manual (not data-dependent aes!) color and alpha

ggplot(adultdata, aes(age, factor(`education-num`), 
                      group = factor(`education-num`))) +
    geom_jitter(color = "gray50", alpha = 0.1) + 
    geom_boxplot()

#Two discrete variables: workclass and education number (treating both as a factor)

ggplot(adultdata, aes(education, workclass)) +
    geom_count()

#Often more interesting with a third variable plotted…

ggplot(adultdata, aes(education, workclass, color = age)) +
    geom_count()

ggplot(adultdata, aes(education, workclass, fill = age)) +
    geom_raster()

### Check for NAs
which(is.na(adultdata$education))
which(is.na(adultdata$`education-num`))
which(is.na(adultdata$age))
for(i in 1:ncol(adultdata)) {print(which(is.na(adultdata[,i])))}

## That doesn't seem right...
for(i in 1:ncol(adultdata)) {print(which((adultdata[,i])=="?"))} #aha! this version of the dataset didn't clean up the question marks!

# Here's one way to clean that up 
ad3 <- head(adultdata, 100) #let's take just the first 100 observations as a temp df, just to make sure the code works (instead of waiting for a loop to run over 50000 cells!)
    
for(i in 1:ncol(ad3)) {
            for (j in 1:nrow(ad3)) {
                ifelse(ad3[j,i]=="?", ad3[j,i] <- NA, ad3[j,i])
            }
    }

# So we could use that loop with the full adultdata tibble, but that's going to be slow

# Alternatively, import the dataset telling readr what it should treat as NA

adultdata <- read_csv("datasets/adult.data.csv", na = "?")

### Look at the data in a table format and thoroughly scan
View(adultdata)
# Look good? Go back to the NA check functions above just to be sure (and to get a sense of where your missing data are!)

### Check that the scale, level, and type fits your expectations
### for each variable of interest
head(adultdata) # Are any numerical data coded as characters?
table(adultdata$education) # table() will print a simple frequency table for all levels in a factor variable
table(adultdata$income) # you can also give table() two factors for frequency across groups
summary(adultdata$age) # can't have a freq. table for a continuous variable, but we CAN get summary stats like mean

ggplot(adultdata, aes(age)) + geom_density()
ggplot(adultdata, aes(`capital-gain`)) + geom_density()
ggplot(adultdata, aes(age, `capital-gain`)) + geom_jitter()
ggplot(adultdata, aes(age, `capital-loss`)) + geom_jitter()

## ok what's the deal with jitter?? why not just use geom_point?

# compare to the matching jitter above
ggplot(adultdata, aes(age, `capital-loss`)) + geom_point() 

# Both graphs represent exactly the same data? What is jitter doing? Why would you want jitter?

## fwiw, geom_jitter is more or less a reskin of geom_point with position set to jitter by default
ggplot(adultdata, aes(age, `capital-loss`)) + geom_point(position = "jitter")



# Big ol' clean-up from our data prep demo

adultdata <- adultdata %>%
    mutate(
        age.bins = case_when(
            age <= 35 ~ "<= 35",
            age > 35 & age <= 50 ~ "36-50",
            age > 50 & age <= 65 ~ "51-65",
            age > 65 ~ "66+",
            TRUE ~ "uh oh"),
        education.bins = case_when(
            education %in% c("Preschool", "1st-4th",
                             "5th-6th", "7th-8th", "9th", "10th", "11th") ~ 'pre-HS',
            education %in% c("12th", "HS-grad", "Some-college") ~ 'HS',
            education %in% c("Assoc-acdm", "Assoc-voc", "Prof-school") ~ 'Assoc',
            education %in% c("Bachelors", "Masters", "Doctorate") ~ 'BA+',
            TRUE ~ "uh oh"),
        education.bins = fct_relevel(
            education.bins, c('pre-HS', 'HS', 'Assoc', 'BA+')),
        income = case_when(
            grepl("<", income) ~ "<=50K",
            grepl(">", income) ~ ">50K",
            TRUE ~ "uh oh"),
        race = as_factor(race),
        race = factor(race, labels = c("White", "Black", "AsiPacIsl",
                                       "AmerIndFirsNat", "Other")))

## Laptops out! let's plot our new binned data
### BUT FIRST, take a look at the data -- we know we just created two binned variables. Were any other variables already binned?

## What are advantages to binning (or not binning) continuous data?
## How could it help you conduct analyses and interpret results?
## How could it help in your figures specifically?

ggplot(adultdata, aes(age.bins, `education-num`)) +	
    geom_jitter() +	
    geom_boxplot()

ggplot(adultdata, aes(age.bins, `education-num`)) +	
    geom_jitter(color = "gray50", alpha = 0.1) +	
    geom_boxplot(outlier.shape = NA, alpha = 0.0)

ggplot(adultdata, aes(education.bins, age)) +	
    geom_jitter(color = "gray50", alpha = 0.1) +
    geom_boxplot(outlier.shape = NA, alpha = 0.0)

# As a quick review on aesthetics…
# Remember many arguments can be set either within or outside of aes()

# Before you try out each plot, ask:
# What is class of each variable? (factor (ordered?), string, continuous/numeric, etc)
# What properties are inside aes() and outside aes()? How will that change things?

ggplot(adultdata, aes(factor(`education-num`), age)) +
    geom_jitter(alpha = 0.1, color = "red") +
    geom_boxplot()

ggplot(adultdata, aes(factor(`education-num`), age)) +
    geom_jitter(aes(color = `education-num`), alpha = 0.1) +
    geom_boxplot()

ggplot(adultdata, aes(factor(`education-num`), age, color = `education-num`)) +
    geom_jitter(alpha = 0.1) +
    geom_boxplot()

ggplot(adultdata, aes(factor(`education-num`), age,
                      color = factor(`education-num`))) +
    geom_jitter(alpha = 0.1) +
    geom_boxplot()


# Now let’s do an initial exploration of how income relates to education, race, and sex in these data

ggplot(adultdata, aes(education.bins, fill = income)) +	
    geom_bar(position = "fill")
ggplot(adultdata, aes(age.bins, fill = income)) +	
    geom_bar(position = "fill")
ggplot(adultdata, aes(sex, fill = income)) +	
    geom_bar(position = "fill")

# Soon we’ll learn how to look at multiple factors using faceting, e.g. for the two data types we’ve looked at today:

ggplot(adultdata, aes(race, fill = income)) +	
    geom_bar(position = "fill") +	
    facet_grid(education.bins ~ sex) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggplot(adultdata, aes(education.bins, age, color = education.bins)) +
    geom_jitter(alpha = 0.1) +
    geom_boxplot(outlier.shape = NA, alpha = 0.0, color = "black") +
    facet_grid(. ~ race)

# Was binning age and education helpful? Why (not)? 

## RECREATE THESE PLOTS

mmdata <- read_csv("datasets/MM Data.csv")
mmdata.long <- read_csv("datasets/MM Data.csv") %>%
    pivot_longer(cols = c("Red", "Green", "Blue", "Orange",
                          "Yellow", "Brown"),
                 names_to = "Color", values_to = "Number")


# plot 1


p <- ggplot(mmdata.long, aes(Color, Number, fill=Color)) +
    geom_boxplot()


# plot 2

#ggplot(mmdata.long, aes(Color, Number, fill=Color)) +
#    geom_boxplot()

p + geom_jitter()


## CHALLENGE PLOT

p + geom_dotplot()



# plot 1
ggplot(data = mmdata.long, aes(Color, Number)) +
    geom_boxplot(aes(fill=Color)) 

# plot 2
ggplot(data = mmdata.long, aes(Color, Number)) +
    geom_boxplot(aes(fill=Color)) +
    geom_jitter()

## CHALLENGE PLOT
ggplot(data = mmdata.long, aes(Color, Number)) +
    geom_boxplot(aes(fill=Color)) +
    geom_dotplot(aes(fill = Color), binaxis = "y", stackdir = "up")
                 


## 5-2 MAKING PRETTY FIGURES ##

## What goes where? Inside or outside aes()? In the original ggplot() function or in the geom_*() function?

### Looking at within aes() only...

ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, 
                 color = Species)) +
    geom_point()

ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) +	
    geom_point(aes(color = Species))

ggplot(iris) +	
    geom_point(aes(x = Sepal.Length, y = Sepal.Width,	
                   color = Species))

ggplot() +	
    geom_point(data = iris,	
               aes(x = Sepal.Length, y = Sepal.Width, 
                   color = Species))

#Dataset and aesthetic mappings in ggplot() will be inherited with the addition of later geoms

ggplot(mpg,	aes(x = cyl, y = hwy,		
                fill = class, color = class)) +	
    geom_jitter(shape = 24) +
    geom_smooth(method = "lm")

ggplot(mpg,	aes(x = cyl, y = hwy,
                fill = class)) +
    geom_jitter(shape = 24) +
    geom_smooth(aes(color = class), method = "lm")

# You can set the same mapping type across multiple geoms
# When/why would you want to do that?

# take care when setting the same mapping type differently across geoms, things get wonky quickly!

ggplot(mpg,
       aes(x = cyl, y = hwy)) +
    geom_jitter(aes(color = manufacturer), shape = 24) +
    geom_smooth(aes(color = class), method = "lm")

ggplot(mpg,	aes(x = cyl, y = hwy,
                fill = class, color = class)) +
    geom_jitter(shape = 24) +
    geom_smooth(data = filter(mpg, class != "2seater"),
                aes(x = cyl, y = hwy),
                method = "lm")

### !!!STOP!!!
### If you have not yet cleaned up your adultdata tibble in this session with the big ol' clean up from ^^^ do that now. Quick check to see if you've already done it:
# 1. Are there NAs or question marks?
# 2. Are the binned variables there?

ggplot(adultdata, aes(age.bins, `education-num`)) +
    geom_jitter() +
    geom_boxplot()

ggplot(adultdata, aes(age.bins, `education-num`)) +
    geom_jitter(color = "gray50", alpha = 0.1) +
    geom_boxplot(outlier.shape = NA, alpha = 0.0)

ggplot(adultdata, aes(education.bins, age)) +
    geom_jitter(color = "gray50", alpha = 0.1) +
    geom_boxplot(outlier.shape = NA, alpha = 0.0)

# Building up to the plots we saw last time:

ggplot(adultdata, aes(race, fill = income)) +	
    geom_bar(position = "fill") +	
    facet_grid(education.bins ~ sex) +	
    theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggplot(adultdata, aes(education.bins, age,		
                      color = education.bins)) +
    geom_jitter(alpha = 0.1) +
    geom_boxplot(outlier.shape = NA,
                 alpha = 0.0, color = "black") +
    facet_grid(. ~ race)

#Adding text-based datapoints and annotations
mmdata <- read_csv("MM Data.csv")
mmdata.long <- read_csv("MM Data.csv") %>%
    pivot_longer(cols = c("Red", "Green", "Blue", "Orange",
                          "Yellow", "Brown"),
                 names_to = "Color", values_to = "Number")
mmdata.long.by.bag <- mmdata.long %>%
    group_by(Bag, Weight) %>%
    summarize(
        total.mms = sum(Number)
    )

ggplot(mmdata.long.by.bag, aes(Weight, total.mms)) +
    geom_smooth(method = "lm") +
    geom_point() +
    labs(x = "Weight (oz)", y = "# M&M candies") +
    theme_apa()


ggplot(mmdata.long.by.bag, aes(Weight, total.mms, label = Bag)) +
    geom_smooth(method = "lm") +
    geom_point() +
    labs(x = "Weight (oz)", y = "# M&M candies") +
    geom_text() +
    theme_apa()

ggplot(mmdata.long.by.bag, aes(Weight, total.mms, label = Bag)) +
    geom_smooth(method = "lm") +
    geom_point() +
    labs(x = "Weight (oz)", y = "# M&M candies") +
    geom_text(nudge_y = 0.5) +
    theme_apa()

ggplot(mmdata.long.by.bag, aes(Weight, total.mms, label = Bag)) +
    geom_smooth(method = "lm") +
    geom_point() +
    labs(x = "Weight (oz)", y = "# M&M candies") +
    geom_text(nudge_y = 0.5) +
    annotate("text", label = "OOPS...",
             x = 53, y = 45, size = 8, colour = "red") +
    theme_apa()

# Let’s rescale the axes; in this case, let’s zoom out!
    ggplot(mmdata.long.by.bag, aes(Weight, total.mms, label = Bag)) +
    geom_smooth(method = "lm") +
    geom_point() +
    labs(x = "Weight (oz)", y = "# M&M candies") +
    geom_text(vjust = 0, nudge_y = 0.5) +
    annotate(
        "text", label = "HELLO!!",
        x = 53, y = 45, size = 8, colour = "red") +
    scale_x_continuous(limits = c(45,55),	
                       breaks = 45:55) +
    scale_y_continuous(limits = c(40,70),	
                       breaks = seq(40,70,10)) +
    theme_apa()

    
    