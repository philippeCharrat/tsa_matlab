function [gamma_x_c,f_abs] = ESS(x,nd,nf,NFFT) ;
    %Inputs : 
    % x - s�quence brut 
    %nd - premier indice de la s�quence � analyser
    %nf - dernier indice de la s�quence � analyser
    %NFFT - nombre de points de TFD-N points
    %Outputs : 
    %gamma_x_c = vecteur contenant la DS pour l'estimateur 1 
    %fabs = vecteur d'abscisses 
    
    % ---Initialisation des variables ---
    x_seq = x(nd : nf); %Sequence � analyser
    N = nf - nd +1; %Longueur de la sequence
    
    % ---Cr�ation de l'estimateur 1 ---
    X = fft(x_seq,NFFT); %Transofrm�e N points de la s�quence  
    gamma_x_c = ((abs(X)).^2)/N; %Estimation simple
    f_abs = 0 : 1/NFFT: 1-1/NFFT;

end
