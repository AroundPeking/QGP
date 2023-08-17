%yi means calculated, while dis_ means data from experiment.
%err_ means error in experiment. ri means yi/dis_. error means abs(ri-1)
clear
set(gcf,'unit','centimeters','position',[40 30 33 25]);
%[left bottom width height];

num=13;
for k=1:num
    clear r1 r2 r3 r4 r5
    Tq0=0.39;
%     Tq0=0.30+0.01*k
    Ts0=0.51;
%     Ts0=0.42+0.01*k
%Tq0=T1*2.76^0.105,Ts0=T2*2.76^0.105
sNN=0.039;
Tq=Tq0*(sNN/2.76)^0.105;
Ts=Ts0*(sNN/2.76)^0.105;

%Xi========================================================================
axes('Position',[0.67 0.63 0.3 0.35]);

load Xi_39_05.dat
load Xi_39_1020.dat
load Xi_39_2030.dat
load Xi_39_3040.dat
load Xi_39_4060.dat


TXi=Ts*(3/(2+Ts/Tq));

NXi1=11.0;
NXi2=6.258;
NXi3=3.61;
NXi4=2.03;
NXi5=0.8;

mXi=1.321;


ptXi=Xi_39_05(:,1);
mtXi=sqrt(ptXi.^2+mXi^2);

dis_Xi_39_05=mtXi./ptXi./ptXi.*Xi_39_05(:,4);
err_Xi_39_05=mtXi./ptXi./ptXi.*sqrt((Xi_39_05(:,5)).^2+(Xi_39_05(:,7)).^2);
n1=size(ptXi);
for i=1:n1(1)
    f1(i)=NXi1*exp(-ptXi(i)/TXi);
    r1(i)=dis_Xi_39_05(i)/f1(i);
end

dis_Xi_39_1020=mtXi./ptXi./ptXi.*Xi_39_1020(:,4);
err_Xi_39_1020=mtXi./ptXi./ptXi.*sqrt((Xi_39_1020(:,5)).^2+(Xi_39_1020(:,7)).^2);
for i=1:n1(1)
    f2(i)=NXi2*exp(-ptXi(i)/TXi);
    r2(i)=dis_Xi_39_1020(i)/f2(i);
end

dis_Xi_39_2030=mtXi./ptXi./ptXi.*Xi_39_2030(:,4);
err_Xi_39_2030=mtXi./ptXi./ptXi.*sqrt((Xi_39_2030(:,5)).^2+(Xi_39_2030(:,7)).^2);
for i=1:n1(1)
    f3(i)=NXi3*exp(-ptXi(i)/TXi);
    r3(i)=dis_Xi_39_2030(i)/f3(i);
end

ptXi2=Xi_39_3040(:,1);
mtXi2=sqrt(ptXi2.^2+mXi^2);
dis_Xi_39_3040=mtXi2./ptXi2./ptXi2.*Xi_39_3040(:,4);
err_Xi_39_3040=mtXi2./ptXi2./ptXi2.*sqrt((Xi_39_3040(:,5)).^2+(Xi_39_3040(:,7)).^2);
n2=size(ptXi2);
for i=1:n2(1)
    f4(i)=NXi4*exp(-ptXi2(i)/TXi);
    r4(i)=dis_Xi_39_3040(i)/f4(i);
end

ptXi3=Xi_39_4060(:,1);
mtXi3=sqrt(ptXi3.^2+mXi^2);
dis_Xi_39_4060=mtXi3./ptXi3./ptXi3.*Xi_39_4060(:,4);
err_Xi_39_4060=mtXi3./ptXi3./ptXi3.*sqrt((Xi_39_4060(:,5)).^2+(Xi_39_4060(:,7)).^2);
n3=size(ptXi3);
for i=1:n3(1)
    f5(i)=NXi5*exp(-ptXi3(i)/TXi);
    r5(i)=dis_Xi_39_4060(i)/f5(i);
end

pt=linspace(0.3,7,20);
NXit=size(pt);
for i=1:NXit(2)
    y1(i)=NXi1*exp(-pt(i)/TXi);
    y2(i)=NXi2*exp(-pt(i)/TXi)/10;
    y3(i)=NXi3*exp(-pt(i)/TXi)/10^2;
    y4(i)=NXi4*exp(-pt(i)/TXi)/10^3;
    y5(i)=NXi5*exp(-pt(i)/TXi)/10^4;
end

semilogy(pt,y1,'k--','LineWidth',2.5)
axis([0 5 1E-12 1E2]);
set(gca,'Ticklength',[0.02 0.025],'FontSize',15,'LineWidth',1.5,......
    'XTICK',[1 2 3 4 5 6],......
    'YTICK',[1e-10 1e-8 1e-6 1E-4 1E-2 1E0]);
hold on
h1=errorbar(ptXi,dis_Xi_39_05,err_Xi_39_05,'ks');
set(h1,'MarkerSize',7,'MarkerFaceColor','k');

semilogy(pt,y2,'k--','LineWidth',2.5)
hold on
h2=errorbar(ptXi,dis_Xi_39_1020/10,err_Xi_39_1020/10,'ko');
set(h2,'MarkerSize',7,'MarkerFaceColor','w');

semilogy(pt,y3,'k--','LineWidth',2.5)
hold on
h3=errorbar(ptXi,dis_Xi_39_2030/10^2,err_Xi_39_2030/10^2,'kv');
set(h3,'MarkerSize',7,'MarkerFaceColor','k');

semilogy(pt,y4,'k--','LineWidth',2.5)
hold on
h4=errorbar(ptXi2,dis_Xi_39_3040/10^3,err_Xi_39_3040/10^3,'k^');
set(h4,'MarkerSize',7,'MarkerFaceColor','w');

semilogy(pt,y5,'k--','LineWidth',2.5)
hold on
h5=errorbar(ptXi3,dis_Xi_39_4060/10^4,err_Xi_39_4060/10^4,'kd');
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
plot(ptXi,r1,'w-','LineWidth',0.1);
axis([0 5 0.5 1.5]);
set(gca,'FontSize',15,'LineWidth',1.5,......
    'XTICK',[0 1 2 3 4 5],......
    'YTICK',[0.5 0.75 1 1.25 1.5]);
hold on
h=errorbar(ptXi,r1,r1*0,'ks');
set(h,'MarkerSize',5,'MarkerFaceColor','k');

h=errorbar(ptXi,r2,r2*0,'ko');
set(h,'MarkerSize',5,'MarkerFaceColor','w');

h=errorbar(ptXi,r3,r3*0,'kv');
set(h,'MarkerSize',5,'MarkerFaceColor','k');

h=errorbar(ptXi2,r4,r4*0,'k^');
set(h,'MarkerSize',5,'MarkerFaceColor','w');

h=errorbar(ptXi3,r5,r5*0,'kd');
set(h,'MarkerSize',5,'MarkerFaceColor','k');

error=zeros(1,num);
error(k)=error(k)+sum((r1-1).^2)+sum((r2-1).^2)+sum((r3-1).^2)+sum((r4-1).^2)+sum((r5-1).^2);
%Lambda========================================================================
axes('Position',[0.37 0.63 0.3 0.35]);
load Lam_39_05.dat
load Lam_39_1020.dat
load Lam_39_2030.dat
load Lam_39_3040.dat
load Lam_39_4060.dat

TLambda=Ts*(3/(1+2*Ts/Tq));

NLambda1=90.83;
NLambda2=50.66;
NLambda3=40.82;
NLambda4=23.02;
NLambda5=10;

mLambda=1.116;


ptLambda=Lam_39_05(:,1);
mtLambda=sqrt(ptLambda.^2+mLambda^2);

dis_Lam_39_05=mtLambda./ptLambda./ptLambda.*Lam_39_05(:,4);
err_Lam_39_05=mtLambda./ptLambda./ptLambda.*sqrt((Lam_39_05(:,5)).^2+(Lam_39_05(:,7)).^2);
n1=size(ptLambda);
for i=1:n1(1)
    f1(i)=NLambda1*exp(-ptLambda(i)/TLambda);
    r1(i)=dis_Lam_39_05(i)/f1(i);
end

dis_Lam_39_1020=mtLambda./ptLambda./ptLambda.*Lam_39_1020(:,4);
err_Lam_39_1020=mtLambda./ptLambda./ptLambda.*sqrt((Lam_39_1020(:,5)).^2+(Lam_39_1020(:,7)).^2);
for i=1:n1(1)
    f2(i)=NLambda2*exp(-ptLambda(i)/TLambda);
    r2(i)=dis_Lam_39_1020(i)/f2(i);
end

dis_Lam_39_2030=mtLambda./ptLambda./ptLambda.*Lam_39_2030(:,4);
err_Lam_39_2030=mtLambda./ptLambda./ptLambda.*sqrt((Lam_39_2030(:,5)).^2+(Lam_39_2030(:,7)).^2);
for i=1:n1(1)
    f3(i)=NLambda3*exp(-ptLambda(i)/TLambda);
    r3(i)=dis_Lam_39_2030(i)/f3(i);
end

ptLambda2=Lam_39_3040(:,1);
mtLambda2=sqrt(ptLambda2.^2+mLambda^2);
dis_Lam_39_3040=mtLambda2./ptLambda2./ptLambda2.*Lam_39_3040(:,4);
err_Lam_39_3040=mtLambda2./ptLambda2./ptLambda2.*sqrt((Lam_39_3040(:,5)).^2+(Lam_39_3040(:,7)).^2);
n2=size(ptLambda2);
for i=1:n2(1)
    f4(i)=NLambda4*exp(-ptLambda2(i)/TLambda);
    r4(i)=dis_Lam_39_3040(i)/f4(i);
end

ptLambda3=Lam_39_4060(:,1);
mtLambda3=sqrt(ptLambda3.^2+mLambda^2);
dis_Lam_39_4060=mtLambda3./ptLambda3./ptLambda3.*Lam_39_4060(:,4);
err_Lam_39_4060=mtLambda3./ptLambda3./ptLambda3.*sqrt((Lam_39_4060(:,5)).^2+(Lam_39_4060(:,7)).^2);
n3=size(ptLambda3);
for i=1:n3(1)
    f5(i)=NLambda5*exp(-ptLambda3(i)/TLambda);
    r5(i)=dis_Lam_39_4060(i)/f5(i);
end

pt=linspace(0.3,7,20);
npt=size(pt);
for i=1:npt(2)
    y1(i)=NLambda1*exp(-pt(i)/TLambda);
    y2(i)=NLambda2*exp(-pt(i)/TLambda)/10;
    y3(i)=NLambda3*exp(-pt(i)/TLambda)/10^2;
    y4(i)=NLambda4*exp(-pt(i)/TLambda)/10^3;
    y5(i)=NLambda5*exp(-pt(i)/TLambda)/10^4;
end

semilogy(pt,y1,'k--','LineWidth',2.5)
axis([0 6 1E-12 1E2]);
set(gca,'Ticklength',[0.02 0.025],'FontSize',15,'LineWidth',1.5,......
    'XTICK',[1 2 3 4 5],......
    'YTICK',[1e-10 1e-8 1e-6 1E-4 1E-2 1E0]);
hold on
h1=errorbar(ptLambda,dis_Lam_39_05,err_Lam_39_05,'ks');
set(h1,'MarkerSize',7,'MarkerFaceColor','k');

semilogy(pt,y2,'k--','LineWidth',2.5)
hold on
h2=errorbar(ptLambda,dis_Lam_39_1020/10,err_Lam_39_1020/10,'ks');
set(h2,'MarkerSize',7,'MarkerFaceColor','w');

semilogy(pt,y3,'k--','LineWidth',2.5)
hold on
h3=errorbar(ptLambda,dis_Lam_39_2030/10^2,err_Lam_39_2030/10^2,'ko');
set(h3,'MarkerSize',7,'MarkerFaceColor','k');

semilogy(pt,y4,'k--','LineWidth',2.5)
hold on
h4=errorbar(ptLambda2,dis_Lam_39_3040/10^3,err_Lam_39_3040/10^3,'ko');
set(h4,'MarkerSize',7,'MarkerFaceColor','w');

semilogy(pt,y5,'k--','LineWidth',2.5)
hold on
h5=errorbar(ptLambda3,dis_Lam_39_4060/10^4,err_Lam_39_4060/10^4,'k^');
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
text(0.5,1e-11,'(b) \Lambda','FontSize',14);

axes('Position',[0.37 0.53 0.3 0.1]);
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
plot(ptLambda,r1,'w-','LineWidth',0.1);
axis([0 6 0.5 1.5]);
set(gca,'FontSize',15,'LineWidth',1.5,......
    'XTICK',[0 1 2 3 4],......
    'YTICK',[0.5 0.75 1 1.25 1.5]);
hold on
h=errorbar(ptLambda,r1,r1*0,'ks');
set(h,'MarkerSize',5,'MarkerFaceColor','k');

h=errorbar(ptLambda,r2,r2*0,'ko');
set(h,'MarkerSize',5,'MarkerFaceColor','w');

h=errorbar(ptLambda,r3,r3*0,'kv');
set(h,'MarkerSize',5,'MarkerFaceColor','k');

h=errorbar(ptLambda2,r4,r4*0,'k^');
set(h,'MarkerSize',5,'MarkerFaceColor','w');

h=errorbar(ptLambda3,r5,r5*0,'kd');
set(h,'MarkerSize',5,'MarkerFaceColor','k');

error(k)=error(k)+sum((r1-1).^2)+sum((r2-1).^2)+sum((r3-1).^2)+sum((r4-1).^2)+sum((r5-1).^2);
%Lambda========================================================================
axes('Position',[0.07 0.63 0.3 0.35]);
load p_39_05.dat
load p_39_1020.dat
load p_39_2030.dat
load p_39_3040.dat
load p_39_4050.dat


Tp=Tq;

Np1=280.37;
Np2=180.858;
Np3=110.61;
Np4=75.43;
Np5=40.3;

mp=0.938;


ptp=p_39_05(:,1);
mtp=sqrt(ptp.^2+mp^2);

dis_p_39_05=mtp./ptp./ptp.*p_39_05(:,3);
err_p_39_05=mtp./ptp./ptp.*sqrt((p_39_05(:,4)).^2+(p_39_05(:,5)).^2);
n1=size(ptp);
for i=1:n1(1)
    f1(i)=Np1*exp(-ptp(i)/Tp);
    r1(i)=dis_p_39_05(i)/f1(i);
end

dis_p_39_1020=mtp./ptp./ptp.*p_39_1020(:,3);
err_p_39_1020=mtp./ptp./ptp.*sqrt((p_39_1020(:,4)).^2+(p_39_1020(:,5)).^2);
for i=1:n1(1)
    f2(i)=Np2*exp(-ptp(i)/Tp);
    r2(i)=dis_p_39_1020(i)/f2(i);
end

dis_p_39_2030=mtp./ptp./ptp.*p_39_2030(:,3);
err_p_39_2030=mtp./ptp./ptp.*sqrt((p_39_2030(:,4)).^2+(p_39_2030(:,5)).^2);
for i=1:n1(1)
    f3(i)=Np3*exp(-ptp(i)/Tp);
    r3(i)=dis_p_39_2030(i)/f3(i);
end

ptp2=p_39_3040(:,1);
mtp2=sqrt(ptp2.^2+mp^2);
dis_p_39_3040=mtp2./ptp2./ptp2.*p_39_3040(:,3);
err_p_39_3040=mtp2./ptp2./ptp2.*sqrt((p_39_3040(:,4)).^2+(p_39_3040(:,5)).^2);
n2=size(ptp2);
for i=1:n2(1)
    f4(i)=Np4*exp(-ptp2(i)/Tp);
    r4(i)=dis_p_39_3040(i)/f4(i);
end

ptp3=p_39_4050(:,1);
mtp3=sqrt(ptp3.^2+mp^2);
dis_p_39_4050=mtp3./ptp3./ptp3.*p_39_4050(:,3);
err_p_39_4050=mtp3./ptp3./ptp3.*sqrt((p_39_4050(:,4)).^2+(p_39_4050(:,5)).^2);
n3=size(ptp3);
for i=1:n3(1)
    f5(i)=Np2*exp(-ptp3(i)/Tp);
    r5(i)=dis_p_39_4050(i)/f5(i);
end

pt=linspace(0.3,7,20);
npt=size(pt);
for i=1:npt(2)
    y1(i)=Np1*exp(-pt(i)/Tp);
    y2(i)=Np2*exp(-pt(i)/Tp)/10;
    y3(i)=Np3*exp(-pt(i)/Tp)/10^2;
    y4(i)=Np4*exp(-pt(i)/Tp)/10^3;
    y5(i)=Np5*exp(-pt(i)/Tp)/10^4;
end

semilogy(pt,y1,'k--','LineWidth',2.5)
axis([0  5 1E-12 1E2]);
set(gca,'Ticklength',[0.02 0.025],'FontSize',15,'LineWidth',1.5,......
    'XTICK',[1 2 3 4 ],......
    'YTICK',[1e-10 1e-8 1e-6 1E-4 1E-2 1E0 1e2]);
hold on
h1=errorbar(ptp,dis_p_39_05,err_p_39_05,'ks');
set(h1,'MarkerSize',7,'MarkerFaceColor','k');

semilogy(pt,y2,'k--','LineWidth',2.5)
hold on
h2=errorbar(ptp,dis_p_39_1020/10,err_p_39_1020/10,'ks');
set(h2,'MarkerSize',7,'MarkerFaceColor','w');

semilogy(pt,y3,'k--','LineWidth',2.5)
hold on
h3=errorbar(ptp,dis_p_39_2030/10^2,err_p_39_2030/10^2,'ko');
set(h3,'MarkerSize',7,'MarkerFaceColor','k');

semilogy(pt,y4,'k--','LineWidth',2.5)
hold on
h4=errorbar(ptp2,dis_p_39_3040/10^3,err_p_39_3040/10^3,'ko');
set(h4,'MarkerSize',7,'MarkerFaceColor','w');

semilogy(pt,y5,'k--','LineWidth',2.5)
hold on
h5=errorbar(ptp3,dis_p_39_4050/10^4,err_p_39_4050/10^4,'k^');
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
text(x0(2),y0(2),'40-50%/10^4','FontSize',12);
text(0.5,1e-11,'(a) p','FontSize',14);

hold off

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
plot(ptp,r1,'w-','LineWidth',0.1);
axis([0 5 0.5 1.5]);
set(gca,'FontSize',15,'LineWidth',1.5,......
    'XTICK',[1 2 3 4 5],......
    'YTICK',[0.5 0.75 1 1.25 1.5]);
hold on
h=errorbar(ptp,r1,r1*0,'ks');
set(h,'MarkerSize',5,'MarkerFaceColor','k');

h=errorbar(ptp,r2,r2*0,'ko');
set(h,'MarkerSize',5,'MarkerFaceColor','w');

h=errorbar(ptp,r3,r3*0,'kv');
set(h,'MarkerSize',5,'MarkerFaceColor','k');

h=errorbar(ptp2,r4,r4*0,'k^');
set(h,'MarkerSize',5,'MarkerFaceColor','w');

h=errorbar(ptp3,r5,r5*0,'kd');
set(h,'MarkerSize',5,'MarkerFaceColor','k');

%labels========================================================================
axes('Position',[0.67 0.08 0.3 0.45]);
%axes('Position',[0.67 0.08 0.3 0.1]);
axis([0 5 1E-12 1E2]);
set(gca,'Ticklength',[0.02 0.025],'FontSize',15,'LineWidth',1.5,......
    'XTICK',[1 2 3 4 5],......
    'YTICK',[1e-8 1e-6 1E-4 1E-2 1E0]);
hold on

error(k)=error(k)+sum((r1-1).^2)+sum((r2-1).^2)+sum((r3-1).^2)+sum((r4-1).^2)+sum((r5-1).^2);
%phi========================================================================
axes('Position',[0.37 0.18 0.3 0.35]);
load phi_39_010.dat
load phi_39_1020.dat
load phi_39_2030.dat
load phi_39_3040.dat
load phi_39_4060.dat


Tphi=Ts;

Nphi1=10.37;
Nphi2=7;
Nphi3=5;
Nphi4=3;
Nphi5=1.2;

mphi=1.02;


ptphi=phi_39_010(:,3);
mtphi=sqrt(ptphi.^2+mphi^2);

dis_phi_39_010=mtphi./ptphi.*phi_39_010(:,4);
err_phi_39_010=mtphi./ptphi.*phi_39_010(:,7);
n1=size(ptphi);
for i=1:n1(1)
    f1(i)=Nphi1*exp(-ptphi(i)/Tphi);
    rr1(i)=dis_phi_39_010(i)/f1(i);
end

dis_phi_39_1020=mtphi./ptphi.*phi_39_1020(:,4);
err_phi_39_1020=mtphi./ptphi.*phi_39_1020(:,7);
for i=1:n1(1)
    f2(i)=Nphi2*exp(-ptphi(i)/Tphi);
    rr2(i)=dis_phi_39_1020(i)/f2(i);
end

dis_phi_39_2030=mtphi./ptphi.*phi_39_2030(:,4);
err_phi_39_2030=mtphi./ptphi.*phi_39_2030(:,7);
for i=1:n1(1)
    f3(i)=Nphi3*exp(-ptphi(i)/Tphi);
    rr3(i)=dis_phi_39_2030(i)/f3(i);
end

ptphi2=phi_39_3040(:,3);
mtphi2=sqrt(ptphi2.^2+mphi^2);
dis_phi_39_3040=mtphi2./ptphi2.*phi_39_3040(:,4);
err_phi_39_3040=mtphi2./ptphi2.*phi_39_3040(:,7);
n2=size(ptphi2);
for i=1:n2(1)
    f4(i)=Nphi4*exp(-ptphi2(i)/Tphi);
    rr4(i)=dis_phi_39_3040(i)/f4(i);
end

ptphi3=phi_39_4060(:,3);
mtphi3=sqrt(ptphi3.^2+mphi^2);
dis_phi_39_4060=mtphi3./ptphi3.*phi_39_4060(:,4);
err_phi_39_4060=mtphi3./ptphi3.*phi_39_4060(:,7);
n3=size(ptphi3);
for i=1:n3(1)
    f5(i)=Nphi5*exp(-ptphi3(i)/Tphi);
    rr5(i)=dis_phi_39_4060(i)/f5(i);
end

pt=linspace(0.3,6,20);
npt=size(pt);
for i=1:npt(2)
    y1(i)=Nphi1*exp(-pt(i)/Tphi);
    y2(i)=Nphi2*exp(-pt(i)/Tphi)/10;
    y3(i)=Nphi3*exp(-pt(i)/Tphi)/10^2;
    y4(i)=Nphi4*exp(-pt(i)/Tphi)/10^3;
    y5(i)=Nphi5*exp(-pt(i)/Tphi)/10^4;
end

semilogy(pt,y1,'k--','LineWidth',2.5)
axis([0 6 1E-12 1E2]);
set(gca,'Ticklength',[0.02 0.025],'FontSize',15,'LineWidth',1.5,......
    'XTICK',[1 2 3 4 5 6],......
    'YTICK',[1e-10 1e-8 1e-6 1E-4 1E-2 1E0]);
hold on
h1=errorbar(ptphi,dis_phi_39_010,err_phi_39_010,'ks');
set(h1,'MarkerSize',7,'MarkerFaceColor','k');

semilogy(pt,y2,'k--','LineWidth',2.5)
hold on
h2=errorbar(ptphi,dis_phi_39_1020/10,err_phi_39_1020/10,'ko');
set(h2,'MarkerSize',7,'MarkerFaceColor','w');

semilogy(pt,y3,'k--','LineWidth',2.5)
hold on
h3=errorbar(ptphi,dis_phi_39_2030/10^2,err_phi_39_2030/10^2,'kv');
set(h3,'MarkerSize',7,'MarkerFaceColor','k');

semilogy(pt,y4,'k--','LineWidth',2.5)
hold on
h4=errorbar(ptphi2,dis_phi_39_3040/10^3,err_phi_39_3040/10^3,'k^');
set(h4,'MarkerSize',7,'MarkerFaceColor','w');

semilogy(pt,y5,'k--','LineWidth',2.5)
hold on
h5=errorbar(ptphi3,dis_phi_39_4060/10^4,err_phi_39_4060/10^4,'kd');
set(h5,'MarkerSize',7,'MarkerFaceColor','k');

x0=[4 4.4];
y0=[2e1 2E1];
scal=8;
plot(x0(1),y0(1),'ks','MarkerSize',5,'MarkerFaceColor','k');
text(x0(2),y0(2),'0-10%','FontSize',12);

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
text(0.5,1e-11,'(e) \phi','FontSize',14);
hold off

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
plot(ptphi,rr1,'w-','LineWidth',0.1);
axis([0 6 0.5 1.5]);
set(gca,'FontSize',15,'LineWidth',1.5,......
    'XTICK',[0 1 2 3 4 5],......
    'YTICK',[0.75 1 1.25 1.5]);
hold on
h=errorbar(ptphi,rr1,rr1*0,'ks');
set(h,'MarkerSize',5,'MarkerFaceColor','k');

h=errorbar(ptphi,rr2,rr2*0,'ko');
set(h,'MarkerSize',5,'MarkerFaceColor','w');

h=errorbar(ptphi,rr3,rr3*0,'kv');
set(h,'MarkerSize',5,'MarkerFaceColor','k');

h=errorbar(ptphi2,rr4,rr4*0,'k^');
set(h,'MarkerSize',5,'MarkerFaceColor','w');

h=errorbar(ptphi3,rr5,rr5*0,'kd');
set(h,'MarkerSize',5,'MarkerFaceColor','k');

hold off

error(k)=error(k)+sum((rr1-1).^2)+sum((rr2-1).^2)+sum((rr3-1).^2)+sum((rr4-1).^2)+sum((rr5-1).^2);
%Omega========================================================================
axes('Position',[0.07 0.18 0.3 0.35]);
load Omega_39_010.dat
load Omega_39_1020.dat
load Omega_39_2040.dat
load Omega_39_4060.dat

TOmega=Ts;


NOmega1=0.7;
NOmega2=0.4;
NOmega3=0.2;
NOmega4=0.0443;

mOmega=1.672;


ptOmega=Omega_39_010(:,1);
mtOmega=sqrt(ptOmega.^2+mOmega^2);

dis_Omega_39_010=mtOmega./ptOmega./ptOmega.*Omega_39_010(:,2);
ero_Omega_39_010=mtOmega./ptOmega./ptOmega.*sqrt((Omega_39_010(:,3)).^2+(Omega_39_010(:,4)).^2);
n1=size(ptOmega);
for i=1:n1(1)
    f1(i)=NOmega1*exp(-ptOmega(i)/TOmega);
    ro1(i)=dis_Omega_39_010(i)/f1(i);
end

dis_Omega_39_1020=mtOmega./ptOmega./ptOmega.*Omega_39_1020(:,2);
ero_Omega_39_1020=mtOmega./ptOmega./ptOmega.*sqrt((Omega_39_1020(:,3)).^2+(Omega_39_1020(:,4)).^2);
for i=1:n1(1)
    f2(i)=NOmega2*exp(-ptOmega(i)/TOmega);
    ro2(i)=dis_Omega_39_1020(i)/f2(i);
end

dis_Omega_39_2040=mtOmega./ptOmega./ptOmega.*Omega_39_2040(:,2);
ero_Omega_39_2040=mtOmega./ptOmega./ptOmega.*sqrt((Omega_39_2040(:,3)).^2+(Omega_39_2040(:,4)).^2);
for i=1:n1(1)
    f3(i)=NOmega3*exp(-ptOmega(i)/TOmega);
    ro3(i)=dis_Omega_39_2040(i)/f3(i);
end

ptOmega3=Omega_39_4060(:,1);
mtOmega3=sqrt(ptOmega3.^2+mOmega^2);
dis_Omega_39_4060=mtOmega3./ptOmega3./ptOmega3.*Omega_39_4060(:,2);
ero_Omega_39_4060=mtOmega3./ptOmega3./ptOmega3.*sqrt((Omega_39_4060(:,3)).^2+(Omega_39_4060(:,4)).^2);
n3=size(ptOmega3);
for i=1:n3(1)
    f4(i)=NOmega1*exp(-ptOmega(i)/TOmega);
    ro4(i)=dis_Omega_39_4060(i)/f4(i);
end

pt=linspace(0.3,7,20);
npt=size(pt);
for i=1:npt(2)
    y1(i)=NOmega1*exp(-pt(i)/TOmega);
    y2(i)=NOmega2*exp(-pt(i)/TOmega)/10;
    y3(i)=NOmega3*exp(-pt(i)/TOmega)/10^2;
    y4(i)=NOmega4*exp(-pt(i)/TOmega)/10^3;
end

semilogy(pt,y1,'k--','LineWidth',2.5)
axis([0 5 1E-12 1E2]);
set(gca,'Ticklength',[0.02 0.025],'FontSize',15,'LineWidth',1.5,......
    'XTICK',[1 2 3 4 ],......
    'YTICK',[1e-10 1e-8 1e-6 1E-4 1E-2 1E0]);
hold on
h1=errorbar(ptOmega,dis_Omega_39_010,ero_Omega_39_010,'ks');
set(h1,'MarkerSize',7,'MarkerFaceColor','k');

semilogy(pt,y2,'k--','LineWidth',2.5)
hold on
h2=errorbar(ptOmega,dis_Omega_39_1020/10,ero_Omega_39_1020/10,'ks');
set(h2,'MarkerSize',7,'MarkerFaceColor','w');

semilogy(pt,y3,'k--','LineWidth',2.5)
hold on
h3=errorbar(ptOmega,dis_Omega_39_2040/10^2,ero_Omega_39_2040/10^2,'ko');
set(h3,'MarkerSize',7,'MarkerFaceColor','k');

semilogy(pt,y4,'k--','LineWidth',2.5)
hold on
h5=errorbar(ptOmega3,dis_Omega_39_4060/10^3,ero_Omega_39_4060/10^3,'k^');
set(h5,'MarkerSize',7,'MarkerFaceColor','k');

x0=[3 3.5];
y0=[2e1 2E1];
scal=8;
plot(x0(1),y0(1),'ks','MarkerSize',5,'MarkerFaceColor','k');
text(x0(2),y0(2),'0-10%','FontSize',12);

y0=y0/scal;
plot(x0(1),y0(1),'ko','MarkerSize',5,'MarkerFaceColor','w');
text(x0(2),y0(2),'10-20%/10','FontSize',12);

y0=y0/scal;
plot(x0(1),y0(1),'kv','MarkerSize',5,'MarkerFaceColor','k');
text(x0(2),y0(2),'20-40%/10^2','FontSize',12);

y0=y0/scal;
plot(x0(1),y0(1),'k^','MarkerSize',5,'MarkerFaceColor','w');
text(x0(2),y0(2),'40-60%/10^3','FontSize',12);

text(0.5,1e-11,'(d) \Omega','FontSize',14);

hold off

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
plot(ptOmega,ro1,'w-','LineWidth',0.1);
axis([0 5 0.5 1.5]);
set(gca,'FontSize',15,'LineWidth',1.5,......
    'XTICK',[0 1 2 3 4],......
    'YTICK',[0.5 0.75 1 1.25 1.5]);
hold on
h=errorbar(ptOmega,ro1,ro1*0,'ks');
set(h,'MarkerSize',5,'MarkerFaceColor','k');

h=errorbar(ptOmega,ro2,ro2*0,'ko');
set(h,'MarkerSize',5,'MarkerFaceColor','w');

h=errorbar(ptOmega,ro3,ro3*0,'kv');
set(h,'MarkerSize',5,'MarkerFaceColor','k');

h=errorbar(ptOmega3,ro4,ro4*0,'k^');
set(h,'MarkerSize',5,'MarkerFaceColor','w');

hold off
error(k)=error(k)+sum((ro1-1).^2)+sum((ro2-1).^2)+sum((ro3-1).^2)+sum((ro4-1).^2);

% str=['Tq0=' num2str(Tq0) '&Ts0='  num2str(Ts0) '&e=' num2str(error(k)) '.png']; 
% saveas(gcf,str);
end