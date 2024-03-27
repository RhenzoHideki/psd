pkg load signal;
N= 5;
k=0:N-1;
n=0:N-1;
x= [2 1 0 1 0]
figure(1);
subplot(311);
stem(n,x)
title('Sinaç x[n]');
X = fft(x);
Y = X.^2;
y = ifft(Y);
subplot(312);
stem(n,abs(y));
title('Sinal y[n] pela DFT');
subplot(313);
stem(n,cconv(x,x,5));
title('Sinal y[n] pela convolução');
