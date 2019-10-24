import cv2
import numpy as np
import math
from matplotlib import pyplot as plt

img = cv2.imread('leopard_noise.png', 0)
h, w = img.shape

f = cv2.dft(np.float32(img),flags = cv2.DFT_COMPLEX_OUTPUT)
fshift = np.fft.fftshift(f)
new_fshift = fshift.copy()

spec = 20*np.log(cv2.magnitude(fshift[:,:,0],fshift[:,:,1]))

pixel_sum = [0, 0]

for i in range(0, h):
	for j in range(0, w):

		#pega pontos com luminosidade alta
		if spec[i][j] > 235:

			#raio "seguro" do centro da imagem
			dist = math.hypot(i - h//2, j - w//2)
			if dist > 28: 

				#pega vizinhança 5x5 para media
				for k in range(0, 5): 
					for l in range(0, 5):

					#pega todos pontos menos o errado
						if k != 2 and l != 2:
							pixel_sum += fshift[i+k][j+l]
				new_fshift[i][j] = pixel_sum/24
				pixel_sum = [0, 0]

new_f = np.fft.ifftshift(new_fshift)
new_img = cv2.idft(new_f)
new_img = 20*np.log(cv2.magnitude(new_img[:,:,0],new_img[:,:,1]))

spec2 = 20*np.log(cv2.magnitude(new_fshift[:,:,0],new_fshift[:,:,1]))

#cv2.imwrite('spec.png',spec2)
#cv2.imwrite('img.png',img)
#cv2.imwrite('new_img.png',new_img)

plt.subplot(121),plt.imshow(img, cmap = 'gray')
plt.title('Old Image'), plt.xticks([]), plt.yticks([])
plt.subplot(122),plt.imshow(new_img, cmap = 'gray')
plt.title('New Image'), plt.xticks([]), plt.yticks([])
plt.show()

"""
import cv2
import numpy as np
from matplotlib import pyplot as plt

img = cv2.imread('leopard_noise.png', 0)

f = cv2.dft(np.float32(img),flags = cv2.DFT_COMPLEX_OUTPUT)
fshift = np.fft.fftshift(f)
new_fshift = fshift


mag = 20*np.log(cv2.magnitude(fshift[:,:,0],fshift[:,:,1]))
new_mag = mag.copy()

h, w = mag.shape

base = 2
pixel_sum = 0
for i in range(base, h-base):
	for j in range(base, w-base):
		if mag[i][j] > 220 :
			if (i > (h//2)+50 or i < (h//2)-50):
				if (j > (w//2)+50 or j < (w//2)-50):
					for k in range(0, 4):
						for l in range(0, 4):
							if k != 2 and l != 2:
								pixel_sum += mag[i+k-base][j+l-base]
					new_mag[i][j] = pixel_sum/24
					pixel_sum = 0

cv2.imwrite('spec2.png',new_mag)
cv2.imwrite('spec.png',mag)

new_f = np.fft.ifftshift(new_fshift)
new_img = cv2.idft(new_f)
new_img = cv2.magnitude(new_img[:,:,0],new_img[:,:,1])

plt.subplot(121),plt.imshow(new_img, cmap = 'gray')
plt.title('Input Image'), plt.xticks([]), plt.yticks([])
plt.subplot(122),plt.imshow(new_mag, cmap = 'gray')
plt.title('Magnitude Spectrum'), plt.xticks([]), plt.yticks([])
plt.show()"""

"""
import cv2
import numpy as np
from matplotlib import pyplot as plt

img = cv2.imread('leopard_noise.png',0)
f = np.fft.fft2(img)
fshift = np.fft.fftshift(f)
magnitude_spectrum = 20*np.log(np.abs(fshift))

f_ishift = np.fft.ifftshift(fshift)
img_back = cv2.idft(f_ishift)
img_back = cv2.magnitude(img_back[:,:,0],img_back[:,:,1])

plt.subplot(121),plt.imshow(img_back, cmap = 'gray')
plt.title('Input Image'), plt.xticks([]), plt.yticks([])
plt.subplot(122),plt.imshow(magnitude_spectrum, cmap = 'gray')
plt.title('Magnitude Spectrum'), plt.xticks([]), plt.yticks([])
plt.show()"""