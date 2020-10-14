function [gamma_x_c,f_abs] = ESW2(x,N,fenetre_char,M,NOVERLAP,NFFT)
   
% ---Initialisation des variables ---
    x_seq = x(1:N);
    eval(['WIN=',fenetre_char,'(M)']);
    f_abs = 0:1/NFFT:1-1/NFFT;
    
% ---Création de l'estimateur 3---
    [gamma_x_c,fabs] = pwelch(x_seq,WIN,NOVERLAP,NFFT,1,'twosided');  

end