clear all; clc;
% Main
%% 2k-point Walsh transform 
size = 8; W8 = Walsh(size)
size = 16; W16 = Walsh(size)
size = 7; W = Walsh(size)  % Must has error message

