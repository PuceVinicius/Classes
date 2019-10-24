print("Não fiz :(")
'''
import cv2
import numpy as np
import math
from matplotlib import pyplot as plt

img = cv2.imread('menino.png')
h, w, _ = img.shape

b, g, r = cv2.split(img)



kernel = cv2.getGaussianKernel(11,10)
kernel = kernel*kernel.T



#RED
f = cv2.dft(np.float32(r),flags = cv2.DFT_COMPLEX_OUTPUT)
rfshift = np.fft.fftshift(f)

red_spec = 20*np.log(cv2.magnitude(rfshift[:,:,0],rfshift[:,:,1]))

red_th = cv2.adaptiveThreshold(red_spec.astype('uint8'),255, \
			cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY,15,-25)

red_th = cv2.dilate(red_th, kernel)

#GREEN
f = cv2.dft(np.float32(g),flags = cv2.DFT_COMPLEX_OUTPUT)
gfshift = np.fft.fftshift(f)

green_spec = 20*np.log(cv2.magnitude(gfshift[:,:,0],gfshift[:,:,1]))

green_th = cv2.adaptiveThreshold(green_spec.astype('uint8'),255, \
			cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY,15,-25)

green_th = cv2.dilate(green_th, kernel)

#BLUE
f = cv2.dft(np.float32(b),flags = cv2.DFT_COMPLEX_OUTPUT)
bfshift = np.fft.fftshift(f)

blue_spec = 20*np.log(cv2.magnitude(bfshift[:,:,0],bfshift[:,:,1]))

blue_th = cv2.adaptiveThreshold(blue_spec.astype('uint8'),255, \
			cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY,15,-25)

blue_th = cv2.dilate(blue_th, kernel)

for i in range(0, h):
	for j in range(0, w):
		#raio "seguro" do centro da imagem
		dist = math.hypot(i - h//2, j - w//2)
		if dist > 29:
			if red_th[i][j] > 0:
				rfshift[i][j] = 0


plt.subplot(121),plt.imshow(red_th, cmap = 'gray')
plt.title('Máscara'), plt.xticks(), plt.yticks([])
plt.subplot(122),plt.imshow(20*np.log(cv2.magnitude(rfshift[:,:,0],rfshift[:,:,1])), cmap = 'gray')
plt.title('Espectro de Magnetude'), plt.xticks(), plt.yticks([])
plt.show()


#---------------------------------------------------------------------
#red
new_rf = np.fft.ifftshift(rfshift)
new_img = cv2.idft(new_rf)
new_r = cv2.magnitude(new_img[:,:,0],new_img[:,:,1])


#green
new_gf = np.fft.ifftshift(gfshift)
new_img = cv2.idft(new_gf)
new_g = cv2.magnitude(new_img[:,:,0],new_img[:,:,1])


#blue
new_bf = np.fft.ifftshift(bfshift)
new_img = cv2.idft(new_bf)
new_b = cv2.magnitude(new_img[:,:,0],new_img[:,:,1])


initial_img = cv2.merge((r, g, b))
final_img = cv2.merge((new_r, new_g, new_b))

#-------------PRINCESA-------------

img2 = cv2.imread('princesa.png')

h, w, _ = img2.shape

b, g, r = cv2.split(img2)



#RED
f = cv2.dft(np.float32(r),flags = cv2.DFT_COMPLEX_OUTPUT)
rfshift = np.fft.fftshift(f)

red_spec = 20*np.log(cv2.magnitude(rfshift[:,:,0],rfshift[:,:,1]))

red_th = cv2.adaptiveThreshold(red_spec.astype('uint8'),255, \
			cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY,15,-25)

red_th = cv2.dilate(red_th, kernel)

for i in range(0, h):
	for j in range(0, w):
		#raio "seguro" do centro da imagem
		dist = math.hypot(i - h//2, j - w//2)
		if dist > 29:

			if red_th[i][j] > 0:
				rfshift[i][j] = 0


#---------------------------------------------------------------------
#red
new_rf = np.fft.ifftshift(rfshift)
new_img = cv2.idft(new_rf)
new_r = cv2.magnitude(new_img[:,:,0],new_img[:,:,1])


#green
new_gf = np.fft.ifftshift(gfshift)
new_img = cv2.idft(new_gf)
new_g = cv2.magnitude(new_img[:,:,0],new_img[:,:,1])


#blue
new_bf = np.fft.ifftshift(bfshift)
new_img = cv2.idft(new_bf)
new_b = cv2.magnitude(new_img[:,:,0],new_img[:,:,1])


initial_img2 = cv2.merge((r, g, b))
final_img2 = cv2.merge((new_r, new_g, new_b))


plt.subplot(223),plt.imshow(initial_img2, cmap = 'gray')
plt.title('Princesa original'), plt.xticks(), plt.yticks([])
plt.subplot(224),plt.imshow(final_img2/180000000, cmap = 'gray')
plt.title('Princesa sem ruído'), plt.xticks(), plt.yticks([])
'''
'''
plt.subplot(323),plt.imshow(green_th, cmap = 'gray')
plt.title('Spectrum'), plt.xticks([]), plt.yticks([])
plt.subplot(324),plt.imshow(gfshift, cmap = 'gray')
plt.title('Colored Image'), plt.xticks(), plt.yticks([])
plt.subplot(325),plt.imshow(red_th, cmap = 'gray')
plt.title('Colored Image'), plt.xticks(), plt.yticks([])
plt.subplot(326),plt.imshow(rfshift, cmap = 'gray')
plt.title('Colored Image'), plt.xticks(), plt.yticks([])
'''
'''
plt.show()

'''
'''
import cv2
import numpy as np
import math
from matplotlib import pyplot as plt

img = cv2.imread('menino.png')
h, w, _ = img.shape
channel_b, channel_g, channel_r = cv2.split(img)


#blue
bluef = np.fft.fft2(channel_b)
bluefshift = np.fft.fftshift(bluef)

#new_blue = cv2.adaptiveThreshold(channel_b, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY, 5, -25)

new_bluef = np.fft.ifftshift(bluefshift)
new_blueimg = np.fft.ifft2(new_bluef)
new_blueimg = np.abs(new_blueimg)



#green
greenf = np.fft.fft2(channel_g)
greenfshift = np.fft.fftshift(greenf)

new_greenf = np.fft.ifftshift(greenfshift)
new_greenimg = np.fft.ifft2(new_greenf)
new_greenimg = np.abs(new_greenimg)




#red
redf = np.fft.fft2(channel_r)
redfshift = np.fft.fftshift(redf)

new_redf = np.fft.ifftshift(redfshift)
new_redimg = np.fft.ifft2(new_redf)
new_redimg = np.abs(new_redimg)

print(bluef.shape)
print(bluefshift.shape)
print(new_bluef.shape)
print(new_blueimg.shape)


final_img = cv2.merge((new_redimg, new_greenimg, new_blueimg))

#plt.subplot(121),plt.imshow(channel_b, cmap = 'gray')
#plt.title('Colored Image'), plt.xticks(), plt.yticks([])
plt.subplot(122),plt.imshow(final_img, cmap = 'gray')
plt.title('Spectrum'), plt.xticks([]), plt.yticks([])
plt.show()

'''

'''
plt.subplot(333),plt.imshow(new_blueimg, cmap = 'gray')
plt.title('Colored Image'), plt.xticks(), plt.yticks([])
plt.subplot(334),plt.imshow(channel_g, cmap = 'gray')
plt.title('Spectrum'), plt.xticks([]), plt.yticks([])
plt.subplot(335),plt.imshow(greenspec, cmap = 'gray')
plt.title('Colored Image'), plt.xticks(), plt.yticks([])
plt.subplot(336),plt.imshow(new_greenimg, cmap = 'gray')
plt.title('Spectrum'), plt.xticks([]), plt.yticks([])
plt.subplot(337),plt.imshow(channel_r, cmap = 'gray')
plt.title('Colored Image'), plt.xticks(), plt.yticks([])
plt.subplot(338),plt.imshow(redspec, cmap = 'gray')
plt.title('Spectrum'), plt.xticks([]), plt.yticks([])
plt.subplot(339),plt.imshow(new_redimg, cmap = 'gray')
plt.title('Colored Image'), plt.xticks(), plt.yticks([])
plt.show()
'''
