import discord

def get_token(file_path):
    with open(file_path, 'r') as file:
        return file.read().strip()

TOKEN_FILE = "token"
TOKEN = get_token(TOKEN_FILE)
CHANNEL_ID = 1224441296773713960

class MyClient(discord.Client):
    async def on_ready(self):
        print(f'Logged in as {self.user}')
        channel = self.get_channel(CHANNEL_ID)
        if channel:
            async for message in channel.history(limit=10):  # Fetch last 10 messages
                print(f'{message.author}: {message.content}')

    async def on_message(self, message):
        if message.channel.id == CHANNEL_ID and not message.author.bot:
            print(f'New message: {message.author}: {message.content}')
            # Here you can send data to Minecraft

client = MyClient()
client.run(TOKEN)
