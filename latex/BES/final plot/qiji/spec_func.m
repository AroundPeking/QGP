function spec=spec_func(pt,mT,Tq,Ts,iH,iE,iC)
global Cq Cs
%%
gphi=0.34;
gXi = 0.03;
%gXi = 0.07;
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
%%
    global Cq Cs
    if iH==1
        spec=gXi*Cq(iE,iC)*Cs(iE,iC)^2*pt.^2./mT/27.*exp(-pt/Tq/3).*exp(-2*pt/Ts/3);
    elseif iH==2
        spec=zeros(1,length(pt));
        for ipt=1:length(pt)
            spec(ipt)=TTT_Lam_2(pt(ipt),Tq,Ts,Cq(iE,iC),Cs(iE,iC));
        end
    elseif iH==3
        spec=gproton*gproton1*gstproton*Cq(iE,iC)^3*pt.^2./mT.*exp(-pt/Tq);
    elseif iH==4
        spec=gphi*Cs(iE,iC)^2*pt./mT/4.*exp(-pt/Ts);
    elseif iH==5
        spec=gOmega*Cs(iE,iC)^3*pt.^2./mT/27.*exp(-pt/Ts);
    end