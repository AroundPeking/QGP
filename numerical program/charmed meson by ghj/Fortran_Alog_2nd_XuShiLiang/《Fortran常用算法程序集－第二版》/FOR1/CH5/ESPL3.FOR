
	SUBROUTINE ESPL3(X,Y,N,XX,M,DY,DDY,S,DS,DDS,T,H)
	DIMENSION X(N),Y(N),XX(M),DY(N),DDY(N)
        DIMENSION S(M),DS(M),DDS(M),H(N)
	DOUBLE PRECISION X,Y,XX,DY,DDY,S,DS,DDS,H,Y0,Y1,
     *                   T,H0,H1,BETA,ALPHA
	H0=X(N)-X(N-1)
	Y0=Y(N)-Y(N-1)
	DY(1)=0.0
	DDY(1)=0.0
	DDY(N)=0.0
	H(1)=1.0
	H(N)=1.0
	DO 10 J=2,N
	  H1=H0
	  Y1=Y0
	  H0=X(J)-X(J-1)
	  Y0=Y(J)-Y(J-1)
	  ALPHA=H1/(H1+H0)
	  BETA=3.0*((1.0-ALPHA)*Y1/H1+ALPHA*Y0/H0)
	  IF (J.LT.N) THEN
	    T=2.0+(1.0-ALPHA)*DY(J-1)
	    DY(J)=-ALPHA/T
	    H(J)=(ALPHA-1.0)*H(J-1)/T
	    DDY(J)=(BETA-(1.0-ALPHA)*DDY(J-1))/T
	  END IF
10	CONTINUE
	DO 20 J=N-1,2,-1
	  H(J)=DY(J)*H(J+1)+H(J)
	  DDY(J)=DY(J)*DDY(J+1)+DDY(J)
20	CONTINUE
	DY(N-1)=(BETA-ALPHA*DDY(2)-(1.0-ALPHA)*DDY(N-1))/
     *          (ALPHA*H(2)+(1.0-ALPHA)*H(N-1)+2.0)
	DO 25 J=3,N
25	DY(J-2)=H(J-1)*DY(N-1)+DDY(J-1)
	DY(N)=DY(1)
	DO 30 J=1,N-1
30	H(J)=X(J+1)-X(J)
	DO 40 J=1,N-1
	  H1=H(J)*H(J)
	  DDY(J)=6.0*(Y(J+1)-Y(J))/H1-
     *           2.0*(2.0*DY(J)+DY(J+1))/H(J)
40	CONTINUE
	H1=H(N-1)*H(N-1)
	DDY(N)=6.0*(Y(N-1)-Y(N))/H1+
     *            2.0*(2.0*DY(N)+DY(N-1))/H(N-1)
	T=0.0
	DO 50 I=1,N-1
	  H1=0.5*H(I)*(Y(I)+Y(I+1))
	  H1=H1-H(I)*H(I)*H(I)*(DDY(I)+DDY(I+1))/24.0
	  T=T+H1
50	CONTINUE
	DO 70 J=1,M
	  H0=XX(J)
55	  IF (H0.GE.X(N)) THEN
	    H0=H0-(X(N)-X(1))
	    GOTO 55
	  END IF
56	  IF (H0.LT.X(1)) THEN
	    H0=H0+(X(N)-X(1))
	    GOTO 56
	  END IF
	  I=1
60	  IF (H0.GT.X(I+1)) THEN
	    I=I+1
	    GOTO 60
	  END IF
	  H1=(X(I+1)-H0)/H(I)
	  S(J)=(3.0*H1*H1-2.0*H1*H1*H1)*Y(I)
	  S(J)=S(J)+H(I)*(H1*H1-H1*H1*H1)*DY(I)
	  DS(J)=6.0*(H1*H1-H1)*Y(I)/H(I)
	  DS(J)=DS(J)+(3.0*H1*H1-2.0*H1)*DY(I)
	  DDS(J)=(6.0-12.0*H1)*Y(I)/(H(I)*H(I))
	  DDS(J)=DDS(J)+(2.0-6.0*H1)*DY(I)/H(I)
	  H1=(H0-X(I))/H(I)
	  S(J)=S(J)+(3.0*H1*H1-2.0*H1*H1*H1)*Y(I+1)
	  S(J)=S(J)-H(I)*(H1*H1-H1*H1*H1)*DY(I+1)
	  DS(J)=DS(J)-6.0*(H1*H1-H1)*Y(I+1)/H(I)
	  DS(J)=DS(J)+(3.0*H1*H1-2.0*H1)*DY(I+1)
	  DDS(J)=DDS(J)+(6.0-12.0*H1)*Y(I+1)/(H(I)*H(I))
	  DDS(J)=DDS(J)-(2.0-6.0*H1)*DY(I+1)/H(I)
70	CONTINUE
	RETURN
	END



	