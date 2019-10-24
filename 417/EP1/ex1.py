import cv2
import numpy as np
from matplotlib import pyplot as plt

img = cv2.imread('leopard_noise.png', 0)
histSize = 256
histRange = (0, 256) # the upper boundary is exclusive
accumulate = False
num = int('00001111',2)
img2 = cv2.bitwise_and(img, num)
hist = cv2.calcHist([img],[0], None, [256], [0,256])
hist2 = cv2.calcHist([img2],[0], None, [256], [0,256])

hist_w = 1300
hist_h = 1000
bin_w = int(round( hist_w/histSize ))
histImage = np.full((hist_h, hist_w, 3), 255, dtype=np.uint8)


cv2.normalize(hist2, hist2, alpha=0, beta=hist_h, norm_type=cv2.NORM_MINMAX)
cv2.normalize(hist, hist, alpha=0, beta=hist_h, norm_type=cv2.NORM_MINMAX)

for i in range (1, histSize):
    cv2.line(histImage, ( bin_w*(i-1), hist_h - int(np.round(hist[i-1])) ),
            ( bin_w*(i), hist_h - int(np.round(hist[i])) ),
            ( 255, 0, 0), thickness=2)
    cv2.line(histImage, ( bin_w*(i-1), hist_h - int(np.round(hist2[i-1])) ),
            ( bin_w*(i), hist_h - int(np.round(hist2[i])) ),
            ( 0, 0, 255), thickness=2)
cv2.imshow('leopard',histImage)
cv2.waitKey(0)
