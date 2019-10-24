import cv2
import numpy as np

img = cv2.imread('plantacao.jpg',0)
h, w = img.shape

img = img.astype(np.float64)
f = np.fft.fft2(img)
fshift = np.fft.fftshift(f)

line = []
#parte superior
for i in range((h//2)-115, (h//2)+115): #isola a parcela da imagem 
    for j in range((w//2)-115, (w//2)+115): #que será testada
        if len(line) == 8:
            break
        if (fshift[i][j] > 3800000 and  #ponto muito claro
        (i not in (range(h//2-3, h//2+3))) and 
        (j not in (range(w//2-3, w//2+3)))): #fora dos eixos
            line.append(i)
            line.append(j)

#parte inferior
for i in range((h//2)+115, (h//2)-115, -1): #isola a parcela da imagem
    for j in range((w//2)+115, (w//2)-115, -1): #que será testada
        if len(line) == 16:
            break
        if (fshift[i][j] > 3800000 and #ponto muito claro
        (i not in (range(h//2-3, h//2+3))) and 
        (j not in (range(w//2-3, w//2+3)))): #fora dos eixos
            line.append(i)
            line.append(j)

#media entre x e y de quatro pontos da esquerda
left_x = (line[0] + line[2] + line[4] + line[6])/4
left_y = (line[1] + line[3] + line[5] + line[7])/4

#media entre x e y de quatro pontos da direita
right_x = (line[8] + line[10] + line[12] + line[14])/4
right_y = (line[9] + line[11] + line[13] + line[15])/4

m1 = (right_y - left_y)/(right_x - left_x)
result = 90 - m1
print(result)
