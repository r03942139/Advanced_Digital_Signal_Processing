clc; clear all;
%% Discrete Fourier Transform for two Real Inputs 
x = rand(1,10);
y = rand(1,10);
XX = fft(x);
YY = fft(y);
[fx,fy]=fftreal(x,y);

%% Detection
exp1 = sum(abs(XX-fx));
exp2 = sum(abs(YY-fy));

if exp1<0.001 && exp1<0.001
    disp('the FFT is also legal by using only one N-point FFT');
else
    disp('Not legal');
end
