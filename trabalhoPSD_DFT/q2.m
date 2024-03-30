%questão 2
pkg load signal;
close all;
clear all;
clc;

N= 4;
k=0:N-1;
n=0:N-1;

%criando sinais
x = [1,0,-1,0]
h = [1,2,4,8]

X = fft(x);
H = fft(h);

%conv pela DFT
convDFT = ifft(X.*H)

%conv utilizando cconv
convDIR = cconv(x,h,4)

%plotando os sinais e comparando
subplot(211)
stem(n,convDFT);
title('Convolução pela DFT')
subplot(212)
stem(n,convDIR)
title('Convolução Dirata')

