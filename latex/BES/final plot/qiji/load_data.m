clc;clear;close all;
%% 导入CSV数据
HH=["Xi","Lambda","proton","phi","Omega"];
EE=["7_7","11_5","19_6","27","39"];
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
            %eval(join([H,'_',E,'_',C,'=',mat2str(h_table),';'],''))
            eval(join(['pt_',H,'_',E,'_',C,'=',mat2str(h_table(:,1).'),';'],''))
            eval(join(['dNdpt_',H,'_',E,'_',C,'=',mat2str(h_table(:,4).'),';'],''))
            eval(join(['err_',H,'_',E,'_',C,'=',mat2str(sum(h_table(:,[5,7]).^2.')),';'],''))            
        end
    end
end
cd ..
%%
cd dat_data\
file_C=["*05.dat","*1020.dat","*2030.dat","*3040.dat","*4060.dat"...
        ,"*010.dat","*2040.dat","*4050.dat"];% special cases for phi & omega &proton
for ifC=1:length(file_C)
        dat_file=dir(file_C(ifC));
    for idat=1:length(dat_file)
        load(dat_file(idat).name)
    end
end
%==========================================================================
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
                if ~strcmp(C,"XXXX")
                fprintf(join(['data ',H,'_',E,'_',C,' doesn''t exist\n'],''))
                end
                continue
            end
            eval(join(['pt_',H,'_',E,'_',C,'='...
                ,H,'_',E,'_',C,'(1,:);'],''))
            eval(join(['dNdpt_',H,'_',E,'_',C,'='...
                ,H,'_',E,'_',C,'(2,:);'],''))
            eval(join(['err_',H,'_',E,'_',C,'='...
                ,H,'_',E,'_',C,'(3,:);'],''))
            clearvars(join([H,'_',E,'_',C],''))
        end
    end
end
cd ..
fprintf('\nfinish import data\n')
clearvars -except -regexp pt_* dNdpt_* err_*