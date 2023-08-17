%%
clc
HH=["Xi","Lambda","proton","phi","Omega"];
m0=[1.321,1.116,0.938,1.02,1.672]; %iHH
EE=["7_7","11_5","19_6","27_","39_"];
sNN=["7.7","11.5","19.6","27","39"];
CC=["05","1020","2030","3040","4060"];
N=[11.0,6.258,3.61,2.03,0.8;
   90.83,50.66,40.82,23.02,10;
   280.37,180.858,110.61,75.43,40.3;
   10.37,7,5,3,1.2;
   0.7,0.4,0.2,0.0443,0
  ]; %iHH iCC
for iHH=1:5
    for iEE=1:5
        figure(iEE)
        for iCC=1:5
            subplot(2,3,iHH)
            if exist(join([HH(iHH),"_",EE(iEE),"_",CC(iCC)],""),'var')
                eval(join([join(['[dis_',HH(iHH),'_',EE(iEE),'_',CC(iCC),',','Bh_',HH(iHH),'_',EE(iEE),'_',CC(iCC)],''),']=func(',join([HH(iHH),'_',EE(iEE),'_',CC(iCC)],''),',',m0(iHH),',',N(iHH,iCC),',HH(iHH),',sNN(iEE),')'],''))
                %join([join(['[dis_',HH(iHH),'_',EE(iEE),'_',CC(iCC),',','Bh_',HH(iHH),'_',EE(iEE),'_',CC(iCC)],''),']=func(',join([HH(iHH),'_',EE(iEE),'_',CC(iCC)],''),',',m0(iHH),',',N(iHH,iCC),',HH(iHH),',sNN(iEE),')'],'')
                                
                eval(join(['semilogy(',...
                join([HH(iHH),"_",EE(iEE),"_",CC(iCC),'(1,:),dis_',HH(iHH),"_",EE(iEE),"_",CC(iCC),',''b--'''],""),',',...
                join([HH(iHH),'_',EE(iEE),'_',CC(iCC),'(1,:),Bh_',HH(iHH),'_',EE(iEE),'_',CC(iCC),',''r--'''],'')...
                ,')'],''))
%                 if iCC==5
%                     hold off
%                 else
%                     hold on
%                 end
            
% %                 eval(join(['semilogy(',...
% %                 join([HH(iHH),"_",EE(iEE),"_",CC(iCC),'(1,:),dis_',HH(iHH),"_",EE(iEE),"_",CC(iCC),'(2,:),''b--'''],""),',',...
% %                 join([HH(iHH),'_',EE(iEE),'_',CC(iCC),'(1,:),Bh_',HH(iHH),'_',EE(iEE),'_',CC(iCC),',''r--'''],'')...
% %                 ,')'],''))
                legend('dis','Bh')
                     
                %plot(eval(join([HH(iHH),"_",EE(iEE),"_",CC(iCC)],"")),eval(join(['dis_',HH(iHH),'_',EE(iEE),'_',CC(iCC),'(1,:),','Bh_',HH(iHH),'_',EE(iEE),'_',CC(iCC)],'')))
            end
        end
    end
end
%%
clc
figure('Name','Xi_11_5')
semilogy(Xi_11_5_05(1,:),dis_Xi_11_5_05,'b--',Xi_11_5_05(1,:),Bh_Xi_11_5_05,'r--'...
    ,Xi_11_5_1020(1,:),dis_Xi_11_5_1020,'b-',Xi_11_5_1020(1,:),Bh_Xi_11_5_1020,'r-'...
    ,Xi_11_5_2030(1,:),dis_Xi_11_5_2030,'b:',Xi_11_5_2030(1,:),Bh_Xi_11_5_2030,'r:'...
    ,Xi_11_5_3040(1,:),dis_Xi_11_5_3040,'b--o',Xi_11_5_3040(1,:),Bh_Xi_11_5_3040,'r--o'...
    ,Xi_11_5_4060(1,:),dis_Xi_11_5_4060,'b-*',Xi_11_5_4060(1,:),Bh_Xi_11_5_4060,'r-*'...
    )
legend('dis_Xi_11_5_05','Bh_Xi_11_5_05'...
      ,'dis_Xi_11_5_1020','Bh_Xi_11_5_1020'...
      ,'dis_Xi_11_5_2030','Bh_Xi_11_5_2030'...
      ,'dis_Xi_11_5_3040','Bh_Xi_11_5_3040'...
      ,'dis_Xi_11_5_4060','Bh_Xi_11_5_4060'...
    )