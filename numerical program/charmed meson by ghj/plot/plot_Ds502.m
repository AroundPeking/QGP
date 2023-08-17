clc;clear;%close all
mat=readtable('dNptdpt_Ds___c020_PbPb502.dat');
mat=table2array(mat);
%%
pt_Exper=[2.5	3.5	4.5	5.5	7	10	14	20	30	43];
y_Exper=[0.15772 0.038594286 0.010569111 0.002892364 0.0006748	0.000090024	1.49279E-05	2.2162E-06	2.70463E-07	3.13372E-08]/2/pi;
y_error=[0.0223652 0.003717143	0.0007938 0.000208036 4.75343E-05	0.000004512	8.76429E-07	1.68055E-07	3.698E-08 1.09484E-08]/2/pi;
pt=double(mat(:,1));
TT=mat(:,2);
TS=mat(:,3);
SS=mat(:,4);
SS2j=mat(:,5);
Total=TT+TS+SS+SS2j;
%%
figure;
ax=axes;
plt_0=errorbar(pt_Exper,y_Exper,y_error,'k');ax.YScale='log';
plt_0.Marker='o';
plt_0.MarkerSize=4;
plt_0.MarkerFaceColor='k';
plt_0.LineStyle='none';
hold on
%=====
plt_1=semilogy(pt,Total,'g-');
plt_1.LineWidth=1.2;
hold on
%=====
plt_2=semilogy(pt,TT,'k-.');
plt_2.LineWidth=1;
hold on
%=====
plt_3=semilogy(pt,TS,'b--');
plt_3.LineWidth=1;
hold on
%=====
plt_4=semilogy(pt,SS,'k-');
plt_4.LineWidth=1;
hold on
%=====
plt_5=semilogy(pt,SS2j,'r-');
plt_5.LineWidth=1;
hold on
%=====
xlim([0,20])
 ylim([10^-10,10^0])
xlabel('p_T(GeV/c)');xticks(0:20);
ylabel('1/{2\pi} d^2N/p_Tdp_Tdy(GeV/c)^{-2}');yticks([10^-10,10^-8,10^-6,10^-4,10^-3,10^-2,10^-1,10^0]);
legend('ALICE D_s@5.02 TeV','sum','therml-thermal','thermal-shower','shower-shower','shower-shower(2j)')
ax.FontName='Times New Roman';
ax.FontSize=12;
ax.FontWeight='bold';