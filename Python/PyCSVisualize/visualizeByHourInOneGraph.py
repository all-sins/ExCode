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

# Create a single plot
fig, ax = plt.subplots(figsize=(12, 8))

# Plot each response time column on the same plot with different colors
ax.plot(df_resampled.index, df_resampled['ResponseTime1'], label='Google1', color='blue')
ax.plot(df_resampled.index, df_resampled['ResponseTime2'], label='Google2', color='green')
ax.plot(df_resampled.index, df_resampled['ResponseTime3'], label='openDNS1', color='red')
ax.plot(df_resampled.index, df_resampled['ResponseTime4'], label='openDNS2', color='purple')

# Set labels and title
ax.set_xlabel('Timestamp')
ax.set_ylabel('Response Time (ms)')
ax.set_title('Response Time Over Time (1-Hour Intervals)')

# Format the X-axis labels to display only the time of day in 24-hour format
date_form = DateFormatter("%H:%M")
ax.xaxis.set_major_formatter(date_form)

# Set major ticks every 1 hour
major_locator = HourLocator(interval=2)
ax.xaxis.set_major_locator(major_locator)

# Rotate X-axis labels for better readability and set font size
plt.xticks(rotation=45, ha='right', fontsize=6)

# Show legends
ax.legend()

# Show the plot
plt.tight_layout()  # Adjust layout to prevent clipping
plt.show()

