clc
clear
N=[11.0,6.258,3.61,2.03,0.8;
   90.83,50.66,40.82,23.02,10;
   280.37,180.858,110.61,75.43,40.3;
   10.37,7,5,3,1.2;
   0.7,0.4,0.2,0.0443,0
  ];
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
                 eval(join(['z_',H,'_',E,'_',C,'=log10(Bh_'...
                    ,H,'_',E,"_",C,")-log10(dis_",H,'_'...
                    ,E,'_',C,')-log10(N(',iHH,',',iCC,'));'],''));

            else
                fprintf("%d\t%d\t%d\t%s\n",iHH,iEE,iCC,C)
            end
        end
    end
end
%% E=7.7
N7_7=zeros(5,5);

for iHH=1:5
    H=HH(iHH);
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
            if exist(join(['z_',H,'_',EE(1),'_',C],""),'var')==0
                continue
            end
            z=eval(join(['z_',H,'_',EE(1),'_',C],''));
            N7_7(iHH,iCC)=fminbnd( @(x)norm(z+log10(x)) ,0.01,1000);
    end
end
N7_7
%% E=11.5
N11_5=zeros(5,5);

for iHH=1:5
    H=HH(iHH);
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
            if exist(join(['z_',H,'_',EE(1),'_',C],""),'var')==0
                continue
            end
            z=eval(join(['z_',H,'_',EE(2),'_',C],''));
            N11_5(iHH,iCC)=fminbnd( @(x)norm(z+log10(x)) ,0.01,1000);
    end
end
N11_5
%% E=19.6
N19_6=zeros(5,5);

for iHH=1:5
    H=HH(iHH);
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
            if exist(join(['z_',H,'_',EE(1),'_',C],""),'var')==0
                continue
            end
            z=eval(join(['z_',H,'_',EE(3),'_',C],''));
            N19_6(iHH,iCC)=fminbnd( @(x)norm(z+log10(x)) ,0.01,1000);
    end
end
N19_6
%% E=27
N27=zeros(5,5);

for iHH=1:5
    H=HH(iHH);
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
            if exist(join(['z_',H,'_',EE(1),'_',C],""),'var')==0
                continue
            end
            z=eval(join(['z_',H,'_',EE(4),'_',C],''));
            N27(iHH,iCC)=fminbnd( @(x)norm(z+log10(x)) ,0.01,1000);
    end
end
N27
%% E=39
N39=zeros(5,5);

for iHH=1:5
    H=HH(iHH);
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
            if exist(join(['z_',H,'_',EE(1),'_',C],""),'var')==0
                continue
            end
            z=eval(join(['z_',H,'_',EE(5),'_',C],''));
            N39(iHH,iCC)=fminbnd( @(x)norm(z+log10(x)) ,0.01,1000);
    end
end
N39