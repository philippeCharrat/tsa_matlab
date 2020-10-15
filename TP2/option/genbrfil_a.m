function brf=genbrfil;
% function brf=genbrf;
% TP estimation spectrale
% g�n�ration d'un bruit blanc gaussien centr� de variance unit� 
% filtr� passe-bas de 100000 points
% affichage de la s�quence de bruit


clc,home
N=100000;
% disp(['G�n�ration d''une r�alisation de bruit blanc gaussien'])
% disp(['de moyenne nulle et de variance unit� de ',num2str(2*N),' �chantillons']);
% g�n�ration de 200000 �chantillons
%
% initialisation du g�n�rateur de bruit gaussien
%
% disp(' ');
% init=input('Donnez un entier pour initialiser le g�n�rateur de bruit blanc gaussien : ');
% disp(' ');
init = round(10^6*rand);
randn('seed',init);
al=randn(2*N,1);
al=al-mean(al);
al=al/std(al);
% affichage de l'histogramme du bruit blanc N(0,1)
[p,z]=hist(al,30);
%scrsz = get(0,'ScreenSize');
% fig1=figure('Position',[0.02*scrsz(3) 0.05*scrsz(4) 0.98*scrsz(3) 0.95*scrsz(4)/2]);
% bar(z,p),
% title(['Histogramme de la r�alisation blanche gaussienne de ',num2str(2*N),' �chantillons']);
% disp(' ')
% disp('appuyez sur une touche pour continuer');
% disp(' ')
% pause
% close(fig1);
% filtrage
% disp(['filtrage du bruit blanc et affichage de la s�quence de ',num2str(N),' �chantillons'])
 load LPbutt
 fal=filter(b,a,al);
% % extraction des nbpt points
brf=fal(fix(N/2):fix(N/2)+N-1);
% % affichage
% scrsz = get(0,'ScreenSize');
% fig1=figure('Position',[0.02*scrsz(3) 0.05*scrsz(4) 0.98*scrsz(3) 0.95*scrsz(4)/2]);
% %fig1=figure('Units','normal','Position',[0.01 0.44 0.98 0.43]);
% plot(0:N-1,brf);axis([0 length(brf)-1 min(brf) max(brf)]);
% title('le bruit filtr� passe-bas � analyser');
% xlabel('indices')
% disp(' ')
% disp('appuyez sur une touche pour terminer');
% pause;
% close(fig1)
% clear al fal

        
    
        
        

