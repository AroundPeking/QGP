clc;clear;close all
%mat1=readtable('dNptdpt_PbPb276_Jpsi_c025.txt');
%mat1=table2array(mat1);
%mat=readtable('dNptdpt_Jpsi_c020_PbPb276.6799739.dat');
mat=readtable('dNptdpt_Jpsi_c020_PbPb276.dat');
mat=table2array(mat);
%%
pt_Exper=[0.25 0.75 1.25 1.75 2.25 2.75 3.25 3.75 4.25 4.75 5.25 5.75 7];
y_Exper=[0.013012,0.010682667,0.0079272,0.004681714,0.002818667,...
    0.001730545,0.000841538,0.000500267,0.000252941,0.000153895,8.62857E-05,0.00006,1.41429E-05 ]/2/pi;
y_error=[0.001544 0.000649333 0.0004824 0.000288571 0.000178222 ...
    0.000114909 5.63077E-05 3.57333E-05 2.30588E-05 1.45263E-05 8.95238E-06 6.78261E-06 1.28571E-06]/2/pi;
pt=double(mat(:,1));
TT=mat(:,2);
TS=mat(:,3);
SS=mat(:,4);
SS2j=mat(:,5);
%SS2j_v15=mat1(:,5);%/0.432*0.1;
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
%plt_6=semilogy(pt,SS2j_v15,'r--');
%plt_6.LineWidth=1;

xlim([0,10])
ylim([10^-10,10^-1])
xlabel('p_T(GeV/c)');xticks(0:20);
ylabel('1/{2\pi} d^2N/p_Tdp_Tdy(GeV/c)^{-2}');yticks([10^-15,10^-10,10^-8,10^-6,10^-5,10^-4,10^-3,10^-2,10^-1]);
legend('ALICE J/\psi@2.76 TeV','total','TT','TS','SS^{1j}','SS^{2j}')%,'SS^{2j}(v15)'
ax.FontName='Times New Roman';
ax.FontSize=12;
ax.FontWeight='bold';