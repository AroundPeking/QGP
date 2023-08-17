%% load data
clc
clear all
HH=["Xi","Lambda","proton","phi","Omega"];
EE=["7_7","11_5","19_6","27_","39_"];
CC=["05","1020","2030","3040","4060"];

HH_file=["Xi-","Lambda","K0S","AntiXi+","AntiLambda"];
EE_file=["7.7","11.5","19.6","27","39"];
CC_file=["0-5%","10-20%","20-30%","30-40%","40-60%"];
% part 1 Xi & Lambda
cd csv_data\
for iH=1:2 % Xi & Lambda
    H=HH(iH);
    H_file=HH_file(iH);
    for iE=1:5
        E=EE(iE);
        E_file=EE_file(iE);
        for iC=1:5
            C=CC(iC);
            C_file=CC_file(iC);
            h_table=csvread(join([H_file,'pTspectrum,Au+Au',E_file,'GeV,',C_file,'.csv'],''),9,0);
            eval(join([H,'_',E,'_',C,'=',mat2str(h_table),';'],''))
            eval(join(['pt_',H,'_',E,'_',C,'=',mat2str(h_table(:,1).'),';'],''))
            eval(join(['dNdpt_',H,'_',E,'_',C,'=',mat2str(h_table(:,4).'),';'],''))
            eval(join(['err_',H,'_',E,'_',C,'=',mat2str(sum(h_table(:,[5,7]).^2.')),';'],''))
        end
    end
end
cd ..
% part 2 
cd dat_data\
file_C=["*05.dat","*1020.dat","*2030.dat","*3040.dat","*4060.dat"...
        ,"*010.dat","*2040.dat","*4050.dat"];% special cases for phi & omega &proton
for ifC=1:length(file_C)
        dat_file=dir(file_C(ifC));
    for idat=1:length(dat_file)
        load(dat_file(idat).name)
    end
end
% HH=["Xi","Lambda","proton","phi","Omega"];
% EE=["7_7","11_5","19_6","27_","39_"];
% CC=["05","1020","2030","3040","4060"];
for iH=3:5 % proton & phi & Omega
    H=HH(iH);
    for iE=1:5
        E=EE(iE);
        for iC=1:5
            C=CC(iC);
            %================= begin Special
            if (iH==4&&iC==1)||(iH==5&&iC==1)
                C="010";
            elseif iH==3&&iC==5
                C="4050";
            elseif iH==5&&iC==2 % can be omitted
                C="1020";       %  
            elseif iH==5&&iC==3
                C="2040";
            elseif iH==5&&iC==4
                C="4060";
            elseif iH==5&&iC==5 %! in program NOmega5=0
                %C="4060";  %!
                C="XXXX";  %!  
            end 
            %================= end Special
            if exist(join([H,'_',E,'_',C],''),'var')==0
                fprintf(join(['data ',H,'_',E,'_',C,' doesn''t exist\n'],''))
                continue
            end
            eval(join(['pt_',H,'_',E,'_',C,'='...
                ,H,'_',E,'_',C,'(1,:);'],''))
            eval(join(['dNdpt_',H,'_',E,'_',C,'='...
                ,H,'_',E,'_',C,'(2,:);'],''))
            eval(join(['err_',H,'_',E,'_',C,'='...
                ,H,'_',E,'_',C,'(3,:);'],''))
        end
    end
end
cd ..
fprintf('\nfinish import data\n')
%**************************************************************************
%% evaluate dis & Bh -- FIND N
global Tq0
global Ts0
Tq0=0.39;
Ts0=0.51;
% HH=["Xi","Lambda","proton","phi","Omega"];
% EE=["7_7","11_5","19_6","27_","39_"];
% CC=["05","1020","2030","3040","4060"];
for iE=1:5
    E=EE(iE);
    eval(join(['N_',E,'=zeros(5,5);'],''))
end
for iH=1:5 % proton & phi & Omega
    H=HH(iH);
    for iE=1:5
        E=EE(iE);
        for iC=1:5
            C=CC(iC);
            %================= begin Special
            if (iH==4&&iC==1)||(iH==5&&iC==1)
                C="010";
            elseif iH==3&&iC==5
                C="4050";
            elseif iH==5&&iC==2 % can be omitted
                C="1020";  %  
            elseif iH==5&&iC==3
                C="2040";
            elseif iH==5&&iC==4
                C="4060";
            elseif iH==5&&iC==5 %! in program NOmega5=0 %39GeV
                %C="4060";  %!
                C="XXXX";  %!  
            end 
            %================= end Special
            if exist(join([H,'_',E,'_',C],''),'var')==0
                continue
            end
            [m0,ns]=h_prop(iH); % hadron's properties
            [sNN]=sNN_func(E); % str E to double sNN
            [Tq,Ts,Th]=T_func(ns,sNN); %evaluate Tq Ts & Th
            pt=eval(join(['pt_',H,'_',E,'_',C],''));
            dNdpt=eval(join(['dNdpt_',H,'_',E,'_',C],''));
            mT=sqrt(pt.^2+m0^2);
            if iH==4 %phi                
                dis=mT./pt.*dNdpt;
            else
                dis=mT./pt./pt.*dNdpt;
            end
            eval(join(['dis_',H,'_',E,'_',C,'=',mat2str(dis),';'],''));            
            Ah=Ah_h_39_c(iH,iC);
            Bh=Ah*exp(-pt/Th);
            zz=log10(Bh)-log10(dis)-log10(Ah);
            %z=-pt/Th-log10(dis);
            %z=-pt/Th-log(dis)
            %N=fminbnd( @(x)norm(z+log(x)) ,0,1000);
            N=fminbnd( @(x)norm(zz+log10(x)) ,0,1000);
            %fprintf(join([H,'_',E,'_',C],''))
            %fprintf(" %d\n",N)
            Bh=N*exp(-pt/Th);
            eval(join(['N_',E,'(',iH,',',iC,')=',num2str(N),';'],''))
            eval(join(['Bh_',H,'_',E,'_',C,'=',mat2str(Bh),';'],''));
        end
    end
end
for iE=1:5
    E=EE(iE);
    eval(join(['N_',E],''))
end
%**************************************************************************
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
        iNO='(c) ';
    elseif strcmp(HNAME,'Lambda')
        axes('Position',[0.37 0.63 0.3 0.35]);
        pt_max=6;
        x0=[4 4.4];
        y0=[2e1 2E1];
        iNO='(b) ';
    elseif strcmp(HNAME,'proton')
        axes('Position',[0.07 0.63 0.3 0.35]);
        pt_max=5;
        x0=[3 3.5];
        y0=[2e1 2E1];
        iNO='(a) ';
        tNAME='p';
    elseif strcmp(HNAME,'phi')
        axes('Position',[0.37 0.18 0.3 0.35]);
        pt_max=6;
        x0=[4 4.4];
        y0=[2e1 2E1];
        iNO='(e) ';
    elseif strcmp(HNAME,'Omega')
        axes('Position',[0.07 0.18 0.3 0.35]);
        pt_max=5;
        x0=[3 3.5];
        y0=[2e1 2E1];
        iNO='(d) ';
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
    plot(x0(1),y0(1),eval(list_errorbar_1(iC))...
        ,'MarkerSize',5,'MarkerFaceColor',eval(list_errorbar_2(iC)));
    text(x0(2),y0(2),eval(marker),'FontSize',12);
    hold on
    end
    text(0.5,1e-11,join([iNO,tNAME],''),'FontSize',14);
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
        set(gca,'Ticklength',[0.02 0.025],'FontSize',15,'LineWidth',1.5,...
            'XTICK',[1 2 3 4 5],...
            'YTICK',[1e-8 1e-6 1E-4 1E-2 1E0]);
        hold on
    end
end
    fpic=getframe(gcf);
    %imwrite(fpic.cdata,join([pwd,'\AuAu ',Energy(iE),' GeV.jpg'],''));
    imwrite(fpic.cdata,join([pwd,'\image\AuAu ',Energy(iE),' GeV_Tq0='...
        ,num2str(Tq0),' & Ts0=',num2str(Ts0),'.jpg'],''));
end
%**************************************************************************
%% functions definition
% HH=["Xi","Lambda","proton","phi","Omega"];
% EE=["7_7","11_5","19_6","27_","39_"];
% CC=["05","1020","2030","3040","4060"];
function [m0,ns]=h_prop(iH)
    if     iH==1 %"Xi"
        m0=1.321;
        ns=2;
    elseif iH==2 %"Lambda" 
        m0=1.116;
        ns=1;
    elseif iH==3 %"proton"
        m0=0.938;
        ns=0;
    elseif iH==4 %"phi"
        m0=1.02;
        ns=3;
    elseif iH==5 %"Omega"
        m0=1.672;
        ns=3;
    else
        'error'
    end
end
function [sNN]=sNN_func(E)
sNN=str2double(strrep(E,"_","."))/1000;
end
function [Tq,Ts,Th]=T_func(ns,sNN)
global Tq0
global Ts0
Tq=Tq0*(sNN/2.76)^0.105;
Ts=Ts0*(sNN/2.76)^0.105;
Th=3/((3-ns)/Tq+ns/Ts);
end
%
function [Ah]=Ah_h_39_c(ih,ic)
N=[11.0,6.258,3.61,2.03,0.8;
   90.83,50.66,40.82,23.02,10;
   280.37,180.858,110.61,75.43,40.3;
   10.37,7,5,3,1.2;
   0.7,0.4,0.2,0.0443,0
  ]; %iHH iCC
Ah=N(ih,ic);
end

%
% function [dis,Bh,chisq]=dis_Bh_func(pt,dN_ptdpt,ih,ie,ic)
%  global Tq0
%  global Ts0
% [m0,ns]=h_prop(ih);
% mT=sqrt(pt.^2+m0^2);
% list_sNN=[7.7,11.5,19.6,27,39];
% sNN=list_sNN(ie)/1000;
% Tq=Tq0*(sNN/2.76)^0.105
% Ts=Ts0*(sNN/2.76)^0.105
% %Tq=0.35*sNN^0.105
% %Ts=0.46*sNN^0.105
% Th=3/((3-ns)/Tq+ns/Ts);
% 
%     %if strcmp(h,'proton')||strcmp(h,'Xi')||strcmp(h,'Lambda')||strcmp(h,'Omega')
%     if ih~=4
%     dis=mT./pt./pt.*dN_ptdpt;
%     %elseif strcmp(h,'phi')
%     else
%     dis=mT./pt.*dN_ptdpt;
%     end
% Ah=Ah_h_c(ih,ic);
% Bh=Ah*exp(-pt/Th);
% ptN=size(pt);ptN=ptN(2);
% chisq=1/ptN*sum(((Bh-dis)./dis).^2);
% end
%**************************************************************************