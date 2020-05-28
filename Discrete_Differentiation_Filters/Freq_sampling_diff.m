clear all;
close all;
clc;
%% Parameter 
k = 8;
df = 0.0001;

F = [0 : df : 0.5 , -0.5 : df : 0-df]; %Normalized Freq.  0 ~ end

N = 2*k + 1;    % 17
dn = length(F) / N;   % delta n
n = floor(1:dn:length(F));  % sampling points

nn = -k:1:k;  % -k ~ 0 ~ k, N points in total (2k+1)
ff = 0:df:1;
sample_F = ff(n);
%% (Step1)  Ideal Diff filter Hd(f)
H = 1j * 2 * pi * F;  % F = -0.5 ~ 0.5  only imaginary part

%% (Step2) 
R = H(n);   % F = 0 ~ 1 (normalized)
rn = ifft(R);  % n = -8 ~ 8
%% (Step3)
RF = fft(rn, length(F));   % R[F]   -8 ~ 8
%% (Step4)
hn = [ rn(k+2:end) , rn(1:k+1) ];  % h[n] Time-domain Shifting  n = 0 ~ 16

%% Ploting  
figure(1);
plot(0:df:1, imag(H), 'b');

hold on;
plot(sample_F, imag(R), 'go');  % Sampling points 
plot(0:df:1, imag(RF), 'r');    % 
hold off;

title(['Freq. Response that k = ', num2str(k)]);
xlabel('Normalized Freq. (Hz)');
legend('Ideal Filter Hd(F)', 'Sampling Point', 'Recovered Filter R(F)');
       
figure(2); 
stem(nn, real(hn));
title(['Designed Filter h[n] that k = ', num2str(k)]);
