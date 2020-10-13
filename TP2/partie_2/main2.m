clc;clear variables;close all;

%s = genbrfil;
load('../sig.mat');
%ESS2(s,1,100000,2^14);
ESM2(s,100000,5000,2^12);
%ESW(s,10000,'rectwin',500,250,512);
