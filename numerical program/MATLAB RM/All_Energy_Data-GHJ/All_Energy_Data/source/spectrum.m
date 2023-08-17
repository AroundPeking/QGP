%% init
clc
clear all
%cd ..
%% Xi(uss),Lambda(uds),proton(uud),phi(s sbar),Omega(sss)
global gXi gOmega gproton gproton1 gstproton gLambda gstLambda gphi
gXi = 0.07;%0.03 in paper <unified>
gOmega = 0.01;
gphi = 0.432;
a=1.75;
b=1.05;
gproton = 1/(beta(a+1,a+b+2)*beta(a+1,b+1));
gproton1 = beta(a+2,b+2)*beta(a+2,a+b+4);
gstproton = 1./6;
c=1;
d=2;
gLambda = 1/beta(c+1,c+d+2)/beta(c+1,d+1);
gstLambda = 1./4;
%% Cq,Cs(sNN,centrality),determine Cq by proton and Cs by phi(why N of Omega is zero?)
%% ["Xi","Lambda","proton","phi","Omega"]
%N7_7
N1=[
     11.4541    5.7481    3.3974    1.6814    0.4461
  221.7333  121.6216   70.6142   37.8018   13.1158
  937.5287  566.2210  368.7218  238.3657  130.4568
    6.2428    3.8052    2.5086    1.5196    0.6535
         0         0         0         0         0
  ]; %iHH iCC
%N11_5
N2=[
   11.1153    6.1330    3.3806    1.8493    0.5556
  179.3339  101.5673   62.7649   33.8882   11.7645
  635.8842  366.4048  241.2366  152.4688   85.7095
    8.0395    5.6268    3.3273    1.8992    0.7412
    0.5799         0         0         0         0
  ];
%N19_6
N3=[   
    10.9911    5.9457    3.5640    1.9261    0.6397
  130.7303   76.8028   47.5971   26.7954   10.4916
  395.3207  245.3865  153.9598   92.3687   56.6170
    9.6833    6.4485    4.0067    2.6322    1.0930
    0.8011    0.4465    0.1766    0.0394         0
  ];
%N27
N4=[      
    9.3405    5.3155    3.2140    1.7473    0.6571
  109.6440   67.6402   41.5905   25.1997    9.9162
  313.4100  195.5461  128.5665   81.0629   47.7071
   10.7767    7.0331    4.6008    2.6347    1.2922
    0.7552    0.4353    0.2105    0.0455         0
  ];
%N39
N5=[    
    8.0985    4.8723    2.8916    1.6647    0.6127
   95.5787   56.6530   37.1188   22.6504    8.9789
  231.2633  147.4718   99.9727   63.9899   37.7648
   10.2722    7.2200    4.7706    3.0662    1.2961
    0.6946    0.4129    0.2032    0.0434         0
  ];
Cqq=zeros(5,5);
Css=zeros(5,5);
for ic=1:5
    for ie=1:5
        Cqq(ic,ie)=Cq(ic,ie);
        Css(ic,ie)=Cs(ic,ie);
    end
end
        Cqq.'
        Css.'
%% set Tq & Ts as global var
global Tq0
global Ts0
Tq0=0.39;
Ts0=0.51;
%% load data in .csv
% data from 'experimental data for strange particle spectra'
list_h_file={'Xi-','Lambda','K0S','AntiXi+','AntiLambda'};
list_h_symb={'Xi','Lambda','K0S','AntiXi','AntiLambda'};
list_e_file={'7.7','11.5','19.6','27','39'};
list_e_symb={'7_7','11_5','19_6','27_','39_'};
list_c_file={'0-5%','10-20%','20-30%','30-40%','40-60%'};
list_c_symb={'05','1020','2030','3040','4060'};
for ih=1:2 %
    for ie=1:5
        for ic=1:5
            if ih==5&&ic==1&&ie==3 % AntiLambdapTspectrum,Au+Au19.6GeV,0-5%.csv is missing
                continue
            %elseif ih==4&&ic==1&&ie==5
            %%AntiXi+pTspectrum,Au+Au39GeV,0-5%.csv can't be read
            %%successfully .\debug with excel finished
                %continue
            end
    %begin style 1
    h_symb=list_h_symb{ih};
    h_file=list_h_file{ih};
    e_symb=list_e_symb{ie};
    e_file=list_e_file{ie};
    c_symb=list_c_symb{ic};
    c_file=list_c_file{ic};
    eval([h_symb,'_',e_symb,'_',c_symb,'=',mat2str(csvread(join([h_file...
        ,'pTspectrum,Au+Au',e_file,'GeV,',c_file,'.csv']),9,0)),';']);
    eval(['pt_',h_symb,'_',e_symb,'_',c_symb,'='...
        ,h_symb,'_',e_symb,'_',c_symb,'(:,1).'';']);
    eval(['dNdpt_',h_symb,'_',e_symb,'_',c_symb,'='...
        ,h_symb,'_',e_symb,'_',c_symb,'(:,4).'';']);
    eval(['err_',h_symb,'_',e_symb,'_',c_symb,'=sum('...
        ,h_symb,'_',e_symb,'_',c_symb,'(:,[5,7]).''.^2);']);
    %end style 1 ;
%the follow two row have same function with style 1
% eval([list_h_symb{ih},'_',list_e_symb{ie},'_',list_c_symb{ic},'=',mat2str(csvread(join([list_h_file{ih},'pTspectrum,Au+Au',list_e_file{ie},'GeV,',list_c_file{ic},'.csv']),9,0))])
% eval([list_h_symb{ih},'_',list_e_symb{ie},'_',list_c_symb{ic},'=',list_h_symb{ih},'_',list_e_symb{ie},'_',list_c_symb{ic},'(:,[1,4]).'''])
        end
    end
end
%% load data in .dat (two different data source)
dat_file_05=dir('*05.dat');
dat_file_1020=dir('*1020.dat');
dat_file_2030=dir('*2030.dat');
dat_file_3040=dir('*3040.dat');
dat_file_4060=dir('*4060.dat');
% special cases for phi & omega &proton
dat_file_010=dir('*010.dat');
dat_file_2040=dir('*2040.dat');
dat_file_4050=dir('*4050.dat');
for idat=1:length(dat_file_05)
    load(dat_file_05(idat).name)
end
for idat=1:length(dat_file_1020)
    load(dat_file_1020(idat).name);
end
for idat=1:length(dat_file_2030)
    load(dat_file_2030(idat).name);
end
for idat=1:length(dat_file_3040)
    load(dat_file_3040(idat).name);
end
for idat=1:length(dat_file_4060)
    load(dat_file_4060(idat).name);
end
% special cases for phi & omega &proton
for idat=1:length(dat_file_010)
    load(dat_file_010(idat).name);
end
for idat=1:length(dat_file_2040)
    load(dat_file_2040(idat).name);
end
for idat=1:length(dat_file_4050)
    load(dat_file_4050(idat).name);
end
list_h_symb_1={'proton','phi','Omega'};
list_e_symb={'7_7','11_5','19_6','27_','39_'};
list_c_symb={'05','1020','2030','3040','4060'};
for ih=1:3
    h_symb=list_h_symb_1{ih};
    for ie=1:5
        e_symb=list_e_symb{ie};
        for ic=1:5
            c_symb=list_c_symb{ic};
            if (ih==2&&ic==1)||(ih==3&&ic==1) %begin Special
                c_symb='010';
            elseif ih==1&&ic==5
                c_symb='4050';
            %elseif ih==3&&ic==2
            %    c_symb='1020'
            elseif ih==3&&ic==3
                c_symb='2040';
            elseif ih==3&&ic==4
                c_symb='4060';
            elseif ih==3&&ic==5 %! in program NOmega5=0
                c_symb='XXXX';  %!                
            end %end Special
            if exist(join([h_symb,"_",e_symb,"_",c_symb],""),'var')
                eval(['pt_',h_symb,'_',e_symb,'_',c_symb,'='...
                    ,h_symb,'_',e_symb,'_',c_symb,'(1,:);'])
                eval(['dNdpt_',h_symb,'_',e_symb,'_',c_symb,'='...
                    ,h_symb,'_',e_symb,'_',c_symb,'(2,:);'])
                eval(['err_',h_symb,'_',e_symb,'_',c_symb,'='...
                    ,h_symb,'_',e_symb,'_',c_symb,'(3,:);'])
            else
                continue
            end
        end
    end
end
%% evaluate dis & Bh
HH=["Xi","Lambda","proton","phi","Omega"];
EE=["7_7","11_5","19_6","27_","39_"];
CC=["05","1020","2030","3040","4060"];
for iHH=1:5
    H=HH(iHH);
    for iEE=1:5
        E=EE(iEE);
        for iCC=1:5
            C=CC(iCC);
            if (iHH==4&&iCC==1)||(iHH==5&&iCC==1) %begin Special
                C="010";
            elseif iHH==3&&iCC==5
                C="4050";
            elseif iHH==5&&iCC==2
                C="1020";
            elseif iHH==5&&iCC==3
                C="2040";
            elseif iHH==5&&iCC==4
                C="4060";
            elseif iHH==5&&iCC==5 %! in program NOmega5=0
                C="XXXX";  %!                
            end %end Special
            
            if exist(join([H,"_",E,"_",C],""),'var')
                eval(join(['[dis_',H,"_",E,"_",C,',Bh_',H,"_",E,"_",C,']=spectra('...
                    ,'pt_',H,"_",E,"_",C,','...
                    ,'dNdpt_',H,"_",E,"_",C,','...
                    ,iHH,',',iEE,',',iCC,');'],''))
            else
                fprintf("%d\t%d\t%d\t%s\n",iHH,iEE,iCC,C)
            end
        end
    end
end
%% TEST plot
HH=["Xi","Lambda","proton","phi","Omega"];
EE=["7_7","11_5","19_6","27_","39_"];
CC=["05","1020","2030","3040","4060"];
Energy=["7.7","11.5","19.6","27","39"];

    list_errorbar_1=["'ks'","'ko'","'kv'","'k^'","'kd'"];
    list_errorbar_2=["'k'","'w'","'k'","'w'","'k'"];
    list_marker=["'0-5%'","'10-20%/10'","'20-30%/10^2'","'30-40%/10^3'","'40-60%/10^4'"];
for iE=1:5
    figure('Name',join(['AuAu ',Energy(iE),' GeV']),'NumberTitle','off')
    set(gcf,'unit','centimeters','position',[40 30 33 25]);
for iH=1:5
    HNAME=HH(iH);
    
    scal=8;
    
    tNAME=join(['\',HNAME],'');
    if strcmp(HNAME,'Xi')
        axes('Position',[0.67 0.63 0.3 0.35]);
        pt_max=5;
        x0=[3 3.5];
        y0=[2e1 2E1];
    elseif strcmp(HNAME,'Lambda')
        axes('Position',[0.37 0.63 0.3 0.35]);
        pt_max=6;
        x0=[4 4.4];
        y0=[2e1 2E1];
    elseif strcmp(HNAME,'proton')
        axes('Position',[0.07 0.63 0.3 0.35]);
        pt_max=5;
        x0=[3 3.5];
        y0=[2e1 2E1];
        tNAME='p';
    elseif strcmp(HNAME,'phi')
        axes('Position',[0.37 0.18 0.3 0.35]);
        pt_max=6;
        x0=[4 4.4];
        y0=[2e1 2E1];
    elseif strcmp(HNAME,'Omega')
        axes('Position',[0.07 0.18 0.3 0.35]);
        pt_max=5;
        x0=[3 3.5];
        y0=[2e1 2E1];
    end
    
    for iC=1:5
        c_symb=CC(iC);
        marker=list_marker(iC);
            if (iH==4&&iC==1)||(iH==5&&iC==1) %begin Special
                c_symb='010';
                marker="'0-10%'";
            elseif iH==3&&iC==5
                c_symb='4050';
                marker="'40-50%/10^4'";
            elseif iH==5&&iC==2
                c_symb='1020';
                marker="'10-20%/10'";
            elseif iH==5&&iC==3
                c_symb='2040';
                marker="'20-40%/10^2'";
            elseif iH==5&&iC==4
                c_symb='4060';
                marker="'40-60%/10^3'";
            elseif iH==5&&iC==5 %! in program NOmega5=0
                c_symb='XXXX';  %!
                marker="XXXX";  %!   
            end %end Special
            
        if exist(join([HNAME,'_',EE(iE),'_',c_symb],''),'var')==0
            continue
        end
        pt_h=eval(join(['pt_',HNAME,'_',EE(iE),'_',c_symb],''));
        dis_h=eval(join(['dis_',HNAME,'_',EE(iE),'_',c_symb],''));
        Bh_h=eval(join(['Bh_',HNAME,'_',EE(iE),'_',c_symb],''));
        err_h=eval(join(['err_',HNAME,'_',EE(iE),'_',c_symb],''));
        r_h=dis_h/Bh_h;

    semilogy(pt_h,Bh_h/10^(iC-1),'k--','LineWidth',2.5)
    axis([0 pt_max 1E-12 1E2]);

    set(gca,'Ticklength',[0.02 0.025],'FontSize',15,'LineWidth',1.5,......
    'XTICK',[1 2 3 4 5 6 7],......
    'YTICK',[1e-10 1e-8 1e-6 1E-4 1E-2 1E0 1E2]);
    hold on

    h=errorbar(pt_h,dis_h/10^(iC-1),err_h/10^(iC-1),eval(list_errorbar_1(iC)));
    set(h,'MarkerSize',7,'MarkerFaceColor',eval(list_errorbar_2(iC)));
    hold on
    y0=y0/scal;
    plot(x0(1),y0(1),eval(list_errorbar_1(iC)),'MarkerSize',5,'MarkerFaceColor',eval(list_errorbar_2(iC)));
    text(x0(2),y0(2),eval(marker),'FontSize',12);
    hold on
    end
    text(0.5,1e-11,join(['(c) ',tNAME],''),'FontSize',14);
    hold off
    
    if strcmp(HNAME,'Xi')
        axes('Position',[0.67 0.53 0.3 0.1]);
        pt_max=5;
    elseif strcmp(HNAME,'Lambda')
        axes('Position',[0.37 0.53 0.3 0.1]);
        pt_max=6;
    elseif strcmp(HNAME,'proton')
        axes('Position',[0.07 0.53 0.3 0.1]);
        pt_max=5;
    elseif strcmp(HNAME,'phi')
        axes('Position',[0.37 0.08 0.3 0.1]);
        pt_max=6;
    elseif strcmp(HNAME,'Omega')
        axes('Position',[0.07 0.08 0.3 0.1]);
        pt_max=5;
    end
    
    pt=linspace(0,pt_max,20);
    y=linspace(1,1,20);
    
    plot(pt,y,'k--','LineWidth',1)
    hold on
    plot(pt,y-0.15,'k--','LineWidth',1)
    hold on
    plot(pt,y+0.15,'k--','LineWidth',1)
    hold on
%     axis([0 pt_max 0.5 1.5]);
%     set(gca,'FontSize',15,'LineWidth',1.5,......
%         'XTICK',[0 1 2 3 4 5],......
%         'YTICK',[0.5 0.75 1 1.25 1.5]);
%     hold on
    for iC=1:5
        c_symb=CC(iC);
            if (iH==4&&iC==1)||(iH==5&&iC==1) %begin Special
                c_symb='010';
            elseif iH==3&&iC==5
                c_symb='4050';
            elseif iH==5&&iC==2
                c_symb='1020';
            elseif iH==5&&iC==3
                c_symb='2040';
            elseif iH==5&&iC==4
                c_symb='4060';
            elseif iH==5&&iC==5 %! in program NOmega5=0
                c_symb='XXXX';  %!
            end %end Special
        if exist(join([HNAME,'_',EE(iE),'_',c_symb],''),'var')==0
            continue          
        end
        pt_h=eval(join(['pt_',HNAME,'_',EE(iE),'_',c_symb],''));
        dis_h=eval(join(['dis_',HNAME,'_',EE(iE),'_',c_symb],''));
        Bh_h=eval(join(['Bh_',HNAME,'_',EE(iE),'_',c_symb],''));
        r_h=dis_h./Bh_h;
        if iC==1
            plot(pt_h,r_h,'w-','LineWidth',0.1);
            hold on
        end
    axis([0 pt_max 0.5 1.5]);
    set(gca,'FontSize',15,'LineWidth',1.5,......
        'XTICK',[0 1 2 3 4,5,6],......
        'YTICK',[0.5 0.75 1 1.25 1.5]);
    hold on

    h_err=errorbar(pt_h,r_h,r_h*0,eval(list_errorbar_1(iC)));
    set(h_err,'MarkerSize',5,'MarkerFaceColor',eval(list_errorbar_2(iC)));
        if iC==5
            hold off
        end
    end
    if iH==3
        %labels========================================================================
        axes('Position',[0.67 0.08 0.3 0.45]);
        %axes('Position',[0.67 0.08 0.3 0.1]);
        axis([0 5 1E-12 1E2]);
        set(gca,'Ticklength',[0.02 0.025],'FontSize',15,'LineWidth',1.5,......
            'XTICK',[1 2 3 4 5],......
            'YTICK',[1e-8 1e-6 1E-4 1E-2 1E0]);
        hold on
    end
end
%     fpic=getframe(gcf);
%     imwrite(fpic.cdata,join([pwd,'\AuAu ',Energy(iE),' GeV.jpg'],''));
end
%%
% global Tq0
% global Ts0
% Tq0=0.37;
% Ts0=0.51;
% HH=["Xi","Lambda","proton","phi","Omega"];
function [Cq]=Cq(ic,ie)
global gstproton gproton gproton1
Cq = (Ah_h_c(3,ic,ie)/gstproton/gproton/gproton1)^(1./3);
end
function [Cs]=Cs(ic,ie)
global gphi
Cs = 2*(Ah_h_c(4,ic,ie)/gphi)^(1./2);
end
function [m0,ns]=h_prop(ih)
if     ih==1
    m0=1.321;
    ns=2;
elseif ih==2
    m0=1.116;
    ns=1;
elseif ih==3
    m0=0.938;
    ns=0;
elseif ih==4
    m0=1.02;
    ns=3;
elseif ih==5
    m0=1.672;
    ns=3;
else
    'error'
end
end
function [Ah]=Ah_h_c(ih,ic,ie)

%N7_7
N1=[
     11.4541    5.7481    3.3974    1.6814    0.4461
  221.7333  121.6216   70.6142   37.8018   13.1158
  937.5287  566.2210  368.7218  238.3657  130.4568
    6.2428    3.8052    2.5086    1.5196    0.6535
         0         0         0         0         0
  ]; %iHH iCC
%N11_5
N2=[
   11.1153    6.1330    3.3806    1.8493    0.5556
  179.3339  101.5673   62.7649   33.8882   11.7645
  635.8842  366.4048  241.2366  152.4688   85.7095
    8.0395    5.6268    3.3273    1.8992    0.7412
    0.5799         0         0         0         0
  ];
%N19_6
N3=[   
    10.9911    5.9457    3.5640    1.9261    0.6397
  130.7303   76.8028   47.5971   26.7954   10.4916
  395.3207  245.3865  153.9598   92.3687   56.6170
    9.6833    6.4485    4.0067    2.6322    1.0930
    0.8011    0.4465    0.1766    0.0394         0
  ];
%N27
N4=[      
    9.3405    5.3155    3.2140    1.7473    0.6571
  109.6440   67.6402   41.5905   25.1997    9.9162
  313.4100  195.5461  128.5665   81.0629   47.7071
   10.7767    7.0331    4.6008    2.6347    1.2922
    0.7552    0.4353    0.2105    0.0455         0
  ];
%N39
N5=[    
    8.0985    4.8723    2.8916    1.6647    0.6127
   95.5787   56.6530   37.1188   22.6504    8.9789
  231.2633  147.4718   99.9727   63.9899   37.7648
   10.2722    7.2200    4.7706    3.0662    1.2961
    0.6946    0.4129    0.2032    0.0434         0
  ];
Ah=eval(join(['N',num2str(ie),'(ih,ic)'],''));
end
function [experiment,calculate]=spectra(pt,dN_ptdpt,ih,ie,ic)
 global Tq0
 global Ts0
 global gXi gOmega gproton gproton1 gstproton gLambda gstLambda gphi
[m0,ns]=h_prop(ih);
mT=sqrt(pt.^2+m0^2);
list_sNN=[7.7,11.5,19.6,27,39];
sNN=list_sNN(ie)/1000;
Tq=Tq0*(sNN/2.76)^0.105;
Ts=Ts0*(sNN/2.76)^0.105;
%Tq=0.35*sNN^0.105
%Ts=0.46*sNN^0.105
experiment=dN_ptdpt;
%Xi(uss),Lambda(uds),proton(uud),phi(s sbar),Omega(sss)
if ih==1
    calculate=gXi*Cq(ic,ie)*Cs(ic,ie)^2*pt.^2.*exp(-pt/Tq/3).*exp(-2*pt/Ts/3)/27./mT;
elseif ih==2
    for ipt=1:length(pt)
        calculate(ipt)=TTT_Lam_2(pt(ipt),Tq,Ts,Cq(ic,ie),Cs(ic,ie));
    end
    %calculate=1/15000.0*gLambda*gstLambda*Cq(ic,ie)^2*Cs(ic,ie)*pt.^2.*exp(-pt/Ts/3).*exp(-2*pt/Tq/3)./mT;
elseif ih==3
    calculate=gproton*gproton1*gstproton*Cq(ic,ie)^3*pt.^2.*exp(-pt/Tq)./mT;
elseif ih==4
    calculate=gphi*Cs(ic,ie)^2*pt.*exp(-pt/Ts)/4./mT;
elseif ih==5
    calculate=gOmega*Cs(ic,ie)^3*pt.^2.*exp(-pt/Ts)/27./mT;
end
end