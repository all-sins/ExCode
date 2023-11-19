import pandas as pd
import matplotlib.pyplot as plt

# Read the CSV file into a Pandas DataFrame
df = pd.read_csv('cip.log', names=['Timestamp', 'ResponseTime1', 'ResponseTime2', 'ResponseTime3', 'ResponseTime4'])

# Convert the 'Timestamp' column to datetime format
df['Timestamp'] = pd.to_datetime(df['Timestamp'], unit='s')

# Create subplots
fig, axs = plt.subplots(4, 1, figsize=(12, 15), sharex=True)

# Plot each response time column in a separate subplot
axs[0].plot(df['Timestamp'], df['ResponseTime1'], label='ResponseTime1', color='blue')
axs[1].plot(df['Timestamp'], df['ResponseTime2'], label='ResponseTime2', color='green')
axs[2].plot(df['Timestamp'], df['ResponseTime3'], label='ResponseTime3', color='red')
axs[3].plot(df['Timestamp'], df['ResponseTime4'], label='ResponseTime4', color='purple')

# Set labels and title
fig.suptitle('Response Time Over Time', fontsize=16)
axs[3].set_xlabel('Timestamp')
fig.text(0.04, 0.5, 'Response Time (ms)', va='center', rotation='vertical')

# Show legends
axs[0].legend()
axs[1].legend()
axs[2].legend()
axs[3].legend()

# Show the plot
plt.show()

