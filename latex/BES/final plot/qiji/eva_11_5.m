iE=2;
[Tq,Ts]=Tq_Ts_func(sNN(iE));
N_use=eval(['N_',EE{iE}]);
%%
% N(iH,iC) Cq(iE,iC) Cs(iE,iC)
% HH=["Xi","Lambda","proton","phi","Omega"];
% EE=["7_7","11_5","19_6","27_","39_"];
% CC=["05","1020","2030","3040","4060"];
%% Xi
iH=1;
[m0,ns]=h_prop(iH);Th=3/((3-ns)/Tq+ns/Ts);
%
mt_Xi_11_5_05  =sqrt(pt_Xi_11_5_05.^2+m0^2);
mt_Xi_11_5_1020=sqrt(pt_Xi_11_5_1020.^2+m0^2);
mt_Xi_11_5_2030=sqrt(pt_Xi_11_5_2030.^2+m0^2);
mt_Xi_11_5_3040=sqrt(pt_Xi_11_5_3040.^2+m0^2);
mt_Xi_11_5_4060=sqrt(pt_Xi_11_5_4060.^2+m0^2);
%
dis_Xi_11_5_05=mt_Xi_11_5_05./pt_Xi_11_5_05./pt_Xi_11_5_05.*dNdpt_Xi_11_5_05;
dis_Xi_11_5_1020=mt_Xi_11_5_1020./pt_Xi_11_5_1020./pt_Xi_11_5_1020.*dNdpt_Xi_11_5_1020;
dis_Xi_11_5_2030=mt_Xi_11_5_2030./pt_Xi_11_5_2030./pt_Xi_11_5_2030.*dNdpt_Xi_11_5_2030;
dis_Xi_11_5_3040=mt_Xi_11_5_3040./pt_Xi_11_5_3040./pt_Xi_11_5_3040.*dNdpt_Xi_11_5_3040;
dis_Xi_11_5_4060=mt_Xi_11_5_4060./pt_Xi_11_5_4060./pt_Xi_11_5_4060.*dNdpt_Xi_11_5_4060;
%
errDis_Xi_11_5_05=mt_Xi_11_5_05./pt_Xi_11_5_05./pt_Xi_11_5_05.*err_Xi_11_5_05;
errDis_Xi_11_5_1020=mt_Xi_11_5_1020./pt_Xi_11_5_1020./pt_Xi_11_5_1020.*err_Xi_11_5_1020;
errDis_Xi_11_5_2030=mt_Xi_11_5_2030./pt_Xi_11_5_2030./pt_Xi_11_5_2030.*err_Xi_11_5_2030;
errDis_Xi_11_5_3040=mt_Xi_11_5_3040./pt_Xi_11_5_3040./pt_Xi_11_5_3040.*err_Xi_11_5_3040;
errDis_Xi_11_5_4060=mt_Xi_11_5_4060./pt_Xi_11_5_4060./pt_Xi_11_5_4060.*err_Xi_11_5_4060;
%
Bh_Xi_11_5_05=N_use(iH,1)*exp(-pt_Xi_11_5_05/Th);
Bh_Xi_11_5_1020=N_use(iH,2)*exp(-pt_Xi_11_5_1020/Th);
Bh_Xi_11_5_2030=N_use(iH,3)*exp(-pt_Xi_11_5_2030/Th);
Bh_Xi_11_5_3040=N_use(iH,4)*exp(-pt_Xi_11_5_3040/Th);
Bh_Xi_11_5_4060=N_use(iH,5)*exp(-pt_Xi_11_5_4060/Th);
%
New_pt_Xi_11_5_05=linspace(0.45*pt_Xi_11_5_05(1),1.2*pt_Xi_11_5_05(end),50);
New_pt_Xi_11_5_1020=linspace(0.45*pt_Xi_11_5_1020(1),1.2*pt_Xi_11_5_1020(end),50);
New_pt_Xi_11_5_2030=linspace(0.45*pt_Xi_11_5_2030(1),1.2*pt_Xi_11_5_2030(end),50);
New_pt_Xi_11_5_3040=linspace(0.45*pt_Xi_11_5_3040(1),1.2*pt_Xi_11_5_3040(end),50);
New_pt_Xi_11_5_4060=linspace(0.45*pt_Xi_11_5_4060(1),1.2*pt_Xi_11_5_4060(end),50);
%
New_mt_Xi_11_5_05  =sqrt(New_pt_Xi_11_5_05.^2+m0^2);
New_mt_Xi_11_5_1020=sqrt(New_pt_Xi_11_5_1020.^2+m0^2);
New_mt_Xi_11_5_2030=sqrt(New_pt_Xi_11_5_2030.^2+m0^2);
New_mt_Xi_11_5_3040=sqrt(New_pt_Xi_11_5_3040.^2+m0^2);
New_mt_Xi_11_5_4060=sqrt(New_pt_Xi_11_5_4060.^2+m0^2);
%
New_Bh_Xi_11_5_05=N_use(iH,1)*exp(-New_pt_Xi_11_5_05/Th);
New_Bh_Xi_11_5_1020=N_use(iH,2)*exp(-New_pt_Xi_11_5_1020/Th);
New_Bh_Xi_11_5_2030=N_use(iH,3)*exp(-New_pt_Xi_11_5_2030/Th);
New_Bh_Xi_11_5_3040=N_use(iH,4)*exp(-New_pt_Xi_11_5_3040/Th);
New_Bh_Xi_11_5_4060=N_use(iH,5)*exp(-New_pt_Xi_11_5_4060/Th);
%
New_spec_Xi_11_5_05=spec_func(New_pt_Xi_11_5_05,New_mt_Xi_11_5_05,Tq,Ts,iH,iE,1);
New_spec_Xi_11_5_1020=spec_func(New_pt_Xi_11_5_1020,New_mt_Xi_11_5_1020,Tq,Ts,iH,iE,2);
New_spec_Xi_11_5_2030=spec_func(New_pt_Xi_11_5_2030,New_mt_Xi_11_5_2030,Tq,Ts,iH,iE,3);
New_spec_Xi_11_5_3040=spec_func(New_pt_Xi_11_5_3040,New_mt_Xi_11_5_3040,Tq,Ts,iH,iE,4);
New_spec_Xi_11_5_4060=spec_func(New_pt_Xi_11_5_4060,New_mt_Xi_11_5_4060,Tq,Ts,iH,iE,5);
%
spec_Xi_11_5_05=spec_func(pt_Xi_11_5_05,mt_Xi_11_5_05,Tq,Ts,iH,iE,1);
spec_Xi_11_5_1020=spec_func(pt_Xi_11_5_1020,mt_Xi_11_5_1020,Tq,Ts,iH,iE,2);
spec_Xi_11_5_2030=spec_func(pt_Xi_11_5_2030,mt_Xi_11_5_2030,Tq,Ts,iH,iE,3);
spec_Xi_11_5_3040=spec_func(pt_Xi_11_5_3040,mt_Xi_11_5_3040,Tq,Ts,iH,iE,4);
spec_Xi_11_5_4060=spec_func(pt_Xi_11_5_4060,mt_Xi_11_5_4060,Tq,Ts,iH,iE,5);
%% Lambda
iH=2;
[m0,ns]=h_prop(iH);Th=3/((3-ns)/Tq+ns/Ts);
%
mt_Lambda_11_5_05  =sqrt(pt_Lambda_11_5_05.^2+m0^2);
mt_Lambda_11_5_1020=sqrt(pt_Lambda_11_5_1020.^2+m0^2);
mt_Lambda_11_5_2030=sqrt(pt_Lambda_11_5_2030.^2+m0^2);
mt_Lambda_11_5_3040=sqrt(pt_Lambda_11_5_3040.^2+m0^2);
mt_Lambda_11_5_4060=sqrt(pt_Lambda_11_5_4060.^2+m0^2);
%
dis_Lambda_11_5_05=mt_Lambda_11_5_05./pt_Lambda_11_5_05./pt_Lambda_11_5_05.*dNdpt_Lambda_11_5_05;
dis_Lambda_11_5_1020=mt_Lambda_11_5_1020./pt_Lambda_11_5_1020./pt_Lambda_11_5_1020.*dNdpt_Lambda_11_5_1020;
dis_Lambda_11_5_2030=mt_Lambda_11_5_2030./pt_Lambda_11_5_2030./pt_Lambda_11_5_2030.*dNdpt_Lambda_11_5_2030;
dis_Lambda_11_5_3040=mt_Lambda_11_5_3040./pt_Lambda_11_5_3040./pt_Lambda_11_5_3040.*dNdpt_Lambda_11_5_3040;
dis_Lambda_11_5_4060=mt_Lambda_11_5_4060./pt_Lambda_11_5_4060./pt_Lambda_11_5_4060.*dNdpt_Lambda_11_5_4060;
%
errDis_Lambda_11_5_05=mt_Lambda_11_5_05./pt_Lambda_11_5_05./pt_Lambda_11_5_05.*err_Lambda_11_5_05;
errDis_Lambda_11_5_1020=mt_Lambda_11_5_1020./pt_Lambda_11_5_1020./pt_Lambda_11_5_1020.*err_Lambda_11_5_1020;
errDis_Lambda_11_5_2030=mt_Lambda_11_5_2030./pt_Lambda_11_5_2030./pt_Lambda_11_5_2030.*err_Lambda_11_5_2030;
errDis_Lambda_11_5_3040=mt_Lambda_11_5_3040./pt_Lambda_11_5_3040./pt_Lambda_11_5_3040.*err_Lambda_11_5_3040;
errDis_Lambda_11_5_4060=mt_Lambda_11_5_4060./pt_Lambda_11_5_4060./pt_Lambda_11_5_4060.*err_Lambda_11_5_4060;
%
Bh_Lambda_11_5_05=N_use(iH,1)*exp(-pt_Lambda_11_5_05/Th);
Bh_Lambda_11_5_1020=N_use(iH,2)*exp(-pt_Lambda_11_5_1020/Th);
Bh_Lambda_11_5_2030=N_use(iH,3)*exp(-pt_Lambda_11_5_2030/Th);
Bh_Lambda_11_5_3040=N_use(iH,4)*exp(-pt_Lambda_11_5_3040/Th);
Bh_Lambda_11_5_4060=N_use(iH,5)*exp(-pt_Lambda_11_5_4060/Th);
%
New_pt_Lambda_11_5_05=linspace(0.45*pt_Lambda_11_5_05(1),1.2*pt_Lambda_11_5_05(end),50);
New_pt_Lambda_11_5_1020=linspace(0.45*pt_Lambda_11_5_1020(1),1.2*pt_Lambda_11_5_1020(end),50);
New_pt_Lambda_11_5_2030=linspace(0.45*pt_Lambda_11_5_2030(1),1.2*pt_Lambda_11_5_2030(end),50);
New_pt_Lambda_11_5_3040=linspace(0.45*pt_Lambda_11_5_3040(1),1.2*pt_Lambda_11_5_3040(end),50);
New_pt_Lambda_11_5_4060=linspace(0.45*pt_Lambda_11_5_4060(1),1.2*pt_Lambda_11_5_4060(end),50);
%
New_mt_Lambda_11_5_05  =sqrt(New_pt_Lambda_11_5_05.^2+m0^2);
New_mt_Lambda_11_5_1020=sqrt(New_pt_Lambda_11_5_1020.^2+m0^2);
New_mt_Lambda_11_5_2030=sqrt(New_pt_Lambda_11_5_2030.^2+m0^2);
New_mt_Lambda_11_5_3040=sqrt(New_pt_Lambda_11_5_3040.^2+m0^2);
New_mt_Lambda_11_5_4060=sqrt(New_pt_Lambda_11_5_4060.^2+m0^2);
%
New_Bh_Lambda_11_5_05=N_use(iH,1)*exp(-New_pt_Lambda_11_5_05/Th);
New_Bh_Lambda_11_5_1020=N_use(iH,2)*exp(-New_pt_Lambda_11_5_1020/Th);
New_Bh_Lambda_11_5_2030=N_use(iH,3)*exp(-New_pt_Lambda_11_5_2030/Th);
New_Bh_Lambda_11_5_3040=N_use(iH,4)*exp(-New_pt_Lambda_11_5_3040/Th);
New_Bh_Lambda_11_5_4060=N_use(iH,5)*exp(-New_pt_Lambda_11_5_4060/Th);
%
New_spec_Lambda_11_5_05=spec_func(New_pt_Lambda_11_5_05,New_mt_Lambda_11_5_05,Tq,Ts,iH,iE,1);
New_spec_Lambda_11_5_1020=spec_func(New_pt_Lambda_11_5_1020,New_mt_Lambda_11_5_1020,Tq,Ts,iH,iE,2);
New_spec_Lambda_11_5_2030=spec_func(New_pt_Lambda_11_5_2030,New_mt_Lambda_11_5_2030,Tq,Ts,iH,iE,3);
New_spec_Lambda_11_5_3040=spec_func(New_pt_Lambda_11_5_3040,New_mt_Lambda_11_5_3040,Tq,Ts,iH,iE,4);
New_spec_Lambda_11_5_4060=spec_func(New_pt_Lambda_11_5_4060,New_mt_Lambda_11_5_4060,Tq,Ts,iH,iE,5);
%
spec_Lambda_11_5_05=spec_func(pt_Lambda_11_5_05,mt_Lambda_11_5_05,Tq,Ts,iH,iE,1);
spec_Lambda_11_5_1020=spec_func(pt_Lambda_11_5_1020,mt_Lambda_11_5_1020,Tq,Ts,iH,iE,2);
spec_Lambda_11_5_2030=spec_func(pt_Lambda_11_5_2030,mt_Lambda_11_5_2030,Tq,Ts,iH,iE,3);
spec_Lambda_11_5_3040=spec_func(pt_Lambda_11_5_3040,mt_Lambda_11_5_3040,Tq,Ts,iH,iE,4);
spec_Lambda_11_5_4060=spec_func(pt_Lambda_11_5_4060,mt_Lambda_11_5_4060,Tq,Ts,iH,iE,5);
%% proton
iH=3;
[m0,ns]=h_prop(iH);Th=3/((3-ns)/Tq+ns/Ts);
%
mt_proton_11_5_05  =sqrt(pt_proton_11_5_05.^2+m0^2);
mt_proton_11_5_1020=sqrt(pt_proton_11_5_1020.^2+m0^2);
mt_proton_11_5_2030=sqrt(pt_proton_11_5_2030.^2+m0^2);
mt_proton_11_5_3040=sqrt(pt_proton_11_5_3040.^2+m0^2);
mt_proton_11_5_4050=sqrt(pt_proton_11_5_4050.^2+m0^2);
%
dis_proton_11_5_05=mt_proton_11_5_05./pt_proton_11_5_05./pt_proton_11_5_05.*dNdpt_proton_11_5_05;
dis_proton_11_5_1020=mt_proton_11_5_1020./pt_proton_11_5_1020./pt_proton_11_5_1020.*dNdpt_proton_11_5_1020;
dis_proton_11_5_2030=mt_proton_11_5_2030./pt_proton_11_5_2030./pt_proton_11_5_2030.*dNdpt_proton_11_5_2030;
dis_proton_11_5_3040=mt_proton_11_5_3040./pt_proton_11_5_3040./pt_proton_11_5_3040.*dNdpt_proton_11_5_3040;
dis_proton_11_5_4050=mt_proton_11_5_4050./pt_proton_11_5_4050./pt_proton_11_5_4050.*dNdpt_proton_11_5_4050;
%
errDis_proton_11_5_05=mt_proton_11_5_05./pt_proton_11_5_05./pt_proton_11_5_05.*err_proton_11_5_05;
errDis_proton_11_5_1020=mt_proton_11_5_1020./pt_proton_11_5_1020./pt_proton_11_5_1020.*err_proton_11_5_1020;
errDis_proton_11_5_2030=mt_proton_11_5_2030./pt_proton_11_5_2030./pt_proton_11_5_2030.*err_proton_11_5_2030;
errDis_proton_11_5_3040=mt_proton_11_5_3040./pt_proton_11_5_3040./pt_proton_11_5_3040.*err_proton_11_5_3040;
errDis_proton_11_5_4050=mt_proton_11_5_4050./pt_proton_11_5_4050./pt_proton_11_5_4050.*err_proton_11_5_4050;
%
Bh_proton_11_5_05=N_use(iH,1)*exp(-pt_proton_11_5_05/Th);
Bh_proton_11_5_1020=N_use(iH,2)*exp(-pt_proton_11_5_1020/Th);
Bh_proton_11_5_2030=N_use(iH,3)*exp(-pt_proton_11_5_2030/Th);
Bh_proton_11_5_3040=N_use(iH,4)*exp(-pt_proton_11_5_3040/Th);
Bh_proton_11_5_4050=N_use(iH,5)*exp(-pt_proton_11_5_4050/Th);
%
New_pt_proton_11_5_05=linspace(0.45*pt_proton_11_5_05(1),1.2*pt_proton_11_5_05(end),50);
New_pt_proton_11_5_1020=linspace(0.45*pt_proton_11_5_1020(1),1.2*pt_proton_11_5_1020(end),50);
New_pt_proton_11_5_2030=linspace(0.45*pt_proton_11_5_2030(1),1.2*pt_proton_11_5_2030(end),50);
New_pt_proton_11_5_3040=linspace(0.45*pt_proton_11_5_3040(1),1.2*pt_proton_11_5_3040(end),50);
New_pt_proton_11_5_4050=linspace(0.45*pt_proton_11_5_4050(1),1.2*pt_proton_11_5_4050(end),50);
%
New_mt_proton_11_5_05  =sqrt(New_pt_proton_11_5_05.^2+m0^2);
New_mt_proton_11_5_1020=sqrt(New_pt_proton_11_5_1020.^2+m0^2);
New_mt_proton_11_5_2030=sqrt(New_pt_proton_11_5_2030.^2+m0^2);
New_mt_proton_11_5_3040=sqrt(New_pt_proton_11_5_3040.^2+m0^2);
New_mt_proton_11_5_4050=sqrt(New_pt_proton_11_5_4050.^2+m0^2);
%
New_Bh_proton_11_5_05=N_use(iH,1)*exp(-New_pt_proton_11_5_05/Th);
New_Bh_proton_11_5_1020=N_use(iH,2)*exp(-New_pt_proton_11_5_1020/Th);
New_Bh_proton_11_5_2030=N_use(iH,3)*exp(-New_pt_proton_11_5_2030/Th);
New_Bh_proton_11_5_3040=N_use(iH,4)*exp(-New_pt_proton_11_5_3040/Th);
New_Bh_proton_11_5_4050=N_use(iH,5)*exp(-New_pt_proton_11_5_4050/Th);
%
New_spec_proton_11_5_05=spec_func(New_pt_proton_11_5_05,New_mt_proton_11_5_05,Tq,Ts,iH,iE,1);
New_spec_proton_11_5_1020=spec_func(New_pt_proton_11_5_1020,New_mt_proton_11_5_1020,Tq,Ts,iH,iE,2);
New_spec_proton_11_5_2030=spec_func(New_pt_proton_11_5_2030,New_mt_proton_11_5_2030,Tq,Ts,iH,iE,3);
New_spec_proton_11_5_3040=spec_func(New_pt_proton_11_5_3040,New_mt_proton_11_5_3040,Tq,Ts,iH,iE,4);
New_spec_proton_11_5_4050=spec_func(New_pt_proton_11_5_4050,New_mt_proton_11_5_4050,Tq,Ts,iH,iE,5);
%
spec_proton_11_5_05=spec_func(pt_proton_11_5_05,mt_proton_11_5_05,Tq,Ts,iH,iE,1);
spec_proton_11_5_1020=spec_func(pt_proton_11_5_1020,mt_proton_11_5_1020,Tq,Ts,iH,iE,2);
spec_proton_11_5_2030=spec_func(pt_proton_11_5_2030,mt_proton_11_5_2030,Tq,Ts,iH,iE,3);
spec_proton_11_5_3040=spec_func(pt_proton_11_5_3040,mt_proton_11_5_3040,Tq,Ts,iH,iE,4);
spec_proton_11_5_4050=spec_func(pt_proton_11_5_4050,mt_proton_11_5_4050,Tq,Ts,iH,iE,5);
%% phi
iH=4;
[m0,ns]=h_prop(iH);Th=3/((3-ns)/Tq+ns/Ts);
%
mt_phi_11_5_010  =sqrt(pt_phi_11_5_010.^2+m0^2);
mt_phi_11_5_1020=sqrt(pt_phi_11_5_1020.^2+m0^2);
mt_phi_11_5_2030=sqrt(pt_phi_11_5_2030.^2+m0^2);
mt_phi_11_5_3040=sqrt(pt_phi_11_5_3040.^2+m0^2);
mt_phi_11_5_4060=sqrt(pt_phi_11_5_4060.^2+m0^2);
%
dis_phi_11_5_010=mt_phi_11_5_010./pt_phi_11_5_010./pt_phi_11_5_010.*dNdpt_phi_11_5_010;
dis_phi_11_5_1020=mt_phi_11_5_1020./pt_phi_11_5_1020./pt_phi_11_5_1020.*dNdpt_phi_11_5_1020;
dis_phi_11_5_2030=mt_phi_11_5_2030./pt_phi_11_5_2030./pt_phi_11_5_2030.*dNdpt_phi_11_5_2030;
dis_phi_11_5_3040=mt_phi_11_5_3040./pt_phi_11_5_3040./pt_phi_11_5_3040.*dNdpt_phi_11_5_3040;
dis_phi_11_5_4060=mt_phi_11_5_4060./pt_phi_11_5_4060./pt_phi_11_5_4060.*dNdpt_phi_11_5_4060;
%
errDis_phi_11_5_010=mt_phi_11_5_010./pt_phi_11_5_010./pt_phi_11_5_010.*err_phi_11_5_010;
errDis_phi_11_5_1020=mt_phi_11_5_1020./pt_phi_11_5_1020./pt_phi_11_5_1020.*err_phi_11_5_1020;
errDis_phi_11_5_2030=mt_phi_11_5_2030./pt_phi_11_5_2030./pt_phi_11_5_2030.*err_phi_11_5_2030;
errDis_phi_11_5_3040=mt_phi_11_5_3040./pt_phi_11_5_3040./pt_phi_11_5_3040.*err_phi_11_5_3040;
errDis_phi_11_5_4060=mt_phi_11_5_4060./pt_phi_11_5_4060./pt_phi_11_5_4060.*err_phi_11_5_4060;
%
Bh_phi_11_5_010=N_use(iH,1)*exp(-pt_phi_11_5_010/Th);
Bh_phi_11_5_1020=N_use(iH,2)*exp(-pt_phi_11_5_1020/Th);
Bh_phi_11_5_2030=N_use(iH,3)*exp(-pt_phi_11_5_2030/Th);
Bh_phi_11_5_3040=N_use(iH,4)*exp(-pt_phi_11_5_3040/Th);
Bh_phi_11_5_4060=N_use(iH,5)*exp(-pt_phi_11_5_4060/Th);
%
New_pt_phi_11_5_010=linspace(0.45*pt_phi_11_5_010(1),1.2*pt_phi_11_5_010(end),50);
New_pt_phi_11_5_1020=linspace(0.45*pt_phi_11_5_1020(1),1.2*pt_phi_11_5_1020(end),50);
New_pt_phi_11_5_2030=linspace(0.45*pt_phi_11_5_2030(1),1.2*pt_phi_11_5_2030(end),50);
New_pt_phi_11_5_3040=linspace(0.45*pt_phi_11_5_3040(1),1.2*pt_phi_11_5_3040(end),50);
New_pt_phi_11_5_4060=linspace(0.45*pt_phi_11_5_4060(1),1.2*pt_phi_11_5_4060(end),50);
%
New_mt_phi_11_5_010  =sqrt(New_pt_phi_11_5_010.^2+m0^2);
New_mt_phi_11_5_1020=sqrt(New_pt_phi_11_5_1020.^2+m0^2);
New_mt_phi_11_5_2030=sqrt(New_pt_phi_11_5_2030.^2+m0^2);
New_mt_phi_11_5_3040=sqrt(New_pt_phi_11_5_3040.^2+m0^2);
New_mt_phi_11_5_4060=sqrt(New_pt_phi_11_5_4060.^2+m0^2);
%
New_Bh_phi_11_5_010=N_use(iH,1)*exp(-New_pt_phi_11_5_010/Th);
New_Bh_phi_11_5_1020=N_use(iH,2)*exp(-New_pt_phi_11_5_1020/Th);
New_Bh_phi_11_5_2030=N_use(iH,3)*exp(-New_pt_phi_11_5_2030/Th);
New_Bh_phi_11_5_3040=N_use(iH,4)*exp(-New_pt_phi_11_5_3040/Th);
New_Bh_phi_11_5_4060=N_use(iH,5)*exp(-New_pt_phi_11_5_4060/Th);
%
New_spec_phi_11_5_010=spec_func(New_pt_phi_11_5_010,New_mt_phi_11_5_010,Tq,Ts,iH,iE,1);
New_spec_phi_11_5_1020=spec_func(New_pt_phi_11_5_1020,New_mt_phi_11_5_1020,Tq,Ts,iH,iE,2);
New_spec_phi_11_5_2030=spec_func(New_pt_phi_11_5_2030,New_mt_phi_11_5_2030,Tq,Ts,iH,iE,3);
New_spec_phi_11_5_3040=spec_func(New_pt_phi_11_5_3040,New_mt_phi_11_5_3040,Tq,Ts,iH,iE,4);
New_spec_phi_11_5_4060=spec_func(New_pt_phi_11_5_4060,New_mt_phi_11_5_4060,Tq,Ts,iH,iE,5);
%
spec_phi_11_5_010=spec_func(pt_phi_11_5_010,mt_phi_11_5_010,Tq,Ts,iH,iE,1);
spec_phi_11_5_1020=spec_func(pt_phi_11_5_1020,mt_phi_11_5_1020,Tq,Ts,iH,iE,2);
spec_phi_11_5_2030=spec_func(pt_phi_11_5_2030,mt_phi_11_5_2030,Tq,Ts,iH,iE,3);
spec_phi_11_5_3040=spec_func(pt_phi_11_5_3040,mt_phi_11_5_3040,Tq,Ts,iH,iE,4);
spec_phi_11_5_4060=spec_func(pt_phi_11_5_4060,mt_phi_11_5_4060,Tq,Ts,iH,iE,5);
%% Omega
iH=5;
[m0,ns]=h_prop(iH);Th=3/((3-ns)/Tq+ns/Ts);
% % %
 mt_Omega_11_5_010  =sqrt(pt_Omega_11_5_010.^2+m0^2);
% % mt_Omega_11_5_1020=sqrt(pt_Omega_11_5_1020.^2+m0^2);
% % mt_Omega_11_5_2040=sqrt(pt_Omega_11_5_2040.^2+m0^2);
% % mt_Omega_11_5_4060=sqrt(pt_Omega_11_5_4060.^2+m0^2);
% % %
 dis_Omega_11_5_010=mt_Omega_11_5_010./pt_Omega_11_5_010./pt_Omega_11_5_010.*dNdpt_Omega_11_5_010;
% % dis_Omega_11_5_1020=mt_Omega_11_5_1020./pt_Omega_11_5_1020./pt_Omega_11_5_1020.*dNdpt_Omega_11_5_1020;
% % dis_Omega_11_5_2040=mt_Omega_11_5_2040./pt_Omega_11_5_2040./pt_Omega_11_5_2040.*dNdpt_Omega_11_5_2040;
% % dis_Omega_11_5_4060=mt_Omega_11_5_4060./pt_Omega_11_5_4060./pt_Omega_11_5_4060.*dNdpt_Omega_11_5_4060;
% % %
 errDis_Omega_11_5_010=mt_Omega_11_5_010./pt_Omega_11_5_010./pt_Omega_11_5_010.*err_Omega_11_5_010;
% % errDis_Omega_11_5_1020=mt_Omega_11_5_1020./pt_Omega_11_5_1020./pt_Omega_11_5_1020.*err_Omega_11_5_1020;
% % errDis_Omega_11_5_2040=mt_Omega_11_5_2040./pt_Omega_11_5_2040./pt_Omega_11_5_2040.*err_Omega_11_5_2040;
% % errDis_Omega_11_5_4060=mt_Omega_11_5_4060./pt_Omega_11_5_4060./pt_Omega_11_5_4060.*err_Omega_11_5_4060;
%
%$
Bh_Omega_11_5_010=N_use(iH,1)*exp(-pt_Omega_11_5_010/Th);
%$
[pt_Omega_11_5_010,pt_Omega_11_5_1020,pt_Omega_11_5_2040,pt_Omega_11_5_4060]=deal(pt_Omega_11_5_010);
%$
New_pt_Omega_11_5_010=linspace(0.45*pt_Omega_11_5_010(1),1.2*pt_Omega_11_5_010(end),50);
New_pt_Omega_11_5_1020=linspace(0.45*pt_Omega_11_5_1020(1),1.2*pt_Omega_11_5_1020(end),50);
New_pt_Omega_11_5_2040=linspace(0.45*pt_Omega_11_5_2040(1),1.2*pt_Omega_11_5_2040(end),50);
New_pt_Omega_11_5_4060=linspace(0.45*pt_Omega_11_5_4060(1),1.2*pt_Omega_11_5_4060(end),50);
%
New_mt_Omega_11_5_010  =sqrt(New_pt_Omega_11_5_010.^2+m0^2);
New_mt_Omega_11_5_1020=sqrt(New_pt_Omega_11_5_1020.^2+m0^2);
New_mt_Omega_11_5_2040=sqrt(New_pt_Omega_11_5_2040.^2+m0^2);
New_mt_Omega_11_5_4060=sqrt(New_pt_Omega_11_5_4060.^2+m0^2);
%
New_Bh_Omega_11_5_010=N_use(iH,1)*exp(-New_pt_Omega_11_5_010/Th);
New_Bh_Omega_11_5_1020=N_use(iH,2)*exp(-New_pt_Omega_11_5_1020/Th);
New_Bh_Omega_11_5_2040=N_use(iH,3)*exp(-New_pt_Omega_11_5_2040/Th);
New_Bh_Omega_11_5_4060=N_use(iH,4)*exp(-New_pt_Omega_11_5_4060/Th);
%
New_spec_Omega_11_5_010=spec_func(New_pt_Omega_11_5_010,New_mt_Omega_11_5_010,Tq,Ts,iH,iE,1);
New_spec_Omega_11_5_1020=spec_func(New_pt_Omega_11_5_1020,New_mt_Omega_11_5_1020,Tq,Ts,iH,iE,2);
New_spec_Omega_11_5_2040=spec_func(New_pt_Omega_11_5_2040,New_mt_Omega_11_5_2040,Tq,Ts,iH,iE,3);
New_spec_Omega_11_5_4060=spec_func(New_pt_Omega_11_5_4060,New_mt_Omega_11_5_4060,Tq,Ts,iH,iE,4);
%
spec_Omega_11_5_010=spec_func(pt_Omega_11_5_010,mt_Omega_11_5_010,Tq,Ts,iH,iE,1);
% spec_Omega_11_5_1020=spec_func(pt_Omega_11_5_1020,mt_Omega_11_5_1020,Tq,Ts,iH,iE,2);
% spec_Omega_11_5_2040=spec_func(pt_Omega_11_5_2040,mt_Omega_11_5_2040,Tq,Ts,iH,iE,3);
% spec_Omega_11_5_4060=spec_func(pt_Omega_11_5_4060,mt_Omega_11_5_4060,Tq,Ts,iH,iE,4);
%
fprintf('finish 11_5\n')