clear all;
close all;
% Chargement du signal
[s,Fs] = audioread('ProtestMonoBruit.wav');
% Vecteur temps
t = [0:1/Fs:(length(s)-1)/Fs];

% Variables
K = 200; % Limite du vecteur des retards
s2 = s(round(60*Fs):round(70*Fs)); % On selectionne une partie du signal initial (entre 60s et 70s)
Ts = 1/Fs; % Periode d'echantillonnage
% Autocorrelation du signal
[R,lags] = xcorr(s2,K,'biased');


M = 20; % Ordre du modele auto-regressif
% Equation matricielle
m = toeplitz(R(K+1:K+1+M)); % Creation de la matrice
m_inv = pinv(m); % Matrice pseudo-inverse
A = zeros(1,M+1); % Creation d'une matrice de 0
A(1,1) = 1;
phi = m_inv*A'; % On effectue le produit matriciel
sigma_carre = 1/phi(1);
h = (-phi(2:end))*sigma_carre;

s_conv = conv(s,h,'valid');
s_predit = s_conv(1:end-1);
s2 = s(M+1:end);
erreur = s_predit-s2; % Erreur de prediction
t2 = t(M+1:length(t)); % Vecteur temps qui correspond au s_predit

seuil = 0.39; % Seuil de détection
for k = 1:length(s)-M
if (abs(s(k)) > seuil) %si craquement au dela du seuil choisi
s_restaure(k+M) = median(s(k-10:k+10)); %on remplace le craquement par la moyenne des 10 valeurs précédentes et 10 valeurs suivantes
else
s_restaure(k+M) = s(k); %si pas de craquement, on garde le signal original
end
end

% Expression du signal (Prediction anticausale)
for n = 1:length(s)-M
s_anticausal(n,1) = 0;
for k = 1:M
s_anticausal(n,1) = s_anticausal(n,1)+h(k)*s(k+n);
end
end
% Erreur anticausale
erreur_anticausale = s_anticausal-s(1:length(s)-M);

% Moyenne de l'erreur causale et anticausale
erreur = (erreur + erreur_anticausale)/2;
seuil2 = 0.23; % Nouveau seuil
% Expression du signal (Prediction causale et anticausale)
for k = 1:length(s)-M
if (abs(erreur(k)) > seuil2)
% Si craquement au dela du seuil choisi, on fait la moyenne des
% deux predictions (causal et anticausal)
s_restaure(k+M) = (s_anticausal(k+M)+s_predit(k))/2;
else
% Si pas de craquement, on garde le signal original
s_restaure(k+M) = s(k);
end
end

sound(s_restaure,Fs)

