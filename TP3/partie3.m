clc;close all;clear variables;

% --- Initialisation des variables 
nu0 = 100;
b = 160;
A0 = 1;
T = 100;
Fs = 500;
RC = 2;
delta_v = 16;

% --- initialisation du filtre passe-bas 
Fp = struct('Fs',500,'F0',nu0,'Dnu',16,'order',6,'class','BP filter') ;
% --- Initialisation du bruit ---- 
Xp = struct('sigma',sqrt(5),'Fs',Fs,'B',b,'T',T) ;
[X,Xp] = CGN(Xp);
% --- Initialisation de la séquence ON-OFF
Sp = struct('Fs',Fs,'A',A0,'Fc',nu0,'FM',0.0,'Phi',0,'T',T,'W',[]);
[S,Sp,M] = OOK(Sp);

% --- Affichage des puissances des signaux d'origine 
Zs = SquareSig(S);
moyenneSignalOrigin = mean(Zs.data)
Xs = SquareSig(X);
moyenneBruitOrigin = mean(Xs.data)

% --- Création de la séquence avec du bruit ---
Signalbruite = AddSig(X,S);

% --- Filtrage du signal bruité avec le filtre ---
Y = BPF(Signalbruite,Fp);
Z = SquareSig(Y);

RC = 200/delta_v
RCFp = struct('Fs',Fs,'RC',RC);
[Wb,RCFp] = RCF(Z,RCFp);
% --- Calcul de la moyenne, l'écart-type et le Kutosis sans le régime transitoire
itrue = Wb.time >= 5*RCFp.RC;
moyenne = mean(Wb.data(itrue));
variance = (std(Wb.data(itrue))).^2;
kurtosi = kurtosis(Wb.data(itrue));
Z_wb = SquareSig(Wb);

figure(4) 
subplot(4,1,1)
plot(S.data);
xlabel("temps");
ylabel("Amplitude");