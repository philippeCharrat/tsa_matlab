function [gamma_xd_c,fabs] = ESM2(x,N,M,nfft)
    % Inputs :
    % x - séquence brut 
    % N - nombre d'échantillons maximum
    % M - nombre d'échantillons d'une sous fenêtre 
    % nfft - nombre de points fft à N points
    % 
    % Oututs :
    % none 
    
    % Initialisation des variables ---
    x_seq = x(1 : N); %sequence à analyser
    fenetre = rectwin(M); % Fenetre taille M << N
    noverlap = 0; % Chevauchement 
    
    % Création de l'estimateur 2 ---
    [gamma_xd_c,fabs] = pwelch(x_seq,fenetre,noverlap,nfft,1,'twosided');
    
end