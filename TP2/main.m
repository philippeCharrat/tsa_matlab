% ----
%  Auteur : Philippe CHARRAT & Axel BRUYERE
%  TP 2 - T.S.A : Estimateurs
%  But : Partie 2
% ----
clc;clear variables;close all;

% G�n�ration d'un bruit blanc --- 
s = genbrfil; % Fonction fournie sur Cpe-campus

% g�n�ration des diff�rents estimateurs
ESS(s,1,1000,2^14);
ESM(s,10000,500,512);
ESW(s,10000,'rectwin',500,250,512);

