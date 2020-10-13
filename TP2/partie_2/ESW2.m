function ESW(x,N,fenetre_char,M,NOVERLAP,NFFT)
   
% ---Initialisation des variables ---
    x_seq = x(1:N);
    eval(['WIN=',fenetre_char,'(M)']);
    f_abs = 0:1/N1-1/N;
    
% ---Création de l'estimateur 3---
    [gamma_x_c,fabs] = pwelch(x_seq,WIN,NOVERLAP,NFFT,1,'twosided');
    gamma_x_c = 10 * log10(gamma_x_c);
    
% ---DSP moyenne vraie et (gamma(f) * Wbm(f))(f)
    [Gth,Gbiais,fth]=sptheo(M,'welch','rectwin');
    
    
% ---Partie affichage---
    figure(2)
    plot(fabs,gamma_x_c,fth,Gth,'r',fth,Gbiais,'k')
    axis([0 0.5 -50 10])
    legend('Estimation de la DSP');
    title('Densités spectrales de puissance calculées')    
end