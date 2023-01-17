################################################################################
# 2.1

# Defining a simple function
add.two <- function(x) {return(x + 2)}

# The names don't matter
# Assign it to any name and call the arguments whatever you want
sdfkjsdf <- function(kgguw) {return(kgguw + 2)}

# Slightly more complicated, including other functions in a function
add.two2 <- function(x) {return(paste(as.character(x), "two"))}

# What counts as "returning"?

fnc_paste_return <- function(argument1, argument2) {
    return(paste(argument1, argument2))
}

fnc_paste <- function(argument1, argument2) {
    paste(argument1, argument2)
}

fnc_paste_store <- function(argument1, argument2) {
    myvalue <- paste(argument1, argument2)
}

fnc_paste_return("hello", "world")
fnc_paste("hello", "world")
fnc_paste_store("hello", "world")

# Set some basic parameters
eggs <- TRUE
milk <- TRUE

# If they have eggs
if (eggs == TRUE) {
    n.milk <- 6 # Buy six milk
} else {
    n.milk <- 1 # If they don't have eggs, buy 1 milk
}

# Same thing but shorter
n.milk <- ifelse(eggs == TRUE, yes = 6, no = 1)

# What's different here? Why would we want that? How will it behave?
if (milk == TRUE && eggs == TRUE) {
    n.milk <- 6
} else if (milk == FALSE && eggs == TRUE) {
    n.milk <- 0
} else if (milk == TRUE && eggs == EGGS) {
    n.milk <- 1
} else {
    n.milk <- 0
}


# If they have milk, buy one carton of milk.
# If they have eggs, buy six eggs.
if (milk == TRUE) {
    n.milk <- 1
} else {
    n.milk <- 0
}
if (eggs == TRUE) {
    n.eggs <- 6
} else {
    n.eggs <- 0
}

# How can we edit this to get 6 eggs and 1 milk (if they have each)?
if (milk == TRUE && eggs == TRUE) {
    n.milk <- 6
} else if (milk == TRUE && eggs == FALSE) {
    n.milk <- 1
} else {
    n.milk <- 0
}  

# How can we edit this to get 6 eggs and 1 milk (if they have each)?
if (milk == TRUE) {
    if (eggs == TRUE) {
        n.milk <- 6
    } else {
        n.milk <- 1
    }
} else {
    n.milk <- 0
}

for (i in c(2,4,8,16)) {print(i)}

for (i in c(1,2,3,4)) {print(2^i)}

timestwo <- function(number) {x <- number*2
print(x) }


i <- 1
while(i <= 4) {
    print(2^i)
    i <- i + 1}

# Hello world demo

print("Hello world!")

print(paste("Hello", "world!")) # Default separator is a space

print(paste("Hello", "world!", sep = "-")) # Make it anything

print(paste0("Hello", "world!")) # Or nothing

print(paste0("Hello", " ", "world", "!")) # Break it up with more than two arguments



## MINI-ASSIGNMENT 3 EXAMPLE WALKTHROUGH

#Write a function called hello.world() that includes:
#    1+ object assignments
#1+ conditional statements
#1+ loops
#hello.world() should take at least one argument (i.e., input object/value) and produce things like:
# [1] hello, class
# [1] bonjour, mes amis
# [1] good morning, Dr. Dowling
# [1] hello?

# Define a function that gives you as many positive greetings as you want; assign to object hello.world()


# hello.world() takes arguments name (character) and n.greet (number of greetings requested)
hello.world <- function(name, n.greet) {
    # set some possible greetings, character variables that may reference the name argument
    greetings <- c(paste0("Hello ", name, "!"), # paste0 will concatenate strings and string-formatted objects without a separator
                   "How's your day going?",
                   paste0("Wow, ", name, ", looking good today."),
                   paste0(name, ", that outfit looks great on you."),
                   paste0(name, "! I'm so glad you're here!"),
                   "OMG hey!", # if I don't want to reference a stored variable/object, I don't have to concato=enate anything
                   paste0("sup ", name, "?"))
    # start the counter off at 1
    i <- 1
    # but before using the counter, check to see if we don't want any greetings at all
    if (n.greet == 0) {
        return(paste0("I have nothing to say to you, ", name, ".")) # return something other than a greeting, but still reference the name argument
    } else {
        while(i <= n.greet) { # is i less than or equal to the number of greetings I asked for?
            print(sample(greetings, 1)) # if yes, print out a random greeting from my list (if no, while loop ends)
            i <- i + 1 # add 1 to the counter because we delivered 1 greeting and restart the while loop
        }
    }
} # end hello.world function define



################################################################################
# 2.2

mydata <- read_csv("pilotdata.csv")

mydata <- read_csv("pilotdata.csv",
                   col_types = cols(
                       participantID = col_character()
                   ))


mmdata <- read_excel("MM Data.xlsx", skip = 1)

mmdata.long <- read_excel("MM Data.xlsx", skip = 1) %>%
    pivot_longer(cols = c("Red", "Green", "Blue", "Orange",
                          "Yellow", "Brown"),
                 names_to = "Color", values_to = "Number")

write_excel_csv(mmdata.long, "MM_Data-long.xls")


mmdata <- read_csv("MM Data.csv")

mmdata.long <- read_csv("MM Data.csv") %>%
    pivot_longer(cols = c("Red", "Green", "Blue", "Orange",
                          "Yellow", "Brown"),
                 names_to = "Color", values_to = "Number")

write_csv(mmdata.long, "MM_Data-long.csv")


################################################################################
# 3.1

testdata <- tibble(
    condition = c(1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2),
    participant = c(1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6),
    score = runif(12),
    notes = c("glasses_none", "glasses_none", "none_none", "none_none",
              "none_incomplete", "none_incomplete", "none_none", "none_none",
              "glasses_none", "glasses_none", "glasses_late", "glasses_late")
)


## Slide 7: group_by and summarize
testdata %>%
    group_by(condition, participant) %>%
    summarize(mean.ptcp.score = mean(score)) %>%
    ungroup() %>% 
    group_by(condition) %>%
    summarize(mean.cond.score = mean(mean.ptcp.score),
              sem.cond.score = sd(mean.ptcp.score)/sqrt(n()),
              n = n(),
              sd = sd(mean.ptcp.score))


## Slide 9(+) pivots
mmdata <- read_csv("MM Data.csv")

mmdata.long <- read_csv("MM Data.csv") %>%
    pivot_longer(cols = c("Red", "Green", "Blue", "Orange",
                          "Yellow", "Brown"),
                 names_to = "Color", values_to = "Number")

mmdata.wide <- mmdata.long %>%
    pivot_wider(names_from = "Color",
                values_from = "Number") %>%
    relocate(Weight,.after = last_col())


## Slide 11: separate, unite
testdata.sep <- testdata %>%
    separate(notes, c("vision_correction", "other_notes"), sep = "_")

testdata.unite <- testdata.sep %>%
    unite("semicolon_notes", "vision_correction":"other_notes", sep = ";")


## What's actually missing in this missingdata tibble?
missingdata <- tibble(
    condition = c(1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2),
    participant = c(1, NA, NA, NA, 2, NA, NA, NA, 3, NA, NA),
    trial = c(1, 2, 3, 4, 1, 2, 3, 4, 1, 3, 4),
    score = c(0, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1),
)

fixeddata <- missingdata %>%
    # participant id is only indicated for the first observation for each participant, fill it in for the rest
    fill(participant) %>% 
    # p3 did not complete trial 2, but we should still see evidence of the (incomplete) observation
    complete(condition, trial) %>%
    replace_na(list(participant = 3)) %>% # a HACK (will not generalize/will break)
    arrange(condition, participant, trial) # just to make it pretty

## Alternatively...

## use crossing() to create a tibble of all possible (i.e. expected) participant x trial observations 
all.ptcp.trial.combos <- crossing(
    participant = unique(missingdata$participant),
    trial = c(1:4)) %>%
    filter(!is.na(participant)) 

## now fix the missing data by...
fixeddata2 <- missingdata %>%
    # using the same fill() fnct to fix participant col.
    fill(participant) %>%
    # join with the expanded tibble of expected combos
    full_join(all.ptcp.trial.combos) %>%
    # arrange(participant, trial) %>% # superstitious but harmless
    # the expected observation for p3, trial2 has been created and is missing values for score (appropriately) and condition, but we know what the condition should be and use fill() as we did above 
    fill(condition)

################################################################################
