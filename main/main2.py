import matplotlib.pyplot as plt
import numpy as np
from PIL import Image
import os
import subprocess
import json

# PTSD Suffered by Omega#2499
# Creates pixels.json for the Array, grab the contents inside and head into the roblox file for more.

# TRY THIS FIX: os.path.realpath(__file__)

current_dir = os.path.dirname(os.path.realpath(__file__)) + "\\image\\"
# Made it get the path more reliably -Tuna

# Load color image for colormap
img_grab = os.path.join(current_dir, "image\cc.png")

img = Image.open(img_grab)

# Load image and convert to grayscale for height
darkness_img_grab = os.path.join(current_dir, "image\hh.png")

darkness_img = Image.open(darkness_img_grab).convert('L')

# Get image dimensions
width, height = img.size

# Create 2D array of darkness values and color values
pixels = np.zeros((height, width, 4), dtype=np.uint8)

# Loop through image pixels and get darkness and color values
darkness_rows = []
pixel_dict = []
for y in range(height):
    row_list = []
    darkness_row = []
    for x in range(width):
        pixel = darkness_img.getpixel((x, y))
        color_pixel = img.getpixel((x, y))
        pixels[y][x][0] = pixel
        pixels[y][x][1] = color_pixel[0]    
        pixels[y][x][2] = color_pixel[1]
        pixels[y][x][3] = color_pixel[2]

        # Convert RGB values to minimal hex color code
        r, g, b = pixels[y][x][1], pixels[y][x][2], pixels[y][x][3]

        #hex_color = f"#{r//32:x}{g//32:x}{b//32:x}"

        def rgb_to_hex(rgb):
            return '%02x%02x%02x' % rgb
        hex_color = f"#{rgb_to_hex((r, g, b))}"

        if pixel == 0:
            pixel = 1

        # Add pixel data to list, d stands for darkness, h stands for hex.
        row_list.append({
            'd': pixel,
            'h': hex_color
        })

        # Add pixel darkness value to row list
        darkness_row.append(pixel)

    # Add row data to main list
    pixel_dict.append(row_list)

    # Add row darkness values to main list
    darkness_rows.append(darkness_row)

# Write pixel dictionary to JSON file
json_string = json.dumps(pixel_dict)
json_string_with_newlines = json_string.replace('],', '],\n')
json_string_with_newlines = json_string_with_newlines.replace('[[', '[\n[')
json_string_with_newlines = json_string_with_newlines.replace(']]', ']\n]')

# Write JSON string to a file
with open('pixels.json', 'w') as json_file:
# Same issue as before, removed \main as it caused problems. -Tuna
    json_file.write(json_string_with_newlines)

    
# Create 2D array of darkness values
darkness_pixels = np.array(darkness_rows)

'''
flipped_pixels = np.fliplr(darkness_pixels)
pixel_dict = {}
for i, row in enumerate(flipped_pixels):
    pixel_dict[i] = row.tolist()
json_string = json.dumps(pixel_dict)
json_string_with_newlines = json_string.replace('],', '],\n')
with open('pixels.json', 'w') as json_file:
    json_file.write(json_string_with_newlines)
pixel_dict = {}
for i, row in enumerate(flipped_pixels):
    pixel_dict[i] = [f"#{int(value):02x}" for value in row]
json_string = json.dumps(pixel_dict)
json_string_with_newlines = json_string.replace('],', '],\n')

with open('pixels.json', 'w') as json_file:
    json_file.write(json_string_with_newlines)
'''

'''
with open('pixels.csv', 'w', newline='') as csvfile:
    writer = csv.writer(csvfile, delimiter='\t')
    for i, row in enumerate(flipped_pixels):
        if i < len(flipped_pixels) - 1:
            writer.writerow(["{" + ", ".join([str(val) for val in row]) + "},"])
        else:
            writer.writerow(["{" + ", ".join([str(val) for val in row])[:-1] + "}"])
'''

# Plot colored pixels as a heatmap
plt.imshow(darkness_pixels)

script_path = ".lune\gen.luau"
input_json = "pixels.json"

# Join the current directory with the relative paths
script_path = os.path.join(current_dir, script_path)
input_json = os.path.join(current_dir, input_json)

# Run Powershell commands to start lune mapGeneration program
subprocess.run([
    "lune",
    script_path,
    input_json,
])
