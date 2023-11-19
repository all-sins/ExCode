import pandas as pd
import matplotlib.pyplot as plt

# Read the CSV file into a Pandas DataFrame
df = pd.read_csv('cip.log', names=['Timestamp', 'ResponseTime1', 'ResponseTime2', 'ResponseTime3', 'ResponseTime4'])

# Convert the 'Timestamp' column to datetime format
df['Timestamp'] = pd.to_datetime(df['Timestamp'], unit='s')

# Plot the data
plt.figure(figsize=(12, 6))
plt.plot(df['Timestamp'], df['ResponseTime1'], label='ResponseTime1')
plt.plot(df['Timestamp'], df['ResponseTime2'], label='ResponseTime2')
plt.plot(df['Timestamp'], df['ResponseTime3'], label='ResponseTime3')
plt.plot(df['Timestamp'], df['ResponseTime4'], label='ResponseTime4')

# Set labels and title
plt.xlabel('Timestamp')
plt.ylabel('Response Time (ms)')
plt.title('Response Time Over Time')
plt.legend()

# Show the plot
plt.show()

