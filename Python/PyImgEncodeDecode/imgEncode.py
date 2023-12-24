import base64
from PIL import Image
import io
import sys

# Usage:
# PowerShell
# python .\imgEncode.py (& Write-Output "gq36.jpg", "gq36.encode")
# Bash
# python3 ./imgEncode.py "gq36.encode" "gq36.jpg"

# Access command-line parameters
params = sys.argv[1:]

input = params[0]
export = params[1]

# Encode Image to Base64
with open(input, "rb") as image_file:
    encoded_text = base64.b64encode(image_file.read()).decode("utf-8")

# Save the encoded text to a file
with open(export, "w") as text_file:
    text_file.write(encoded_text)

