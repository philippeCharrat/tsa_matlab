function [gamma_x_c,f_abs] = ESS(x,nd,nf,NFFT) ;

    % ---Initialisation des variables ---
    x_seq = x(nd : nf); %Sequence à analyser
    N = nf - nd +1; %Longueur de la sequence
    
    % ---Création de l'estimateur 1 ---
    X = fft(x_seq,NFFT); %Transofrmée N points de la séquence  
    gamma_x_c = ((abs(X)).^2)/N; %Estimation simple
    f_abs = 0 : 1/NFFT: 1-1/NFFT;

 
end
