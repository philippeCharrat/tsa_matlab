function [gamma_x_c,f_abs] = ESS(x,nd,nf,NFFT) ;
    %Inputs : 
    % x - séquence brut 
    %nd - premier indice de la séquence à  analyser
    %nf - dernier indice de la séquence à  analyser
    %NFFT - nombre de points de TFD-N points
    %Outputs : 
    %gamma_x_c = vecteur contenant la DS pour l'estimateur 1 
    %fabs = vecteur d'abscisses 
    
    % ---Initialisation des variables ---
    x_seq = x(nd : nf); %Sequence à  analyser
    N = nf - nd +1; %Longueur de la sequence
    
    % ---Création de l'estimateur 1 ---
    X = fft(x_seq,NFFT); %Transofrmée N points de la séquence  
    gamma_x_c = ((abs(X)).^2)/N; %Estimation simple
    f_abs = 0 : 1/NFFT: 1-1/NFFT;

end
