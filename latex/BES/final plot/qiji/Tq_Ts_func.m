function [Tq,Ts]=Tq_Ts_func(sNN)
global Tq0
global Ts0
Tq=Tq0*(sNN/2.76)^0.105;%TeV
Ts=Ts0*(sNN/2.76)^0.105;
end