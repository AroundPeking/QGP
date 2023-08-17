function yy=TTT_Lam_2(pt,T,Ts,C,Cs)
gst=1/4;
a=1;
b=2;
g=1/beta(a+1,b+1)/beta(a+1,a+b+2);

   a0=0.01;
   b0=pt-0.03;
   del=0.010;
   nn=floor((b0-a0)/del);
   p1=a0;
   yy=0.0;
   mt=sqrt(pt^2+1.116^2);
   
   y0=TTT_Lam_1(pt,p1,T,Ts);
   for i=1:nn
       p1=p1+del;
       y1=TTT_Lam_1(pt,p1,T,Ts);
       sl=log(y1/y0);
       if(abs(sl)<0.0001) yy=yy+y1*del;
       else   yy=yy+(y1-y0)/sl*del;
       end
       y0=y1;
   end
   yy=g*gst*C^2*Cs/mt/pt^(2*a+b+3)*yy;
   
