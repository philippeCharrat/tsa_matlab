function  ESS(x,nd,nf,NFFT) ;

    % ---Initialisation des variables ---
    x_seq = x(nd : nf); %Sequence à analyser
    N = nf - nd +1; %Longueur de la sequence
    
    % ---Création de l'estimateur 1 ---
    X = fft(x_seq,NFFT); %Transofrmée N points de la séquence  
    gamma_x_c = ((abs(X)).^2)/NFFT; %Estimation simple
    log_gamma_x_c = 10*log10(gamma_x_c); %Passage au log (forme quadratique donc log * 10)
    
    % ---DSP moyenne vraie et (gamma(f) * Wbm(f))(f)
    [Gth,Gbiais,fth]=sptheo(N,'simple');
    f_abs = 0:1/NFFT:1-1/NFFT;
    
    % ---Partie affichage ---
    figure(2)
    hold on
    plot(f_abs,log_gamma_x_c,fth,Gth,'k',fth,Gbiais,'r')
    axis([0 0.5 -50 10])
    legend('Estimation de la DSP','DSPMV','Convolution de la DSP et de la fenetre de Barlett')
    title('Densités spectrales de puissance calculées')


end
