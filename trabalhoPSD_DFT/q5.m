%questão 5
pkg load signal;
close all;
clear all;
clc;

N= 9;
k=0:N-1;
n=0:N-1;

%Cria o sinal com tamanho 9 para conv circular
x1 = [1,-2,-1,3,0,0,0,0,0]
x2 = [0,2,0,0,-1,1,0,0,0]
cc = cconv(x1,x2,9);

%Ajusta os sinais para os tamanhos originais
%Faz a convolução linear
x1 = [1,-2,-1,3]
x2 = [0,2,0,0,-1,1]
cl = conv(x1,x2);

%Compara os resultados das convoluções linear e circular
subplot(211)
stem(n,cc);
title('Convolução circular');
subplot(212)
stem(n,cl);
title('Convolução Linear');
