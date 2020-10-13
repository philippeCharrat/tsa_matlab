function  ESS(x,nd,nf,NFFT) ;

    % ---Initialisation des variables ---
    x_seq = x(nd : nf); %Sequence à analyser
    N = nf - nd +1; %Longueur de la sequence
    
    % ---Création de l'estimateur 1 ---
    X = fft(x_seq,NFFT); %Transofrmée N points de la séquence  
    gamma_x_c = ((abs(X)).^2)/N; %Estimation simple
    f_abs = 0 : 1/NFFT: 1-1/NFFT;

    % ---Partie affichage ---
    figure(2);
    semilogy(f_abs,gamma_x_c);
    axis([0 0.5 -inf inf]);
    legend('Estimation de la DSP');
    title('Densités spectrales de puissance calculées');


end
