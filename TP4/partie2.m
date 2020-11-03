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
    close all
%3. Identification du modèle AR(M)
    %Initialisation des variables
    M = 20;
    lag_0 = find(lags==0);
    %Création du vecteur r pour la fonction toeplitz.m
    r = zeros(1,M+1);
    r(1) = R(lag_0);
    for k = 1:1:M
        r(k+1) = R(lag_0 + k);
    end
    %Création de la matrice de Toeplitz
    tpz = toeplitz(r);
    %Pseudo-inversion pour résoudre le système 
    inv_tpz = pinv(tpz);
    %Vecteur contenant les résultats du système
    result = zeros(M+1,1);
    result(1) = 1;
    %Matrice des h/sigma^2
    phi = inv_tpz*result;
    h = zeros(M+1,1);
    %Division des termes par phi(1) = 1/sigma^2
    for k = 1:1:M+1
        h(k) = -phi(k)/phi(1);
    end
    %On tronque le vecteur de son premier terme
    h = h(2:end);    
    %Partie affichage
    figure(4)
    stem(h)
    xlabel('Indices k')
    ylabel('h[k]')
    title('Coefficients du modèle AR(M) obetnus')
    









