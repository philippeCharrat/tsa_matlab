function [sequence] = ESS(x,nd,nf,N) ;
    sequence = x(nd : nf);
    nb_echant = nf - nd +1;
    X = fft(sequence,N);
    gamma_x_c = ((abs(X)).^2)/N;
    log_gamma_x_c = 10*log10(gamma_x_c);
    [Gth,Gbiais,fth]=sptheo(nb_echant,'simple');
    f_abs = 0:1/N:1-1/N;
    figure(2)
    hold on
    plot(f_abs,log_gamma_x_c,fth,Gth,'k',fth,Gbiais,'r')
    axis([0 0.5 -50 10])
    legend('Estimation de la DSP','DSPMV','Convolution de la DSP et de la fenetre de Barlett')
    title('Densités spectrales de puissance calculées')


end
