function [gamma_x_c,f_abs] = ESW2(x,N,fenetre_char,M,NOVERLAP,NFFT)
    %Inputs : 
    % x - séquence brut 
    %nd - premier indice de la séquence à  analyser
    %nf - dernier indice de la séquence à  analyser
    %NFFT - nombre de points de TFD-N points
    %fenetre_char : str contenant le type de la fenêtre
    %Noverlap : la couvertures entre les différentes fenêtre en % 
    %Outputs : 
    %gamma_x_c = vecteur contenant la DS pour l'estimateur 3 
    %fabs = vecteur d'abscisses 
    % ---Initialisation des variables ---
    x_seq = x(1:N);
    eval(['WIN=',fenetre_char,'(M)']);
    f_abs = 0:1/NFFT:1-1/NFFT;
    
% ---Création de l'estimateur 3---
    [gamma_x_c,fabs] = pwelch(x_seq,WIN,NOVERLAP,NFFT,1,'twosided');  

end