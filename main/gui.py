import PySimpleGUI as sg
from PIL import Image
import os
import subprocess



current_dir = os.path.dirname(os.path.realpath(__file__))
condition = False
height = False
color = False

layout = [
    [sg.Text("Select an image:")],
    [sg.Input(key="-FILE1-", enable_events=True, visible=False), sg.FileBrowse('Height', file_types=(("Image Files", "*.png"),)), sg.Image(key="-IMAGE1-", size=(15, 150))],
    [sg.Input(key="-FILE2-", enable_events=True, visible=False), sg.FileBrowse('Color', file_types=(("Image Files", "*.png"),)), sg.Image(key="-IMAGE2-", size=(15, 150))],
    [sg.Radio('Both Color and Height', "HEIGHTCOLOR1", key='-COLORR-', default=True),sg.Radio('Only Height', "HEIGHTCOLOR1", key='-HEIGHTR-')],
    [sg.Checkbox("Optimise Color", default=True, key="-COLOR1-", enable_events=True), sg.Checkbox("Optimise Height", key="-HEIGHT1-", enable_events=True)],
    [sg.Text("Optimization Value:"), sg.Input(key="-QUANT-", default_text="25", size=(2,1))],
    [sg.Submit(key="-PROG-"), sg.Save()]
]

window = sg.Window("RoGen GUI", layout)
window.bind("<Return>", "pressEnter")

def resize_image(image_path, quant, quant_apply, max_size=(400, 400)):
    img = Image.open(image_path)
    if quant_apply:
        img = img.quantize(int(quant))
    img.thumbnail(max_size)
    temp_file = "temp.png"
    img.save(temp_file)
    return temp_file
def launchprogram(heightLoc, colorLoc, colorB, heightB, height_onlyB, quantVar): 
    subprocess.run(["python", current_dir + "/main2.py", str(heightLoc), str(colorLoc), str(colorB), str(heightB), str(height_onlyB), str(quantVar)])

while True:
    event, values = window.read()
    if event == "Exit" or event == sg.WIN_CLOSED:
        break
    print(height, color)

    '''
    if values["-COLOR1-"] and color is True:
        temp_file = resize_image(color_path, values["-QUANT-"], True)
        window["-IMAGE2-"].update(filename=temp_file)
    elif color is True:
        temp_file = resize_image(color_path, values["-QUANT-"], False)
        window["-IMAGE2-"].update(filename=temp_file)
    if values["-HEIGHT1-"] and height is True:
        temp_file = resize_image(height_path, values["-QUANT-"], True)
        window["-IMAGE1-"].update(filename=temp_file)
    elif height is True:
        temp_file = resize_image(height_path, values["-QUANT-"], False)
        window["-IMAGE1-"].update(filename=temp_file)
    '''

    if color is True:
        temp_file = resize_image(color_path, values["-QUANT-"], values["-COLOR1-"])
        window["-IMAGE2-"].update(filename=temp_file)
    if height is True:
        temp_file = resize_image(height_path, values["-QUANT-"], values["-HEIGHT1-"])
        window["-IMAGE1-"].update(filename=temp_file)

    if event in ("-PROG-", "pressEnter"):
        failure_state = 0
        optimize_color = values["-COLOR1-"]
        optimize_height = values["-HEIGHT1-"]
        height_or_color = 0 if values["-COLORR-"] else 1
        height_image = values["-FILE1-"]
        if values["-FILE1-"] == "":
            sg.Popup('No Height Map Present', 'Please input a height map!')
            failure_state += 100
        if height_or_color == '1':
            color_image = height_image
        else:
            color_image = values["-FILE2-"]
            if values["-FILE2-"] == "" and height_or_color == 0:
                sg.Popup('No Color Map Present!', 'Please input a color map or use the program in height only mode!')
                failure_state += 10
                window.Element('-HEIGHTR-').update(value=True)
                color_image = height_image
            

        

        print(height_image, color_image, optimize_color, optimize_height, height_or_color, values["-QUANT-"])
        if failure_state > 0:
            print("FAIL! Error Code:", failure_state)
        else:
            launchprogram(height_image, color_image, optimize_color, optimize_height, height_or_color, values["-QUANT-"])
            sg.Popup('Success!', 'Succesfully created a new map.')
        

    elif event in ["-FILE1-", "-FILE2-"]:
        image_path = values[event]
        if image_path:
            temp_file = resize_image(image_path, values["-QUANT-"], False)
            # Correctly convert the event name to the key of the image element
            image_key = "-IMAGE" + event[-2:]
            if image_key == "-IMAGE1-":
                height = True
                height_path = image_path
            if image_key == "-IMAGE2-":
                color = True
                color_path = image_path
            window[image_key].update(filename=temp_file)
        

            
window.close()
