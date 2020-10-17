% ----
%  Auteur : Philippe CHARRAT & Axel BRUYERE
%  TP 2 - T.S.A : Estimateurs
%  But : Partie 2
% ----
clc;clear variables;close all;

% Génération d'un bruit blanc --- 
s = genbrfil; % Fonction fournie sur Cpe-campus

% génération des différents estimateurs
ESS(s,1,1000,2^14);
ESM(s,10000,500,512);
ESW(s,10000,'rectwin',500,250,512);

