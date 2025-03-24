import numpy as np
from PIL import Image
import glob
import re
import imageio

rgb = np.zeros((480, 640, 3), dtype=np.uint8)

raw_file_list = sorted(glob.glob('pixel_file*.txt'))
print(raw_file_list)

images = []

for raw_file_name in raw_file_list:

    # Open the file in read mode
    with open(raw_file_name, 'r') as file:
        data_into_list = file.read().rstrip().split("\n") 

    x = 0
    y = 0
    d = 0
    count = np.zeros(4)

    # check if the number of pixels is correct
    # should be 640*480*3 = 921600
    if len(data_into_list) != 921600:
        continue

    # count the times of occurance for each number
    for i in range(len(data_into_list)):
        count[int(data_into_list[i])] += 1
    print(count)

    # reading RGB anb scale to 0-255
    for i in range(0, len(data_into_list), 3):
        r = int(data_into_list[i])
        g = int(data_into_list[i+1])
        b = int(data_into_list[i+2])
        a = (r + g + b) 
        if a == 0:
            a = 40
        rgb[x][y][0] = float(r / a) * 255
        rgb[x][y][1] = float(g / a) * 255
        rgb[x][y][2] = float(b / a) * 255
        y += 1

        if(y >= 640):
            y = 0
            x += 1

    # dump all the calculated RGB for debug
    with open('pixel_rgb.txt', 'w') as file:
        for i in range(480):
            for j in range(640):
                for d in range(3):
                    file.write(str(rgb[i][j][d]))
                    file.write(' ')
                file.write('\n')

    # show the image and save to file
    img_file_name = re.sub(r"pixel_file_(\d+)\.txt", r"frame_\1.bmp", raw_file_name)
    print(img_file_name)
    img = Image.fromarray(rgb)
    #img.show()
    img.save(img_file_name)

#for i in range(len(raw_file_list)):
#    file_name = "frame_" + str(i) + ".bmp"
#    images.append(imageio.imread(file_name))
#
#imageio.mimsave('./movie.gif', images)
