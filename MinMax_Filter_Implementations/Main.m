%% ADSP HW1  
clc;clear;
tic;
%% Parameters
N = 19; k = (N-1)/2;     % Filter length N=19, k=(N-1)/2=9
fs = 4000;             % Sampling frequency = 4000Hz
delta = 0.001;  
F = 0:delta:0.5; % Normalized frequency interval 
Hd = [zeros(1, 0.2/delta) ones(1,0.3/delta+1)]; % Desired HPF  , Stop-band 0~800Hz <=> F: 0~ 0.2 (800/4000)
trans = [700/fs , 900/fs]; % Normalized transition band: (700~900)/fs 
    % ==== Weighting function: W(F) = 1 for passband, W(F) = 0.5 for stopband.
W = [ 0.5*ones(1,round(trans(1)/delta+1)) zeros(1,round((trans(2)-trans(1))/delta)-1) ones(1,round((0.5-trans(2))/delta+1))];
    % ===============================================================    
Delta = 0.0001; %maxima error DELTA = 0.0001 in Step 5.

%% Step 1. Guessing (k+2) Extreme points
% N = 19, k = (N-1)/2 = 9, k+2 = 11 and exclude the transition band F=[0.175 0.225]
exf = [0.01 0.03 0.08 0.13 0.24 0.29 0.32 0.37 0.42 0.47 0.50]; % Random Assign by Myself
                                                        % Just avoid the transition band                                                                                                   
%% Output Function
% ========= Input =========
% F: Normalized Frequency Interval       Hd: Desired Fiter Hd(F)
% W: weighting function W(F)              N: filter length N
% exF: arbitrary extreme frequency      DEL: Set the maxima error DELTA in Step 5.

n = 0:N-1;
[R, h, MaxerrF] = MiniMaxFilter(F,Hd,W,N,exf,Delta);
% ============= Output ========
% R: designed filter R(f)
% h: Impulse response h[n] of the designed filter R(f)
% MaxErrF: The maximal error for each iteration
%% Frequency response (Normalized freq.)
figure(1);
plot(F*fs,Hd,F*fs,R,'linewidth',1.5);
title('Frequency response R(F)');
xlabel('F');
grid on;
%% Impulse response h[n]
figure(2);
stem(n,h,'b','linewidth',1.5);
title('Impulse response h[n]');
xlabel('n');
ylabel('h[n]');
grid on;

figure(3)
plot(n,abs(h),'b','linewidth',1.5);
title('Amplitude response of h[n]');
xlabel('n');
ylabel('phase');
grid on;

figure(4)
freqz(h);

disp('The maximal error for each iteration');
disp(sprintf('Iteration \t Maximal error'));
for itera = 1:length(MaxerrF)
    disp(sprintf('\t%d\t\t\t%f', itera, MaxerrF(itera)));
end
disp('  ');
toc;