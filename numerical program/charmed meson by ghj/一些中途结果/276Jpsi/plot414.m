clc;clear;close all
load Tu_Jpsi_c020.dat
load Ts_Jpsi_c020.dat
load Tc_Jpsi_c020.dat
semilogy(Tu_Jpsi_c020(:,1),Tu_Jpsi_c020(:,2),'r');hold on
semilogy(Ts_Jpsi_c020(:,1),Ts_Jpsi_c020(:,2),'g');hold on
semilogy(Tc_Jpsi_c020(:,1),Tc_Jpsi_c020(:,2),'b');hold on
legend('T_u','T_s','T_c')