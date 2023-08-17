clc;clear;close all
%Jpsi 2.76
pt_Exper_j2=[0.25 0.75 1.25 1.75 2.25 2.75 3.25 3.75 4.25 4.75 5.25 5.75 7];
y_Exper_j2=[0.013012,0.010682667,0.0079272,0.004681714,0.002818667,...
    0.001730545,0.000841538,0.000500267,0.000252941,0.000153895,8.62857E-05,0.00006,1.41429E-05 ]/2/pi;
y_error_j2=[0.001544 0.000649333 0.0004824 0.000288571 0.000178222 ...
    0.000114909 5.63077E-05 3.57333E-05 2.30588E-05 1.45263E-05 8.95238E-06 6.78261E-06 1.28571E-06]/2/pi;
%Jpsi 5.02
pt_Exper_j5=[0.725	2.15	4	7.5];
y_Exper_j5=[0.005136863	0.002442843	0.000363271	1.37298E-05 ];
y_error_j5=[0.001009811	0.000262791	4.25739E-05	2.5677E-06];
%D^0 2.76
pt_Exper_D2=[1.5 2.5 3.5 4.5 5.5 7 10 14 20];
y_Exper_D2=[1.766666667	0.412	0.074857143	0.016533333	0.004109091	0.000922857	0.000152	1.84286E-05	0.00000358 ]/2/pi;
y_error_D2=[0.258	0.02728	0.004628571	0.001282222	0.0004	7.94286E-05	0.0000125	2.71429E-06	0.00000092]/2/pi;
%D^0 5.02
pt_Exper_D5=[0.5	1.25	1.75	2.25	2.75	3.25	3.75	4.25	...
    4.75	5.25	5.75	6.25	6.75	7.25	7.75	8.5	9.5	11	14	20	30	43];
y_Exper_D5=[3.44792	2.374752	1.61712	0.908422222	0.444363636	0.222354154	0.098503733	0.047019294	...
    0.022985895	0.011772381	0.007240522	0.004039504	0.002574326	0.001812234	0.001196018	...
    0.000747504	0.000407793	0.000193295	5.73595E-05	9.88705E-06	1.04673E-06	1.01261E-07...
 ]/2/pi;
y_error_D5=[0.772678	0.3681024	0.084972571	0.031560267	0.011140982	0.004750862	0.002205339	...
    0.001134471	0.000604432	0.000317366	0.0001916	0.000118664	7.94684E-05	5.75611E-05	4.13766E-05	...
    1.90455E-05	1.14489E-05	4.56416E-06	1.85209E-06	4.01499E-07	8.66107E-08	1.88277E-08 ...
]/2/pi;
%Ds 2.76
pt_Exper_s2=[5 7 10];
y_Exper_s2=[0.00746	0.000692857	0.0000734 ]/2/pi;
y_error_s2=[0.00284	0.000281429	0.000021  ]/2/pi;
%Ds 5.02
pt_Exper_s5=[2.5	3.5	4.5	5.5	7	10	14	20	30	43];
y_Exper_s5=[0.15772 0.038594286 0.010569111 0.002892364 0.0006748	0.000090024	1.49279E-05	2.2162E-06	2.70463E-07	3.13372E-08]/2/pi;
y_error_s5=[0.0223652 0.003717143	0.0007938 0.000208036 4.75343E-05	0.000004512	8.76429E-07	1.68055E-07	3.698E-08 1.09484E-08]/2/pi;

%Plot
figure;
ax=axes;

plt_0=errorbar(pt_Exper_D5,y_Exper_D5,y_error_D5,'r--');ax.YScale='log';
plt_0.Marker='v';
plt_0.MarkerSize=4;
plt_0.MarkerFaceColor='r';
%plt_0.LineStyle='none';
hold on
%=====
plt_0=errorbar(pt_Exper_D2,y_Exper_D2,y_error_D2,'r');ax.YScale='log';
plt_0.Marker='v';
plt_0.MarkerSize=4;
plt_0.MarkerFaceColor='r';
%plt_0.LineStyle='none';
hold on
%=====
plt_0=errorbar(pt_Exper_s5,y_Exper_s5,y_error_s5,'k--');ax.YScale='log';
plt_0.Marker='.';
plt_0.MarkerSize=4;
plt_0.MarkerFaceColor='k';
%plt_0.LineStyle='none';
hold on
%=====
plt_0=errorbar(pt_Exper_s2,y_Exper_s2,y_error_s2,'k');ax.YScale='log';
plt_0.Marker='.';
plt_0.MarkerSize=4;
plt_0.MarkerFaceColor='k';
%plt_0.LineStyle='none';
hold on
%=====
plt_0=errorbar(pt_Exper_j5,y_Exper_j5,y_error_j5,'g--');ax.YScale='log';
plt_0.Marker='o';
plt_0.MarkerSize=4;
plt_0.MarkerFaceColor='g';
%plt_0.LineStyle='none';
hold on
%=====
plt_0=errorbar(pt_Exper_j2,y_Exper_j2,y_error_j2,'g');ax.YScale='log';
plt_0.Marker='o';
plt_0.MarkerSize=4;
plt_0.MarkerFaceColor='g';
%plt_0.LineStyle='none';
hold on
%=====

xlim([0,20])
ylim([10^-8,10^0])
xlabel('p_T(GeV/c)');xticks(0:20);
ylabel('1/{2\pi} d^2N/p_Tdp_Tdy(GeV/c)^{-2}');yticks([10^-10,10^-8,10^-7,10^-6,10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1]);
legend('D^0@5.02 TeV','D^0@2.76 TeV','D_s@5.02 TeV','D_s@2.76 TeV','J/\psi@5.02 TeV','J/\psi@2.76 TeV')
ax.FontName='Times New Roman';
ax.FontSize=12;
ax.FontWeight='bold';
