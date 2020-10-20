clc;close all;clear variables;

nu0 = 100;
b = 160;
A0 = 1;
T = 100;
Fs = 500;
Dnu = 16;
Sp = struct('Fs',Fs,'A',A0,'Fc',nu0,'FM',0,'Phi',0,'T',T,'W',[])
[S,Sp,M] = OOK(Sp) 
plot(S.time,S.data,':r')

Fp = struct('Fs',500,'F0',nu0,'Dnu',Dnu,'order',6,'class','BP filter') ;  
Y = BPF(S,Fp);

puissance = trapz(S.time,(S.data).^2)/100;
puissanceB = trapz(Y.time,(Y.data).^2)/100;
amplitude = max(S.data);
Gamma_S = puissance/(2*b);
nE1 = A0^2 / (4*Gamma_S*Dnu);
nE = A0^2 / (4*Gamma_S*b);
gain = nE1/nE; 


