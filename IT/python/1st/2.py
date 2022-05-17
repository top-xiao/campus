# -*- coding:utf-8 -*-

import numpy as np
import cv2
import matplotlib.pyplot as plt

# 準備した画像の読み込み
img = cv2.imread("2.jpg")

# グレースケールに変換
gray_img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

# cannyで輪郭を強調
canny_img= cv2.Canny(gray_img, 50, 150)
# 結果を出力
plt.imshow(gray_img)

# 結果を保存
cv2.imwrite("canny_image_1.jpg", canny_img)
