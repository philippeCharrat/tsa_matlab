clc;close all;clear variables;

%1. Signal et contexte
    [s,Fs] = audioread('ProtestMonoBruit.wav');
    temps_max = length(s)/Fs;
    temps = 0:temps_max/length(s):temps_max-(temps_max/length(s));
    %Partie affichage
    figure(1)
    plot(temps,s)
    axis tight
    xlabel('Temps(s)')
    ylabel('Signal reçu')
    title('Signal reçu à restaurer')
%2. Estimation de la fonction d'autocorrélation
    %Initialisation des variables
    K = 200
    indice_temps_60 = find(temps==60);
    indice_temps_70 = find(temps==70);
    time2 = temps(indice_temps_60:indice_temps_70);
    s2 = s(indice_temps_60:indice_temps_70);
    %Autocorrélation
    [R,lags] = xcorr(s2,K,'biased');
    %Partie affichage
    figure(2)
    plot(time2,s2)
    axis tight
    xlabel('Temps(s)')
    ylabel('Signal reçu')
    title('Signal reçu à restaurer, vu entre T = 60s et T = 70s')
    figure(3)
    plot(lags,R)
    xlabel('Retards')
    ylabel('Corrélations')
    title("Fonction d'autocorrélation calculée pour K = 200") 
    
%3. Identification du modèle AR(M)
    %Initialisation des variables
    M = 20;
    lag_0 = find(lags==0);
    %Création du vecteur r pour la fonction toeplitz.m
    r = zeros(1,M+1);
    r(1) = R(lag_0);
    for k = 1:1:M
        r(k+1) = R(lag_0 + k);
    end
    %Création de la matrice de Toeplitz
    tpz = toeplitz(r);
    %Pseudo-inversion pour résoudre le système 
    inv_tpz = pinv(tpz);
    %Vecteur contenant les résultats du système
    result = zeros(M+1,1);
    result(1) = 1;
    %Matrice des h/sigma^2
    phi = inv_tpz*result;
    h = zeros(M+1,1);
    %Division des termes par phi(1) = 1/sigma^2
    for k = 1:1:M+1
        h(k) = -phi(k)/phi(1);
    end
    %On tronque le vecteur de son premier terme
    h = h(2:end);    
    %Partie affichage
    figure(4)
    stem(h)
    xlabel('Indices k')
    ylabel('h[k]')
    title('Coefficients du modèle AR(M) obetnus')
    
%4. Prédiction linéaire
%Initialisation des variables
p = 1;s_chapeau = zeros(1,length(s2));
% Pour tous les éléments de la séquences supérieur à 20.
for n = indice_temps_60+20:indice_temps_70
    somme = 0;
    % Application de la formule : somme de 1 à M de h[k]*S(n-k)
    for k = 1:M
        somme = somme + h(k)*s(n-k);
    end
    % Ajout de la valeur dans le vecteur
    s_chapeau(p) = somme;p = p+1;
end% Calcul de l’erreur quadratique moyenne
erreur_quad = s_chapeau-s2';
    
    close all
    %Partie affichage
    figure(5)
    subplot(211)
    plot(time2,s2,'r',time2,s_chapeau,'b')
    xlabel('Temps(s)')
    ylabel('Amplitude')
    legend("Signal d'origine","Signal prédit")
    title("Signaux d'origine et prédit entre t = 60s et t = 70s")
    subplot(212)
    plot(time2,s2'-s_chapeau,'r')
    xlabel('Temps(s)')
    ylabel('Amplitude')
    title('Erreur quadratique')
    
    
    
    
    
%5. Restauration par seuillage 
    seuil = 0.03;
    crak = find(abs(erreur_quad)>=seuil);
    for k = 1:1:length(crak)
        s_chapeau(crak(k)) = median(s(indice_temps_60+crak(k)-10:indice_temps_60+crak(k)+10));
    end
    erreur_quad = s2'-s_chapeau;
    figure(6)
    subplot 211
    plot(time2,s2,'r',time2,s_chapeau,'b')
    xlabel('Temps(s)')
    ylabel('Amplitude')
    title('Signal restauré par seuillage')
%     subplot 312
%     plot(time2,s2)
    subplot 212
    plot(time2,erreur_quad)
    xlabel('Temps(s)')
    ylabel('Amplitude')
    title('Erreur quadratique restante après la restauration par seuillage')
    sound(s_chapeau,Fs)
%6. Restauration par prédiction causale/anticausale
    p = 1;
    s_chapeau_anticausal = zeros(1,length(s2));
    for n = indice_temps_60:indice_temps_70-M
        somme_anticausal = 0;
        for k = 1:M
            %s_chapeau_anticausal vaut la somme des [k] * s[n+k]
            somme_anticausal = somme_anticausal + h(k)*s(n+k);
        end
        s_chapeau_anticausal(p) = somme_anticausal;
        p = p+1;
    end
    erreur_quad_anticausal = s_chapeau_anticausal-s2';
    
    erreur_quad_c_antic = (erreur_quad+erreur_quad_anticausal)/2;
    s_chapeau_c_antic = erreur_quad_c_antic + s2';
    
    figure(7)
    subplot 311
    plot(time2,erreur_quad)
    xlabel('Temps(s)')
    ylabel('Amplitude des craquaments')
    title('Erreur de prédiction causale')
    subplot 312
    plot(time2,erreur_quad_anticausal)
    xlabel('Temps(s)')
    ylabel('Amplitude des craquaments') 
    title('Erreur de prédiction anticausale')
    subplot 313
    plot(time2,erreur_quad_c_antic)
    xlabel('Temps(s)')
    ylabel('Amplitude des craquaments')    
    title('Erreur de prédiction causale/anticausale')    
    
    
%     %Seuillage avec les prédictions causale/anticausale
%     seuil2 = 10e-4;
%     crak_c_antic = find(abs(erreur_quad_c_antic)>=seuil2);
%     for k = 1:1:length(crak_c_antic)
%         s_chapeau_c_antic(crak_c_antic(k)) = (s_chapeau(crak_c_antic(k))+s_chapeau_anticausal(crak_c_antic(k)))/2;
%     end
%     erreur_quad_c_antic2 = s_chapeau_c_antic - s2';
    

    crak_antic = find(abs(erreur_quad_anticausal)>=seuil);
    inter = intersect(crak,crak_antic);
    s_restaur = s2;
    for k = 1:length(inter)
        s_restaur(inter(k)) = (s_chapeau(inter(k)) + s_chapeau_anticausal(inter(k)))/2;
    end

    
%     figure(8)
%     subplot 211
%     plot(time2,s2,'r',time2,s_chapeau_c_antic,'b')
%     xlabel('Temps(s)')
%     ylabel('Amplitude')
%     legend('Signal original','Signal seuillé')
%     title("Superposition des signaux d'origine et seuillé")
%     subplot 212
%     plot(time2,erreur_quad_c_antic)
%     xlabel('Temps(s)')
%     ylabel('Amplitude des craquements')
%     title("Erreur quadratique après seuillage causal/anticausal")
    
   % sound(s2,Fs)
    %sound(s_restaur,Fs)
    
    






