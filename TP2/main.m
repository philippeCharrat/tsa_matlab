clc;clear variables;close all;

s = genbrfil;
%load('sig.mat');
ESS(s,1,1000,2^10);
%ESM(s,10000,500,512);
%ESW(s,10000,'rectwin',500,250,512);

