%% h_properties(h_String)
% function [m0,ns]=h_prop(h)
% if strcmp(h,'Xi')
%     m0=1.321;
%     ns=2;
% elseif strcmp(h,'Lambda')
%     m0=1.116;
%     ns=1;
% elseif strcmp(h,'proton')
%     m0=0.938;
%     ns=0;
% elseif strcmp(h,'phi')
%     m0=1.02;
%     ns=3;
% elseif strcmp(h,'Omega')
%     m0=1.672;
%     ns=3;
% else
%     'error'
% end
% end
%% function
%function [dis,Bh]=func(pt,dN_ptdpt,m0,N,h,sNN)
%function [dis,Bh]=func(pt__dN_ptdpt,m0,N,h,sNN)
% pt=pt__dN_ptdpt(1,:)
% dN_ptdpt=pt__dN_ptdpt(2,:)
% mT=sqrt(pt.^2+m0^2)
% sNN=sNN/1000
% if strcmp(h,'proton')||strcmp(h,'Xi')||strcmp(h,'Lambda')||strcmp(h,'Omega')
% dis=mT./pt./pt.*dN_ptdpt;
% elseif strcmp(h,'phi')    
% dis=mT./pt.*dN_ptdpt;
% end
% if strcmp(h,'proton')
%     ns=0;
% elseif strcmp(h,'Lambda')
%     ns=1;
% elseif strcmp(h,'Xi')
%     ns=2
% elseif strcmp(h,'phi')||strcmp(h,'Omega')
%     ns=3;
% end
% Tq0=0.37;
% Ts0=0.51;
% Tq=Tq0*(sNN/2.76)^0.105
% Ts=Ts0*(sNN/2.76)^0.105
% %Tq=0.35*sNN^0.105
% %Ts=0.46*sNN^0.105
% Th=3/((3-ns)/Tq+ns/Ts);
% Ah=N;
% Bh=Ah*exp(-pt/Th);
% end