adultdata <- read_csv("datasets/adult.data.csv")

## A few things to do for each variable you plan to use in your
## plotting/analysis

### Check for NAs

## which(): returns list of indices within an object that evaluate as TRUE

which(adultdata$education == "Bachelors") # works with any conditional, but not always very informative...
which(is.na(adultdata$education)) # the conditional check for NAs is useful!
which(is.na(adultdata$`education-num`)) # what's with the quotes here?
which(is.na(adultdata$age))
# rather than doing this for each column individually, run a simple loop
for(i in 1:ncol(adultdata)) {print(which(is.na(adultdata[,i])))}

### Great! No missing data! But there are >700,000 cells in this table, and that seems unlikely...

### Look at the data -- NAs are encoded as '?'
View(adultdata)

## ?? That's not very tidy, how can we fix it?

# Option 1: Fix it when we import the data
adultdata_importNA <- read_csv("datasets/adult.data.csv", na = "?")

# Option 2: Fix with base R reassignment, syntax: df[df==""]<-NA
adultdata_assignNA <- adultdata # this doesn't use a pipe, so make a duplicate tibble to work with if we don't want to overwrite the original tibble
adultdata_assignNA[adultdata_assignNA=="?"]<-NA

# ?? Did both options achieve the same result?
all_equal(adultdata_importNA, adultdata_assignNA)

# Apply the fix to the real data
adultdata[adultdata=="?"]<-NA

### Check that the scale, level, and type fits your expectations
### for each variable of interest

# preview of tbl with first few observations
head(adultdata) 

# get some basic count info for sanity check purposes
table(adultdata$income)
table(adultdata$education)

# basic summary info for a numeric column
summary(adultdata$age)

# Let's play with some visuals, another way to get to know our data before we commit to using it
# ?? How do we interpret these plots? Keep in mind not all plots are inherently useful.

# we can keep these commented out by default and uncomment as needed
# that way we can run the script start to finish without displaying a series of plots that don't actually do anything in the data-prep process
ggplot(adultdata, aes(age)) + geom_density()
ggplot(adultdata, aes(`capital-gain`)) + geom_density()
ggplot(adultdata, aes(age, `capital-gain`)) + geom_jitter()
ggplot(adultdata, aes(age, `capital-loss`)) + geom_jitter()

# let's make some data prep changes to make our plots easier to interpret

# Look (with your human eyeballs!) at the data
# ?? What kinds of things would be useful to clean up?
# Think about: 
#   Should my analyses use *groups* or *individuals*?
#   Are there inconsistencies either *within* or *across* columns that make things tricky to interpret, even if they don't actually break the dataset?
#   Were the plots I generated useful? Why (not)? What would I need to make them (more) useful?
#   Did the columns get assigned appropriate classes when they were imported with readr?
#       If I have factor variables, are the levels and labels organized sensibly?
#       Are there columns treated as numeric (or integer) that don't actually represent continuous, numerical information? If so, which class should they actually be?

adultdata <- adultdata %>%
    mutate( # multiple columns being created and modified within a single mutate!
        ## ?? Which of these object assignments within the mutate CREATE a new column and which MODIFY an existing column?
        age.bins = case_when( 
            age <= 35 ~ "<= 35",
            age > 35 & age <= 50 ~ "36-50",
            age > 50 & age <= 65 ~ "51-65",
            age > 65 ~ "66+",
            TRUE ~ "uh oh"
        ),
        education.bins = case_when( 
            education %in% c("Preschool", "1st-4th",
                             "5th-6th", "7th-8th", "9th", "10th", "11th") ~ 'pre-HS',
            education %in% c("12th", "HS-grad", "Some-college") ~ 'HS',
            education %in% c("Assoc-acdm", "Assoc-voc", "Prof-school") ~ 'Assoc',
            education %in% c("Bachelors", "Masters", "Doctorate") ~ 'BA+',
            TRUE ~ "uh oh"
        ),
        education.bins = fct_relevel( 
            education.bins, c('pre-HS', 'HS', 'Assoc', 'BA+')),
        income = case_when(
            grepl("<", income) ~ "<=50K",
            grepl(">", income) ~ ">50K",
            TRUE ~ "uh oh"
        ),
        race = as_factor(race),
        race = factor(race, labels = c("White", "Black", "AsiPacIsl",
                                       "AmerIndFirsNat", "Other")))
