import numpy as np 
from scipy import signal

ksize = 3      															#ksize x ksize convolution kernel
im_size = 28   															#im_size x im_size input activation map

def strideConv(arr, arr2, s): 											  #the function that performs the 2D convolution
    return signal.convolve2d(arr, arr2[::-1, ::-1], mode='valid')[::s, ::s]

kernel =  np.arange(0,ksize*ksize,1).reshape((ksize,ksize))                   #the kernel is a matrix of increasing numbers
act_map = np.tile(np.arange(5)  , (im_size*im_size // 5 + 1 ))[:im_size*im_size].reshape((im_size,im_size))           #the activation map is a matrix of increasin numbers

conv = strideConv(act_map,kernel,1)
print(kernel)
print()
print(act_map)
print()
print(conv) 