import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.dates import DateFormatter, HourLocator

# Read the CSV file into a Pandas DataFrame
df = pd.read_csv('cip.log', names=['Timestamp', 'ResponseTime1', 'ResponseTime2', 'ResponseTime3', 'ResponseTime4'])

# Convert the 'Timestamp' column to datetime format
df['Timestamp'] = pd.to_datetime(df['Timestamp'], unit='s')

# Set 'Timestamp' as the DataFrame index
df.set_index('Timestamp', inplace=True)

# Resample the data in 1-hour intervals, taking the mean of each hour
df_resampled = df.resample('1H').mean()

# Create subplots
fig, axs = plt.subplots(4, 1, figsize=(12, 15), sharex=True)

# Plot each response time column in a separate subplot
axs[0].plot(df_resampled.index, df_resampled['ResponseTime1'], label='ResponseTime1', color='blue')
axs[1].plot(df_resampled.index, df_resampled['ResponseTime2'], label='ResponseTime2', color='green')
axs[2].plot(df_resampled.index, df_resampled['ResponseTime3'], label='ResponseTime3', color='red')
axs[3].plot(df_resampled.index, df_resampled['ResponseTime4'], label='ResponseTime4', color='purple')

# Set labels and title
fig.suptitle('Response Time Over Time (1-Hour Intervals)', fontsize=16, y=1.02)  # Adjust title position
axs[3].set_xlabel('Timestamp')
fig.text(0.04, 0.5, 'Response Time (ms)', va='center', rotation='vertical')

# Show legends
axs[0].legend()
axs[1].legend()
axs[2].legend()
axs[3].legend()

# Format the X-axis labels to display both date and hour
date_form = DateFormatter("%Y-%m-%d %H:%M:%S")
axs[3].xaxis.set_major_formatter(date_form)

# Set hourly minor ticks
minor_locator = HourLocator(interval=1)
axs[3].xaxis.set_minor_locator(minor_locator)

# Format minor ticks to display only the time of day in 24-hour format and angle them
axs[3].xaxis.set_minor_formatter(DateFormatter("%H:%M"))
plt.xticks(rotation=45, ha='right')  # Adjust rotation and alignment of major ticks

# Show the plot
plt.tight_layout()  # Adjust layout to prevent clipping
plt.show()

