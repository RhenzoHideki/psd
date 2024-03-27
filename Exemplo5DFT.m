pkg load signal;
N= 5;
k=0:N-1;
n=0:N-1;
x= [1 3 3 2 0]
h =[1 1 1 1 0];
figure(1);
subplot(411);
stem(n,x)
title('Sinal x[n]');

subplot(412);
stem(n,h);
title('Sinal x[n]');

X = fft(x);
H = fft(h);

Y = X .* H;

y = ifft(Y);

subplot(413);
stem(n,abs(y));
title('Sinal y[n] pela DFT');

subplot(414);
stem(n,cconv(x,h,5));
title('Sinal y[n] pela convolução');
