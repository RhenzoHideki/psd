%questão 3
pkg load signal;
close all;
clear all;
clc;

N= 8;
k=0:N-1;
n=0:N-1;

%criando os sinais
x1 = [1,2,1,1,2,1,1,2]
x2 = [0,1,3,2,0,0,0,0]

%Fazendo a convolução de 8
x3 = cconv(x1,x2,8)

%Plotando o sinal
stem(n,x3)
ylim([0 9]);

%Valor de x3[2] = 9
