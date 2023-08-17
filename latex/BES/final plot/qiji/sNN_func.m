function [sNN]=sNN_func(E)
sNN=str2double(strrep(E,"_","."))/1000;%TeV
end