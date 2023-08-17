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
        ns=2; % to make Th=Ts
    elseif iH==5 %"Omega"
        m0=1.672;
        ns=3;
    else
        'error'
    end
end