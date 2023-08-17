function yy=TT_K(pt,C,Cs,T,Ts)
a=1;
b=2;
mt=sqrt(pt^2+0.494^2);


   a0=0;
   b0=pt-0.01;
   del=0.010;
   nn=floor((b0-a0)/del);
   p1=a0;
   yy=0.0;
   
   y0=p1*(pt-p1)^2*p1*exp(-p1/T)*(pt-p1)*exp(-(pt-p1)/Ts);
   for i=1:nn
       p1=p1+del;
       y1=p1*(pt-p1)^2*p1*exp(-p1/T)*(pt-p1)*exp(-(pt-p1)/Ts);
       sl=log(y1/y0);
       if(abs(sl)<0.0001) yy=yy+y1*del;
       else   yy=yy+(y1-y0)/sl*del;
       end
       y0=y1;
   end
   yy=12*C*Cs./mt./pt^5*yy;
   
