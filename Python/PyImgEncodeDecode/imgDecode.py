import base64
from PIL import Image
import io
import sys

# Usage:
# PowerShell
# python .\imgDecode.py (& Write-Output "gq36.encode", "gq36.jpg")
# Bash
# python3 ./imgDecode.py "gq36.encode" "gq36.jpg"

# Access command-line parameters
params = sys.argv[1:]

input = params[0]
export = params[1]

with open(input, "rb") as encoded_file:
    # Read the encoded text
    encoded_text = encoded_file.read()

# Decode Base64 back to Image
decoded_data = base64.b64decode(encoded_text)
decoded_image = Image.open(io.BytesIO(decoded_data))
decoded_image.save(export)
