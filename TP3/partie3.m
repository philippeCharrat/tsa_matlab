clc;close all;clear variables;

% --- Initialisation des variables 
nu0 = 100;
b = 160;
A0 = 1;
T = 100;
Fs = 500;
delta_v = 16;

% --- initialisation du filtre passe-bas 
Fp = struct('Fs',500,'F0',nu0,'Dnu',16,'order',6,'class','BP filter') ;
% --- Initialisation du bruit ---- 
Xp = struct('sigma',sqrt(5),'Fs',Fs,'B',b,'T',T) ;
[X,Xp] = CGN(Xp);
% --- Initialisation de la s�quence ON-OFF
Sp = struct('Fs',Fs,'A',A0,'Fc',nu0,'FM',0.05,'Phi',0,'T',T,'W',[]);
[S,Sp,M] = OOK(Sp);

% --- Affichage des puissances des signaux d'origine 
Zs = SquareSig(S);
moyenneSignalOrigin = mean(Zs.data)
Xs = SquareSig(X);
moyenneBruitOrigin = mean(Xs.data)

% --- Cr�ation de la s�quence avec du bruit ---
Signalbruite = AddSig(X,S);

% --- Filtrage du signal bruit� avec le filtre ---
Y = BPF(Signalbruite,Fp);
Z = SquareSig(Y);

RC = 20/delta_v
RCFp = struct('Fs',Fs,'RC',RC);
[Wb,RCFp] = RCF(Z,RCFp);
% --- Calcul de la moyenne, l'�cart-type et le Kutosis sans le r�gime transitoire
itrue = Wb.time >= 5*RCFp.RC;
moyenne = mean(Wb.data(itrue));
variance = (std(Wb.data(itrue))).^2;
kurtosi = kurtosis(Wb.data(itrue));
Z_wb = SquareSig(Wb);

% --- Cr�ation du signal final --- 
nombre_indice = length(Wb.data);
signal_final = zeros(1,nombre_indice);

% --- Parcours du signal en sortit du filtre 
for i =1:nombre_indice
    % Si la valeur i du signal est sup�rieur aux filtres alors on l'ajoute
    % dans le nouveaux signal.
    if Wb.data(i) >= 0.71
        signal_final(i) = 1;
    end 
end

figure(4) 
subplot(4,1,1)
plot(S.data);
xlabel("temps");
ylabel("Amplitude");
title("Signal d'origine");
subplot(4,1,2)
plot(Signalbruite.data);
xlabel("temps");
ylabel("Amplitude");
title("Signal Bruit�");
subplot(4,1,3)
plot(Wb.data);
xlabel("temps");
ylabel("Amplitude");
title("Signal en sortie du filtre");
subplot(4,1,4)
plot(signal_final, '.r');
xlabel("temps");
ylabel("Amplitude");
title("Signal final");

load SignalRecu_21
[TxMsg,Xp] = RxMessage_DQ(X,Xp) ;
