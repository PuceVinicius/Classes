#implementação fortemente baseada no notebook disponível
#pelo siamxt

import numpy as np # numpy is the major library in which siamxt was built upon
                   # we like the array programming style =)

# We are using PIL to read images     
from PIL import Image

# and matplotlib to display images
import matplotlib.pyplot as plt

import time # Let's measure some processing times

import siamxt  

# Loading the image.
# Make sure the image you read is either uint8 or uint16
img = np.asarray(Image.open("fruit.png"))
print("Image dimensions: %dx%d pixels" %img.shape)

#Displaying the image
fig = plt.figure()
plt.imshow(img, cmap='Greys_r')
plt.axis('off')
plt.title("Original image")


#Structuring element with connectivity-8
Bc = np.ones((3,3),dtype = bool)

# Negating the image
img_max = img.max()
img_neg = img_max-img

# Area threshold
area = 40

#Building the max-tree of the negated image, i.e. min-tree
mxt_neg = siamxt.MaxTreeAlpha(img_neg,Bc)

# Making a hard copy of the max-tree
mxt_neg2 = mxt_neg.clone()

#Applying an area-open filter
mxt_neg.areaOpen(area)

#Recovering the image 
img_filtered =  mxt_neg.getImage()

# Negating the image back
img_filtered = img_max -img_filtered

#Displaying the filtered image
fig = plt.figure()
plt.imshow(img_filtered, cmap='Greys_r')
plt.axis('off')
plt.title("area-open, area = %d " %area)
plt.show()