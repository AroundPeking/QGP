figure('Name','Bh_27')
set(gcf,'unit','centimeters','position',[40 30 33 25]);
%% Xi
axes('Position',[0.67 0.63 0.3 0.35]);
semilogy(New_pt_Xi_27_05,New_Bh_Xi_27_05,'k--','LineWidth',2.5)
axis([0 5 1E-12 1E2]);
set(gca,'Ticklength',[0.02 0.025],'FontSize',15,'LineWidth',1.5,......
    'XTICK',[1 2 3 4 5 6],......
    'YTICK',[1e-10 1e-8 1e-6 1E-4 1E-2 1E0]);
hold on
h1=errorbar(pt_Xi_27_05,dis_Xi_27_05,errDis_Xi_27_05,'ks');
set(h1,'MarkerSize',7,'MarkerFaceColor','k');

semilogy(New_pt_Xi_27_1020,New_Bh_Xi_27_1020/10,'k--','LineWidth',2.5)
hold on
h2=errorbar(pt_Xi_27_1020,dis_Xi_27_1020/10,errDis_Xi_27_1020/10,'ko');
set(h2,'MarkerSize',7,'MarkerFaceColor','w');

semilogy(New_pt_Xi_27_2030,New_Bh_Xi_27_2030/10^2,'k--','LineWidth',2.5)
hold on
h3=errorbar(pt_Xi_27_2030,dis_Xi_27_2030/10^2,errDis_Xi_27_2030/10^2,'kv');
set(h3,'MarkerSize',7,'MarkerFaceColor','k');

semilogy(New_pt_Xi_27_3040,New_Bh_Xi_27_3040/10^3,'k--','LineWidth',2.5)
hold on
h4=errorbar(pt_Xi_27_3040,dis_Xi_27_3040/10^3,errDis_Xi_27_3040/10^3,'k^');
set(h4,'MarkerSize',7,'MarkerFaceColor','w');

semilogy(New_pt_Xi_27_4060,New_Bh_Xi_27_4060/10^4,'k--','LineWidth',2.5)
hold on
h5=errorbar(pt_Xi_27_4060,dis_Xi_27_4060/10^4,errDis_Xi_27_4060/10^4,'kd');
set(h5,'MarkerSize',7,'MarkerFaceColor','k');

x0=[3 3.5];
y0=[2e1 2E1];
scal=8;
plot(x0(1),y0(1),'ks','MarkerSize',5,'MarkerFaceColor','k');
text(x0(2),y0(2),'0-5%','FontSize',12);

y0=y0/scal;
plot(x0(1),y0(1),'ko','MarkerSize',5,'MarkerFaceColor','w');
text(x0(2),y0(2),'10-20%/10','FontSize',12);

y0=y0/scal;
plot(x0(1),y0(1),'kv','MarkerSize',5,'MarkerFaceColor','k');
text(x0(2),y0(2),'20-30%/10^2','FontSize',12);

y0=y0/scal;
plot(x0(1),y0(1),'k^','MarkerSize',5,'MarkerFaceColor','w');
text(x0(2),y0(2),'30-40%/10^3','FontSize',12);

y0=y0/scal;
plot(x0(1),y0(1),'kd','MarkerSize',5,'MarkerFaceColor','k');
text(x0(2),y0(2),'40-60%/10^4','FontSize',12);
text(0.5,1e-11,'(c) \Xi','FontSize',14);
hold off

%
r1=dis_Xi_27_05./Bh_Xi_27_05;
r2=dis_Xi_27_1020./Bh_Xi_27_1020;
r3=dis_Xi_27_2030./Bh_Xi_27_2030;
r4=dis_Xi_27_3040./Bh_Xi_27_3040;
r5=dis_Xi_27_4060./Bh_Xi_27_4060;
%

axes('Position',[0.67 0.53 0.3 0.1]);
pt=linspace(0,5,20);
for i=1:20
    y(i)=1;   
end
plot(pt,y,'k--','LineWidth',1)
hold on
plot(pt,y-0.15,'k--','LineWidth',1)
hold on
plot(pt,y+0.15,'k--','LineWidth',1)
hold on
plot(pt_Xi_27_05,r1,'w-','LineWidth',0.1);
axis([0 5 0.5 1.5]);
set(gca,'FontSize',15,'LineWidth',1.5,......
    'XTICK',[0 1 2 3 4 5],......
    'YTICK',[0.5 0.75 1 1.25 1.5]);
hold on
h=errorbar(pt_Xi_27_05,r1,r1*0,'ks');
set(h,'MarkerSize',5,'MarkerFaceColor','k');

h=errorbar(pt_Xi_27_1020,r2,r2*0,'ko');
set(h,'MarkerSize',5,'MarkerFaceColor','w');

h=errorbar(pt_Xi_27_2030,r3,r3*0,'kv');
set(h,'MarkerSize',5,'MarkerFaceColor','k');

h=errorbar(pt_Xi_27_3040,r4,r4*0,'k^');
set(h,'MarkerSize',5,'MarkerFaceColor','w');

h=errorbar(pt_Xi_27_4060,r5,r5*0,'kd');
set(h,'MarkerSize',5,'MarkerFaceColor','k');
%% =================================================================
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% =================================================================
%% Lambda
axes('Position',[0.37 0.63 0.3 0.35]);
semilogy(New_pt_Lambda_27_05,New_Bh_Lambda_27_05,'k--','LineWidth',2.5)
axis([0 7 1E-12 1E2]);
set(gca,'Ticklength',[0.02 0.025],'FontSize',15,'LineWidth',1.5,......
    'XTICK',[1 2 3 4 5],......
    'YTICK',[1e-10 1e-8 1e-6 1E-4 1E-2 1E0]);
hold on
h1=errorbar(pt_Lambda_27_05,dis_Lambda_27_05,errDis_Lambda_27_05,'ks');
set(h1,'MarkerSize',7,'MarkerFaceColor','k');

semilogy(New_pt_Lambda_27_1020,New_Bh_Lambda_27_1020/10,'k--','LineWidth',2.5)
hold on
h2=errorbar(pt_Lambda_27_1020,dis_Lambda_27_1020/10,errDis_Lambda_27_1020/10,'ko');
set(h2,'MarkerSize',7,'MarkerFaceColor','w');

semilogy(New_pt_Lambda_27_2030,New_Bh_Lambda_27_2030/10^2,'k--','LineWidth',2.5)
hold on
h3=errorbar(pt_Lambda_27_2030,dis_Lambda_27_2030/10^2,errDis_Lambda_27_2030/10^2,'kv');
set(h3,'MarkerSize',7,'MarkerFaceColor','k');

semilogy(New_pt_Lambda_27_3040,New_Bh_Lambda_27_3040/10^3,'k--','LineWidth',2.5)
hold on
h4=errorbar(pt_Lambda_27_3040,dis_Lambda_27_3040/10^3,errDis_Lambda_27_3040/10^3,'k^');
set(h4,'MarkerSize',7,'MarkerFaceColor','w');

semilogy(New_pt_Lambda_27_4060,New_Bh_Lambda_27_4060/10^4,'k--','LineWidth',2.5)
hold on
h5=errorbar(pt_Lambda_27_4060,dis_Lambda_27_4060/10^4,errDis_Lambda_27_4060/10^4,'kd');
set(h5,'MarkerSize',7,'MarkerFaceColor','k');

x0=[4 4.4];
y0=[2e1 2E1];
scal=8;
plot(x0(1),y0(1),'ks','MarkerSize',5,'MarkerFaceColor','k');
text(x0(2),y0(2),'0-5%','FontSize',12);

y0=y0/scal;
plot(x0(1),y0(1),'ko','MarkerSize',5,'MarkerFaceColor','w');
text(x0(2),y0(2),'10-20%/10','FontSize',12);

y0=y0/scal;
plot(x0(1),y0(1),'kv','MarkerSize',5,'MarkerFaceColor','k');
text(x0(2),y0(2),'20-30%/10^2','FontSize',12);

y0=y0/scal;
plot(x0(1),y0(1),'k^','MarkerSize',5,'MarkerFaceColor','w');
text(x0(2),y0(2),'30-40%/10^3','FontSize',12);

y0=y0/scal;
plot(x0(1),y0(1),'kd','MarkerSize',5,'MarkerFaceColor','k');
text(x0(2),y0(2),'40-60%/10^4','FontSize',12);
text(0.5,1e-11,'(c) \Lambda','FontSize',14);
hold off

%
r1=dis_Lambda_27_05./Bh_Lambda_27_05;
r2=dis_Lambda_27_1020./Bh_Lambda_27_1020;
r3=dis_Lambda_27_2030./Bh_Lambda_27_2030;
r4=dis_Lambda_27_3040./Bh_Lambda_27_3040;
r5=dis_Lambda_27_4060./Bh_Lambda_27_4060;
%

axes('Position',[0.37 0.53 0.3 0.1]);
pt=linspace(0,5,20);
for i=1:20
    y(i)=1;   
end
plot(pt,y,'k--','LineWidth',1)
hold on
plot(pt,y-0.15,'k--','LineWidth',1)
hold on
plot(pt,y+0.15,'k--','LineWidth',1)
hold on
plot(pt_Lambda_27_05,r1,'w-','LineWidth',0.1);
axis([0 7 0.5 1.5]);
set(gca,'FontSize',15,'LineWidth',1.5,......
    'XTICK',[0 1 2 3 4],......
    'YTICK',[0.5 0.75 1 1.25 1.5]);
hold on
h=errorbar(pt_Lambda_27_05,r1,r1*0,'ks');
set(h,'MarkerSize',5,'MarkerFaceColor','k');

h=errorbar(pt_Lambda_27_1020,r2,r2*0,'ko');
set(h,'MarkerSize',5,'MarkerFaceColor','w');

h=errorbar(pt_Lambda_27_2030,r3,r3*0,'kv');
set(h,'MarkerSize',5,'MarkerFaceColor','k');

h=errorbar(pt_Lambda_27_3040,r4,r4*0,'k^');
set(h,'MarkerSize',5,'MarkerFaceColor','w');

h=errorbar(pt_Lambda_27_4060,r5,r5*0,'kd');
set(h,'MarkerSize',5,'MarkerFaceColor','k');
%% =================================================================
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% =================================================================
%% proton
axes('Position',[0.07 0.63 0.3 0.35]);
semilogy(New_pt_proton_27_05,New_Bh_proton_27_05,'k--','LineWidth',2.5)
axis([0 5 1E-12 1E3]);
set(gca,'Ticklength',[0.02 0.025],'FontSize',15,'LineWidth',1.5,......
    'XTICK',[1 2 3 4],......
    'YTICK',[1e-10 1e-8 1e-6 1E-4 1E-2 1E0 1E2]);
hold on
h1=errorbar(pt_proton_27_05,dis_proton_27_05,errDis_proton_27_05,'ks');
set(h1,'MarkerSize',7,'MarkerFaceColor','k');

semilogy(New_pt_proton_27_1020,New_Bh_proton_27_1020/10,'k--','LineWidth',2.5)
hold on
h2=errorbar(pt_proton_27_1020,dis_proton_27_1020/10,errDis_proton_27_1020/10,'ko');
set(h2,'MarkerSize',7,'MarkerFaceColor','w');

semilogy(New_pt_proton_27_2030,New_Bh_proton_27_2030/10^2,'k--','LineWidth',2.5)
hold on
h3=errorbar(pt_proton_27_2030,dis_proton_27_2030/10^2,errDis_proton_27_2030/10^2,'kv');
set(h3,'MarkerSize',7,'MarkerFaceColor','k');

semilogy(New_pt_proton_27_3040,New_Bh_proton_27_3040/10^3,'k--','LineWidth',2.5)
hold on
h4=errorbar(pt_proton_27_3040,dis_proton_27_3040/10^3,errDis_proton_27_3040/10^3,'k^');
set(h4,'MarkerSize',7,'MarkerFaceColor','w');

semilogy(New_pt_proton_27_4050,New_Bh_proton_27_4050/10^4,'k--','LineWidth',2.5)
hold on
h5=errorbar(pt_proton_27_4050,dis_proton_27_4050/10^4,errDis_proton_27_4050/10^4,'kd');
set(h5,'MarkerSize',7,'MarkerFaceColor','k');

x0=[3 3.5];
y0=[2e1 2E1];
scal=8;
plot(x0(1),y0(1),'ks','MarkerSize',5,'MarkerFaceColor','k');
text(x0(2),y0(2),'0-5%','FontSize',12);

y0=y0/scal;
plot(x0(1),y0(1),'ko','MarkerSize',5,'MarkerFaceColor','w');
text(x0(2),y0(2),'10-20%/10','FontSize',12);

y0=y0/scal;
plot(x0(1),y0(1),'kv','MarkerSize',5,'MarkerFaceColor','k');
text(x0(2),y0(2),'20-30%/10^2','FontSize',12);

y0=y0/scal;
plot(x0(1),y0(1),'k^','MarkerSize',5,'MarkerFaceColor','w');
text(x0(2),y0(2),'30-40%/10^3','FontSize',12);

y0=y0/scal;
plot(x0(1),y0(1),'kd','MarkerSize',5,'MarkerFaceColor','k');
text(x0(2),y0(2),'40-60%/10^4','FontSize',12);
text(0.5,1e-11,'(c) p','FontSize',14);
hold off

%
r1=dis_proton_27_05./Bh_proton_27_05;
r2=dis_proton_27_1020./Bh_proton_27_1020;
r3=dis_proton_27_2030./Bh_proton_27_2030;
r4=dis_proton_27_3040./Bh_proton_27_3040;
r5=dis_proton_27_4050./Bh_proton_27_4050;
%

axes('Position',[0.07 0.53 0.3 0.1]);
pt=linspace(0,5,20);
for i=1:20
    y(i)=1;   
end
plot(pt,y,'k--','LineWidth',1)
hold on
plot(pt,y-0.15,'k--','LineWidth',1)
hold on
plot(pt,y+0.15,'k--','LineWidth',1)
hold on
plot(pt_proton_27_05,r1,'w-','LineWidth',0.1);
axis([0 5 0.5 1.5]);
set(gca,'FontSize',15,'LineWidth',1.5,......
    'XTICK',[0 1 2 3 4],......
    'YTICK',[0.5 0.75 1 1.25 1.5]);
hold on
h=errorbar(pt_proton_27_05,r1,r1*0,'ks');
set(h,'MarkerSize',5,'MarkerFaceColor','k');

h=errorbar(pt_proton_27_1020,r2,r2*0,'ko');
set(h,'MarkerSize',5,'MarkerFaceColor','w');

h=errorbar(pt_proton_27_2030,r3,r3*0,'kv');
set(h,'MarkerSize',5,'MarkerFaceColor','k');

h=errorbar(pt_proton_27_3040,r4,r4*0,'k^');
set(h,'MarkerSize',5,'MarkerFaceColor','w');

h=errorbar(pt_proton_27_4050,r5,r5*0,'kd');
set(h,'MarkerSize',5,'MarkerFaceColor','k');
%labels========================================================================
axes('Position',[0.67 0.08 0.3 0.45]);
%axes('Position',[0.67 0.08 0.3 0.1]);
axis([0 5 1E-12 1E2]);
set(gca,'Ticklength',[0.02 0.025],'FontSize',15,'LineWidth',1.5,......
    'XTICK',[],......
    'YTICK',[]);
hold on
%% =================================================================
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% =================================================================
%% phi
axes('Position',[0.37 0.18 0.3 0.35]);
semilogy(New_pt_phi_27_010,New_Bh_phi_27_010,'k--','LineWidth',2.5)
axis([0 6 1E-12 1E2]);
set(gca,'Ticklength',[0.02 0.025],'FontSize',15,'LineWidth',1.5,......
    'XTICK',[1 2 3 4 5 6],......
    'YTICK',[1e-10 1e-8 1e-6 1E-4 1E-2 1E0]);
hold on
h1=errorbar(pt_phi_27_010,dis_phi_27_010,errDis_phi_27_010,'ks');
set(h1,'MarkerSize',7,'MarkerFaceColor','k');

semilogy(New_pt_phi_27_1020,New_Bh_phi_27_1020/10,'k--','LineWidth',2.5)
hold on
h2=errorbar(pt_phi_27_1020,dis_phi_27_1020/10,errDis_phi_27_1020/10,'ko');
set(h2,'MarkerSize',7,'MarkerFaceColor','w');

semilogy(New_pt_phi_27_2030,New_Bh_phi_27_2030/10^2,'k--','LineWidth',2.5)
hold on
h3=errorbar(pt_phi_27_2030,dis_phi_27_2030/10^2,errDis_phi_27_2030/10^2,'kv');
set(h3,'MarkerSize',7,'MarkerFaceColor','k');

semilogy(New_pt_phi_27_3040,New_Bh_phi_27_3040/10^3,'k--','LineWidth',2.5)
hold on
h4=errorbar(pt_phi_27_3040,dis_phi_27_3040/10^3,errDis_phi_27_3040/10^3,'k^');
set(h4,'MarkerSize',7,'MarkerFaceColor','w');

semilogy(New_pt_phi_27_4060,New_Bh_phi_27_4060/10^4,'k--','LineWidth',2.5)
hold on
h5=errorbar(pt_phi_27_4060,dis_phi_27_4060/10^4,errDis_phi_27_4060/10^4,'kd');
set(h5,'MarkerSize',7,'MarkerFaceColor','k');

x0=[4 4.4];
y0=[2e1 2E1];
scal=8;
plot(x0(1),y0(1),'ks','MarkerSize',5,'MarkerFaceColor','k');
text(x0(2),y0(2),'0-5%','FontSize',12);

y0=y0/scal;
plot(x0(1),y0(1),'ko','MarkerSize',5,'MarkerFaceColor','w');
text(x0(2),y0(2),'10-20%/10','FontSize',12);

y0=y0/scal;
plot(x0(1),y0(1),'kv','MarkerSize',5,'MarkerFaceColor','k');
text(x0(2),y0(2),'20-30%/10^2','FontSize',12);

y0=y0/scal;
plot(x0(1),y0(1),'k^','MarkerSize',5,'MarkerFaceColor','w');
text(x0(2),y0(2),'30-40%/10^3','FontSize',12);

y0=y0/scal;
plot(x0(1),y0(1),'kd','MarkerSize',5,'MarkerFaceColor','k');
text(x0(2),y0(2),'40-60%/10^4','FontSize',12);
text(0.5,1e-11,'(c) \phi','FontSize',14);
hold off

%
r1=dis_phi_27_010./Bh_phi_27_010;
r2=dis_phi_27_1020./Bh_phi_27_1020;
r3=dis_phi_27_2030./Bh_phi_27_2030;
r4=dis_phi_27_3040./Bh_phi_27_3040;
r5=dis_phi_27_4060./Bh_phi_27_4060;
%

axes('Position',[0.37 0.08 0.3 0.1]);
pt=linspace(0,6,20);
for i=1:20
    y(i)=1;   
end
plot(pt,y,'k--','LineWidth',1)
hold on
plot(pt,y-0.15,'k--','LineWidth',1)
hold on
plot(pt,y+0.15,'k--','LineWidth',1)
hold on
plot(pt_phi_27_010,r1,'w-','LineWidth',0.1);
axis([0 6 0.5 1.5]);
set(gca,'FontSize',15,'LineWidth',1.5,......
    'XTICK',[0 1 2 3 4 5],......
    'YTICK',[ 0.75 1 1.25 1.5]);
hold on
h=errorbar(pt_phi_27_010,r1,r1*0,'ks');
set(h,'MarkerSize',5,'MarkerFaceColor','k');

h=errorbar(pt_phi_27_1020,r2,r2*0,'ko');
set(h,'MarkerSize',5,'MarkerFaceColor','w');

h=errorbar(pt_phi_27_2030,r3,r3*0,'kv');
set(h,'MarkerSize',5,'MarkerFaceColor','k');

h=errorbar(pt_phi_27_3040,r4,r4*0,'k^');
set(h,'MarkerSize',5,'MarkerFaceColor','w');

h=errorbar(pt_phi_27_4060,r5,r5*0,'kd');
set(h,'MarkerSize',5,'MarkerFaceColor','k');
%% =================================================================
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% =================================================================
%% Omega
axes('Position',[0.07 0.18 0.3 0.35]);
semilogy(New_pt_Omega_27_010,New_Bh_Omega_27_010,'k--','LineWidth',2.5)
axis([0 5 1E-12 1E2]);
set(gca,'Ticklength',[0.02 0.025],'FontSize',15,'LineWidth',1.5,......
    'XTICK',[1 2 3 4 ],......
    'YTICK',[1e-10 1e-8 1e-6 1E-4 1E-2 1E0]);
hold on
h1=errorbar(pt_Omega_27_010,dis_Omega_27_010,errDis_Omega_27_010,'ks');
set(h1,'MarkerSize',7,'MarkerFaceColor','k');

semilogy(New_pt_Omega_27_1020,New_Bh_Omega_27_1020/10,'k--','LineWidth',2.5)
hold on
h2=errorbar(pt_Omega_27_1020,dis_Omega_27_1020/10,errDis_Omega_27_1020/10,'ko');
set(h2,'MarkerSize',7,'MarkerFaceColor','w');

semilogy(New_pt_Omega_27_2040,New_Bh_Omega_27_2040/10^2,'k--','LineWidth',2.5)
hold on
h3=errorbar(pt_Omega_27_2040,dis_Omega_27_2040/10^2,errDis_Omega_27_2040/10^2,'kv');
set(h3,'MarkerSize',7,'MarkerFaceColor','k');

% semilogy(New_pt_Omega_27_3040,New_Bh_Omega_27_3040/10^3,'k--','LineWidth',2.5)
% hold on
% h4=errorbar(pt_Omega_27_3040,dis_Omega_27_3040/10^3,errDis_Omega_27_3040/10^3,'k^');
% set(h4,'MarkerSize',7,'MarkerFaceColor','w');

semilogy(New_pt_Omega_27_4060,New_Bh_Omega_27_4060/10^4,'k--','LineWidth',2.5)
hold on
h5=errorbar(pt_Omega_27_4060,dis_Omega_27_4060/10^4,errDis_Omega_27_4060/10^4,'kd');
set(h5,'MarkerSize',7,'MarkerFaceColor','k');

x0=[3 3.5];
y0=[2e1 2E1];
scal=8;
plot(x0(1),y0(1),'ks','MarkerSize',5,'MarkerFaceColor','k');
text(x0(2),y0(2),'0-5%','FontSize',12);

y0=y0/scal;
plot(x0(1),y0(1),'ko','MarkerSize',5,'MarkerFaceColor','w');
text(x0(2),y0(2),'10-20%/10','FontSize',12);

y0=y0/scal;
plot(x0(1),y0(1),'kv','MarkerSize',5,'MarkerFaceColor','k');
text(x0(2),y0(2),'20-30%/10^2','FontSize',12);

y0=y0/scal;
plot(x0(1),y0(1),'k^','MarkerSize',5,'MarkerFaceColor','w');
text(x0(2),y0(2),'30-40%/10^3','FontSize',12);

y0=y0/scal;
plot(x0(1),y0(1),'kd','MarkerSize',5,'MarkerFaceColor','k');
text(x0(2),y0(2),'40-60%/10^4','FontSize',12);
text(0.5,1e-11,'(c) \Omega','FontSize',14);
hold off

% %
r1=dis_Omega_27_010./Bh_Omega_27_010;
r2=dis_Omega_27_1020./Bh_Omega_27_1020;
r3=dis_Omega_27_2040./Bh_Omega_27_2040;
% r4=dis_Omega_27_3040./Bh_Omega_27_3040;
r5=dis_Omega_27_4060./Bh_Omega_27_4060;
% %

axes('Position',[0.07 0.08 0.3 0.1]);
pt=linspace(0,5,20);
for i=1:20
    y(i)=1;   
end
plot(pt,y,'k--','LineWidth',1)
hold on
plot(pt,y-0.15,'k--','LineWidth',1)
hold on
plot(pt,y+0.15,'k--','LineWidth',1)
hold on
plot(pt_Omega_27_010,r1,'w-','LineWidth',0.1);
axis([0 5 0.5 1.5]);
set(gca,'FontSize',15,'LineWidth',1.5,......
    'XTICK',[0 1 2 3 45],......
    'YTICK',[0.5 0.75 1 1.25 1.5]);
hold on
h=errorbar(pt_Omega_27_010,r1,r1*0,'ks');
set(h,'MarkerSize',5,'MarkerFaceColor','k');

h=errorbar(pt_Omega_27_1020,r2,r2*0,'ko');
set(h,'MarkerSize',5,'MarkerFaceColor','w');

h=errorbar(pt_Omega_27_2040,r3,r3*0,'kv');
set(h,'MarkerSize',5,'MarkerFaceColor','k');

% h=errorbar(pt_Omega_27_3040,r4,r4*0,'k^');
% set(h,'MarkerSize',5,'MarkerFaceColor','w');

h=errorbar(pt_Omega_27_4060,r5,r5*0,'kd');
set(h,'MarkerSize',5,'MarkerFaceColor','k');