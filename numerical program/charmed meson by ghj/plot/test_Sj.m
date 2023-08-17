clc;clear;close all

mat1=readtable('./Sj_c.dat');
mat1=table2array(mat1);
mat2=readtable('./Sj_cbar.dat');
mat2=table2array(mat2);
mat3=readtable('./Sj_sbar.dat');
mat3=table2array(mat3);
mat4=readtable('./Sj_ubar.dat');
mat4=table2array(mat4);
%%
pt=double(mat1(:,1));
c=(mat1(:,2));
cbar=(mat2(:,2));
sbar=(mat3(:,2));
ubar=(mat4(:,2));
%%
figure;
ax=axes;
%=====
plt_1=semilogy(pt,c,'b--');
plt_1.LineWidth=1;
hold on
%=====
plt_2=semilogy(pt,cbar,'k-.');
plt_2.LineWidth=1;
hold on
%=====
plt_3=semilogy(pt,sbar,'r-');
plt_3.LineWidth=1;
hold on
%=====
plt_4=semilogy(pt,ubar,'g--');
plt_4.LineWidth=1;
hold on
%=====

xlim([0,20])
ylim([10^-5,10^1])
xlabel('p_T(GeV/c)');xticks(0:5:20);
ylabel('S_j(q)');yticks([10^-5,10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2]);
h=legend('c','$\bar{c}$','$\bar{s}$','$\bar{u}$');
set(h,'Interpreter','latex');
ax.FontName='Times New Roman';
ax.FontSize=12;
ax.FontWeight='bold';