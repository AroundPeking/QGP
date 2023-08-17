function yy=TTT_Lam_1(pt,p1,T,Ts)
a=1;
b=2;

   a0=0.01;
   b0=pt-p1-0.01;
   del=0.010;
   nn=floor((b0-a0)/del);
   p2=a0;
   yy=0.0;
   
   y0=(p1*p2)^(a+1)*(pt-p1-p2)^(b+1).*exp(-(p1+p2)/T)*exp(-(pt-p1-p2)/Ts);
   for i=1:nn
       p2=p2+del;
       y1=(p1*p2)^(a+1)*(pt-p1-p2)^(b+1)*exp(-(p1+p2)/T)*exp(-(pt-p1-p2)/Ts);
       sl=log(y1/y0);
       if(abs(sl)<0.0001) yy=yy+y1*del;
       else   yy=yy+(y1-y0)/sl*del;
       end
       y0=y1;
   end
   yy=yy;
   
