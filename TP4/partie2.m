clc;close all;clear variables;

%1. Signal et contexte
    [s,Fs] = audioread('ProtestMonoBruit.wav');
    time_max = length(s)/Fs;
    time = 0:time_max/length(s):time_max-(time_max/length(s));
    %Partie affichage
    figure(1)
    plot(time,s)
    axis tight
    xlabel('Temps(s)')
    ylabel('Signal reçu')
    title('Signal reçu à restaurer')
    close all
%2. Estimation de la fonction d'autocorrélation
    %Initialisation des variables
    K = 200
    time_60 = find(time==60);
    time_70 = find(time==70);
    time2 = time(time_60:time_70);
    s2 = s(time_60:time_70);
    %Autocorrélation
    [R,lags] = xcorr(s,K,'biased');
    %Partie affichage
    figure(2)
    plot(time2,s2)
    axis tight
    xlabel('Temps(s)')
    ylabel('Signal reçu')
    title('Signal reçu à restaurer, vu entre T = 60s et T = 70s')
    figure(3)
    plot(lags,R)
    xlabel('Retards')
    ylabel('Corrélations')
    title("Fonction d'autocorrélation calculée pour K = 200")    