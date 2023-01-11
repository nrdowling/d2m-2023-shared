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


