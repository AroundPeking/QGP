clc;clear;close all

mat1=readtable('./Fiq_light.dat');
mat1=table2array(mat1);
mat0=readtable('./Fiq_s.dat');
mat0=table2array(mat0);
mat2=readtable('./Fiq_g.dat');
mat2=table2array(mat2);
mat3=readtable('./Fiq_c.dat');
mat3=table2array(mat3);
%%
pt=double(mat1(:,1));
light=double(mat1(:,2));
s=double(mat0(:,2));
g=double(mat2(:,2));
c=double(mat3(:,2));
%%
figure;
ax=axes;
%=====
plt_1=semilogy(pt,light,'b-');
plt_1.LineWidth=1;
hold on
%=====
plt_0=semilogy(pt,s,'m-');
plt_0.LineWidth=1;
hold on
%=====
plt_2=semilogy(pt,g,'k-');
plt_2.LineWidth=1;
hold on
%=====
plt_3=semilogy(pt,c,'g-');
plt_3.LineWidth=1;
hold on
%=====

xlim([0,35])
ylim([10^-4,10^2])
xlabel('p_T(GeV/c)');xticks(0:5:35);
ylabel('F_i(q)');yticks([10^-4,10^-3,10^-2,10^-1,10^0,10^1,10^2]);
legend('light quark','strange','gluon','charm')
ax.FontName='Times New Roman';
ax.FontSize=12;
ax.FontWeight='bold';