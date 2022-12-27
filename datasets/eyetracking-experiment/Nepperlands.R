# Call the packages you need at the very top
library(tidyverse)
library(readxl)

# Set up paths to other directories that you will use
raw.data.path <- "rawdata/"
ptcp.metadata.file <- "metadata/NepperlandsET-4T_ParticipantList-backup-20210901.xlsx"

# Set any other global variables up top here
all.gazedata <- tibble()
filler.vids <- c(
  "Bergelson-flittingshapes_whistle.avi",
  "Kittens.avi",
  "Wermelinger - atCar.avi",
  "Wermelinger - atFrog.avi")

# Read in the participant and experiment metadata
# First list all the sheets in the file
metadata.sheets <- excel_sheets(ptcp.metadata.file)
# Create an empty tibble that we will load all the sheets into
ptcp.metadata <- tibble()
# Loop through each sheet...
for (sheet in metadata.sheets) {
  # Read the information in the sheet
  sheet.metadata <- read_excel(ptcp.metadata.file, sheet = sheet) %>%
    # Remove columns we won't use
    select(-Date, -Time, -Notes, -`Screen?`)
  # Add the information to the all-sheet tibble
  ptcp.metadata <- ptcp.metadata %>%
    bind_rows(sheet.metadata)
}

# Generate a list of all the files that are raw data using pattern matching
participants <- dir(raw.data.path, pattern = "*.txt")

# Loop through all raw data files...
for (p in participants) {
  # Not necessary, but in case you like updates
  # because as you'll see, we've silenced read_tsv()
  print(p)
  # Read in each one as a tsv
  p.gazedata <- read_tsv(paste0(raw.data.path, p),
                         show_col_types = FALSE) %>%
    # Exclude the lines in the files where participants are watching fillers
    filter(!(VideoName %in% filler.vids)) %>%
    # Add the participant's id to their data table
    mutate(Participant = str_extract(p, "[\\d]{4}"))
  # Copy the individual's data to the all-data tibble
  all.gazedata <- all.gazedata %>%
    bind_rows(p.gazedata)
  # ... and then repeat for the remainder of the participants, one by one
}

# Examine the data with a few sanity checks to make sure that it is correct
# and that you have an idea of what it looks like
View(head(all.gazedata))
View(tail(all.gazedata))
nrow(all.gazedata)
ncol(all.gazedata)
names(all.gazedata)
unique(all.gazedata$Participant)
unique(all.gazedata$VideoName)
length(unique(all.gazedata$Participant)) == length(participants)

# Join the metadata and the tracker data together
all.gaze.and.meta.data <- all.gazedata %>%
  mutate(Participant = as.numeric(Participant)) %>%
  left_join(ptcp.metadata, by = c("Participant" = "Participant_ID")) %>%
  rename(AgeGroup = "Age_Group")

# Some more sanity checks
nrow(all.gaze.and.meta.data)
nrow(all.gazedata)
ncol(all.gazedata)
ncol(all.gaze.and.meta.data)
names(all.gaze.and.meta.data)
