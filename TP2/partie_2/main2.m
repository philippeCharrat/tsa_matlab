% ----
%  Auteur : Philippe CHARRAT & Axel BRUYERE
%  TP 1 - T.S.A : Estimateurs
%  But : Partie 2
% ----
clc;
clear variables;
close all;

%s = genbrfil;
load('../sig.mat');
[gamma_x_e1,fabs1] =ESS2(s,1,100000,2^14);
[gamma_x_e2,fabs2] =ESM2(s,100000,1000,1024);
[gamma_x_e3,fabs3] =ESW2(s,100000,'rectwin',2000,0.5,2048);
    
% Partie affichage ---
figure(1);
subplot(3,1,1)
semilogy(fabs1,gamma_x_e1,'b');
axis([0 0.5 -inf inf])
legend('Estimateur 1')
title("Représentation de l'estimateur simple en fonction du signal")

subplot(3,1,2)
semilogy(fabs2,gamma_x_e2,'b');
axis([0 0.5 -inf inf])
legend('Estimateur 2')
title("Représentation de l'estimateur moyenné en fonction du signal ")

subplot(3,1,3)
semilogy(fabs3,gamma_x_e3,'b');
axis([0 0.5 -inf inf])
legend('Estimateur 3')
title("Représentation de l'estimateur Welch en fonction du signal")