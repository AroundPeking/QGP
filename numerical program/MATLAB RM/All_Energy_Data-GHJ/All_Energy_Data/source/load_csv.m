clc
clear all
list_h_file={'Xi-','Lambda','K0S','AntiXi+','AntiLambda'};
list_h_symb={'Xi','Lambda','K0S','AntiXi','AntiLambda'};
list_e_file={'7.7','11.5','19.6','27','39'};
list_e_symb={'7_7','11_5','19_6','27_','39_'};
list_c_file={'0-5%','10-20%','20-30%','30-40%','40-60%'};
list_c_symb={'05','1020','2030','3040','4060'};
for ih=1:5
    for ie=1:5
        for ic=1:5
            if ih==5&&ic==1&&ie==3 % AntiLambdapTspectrum,Au+Au19.6GeV,0-5%.csv is missing
                continue
            elseif ih==4&&ic==1&&ie==5 % AntiXi+pTspectrum,Au+Au39GeV,0-5%.csv and be read successfully
                continue
            end
    %begin style 1
    h_symb=list_h_symb{ih};
    h_file=list_h_file{ih};
    e_symb=list_e_symb{ie};
    e_file=list_e_file{ie};
    c_symb=list_c_symb{ic};
    c_file=list_c_file{ic};
    eval([h_symb,'_',e_symb,'_',c_symb,'=',mat2str(csvread(join([h_file...
        ,'pTspectrum,Au+Au',e_file,'GeV,',c_file,'.csv']),9,0))])
    eval([h_symb,'_',e_symb,'_',c_symb,'='...
        ,h_symb,'_',e_symb,'_',c_symb,'(:,[1,4]).'''])
    %end style 1 ; the follow two row have same function with style 1
% eval([list_h_symb{ih},'_',list_e_symb{ie},'_',list_c_symb{ic},'=',mat2str(csvread(join([list_h_file{ih},'pTspectrum,Au+Au',list_e_file{ie},'GeV,',list_c_file{ic},'.csv']),9,0))])
% eval([list_h_symb{ih},'_',list_e_symb{ie},'_',list_c_symb{ic},'=',list_h_symb{ih},'_',list_e_symb{ie},'_',list_c_symb{ic},'(:,[1,4]).'''])
        end
    end
end