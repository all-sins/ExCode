import pandas as pd
import matplotlib.pyplot as plt

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
fig.suptitle('Response Time Over Time (1-Hour Intervals)', fontsize=16)
axs[3].set_xlabel('Timestamp')
fig.text(0.04, 0.5, 'Response Time (ms)', va='center', rotation='vertical')

# Show legends
axs[0].legend()
axs[1].legend()
axs[2].legend()
axs[3].legend()

# Show the plot
plt.show()

