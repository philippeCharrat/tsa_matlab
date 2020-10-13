clc;clear variables;close all;

s = genbrfil;
%load('sig.mat');
[sequence] = ESS(s,1,100000,2^17);