%Questão 1
pkg load signal;
close all;
clear all;
clc;

N= 8;
k=0:N-1;
n=0:N-1

%Cria o vetor de impulso dos sinais
x1 = [0,1,2,3,2,1,0,0];
x2 = [2,1,0,0,0,1,2,3];

%Faz a DFT de x1
X = fft(x1);
%Desloca X1 em 4
Y = exp(j*pi*2*4*k/8).*X;

%Faz a inversa
y = ifft(Y);

%Compara o resultado com x2
subplot(211)
stem(n,x2)
title('x_2 (n)')
subplot(212)
stem(n,y)
title('x_1 [(n-4) mod 8]')

