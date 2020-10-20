clc;close all;clear variables;

nu0 = 100;
b = 160;
A0 = 1;
T = 100;
Fs = 500;
Dnu = 10;
RC = 2;
Sp = struct('Fs',Fs,'A',A0,'Fc',nu0,'FM',0.05,'Phi',0,'T',T,'W',[])
[S,Sp,M] = OOK(Sp) 
plot(S.time,S.data,':r')

Xp = struct('sigma',sqrt(5),'Fs',Fs,'B',b,'T',T) ;
[B,Xp] = CGN(Xp);
X = AddSig(B,S);

Fp = struct('Fs',500,'F0',nu0,'Dnu',Dnu,'order',6,'class','BP filter') ;  
Y = BPF(X,Fp);

Z = SquareSig(Y);

RCFp = struct('Fs',Fs,'RC',RC);
[Wb,RCFp] = RCF(Z,RCFp);

figure(2)
subplot(221)
plot(S.time,S.data)
title("Signal d'origine (S(t))")
subplot(222)
plot(Y.time,Y.data)
title("Signal bruité filtré (Y(t))")
subplot(223)
plot(Z.time,Z.data)
title("Signal au carré (Z(t))")
subplot(224)
plot(Wb.time,Wb.data)
title("Signal après le filtre RC (W(t))")

% puissance = trapz(S.time,(S.data).^2)/100;
% puissanceB = trapz(Y.time,(Y.data).^2)/100;
% amplitude = max(S.data);
% Gamma_S = puissance/(2*b);
% nE1 = A0^2 / (4*Gamma_S*Dnu);
% nE = A0^2 / (4*Gamma_S*b);
% gain = nE1/nE; 