cat("\014") # RStudio excluse clear().
# Load necessary libraries
library(ggplot2)
library(dplyr)
library(tidyr) # pivot_longer()

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

# Convert the Unix timestamp to a human-readable date-time format
csvData$Datetime <- as.POSIXct(csvData$`Unix-Timestamp`, origin = "1970-01-01", tz = "UTC")

csvDataLong <- csvData %>%
    pivot_longer(
        cols = starts_with("GoogleDNS") | starts_with("OpenDNS"),
        names_to = "DNS_Source",
        values_to = "Latency"
    )

# Aggregate the data by time buckets (e.g., per minute) to reduce size
csvData_aggregated <- csvDataLong %>%
    mutate(TimeBucket = cut(Datetime, breaks = "1 hour")) %>% # Adjust time bucket size as needed
    group_by(TimeBucket, `DNS_Source`) %>%
    summarize(AvgLatency = mean(Latency))

# Plot the heatmap
ggplot(csvData_aggregated, aes(x = TimeBucket, y = `DNS_Source`, fill = AvgLatency)) +
    geom_() +
    scale_fill_gradient(low = "lightblue", high = "red") + # Customize color scale
    labs(
        title = "Heatmap of Average Latency Over Time",
        x = "Time",
        y = "DNS Source",
        fill = "Avg Latency (ms)"
    ) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) # Rotate x-axis labels for readability
