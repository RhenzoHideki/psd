pkg load signal;
N= 10;
k=0:N-1;
n=0:N-1;
x= [1 1 1 1 1 1 0 0 0 0];

figure(1);
subplot(211);
stem(n,x)
title('Sinal x[n]');
X = fft(x);
Y = X.*conj(X);
y = ifft(Y);
subplot(212);
stem(n,abs(y));
title('Sinal y[n] pela DFT');
%subplot(313);
%stem(n,cconv(x,conj(x),10));
%title('Sinal y[n] pela convolução');
