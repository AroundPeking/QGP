clc;clear;close all;
%%
% HH=["Xi","Lambda","proton","phi","Omega"];
% EE=["7_7","11_5","19_6","27_","39_"];
% CC=["05","1020","2030","3040","4060"];
%%
load_data
load('NCqCs.mat')
%%
global Tq0
global Ts0
Tq0=0.39;
Ts0=0.51;
% N(iH,iC) Cq(iE,iC) Cs(iE,iC)
%%
EE={'7_7','11_5','19_6','27','39'};
sNN=sNN_func(EE);
Energy=1000*sNN;
%%
eva_7_7
eva_11_5
eva_19_6
eva_27
eva_39
%%
plot_Bh_7_7
saveas(gcf,[pwd,'\Bh\Bh_7_7.eps'])
plot_Bh_11_5
saveas(gcf,[pwd,'\Bh\Bh_11_5.eps'])
plot_Bh_19_6
saveas(gcf,[pwd,'\Bh\Bh_19_6.eps'])
plot_Bh_27
saveas(gcf,[pwd,'\Bh\Bh_27.eps'])
plot_Bh_39
saveas(gcf,[pwd,'\Bh\Bh_39.eps'])
%%
plot_spec_7_7
saveas(gcf,[pwd,'\spec\spec_7_7.eps'])
plot_spec_11_5
saveas(gcf,[pwd,'\spec\spec_11_5.eps'])
plot_spec_19_6
saveas(gcf,[pwd,'\spec\spec_19_6.eps'])
plot_spec_27
saveas(gcf,[pwd,'\spec\spec_27.eps'])
plot_spec_39
saveas(gcf,[pwd,'\spec\spec_39.eps'])