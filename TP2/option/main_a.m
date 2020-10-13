clc;clear variables;close all;

tab_gen_s = zeros(16384, 100);
tab_gen_M = zeros(16384, 100);

for i=1:1:101 
    s = genbrfil_a;
    gammas = ESS_a(s,1,10000,2^14);
    tab_gen_s(:,i)= gammas;
    gammam = ESM_a(s,10000,10000,2^14);
    tab_gen_M(i,:)= gammam;
end
var(tab_gen_s)
var(tab_gen_M)
%load('sig.mat');
%ESM(s,10000,500,512);