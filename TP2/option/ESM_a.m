function gamma_xd_c = ESM_a(x,N,M,nfft)
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
    log_gamma_xd_c = 10 * log10(gamma_xd_c);
    
%     % DSP moyenne vraie et (gamma(f') * Wbm(f'))(f) ---
%     [Gth,Gbiais,fth]=sptheo(M,'moyenne'); % 1er param : M
%     
%     % Partie affichage ---
%     figure(2)
%     hold on
%     plot(fabs,log_gamma_xd_c,'b',fth,Gth,'k',fth,Gbiais,'r')
%     axis([0 0.5 -50 10])
%     legend('Estimateur 2','DSPMV','Convolution de la DSP et de la fenetre de Barlett')
%     title('Densités spectrales de puissance calculées')
end