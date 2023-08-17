clc;clear;close all
%mat=readtable('dNptdpt_D0___c020_PbPb502.dat');
mat=readtable('dNptdpt_PbPb502_D0_c025.txt');
mat=table2array(mat);
%%
pt_Exper=[0.5	1.25	1.75	2.25	2.75	3.25	3.75	4.25	...
    4.75	5.25	5.75	6.25	6.75	7.25	7.75	8.5	9.5	11	14	20	30	43];
y_Exper=[3.44792	2.374752	1.61712	0.908422222	0.444363636	0.222354154	0.098503733	0.047019294	...
    0.022985895	0.011772381	0.007240522	0.004039504	0.002574326	0.001812234	0.001196018	...
    0.000747504	0.000407793	0.000193295	5.73595E-05	9.88705E-06	1.04673E-06	1.01261E-07...
 ]/2/pi;
y_error=[0.772678	0.3681024	0.084972571	0.031560267	0.011140982	0.004750862	0.002205339	...
    0.001134471	0.000604432	0.000317366	0.0001916	0.000118664	7.94684E-05	5.75611E-05	4.13766E-05	...
    1.90455E-05	1.14489E-05	4.56416E-06	1.85209E-06	4.01499E-07	8.66107E-08	1.88277E-08 ...
]/2/pi;
pt=double(mat(:,1));
k=1.0;
TT=mat(:,2)*k;
TS=mat(:,3)*k;
SS=mat(:,4);
SS2j=mat(:,5)*k;
Total=(TT+TS+SS+SS2j);
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
 ylim([10^-10,10^1])
xlabel('p_T(GeV/c)');xticks(0:20);
ylabel('1/{2\pi} d^2N/p_Tdp_Tdy(GeV/c)^{-2}');yticks([10^-10,10^-8,10^-6,10^-4,10^-3,10^-2,10^-1,10^0,10^1]);
legend('ALICE D^0@5.02 TeV','sum','therml-thermal','thermal-shower','shower-shower','shower-shower(2j)')
ax.FontName='Times New Roman';
ax.FontSize=12;
ax.FontWeight='bold';