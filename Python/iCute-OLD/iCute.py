import discord
import time
import icmplib

# Next, we create an instance of a Client. This client is our connection to Discord.
client = discord.Client()

@client.event
async def on_ready():
    print('We have logged in as {0.user}'.format(client))


# TODO
# Add more advanced logic to translate the results into non-tech savvy people readable information.
# Perhaps make it a command that accepts parameters. Protect it of course.
# Make the command trigger when someone mentions me maybe?

# Global variables.
botBusy = False

@client.event
async def on_message(message):
    global bot_busy
    if not bot_busy:
        if message.author != client.user:
            if message.content.startswith("$ctp"):
                bot_busy = True
                async with message.channel.typing():
                    await message.channel.send("{} requested command!".format(message.author))
                    await message.channel.send("Checking if Tsu can play! Please wait...")

                    # Capture initial time when starting timer. NOTE: time.perf.counter() returns time in seconds. So
                    # simply multiply by 1000 to get milliseconds! \o/
                    timer_init = time.perf_counter()

                    # icmplib.ping(address, count=4, interval=1, timeout=2)
                    ping_object = icmplib.ping("8.8.8.8", 10, 1, 2)
                    prep_str = "Max: %d ms\nMin: %d ms\nDropped Packets: %d\nAverage Latency: %d ms" % (ping_object.max_rtt, ping_object.min_rtt, ping_object.packet_loss, ping_object.avg_rtt)
                    await message.channel.send(prep_str)

                    # Calculate the duration of the timer.
                    time_passed_ms = round((time.perf_counter() - timer_init), 2)
                    await message.channel.send("Command processed in: {} seconds.".format(time_passed_ms))
    else:
        await message.channel.send("Sorry, {}! Bot busy: {}".format(message.author, bot_busy))


# Use secret token to run the bot. Makes it go online.
client.run("TOKENHERE")