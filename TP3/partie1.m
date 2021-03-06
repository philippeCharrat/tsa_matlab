clear variables;
close all;
clc;

tmax = 100;
fs = 500;
v0 = 100;
b = 160;
delta_v = 16;
RC = 0;
tab_RC_dV = [2 20 100];
tab_Wb = [];
tab_RCP = [];

Xp = struct('sigma',sqrt(5),'Fs',fs,'B',b,'T',tmax) ;

[X,Xp] = CGN(Xp);
figure(9);
Fp = struct('Fs',fs,'F0',v0,'Dnu',delta_v,'order',6,'class','BP filter') ;  
Y = BPF(X,Fp) ;

moyennedeB = mean(X.data);
variancedeB = (std(X.data))^2;
P_B_X = trapz(X.time,(X.data).^2)/tmax;
Gamma_X = P_B_X/(2*b);

moyennedeBF = mean(Y.data);
variancedeBF = (std(Y.data))^2;
P_B_Y = trapz(Y.time,(Y.data).^2)/tmax;
Gamma_Y = P_B_Y/(2*b);

Z_b = SquareSig(Y);

figure(2);
plot(X.time,X.data);
title("Bruit B(t) g�n�r�");
xlabel("temps (s)");
ylabel("Amplitude");
legend(strcat("signal B(t) avec une moyenne de : ",num2str(moyennedeB)," et une variance de : ",num2str(variancedeB)," PB : ",num2str(P_B_X)," et G0 : ",num2str(Gamma_X))); 

figure(3);
plot(Y.time,Y.data);
title("Bruit B(t) filtr�");
xlabel("temps (s)");
ylabel("Amplitude");
legend(strcat("signal B(t) avec une moyenne de : ",num2str(moyennedeBF)," et une variance de : ",num2str(variancedeBF)," PB : ",num2str(P_B_Y)," et G0 : ",num2str(Gamma_Y))); 

for i=1:3
    figure(3+i)
    RC_dV = tab_RC_dV(i);
    RC = RC_dV/delta_v;
    RCFp = struct('Fs',fs,'RC',RC);
    [Wb,RCFp] = RCF(Z_b,RCFp);
    tab_Wb = [tab_Wb; Wb];
    tab_RCP = [tab_RCP; RCFp];
end

figure(7)
for i=1:3
    subplot(3,1,i);
    Wb = tab_Wb(i,:);
    RCp = tab_RCP(i,:);
    plot(Wb.time,Wb.data);
    xlabel("temps (s)");
    ylabel("Amplitude");
    itrue = Wb.time >= 5*RCp.RC;
    moyenne = mean(Wb.data(itrue));
    variance = (std(Wb.data(itrue))).^2;
    kurtosi = kurtosis(Wb.data(itrue));
    moyenneV = mean(Wb.data);
    varianceV = (std(Wb.data)).^2;
    kurtosiV = kurtosis(Wb.data);
    legend(strcat("ind�but=0->Moy=",num2str(moyenneV)," Var=",num2str(varianceV)," Var=",num2str(varianceV)," k=",num2str(kurtosiV))); 
    title(strcat("WB(t) pour  RC: ",num2str(RCp.RC)," vxRc=",num2str(RCp.RC*16)," Moy=",num2str(moyenne)," Var=",num2str(variance)," k=",num2str(kurtosi))); 
end 
