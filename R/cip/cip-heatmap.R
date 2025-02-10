# Load necessary libraries
library(ggplot2)
library(dplyr)
library(lubridate)

# Set the working directory to where your CSV file is located (adjust as needed)
setwd("/home/tsu/Playground/ExCode/R/cip")

# Read the CSV data
csvData <- read.csv("./cip.log", header = FALSE)

# Rename columns for easier reference
colnames(csvData) <- c("Unix-Timestamp", 
                       "GoogleDNS-1", 
                       "GoogleDNS-2", 
                       "OpenDNS-1", 
                       "OpenDNS-2")

# Convert the Unix-Timestamp to a proper Date-Time format
csvData$Datetime <- as.POSIXct(csvData$`Unix-Timestamp`, origin = "1970-01-01", tz = "UTC")

# Reshape the data into long format for easier plotting
csvData_long <- csvData %>%
    pivot_longer(
        cols = c("GoogleDNS-1", "GoogleDNS-2", "OpenDNS-1", "OpenDNS-2"),
        names_to = "DNS_Source",
        values_to = "Latency"
    )

# Throw out 0 values.
csvData_long <- csvData_long %>%
    filter(Latency != 0)

# Throw out values larger than 300.
csvData_long <- csvData_long %>%
    filter(Latency <= 300)

# Group the data by time buckets (e.g., 5-minute intervals) and DNS source
csvData_long_buckets <- csvData_long %>%
    mutate(TimeBucket = floor_date(Datetime, "1 minutes")) %>%
    group_by(TimeBucket, DNS_Source) %>%
    summarize(AverageLatency = mean(Latency, na.rm = TRUE))

# Create a column with just the time portion for plotting
csvData_long_buckets <- csvData_long_buckets %>%
    mutate(TimeOfDay = format(TimeBucket, format = "%H:%M:%S"))

ggplot(csvData_long_buckets, aes(x = TimeBucket, y = AverageLatency, color = DNS_Source)) +
    geom_line() +
    scale_x_datetime(date_breaks = "1 hour", date_labels = "%H:%M") +
    labs(x = "Time",
         y = "Latency",
         title = "Latency over time.") +
    theme(
        axis.text.x = element_text(angle = 90, hjust = 1)  # Rotate x-axis text 90 degrees
    )