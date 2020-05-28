% Discrete Fourier Transform for two Real Inputs 
function [fx,fy]=fftreal(x,y)

z = x + 1i*y;
fz = fft(z);
N = length(fz);

fzz(1) = fz(1);
fzz(N:-1:2) = fz(2:N);
fx = (fz + conj(fzz))/2;
fy = (fz - conj(fzz))/2/1i;

end


