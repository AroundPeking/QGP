% eval([h_symb,'_',e_symb,'_',c_symb,'=',mat2str(csvread(join([h_file,'pTspectrum,Au+Au',e_file,'GeV,',c_file,'.csv']),9,0))])
% eval([h_symb,'_',e_symb,'_',c_symb,'=',h_symb,'_',e_symb,'_',c_symb,'(:,[1,4]).'''])
% cd ..
% clear all
% clc
a=[11,12,13;
 21,22,23;
 31,32,33]
a(2,2)